Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732B6C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DA520873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="V1KbGIlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgCKH7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:59:32 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:51217 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgCKH7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:59:31 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6A0E023E29;
        Wed, 11 Mar 2020 08:59:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583913569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3NogsQz7wiZ70AbZz1VWk6qyrDDirbu/9UQ/ggIecg=;
        b=V1KbGIlS7M3aSBDQA5unOqGTf/tjSzhf7I07ZBUVsb1azP/hgVMUdv4qptOaX/FTetMszE
        dETLBo6a3pfT67v41nRVl91p44nfWpzr6XmO2lbiZJ8MrAfFqD4VWxR2kObsCkIt9YnRhA
        Cs2LrkkWxtygH+OaoGnVrTehFjER9XE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Mar 2020 08:59:27 +0100
From:   Michael Walle <michael@walle.cc>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH] mfd: mfd-core: inherit only valid dma_masks/flags
 from parent
In-Reply-To: <20200311061806.GB10902@lst.de>
References: <20200310230935.23962-1-michael@walle.cc>
 <20200311061806.GB10902@lst.de>
Message-ID: <4832f1edcad3fadeafce77680a7e7138@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 6A0E023E29
X-Spamd-Result: default: False [-0.10 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.777];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-03-11 07:18, schrieb Christoph Hellwig:
> On Wed, Mar 11, 2020 at 12:09:35AM +0100, Michael Walle wrote:
>> Only copy the dma_masks and flags from the parent device, if the 
>> parent
>> has a valid dma_mask/flags. Commit cdfee5623290 ("driver core:
>> initialize a default DMA mask for platform device") initialize the DMA
>> masks of a platform device. But if the parent doesn't have a dma_mask
>> set, for example if it's an I2C device, the dma_mask of the child
>> platform device will be set to zero again. Which leads to many "DMA 
>> mask
>> not set" warnings, if the MFD cell has the of_compatible property set.
>> 
>> [    1.877937] sl28cpld-pwm sl28cpld-pwm: DMA mask not set
>> [    1.883282] sl28cpld-pwm sl28cpld-pwm.0: DMA mask not set
>> [    1.888795] sl28cpld-gpio sl28cpld-gpio: DMA mask not set
>> 
>> Thus a MFD child should just inherit valid dma_masks and keep the
>> platform default otherwise.
>> 
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> 
>> Hi,
>> 
>> I don't know if that is the correct way of handling things. Maybe I'm
>> also doing something wrong in my driver, I had a look at other I2C MFD
>> drivers but couldn't find a clue why they shouldn't have the same
>> problem.
>> 
>> There was also a thread [1] about this topic, but there seems to be no
>> conclusion.
>> 
>> [1] https://www.spinics.net/lists/linux-renesas-soc/msg31581.html
>> 
>>  drivers/mfd/mfd-core.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
>> index b9eb8f40c073..5d8ea5e8e93c 100644
>> --- a/drivers/mfd/mfd-core.c
>> +++ b/drivers/mfd/mfd-core.c
>> @@ -139,9 +139,12 @@ static int mfd_add_device(struct device *parent, 
>> int id,
>> 
>>  	pdev->dev.parent = parent;
>>  	pdev->dev.type = &mfd_dev_type;
>> -	pdev->dev.dma_mask = parent->dma_mask;
>> -	pdev->dev.dma_parms = parent->dma_parms;
>> -	pdev->dev.coherent_dma_mask = parent->coherent_dma_mask;
>> +	if (parent->dma_mask)
>> +		pdev->dev.dma_mask = parent->dma_mask;
>> +	if (parent->dma_parms)
>> +		pdev->dev.dma_parms = parent->dma_parms;
> 
> Both of these are pointers, and we can't just share them.  You need
> to allocate storage for them and the allocate the values over.

So they were alreay copied wrong before this patch? If so, should
there be a fixes patch for it? The commit who introduced the copy
dates back to 2013:
   b018e1361bad3 mfd: core: Copy DMA mask and params from parent

-michael
