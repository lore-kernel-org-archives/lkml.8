Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722ECC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFA120848
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgCKLZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:25:06 -0400
Received: from foss.arm.com ([217.140.110.172]:48340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgCKLZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:25:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A95351FB;
        Wed, 11 Mar 2020 04:25:05 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A836A3F6CF;
        Wed, 11 Mar 2020 04:25:04 -0700 (PDT)
Subject: Re: [RFC PATCH] mfd: mfd-core: inherit only valid dma_masks/flags
 from parent
To:     Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
References: <20200310230935.23962-1-michael@walle.cc>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5f167c37-566f-bd62-b0fd-fdb7925c5afd@arm.com>
Date:   Wed, 11 Mar 2020 11:25:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310230935.23962-1-michael@walle.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-10 11:09 pm, Michael Walle wrote:
> Only copy the dma_masks and flags from the parent device, if the parent
> has a valid dma_mask/flags. Commit cdfee5623290 ("driver core:
> initialize a default DMA mask for platform device") initialize the DMA
> masks of a platform device. But if the parent doesn't have a dma_mask
> set, for example if it's an I2C device, the dma_mask of the child
> platform device will be set to zero again. Which leads to many "DMA mask
> not set" warnings, if the MFD cell has the of_compatible property set.
> 
> [    1.877937] sl28cpld-pwm sl28cpld-pwm: DMA mask not set
> [    1.883282] sl28cpld-pwm sl28cpld-pwm.0: DMA mask not set
> [    1.888795] sl28cpld-gpio sl28cpld-gpio: DMA mask not set
> 
> Thus a MFD child should just inherit valid dma_masks and keep the
> platform default otherwise.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> 
> Hi,
> 
> I don't know if that is the correct way of handling things. Maybe I'm
> also doing something wrong in my driver, I had a look at other I2C MFD
> drivers but couldn't find a clue why they shouldn't have the same
> problem.

The underlying issue is that about 99% of MFD children should not be 
going through dma_configure() at all because their parent 'real' device 
is not on a DMA-capable bus, but as they are platform devices we are 
forced to give them the benefit of the doubt. For DT systems the only 
vaguely-reasonable heuristic to distinguish between "platform" meaning 
"SoC memory-mapped device" and "platform" meaning "random crap made up 
by Linux" is whether the device has a populated OF node, but MFD's trick 
of hanging the parent device's OF node onto its synthesised children 
kicks a hole right through even that.

Modulo any other concerns with the existing code, does the change below 
make things work the way you want? It's still a bit of a bodge, but 
short of invasive large-scale changes with bus types I don't see a way 
to do the 'right' thing :/

Robin.

----->8-----
diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index f5a73af60dd4..1e4a6e8bd630 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -138,7 +138,7 @@ static int mfd_add_device(struct device *parent, int id,

  	pdev->dev.parent = parent;
  	pdev->dev.type = &mfd_dev_type;
-	pdev->dev.dma_mask = parent->dma_mask;
+	pdev->dma_mask = parent->dma_mask ? *parent->dma_mask : 0;
  	pdev->dev.dma_parms = parent->dma_parms;
  	pdev->dev.coherent_dma_mask = parent->coherent_dma_mask;

