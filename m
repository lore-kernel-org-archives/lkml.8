Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A28C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B204D208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L0FafcRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgH1J1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbgH1J1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:27:35 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C8EC061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:27:35 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id v138so240568vsv.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52zKqUSdV0qZVoQTtvFuZSla22zZLeCM10kF2S2vylo=;
        b=L0FafcRxcvqheShftDUhSlbBJqAncc/ePSfPwPCIweprjftt5/BSgKy3BKAM1BIq8e
         d30cYn4yCMozW389UnScIzZA25N7mV48wgStk8TiZdT1bD6uB962M94nBJaZKxYvo/Gy
         HU7t/wY2ow3sRQ4AXXumJAONBgcaPrIKF0N0/HyR1NZiEGAeCCCp/6LL8hM7zHiVXksw
         bQO8ZmKqH8g/4wh2kgPILpNVwbm1LvlKJLjLtafFlsn49lhNg0zke4FGIMadetI0OUW5
         8HDZwmB0ef7yW3dz4nuGmLZrudcB6G5cqT0pOWgpJ+K/D7+LGf7Czf+JNZ77oJE6OQui
         K13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52zKqUSdV0qZVoQTtvFuZSla22zZLeCM10kF2S2vylo=;
        b=IDERpJLL7LTpkfq+ca6sW5Il4SCcp1CNnfp7fXsjO2ubuw0d8DPEx6bd9s++y8XCEl
         PIUlTN15Jw69ziocqh/bPn2f/A2NcxioJZl9+CFJz2WUIfUyrWJajWyECWsDnwnvxQ+K
         x7pQfPwKI3F5UDd3FLNv9DqQCr1/DMi1KGoXK1Wk9xMMFCDlHeCiItQ3HJzBDv071FtG
         UsKTGG1TK8y7iHFxNHWz8gX3FLkDnaFrVPtosi66+9s9Yk8TwwPtafaq985noy8IFfo/
         vZfy+kB0i/NSH5vpVZNCkhHpgy9XlhGdQQs7H5Kmq7gQNJpX6rzJgd9pFdTIp3HZUJ6q
         MtuQ==
X-Gm-Message-State: AOAM531kKkV3NnXLNzpfbi7ENfHRP0hgovr/Gnz4T9W29Xv7QF09B2VO
        YFYHwJOtooCkJmd+mBevd1a4iavWh7P4LMlRPQ5s1A==
X-Google-Smtp-Source: ABdhPJy/B7VHMvzvzbEi7QEAfxMZ4jV3nwJaVkTt3w6kaS4gxUPya72WKU4yOeFrkvQuSmkZLEUi4A5sE5rkYCX+fYk=
X-Received: by 2002:a67:f8ce:: with SMTP id c14mr251691vsp.14.1598606854311;
 Fri, 28 Aug 2020 02:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200714121856.955680-1-hch@lst.de> <20200714121856.955680-10-hch@lst.de>
 <20200828020045.GT3265@brightrain.aerifal.cx> <20200828021152.GU3265@brightrain.aerifal.cx>
 <20200828042422.GA29734@lst.de>
In-Reply-To: <20200828042422.GA29734@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Aug 2020 11:26:57 +0200
Message-ID: <CAPDyKFrKJrUN8mJ94g0+0Vs3aT1uq9MmHWfvzcVaoA5efaYPmQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 at 06:24, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Aug 27, 2020 at 10:11:53PM -0400, Rich Felker wrote:
> > > This change broke SD card support on J2 because MMC_SPI spuriously
> > > depends on HAS_DMA. It looks like it can be fixed just by removing
> > > that dependency from drivers/mmc/host/Kconfig.
> >
> > It can't. mmp_spi_probe fails with ENOMEM, probably due to trying to
> > do some DMA setup thing that's not going to be needed if the
> > underlying SPI device doesn't support/use DMA.
>
> Adding the linux-mmc and linux-spi lists, as that seems pretty odd.

The mmc_spi driver needs modernizations, so I am not surprised to see
odd things.

My guess is that in ->probe() we check "if
(spi->master->dev.parent->dma_mask)" - > and runs dma_map*()
operations, which fails and leads to bailing out of ->probe() to
return an error code.

However, by looking at the code, one get the feeling that the DMA
support is somewhat prepared to be made optional. I guess it has never
been really tested, as the Kconfig option has "depends on HAS_DMA"  -
and it's been like that as long as I can remember.

Kind regards
Uffe
