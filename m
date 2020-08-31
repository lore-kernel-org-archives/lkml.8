Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFB2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC6CA207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="irsBQYiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgHaLac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgHaL3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:29:41 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E95C06123F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 04:29:31 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id s127so1222389vkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 04:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JIN710TFLeLsKqRRlGqyF1G56AtXFbXojtnB+ek7vjU=;
        b=irsBQYiwNj1Qd8vMPMDZ4IELqeCiPeWMfkpBS3c2ZNz7mZFu5GH+I3B7C0OPEjwMVD
         9jI1XXFeXGnU2b2vums9U5nwrWH6D0JR8+2oZUphySN+PnNxeueJzDWGnvYwt/oltfMD
         22ZbWt8+LSAgrcF3KfEDBpLH3L3bqcmci89/GwhyaMurg6aJNkKIcnBmBAkNJinIQkY1
         sd8lVRWhg89SyMdMugmmdByKiTxoWw4s11IaTQo1XbNMhUAko8qoNtgXLFhxi6gu+Sow
         h1kW2Fb4raKYv6Gc7y/Bhtd4ewL/1azXQH6Gakmz1md2e2rsSKov/8PxpyaUZ9MImqDH
         NVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JIN710TFLeLsKqRRlGqyF1G56AtXFbXojtnB+ek7vjU=;
        b=XQNlg06RcnWQPZEngXTnHOxTDmi7qDYBTrWnRPBZz1QRgFqGqKSwz3hvwz+W1Ql8JS
         4AEac6QkQqAWYU7lLki0qq0cgwENEjVCWx/xHwe4dewuvRTnr1LVDtJfawk715kdaNRp
         k9z3YiAligvG97JylwVX/gt4NGy/YUzbPLQWT5wyuRpPjfnve5gUzEfumEgidgOpCzUa
         dNaLiwHgZvFqOJuYK6024kNKQDkDpi3NOLch3GZrODrCEdA+vVySwYz2Od7PhtUMlcuk
         jA0uy3rwgyIYq7TFSJkRMz7XZZtQKo2dvkS1JE6jSK8RFl4aOndqeIdqiDLOgjPfmQgp
         offA==
X-Gm-Message-State: AOAM532MioeCh7ocCSLNbtYvDXpjdhUCLr1+VlzWjawNzjEkkmcm7Sq6
        zBpugKpBXA8e9NzusFC7qfHoKPtFnPE/ZQJ72PYQgQ==
X-Google-Smtp-Source: ABdhPJw4BM3EMv3eBn1ExCUI2PJJGFIfafdTX935b2p/ZrPMqqlhkRsSr+VDzuwhyidZqSRYvMBnWkwMt12C+fZFJyw=
X-Received: by 2002:a1f:2a48:: with SMTP id q69mr458218vkq.69.1598873366828;
 Mon, 31 Aug 2020 04:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200714121856.955680-1-hch@lst.de> <20200714121856.955680-10-hch@lst.de>
 <20200828020045.GT3265@brightrain.aerifal.cx> <20200828021152.GU3265@brightrain.aerifal.cx>
 <20200828042422.GA29734@lst.de> <CAPDyKFrKJrUN8mJ94g0+0Vs3aT1uq9MmHWfvzcVaoA5efaYPmQ@mail.gmail.com>
 <20200828150942.GV3265@brightrain.aerifal.cx> <20200829083121.GA7851@lst.de>
In-Reply-To: <20200829083121.GA7851@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 Aug 2020 13:28:50 +0200
Message-ID: <CAPDyKFpqd2n64=i5-45nJ=acbgS0AmOK0D2rtn-1bJj2HV9pnQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
To:     Christoph Hellwig <hch@lst.de>, Rich Felker <dalias@libc.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Aug 2020 at 10:31, Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Aug 28, 2020 at 11:09:43AM -0400, Rich Felker wrote:
> > > However, by looking at the code, one get the feeling that the DMA
> > > support is somewhat prepared to be made optional. I guess it has never
> > > been really tested, as the Kconfig option has "depends on HAS_DMA"  -
> > > and it's been like that as long as I can remember.
> >
> > It always worked on our "byte-banged" SPI controller, with no DMA
> > controller present, before Christoph's changes in this patch series,
>
> Before that nommu sh builds provided a DMA mapping implementation
> that even worked for the streaming side (dma_map_*), but would corrupt
> data if you used dma_alloc_coherent memory to communicate with the
> device.

I see.

>
> > and seems to be working now (although I have some other, hopefully
> > unrelated regressions to debug) with #ifdef CONFIG_HAS_DMA around the
> > if (spi->master->dev.parent->dma_mask) block in mmc_spi_probe. That's
> > probably not the right fix though -- why isn't it checking
> > host->dma_dev instead and only attempting DMA setup if dma_dev is
> > non-null?
>
> I don't think dma_dev can be NULL right now.  dma_dev is assigned here:
>
>         if (spi->master->dev.parent->dma_mask) {
>                 struct device   *dev = spi->master->dev.parent;
>
>                 host->dma_dev = dev;
>
> but for any OF or real bus device dma_mask never is zero (it actually is
> a pointer), and the value of it also is initialized to 32-bit by default,
> making this effectively an "if (1) {".  The driver needs some way to
> communicate if a given device actually is DMA capable or not. Or is that
> purely a factor of the platform which would be a little strange.

Okay, thanks for clarifying things.

>
> In which case we should do something like:
>
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 39bb1e30c2d722..3b0cc9a70e6432 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1374,7 +1374,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>         if (!host->data)
>                 goto fail_nobuf1;
>
> -       if (spi->master->dev.parent->dma_mask) {
> +       if (IS_ENABLED(CONFIG_HAS_DMA)) {

I guess "#ifdef CONFIG_HAS_DMA", would work as well as CONFIG_HAS_DMA
can't be "m".

I would also suggest moving the DMA setup things into a separate
function. Then when CONFIG_HAS_DMA is unset, we can use a stub.

>                 struct device   *dev = spi->master->dev.parent;
>
>                 host->dma_dev = dev;

Let me cook a patch that we can try.

Kind regards
Uffe
