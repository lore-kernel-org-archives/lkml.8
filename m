Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52872C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B69206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbgAXLzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:55:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:57622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729567AbgAXLzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:55:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C0972ABED;
        Fri, 24 Jan 2020 11:55:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <adf69613-518f-db01-c1c1-8d3fda4b5182@ti.com>
Date:   Fri, 24 Jan 2020 12:51:52 +0100
Cc:     <f.fainelli@gmail.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH for-next] arm64: defconfig: Set bcm2835-dma as built-in
From:   "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
To:     "Peter Ujfalusi" <peter.ujfalusi@ti.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Message-Id: <C0400CAEQS8N.3P1J37PC0KU9F@linux-9qgx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri Jan 24, 2020 at 1:31 PM, Peter Ujfalusi wrote:
> Hi Nicolas,
>
> On 24/01/2020 13.17, Nicolas Saenz Julienne wrote:
> > With the introduction of 738987a1d6f1 ("mmc: bcm2835: Use
> > dma_request_chan() instead dma_request_slave_channel()") sdhost-bcm2835
> > now waits for its DMA channel to be available when defined in the
> > device-tree (it would previously default to PIO). Albeit the right
> > behaviour, the MMC host is needed for booting. So this makes sure the
> > DMA channel shows up in time.
> >=20
> > Fixes: 738987a1d6f1 ("mmc: bcm2835: Use dma_request_chan() instead dma_=
request_slave_channel()")
>
> it is not a bug, it is a feature ;)

Agree, I'm just afraid of your series being picked up by a stable
release without this patch. But maybe it's not necessary?

> Yes, if a driver have DMA binding and it is needed during boot then the
> DMA driver also needs to be built in.
> I believe it is desired to use DMA instead of PIO in any case for MMC
> and in the past bcm2835 did not used DMA if DMA was module and the MMC
> was built in.
>
> Sorry for the inconvenience this change has caused to bcm2835!

Not at all :)

> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks,
Nicolas
