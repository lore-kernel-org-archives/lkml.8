Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDB3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8322073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fE40P/Ga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgFAWyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 18:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgFAWyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 18:54:19 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D905FC03E96B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 15:54:17 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id r10so910609vsa.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 15:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahBMXlLUd844T91f3aGesWzPLvREUhRkr0Fgcws0YGs=;
        b=fE40P/GaA/oeYfZvFFTM420T8Kn7sVmkFjI7Qoy0bvihR4lmVHQUDbxoCW8m2JzSuj
         CYOn8agMAC73Y21kyw43VwgR2EToUMJXfHZ3OHfVQwIlMjT6c2ctwCKWkTS063a7GUxk
         +cnqb/McO2igW/hXGaTuSyE91w8VGgwOWJfbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahBMXlLUd844T91f3aGesWzPLvREUhRkr0Fgcws0YGs=;
        b=W7ZZewvgIPltDdFme1lAD/9H3nRx8EMtxYqwYChWKLTtAiD44+zJHDYEEnRgR4wMSI
         f3dW7K+nOzApan7jJlSEcOZ1SBEwIpQ8++GFss591i7VDbUx3/LZDW0TAkQomk4n7kaV
         ZeLqjqNahDU7KLcg4sqEjnMSRaNUbvOMZjVuf0ymPwAvVXg258rkC8mbxj0w5mrz8XYq
         Bo7KKXgUIsQAnBWuBH/0MwCJ/lGaGizLq+1SnE/mYbk1NQfJem+QXf7A28o8XLV2aksg
         JBPNvd2/1UwhXvZ/7wWaAwtPSGfnGADyzSaS/YDeYuGuEUQ2m25Zr1SKL9YfQrWwplPk
         gz4g==
X-Gm-Message-State: AOAM531EAJzq0iLurUMQtLdBctonRo4R/nZKNyF2XLk4jFhk0q9wbgV6
        BFOQaZBZDhHb20nZrj8WMPho2vfGU78=
X-Google-Smtp-Source: ABdhPJz/ROGrYGg95LeBXkvR8nadlMB14TeboQWWUjr+vhIBXP+n5wZCBxrZMMUBPkEj2vhQr465BQ==
X-Received: by 2002:a05:6102:10a:: with SMTP id z10mr16187911vsq.131.1591052056437;
        Mon, 01 Jun 2020 15:54:16 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id t131sm146650vkc.32.2020.06.01.15.54.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 15:54:15 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id z13so907259vsn.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 15:54:15 -0700 (PDT)
X-Received: by 2002:a67:1703:: with SMTP id 3mr16545948vsx.169.1591052054915;
 Mon, 01 Jun 2020 15:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200528151912.1.Id689a39ce8d1ec6f29f4287277ad977ff4f57d7d@changeid>
 <20200601014646.GA794847@linux.intel.com>
In-Reply-To: <20200601014646.GA794847@linux.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Jun 2020 15:54:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VaET7ZXE0f6ciKmE=p1R1DMF9jCue9_XAD4870byKGog@mail.gmail.com>
Message-ID: <CAD=FV=VaET7ZXE0f6ciKmE=p1R1DMF9jCue9_XAD4870byKGog@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis_spi: Don't send anything during flow control
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 31, 2020 at 6:47 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, May 28, 2020 at 03:19:30PM -0700, Douglas Anderson wrote:
> > During flow control we are just reading from the TPM, yet our spi_xfer
> > has the tx_buf and rx_buf both non-NULL which means we're requesting a
> > full duplex transfer.
> >
> > SPI is always somewhat of a full duplex protocol anyway and in theory
> > the other side shouldn't really be looking at what we're sending it
> > during flow control, but it's still a bit ugly to be sending some
> > "random" data when we shouldn't.
> >
> > The default tpm_tis_spi_flow_control() tries to address this by
> > setting 'phy->iobuf[0] = 0'.  This partially avoids the problem of
> > sending "random" data, but since our tx_buf and rx_buf both point to
> > the same place I believe there is the potential of us sending the
> > TPM's previous byte back to it if we hit the retry loop.
> >
> > Another flow control implementation, cr50_spi_flow_control(), doesn't
> > address this at all.
> >
> > Let's clean this up and just make the tx_buf NULL before we call
> > flow_control().  Not only does this ensure that we're not sending any
> > "random" bytes but it also possibly could make the SPI controller
> > behave in a slightly more optimal way.
> >
> > NOTE: no actual observed problems are fixed by this patch--it's was
> > just made based on code inspection.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/char/tpm/tpm_tis_spi_main.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> > index d96755935529..8d2c581a93c6 100644
> > --- a/drivers/char/tpm/tpm_tis_spi_main.c
> > +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> > @@ -53,8 +53,6 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
> >
> >       if ((phy->iobuf[3] & 0x01) == 0) {
> >               // handle SPI wait states
> > -             phy->iobuf[0] = 0;
> > -
>
> Why this should be removed?

As far as I can tell the only purpose of that was to make sure we were
sending 0.  Specifically "tx_buf" "rx_buf" both point to "phy->iobuf"
so setting the first byte to 0 here made sure that we weren't sending
out "random" data but were instead sending a 0.  After my change
"tx_buf" is NULL so we don't need to do this--the controller should
take charge of sending nothing on the lines (AKA sending a zero).

Does that answer your question, or were you worried about us needing
to init iobuf[0] to 0 in some other case?

-Doug
