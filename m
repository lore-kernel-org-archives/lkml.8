Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8395CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568B3206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="Pb+02f+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgHCNSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHCNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:18:12 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A22EC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 06:18:12 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q128so2671346qkd.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZcGSsHeP5e+40JMga9CZxbgjB55gpH983rZr/StcFAo=;
        b=Pb+02f+lDwuPKfIgC7YpTTAr50AWdc6glnECFDurbxg4pSS3SjHUTXxXX3wN+Hprr/
         n1J0MOvStjeeMjEG19RtlI2OLIfbaif/JPVlVcVjlup8AWCPXVek+TkWEHvodvhoh+q4
         X/tQfzPDPAVwtECIcLoMry+52bo6Ms36g536J0ASbYh1mV+fjLxA3etISDxPvxFnqxAO
         HVvyLWrRyJKHQu4A3ic+p9o3Na0Aw22MdRVvJJwAhNXXLW34+8BQz0QDdVfRscAm51gE
         sjqCGCvG9FBMpyFF+fQWOpvSutGu+5NNFokSkYcXZ/VNEe47VCVNNrcy8DYPqs8hwUOk
         U+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZcGSsHeP5e+40JMga9CZxbgjB55gpH983rZr/StcFAo=;
        b=hcbpPMMthg2c2BaJSM9FeATVcezsJMSrFMfDw+8RNhXtjGNPWQs3TBwrqYOPaHu0vx
         i6fJRFNAXcVKHBR7OlDh9ZZKb3iysrEYmQaNC/q6/fYPyEWaNUsJDk6zA0HcIEOLIEji
         Mmii6er0BxBBeNJ5KQBMk6PkzI378p7KPRo8EvSAjwUPEGtGDooCagAEKx+rD40TeUfC
         vLucvNF+O8pGynvDDlNMTJZrSb0dmVX5W/39UdU+8w1uuvLS09loTrDD0uIH2nFaXtGX
         5qH0nMKMC+mthCJnLjljx9XeVS1a1Mjk/Gv88RvQfDT5Lo/DKgz0JWPePM9dHDTmOEdk
         eA/Q==
X-Gm-Message-State: AOAM5325+i593PJVhDKMYofi6Gpc/+fiQThDR9AhBKFwjR86kJIcijrD
        DOH16AA8MOKZONLHf5aO05VGdNuCr5OHA0tex+1zSA==
X-Google-Smtp-Source: ABdhPJzV2OSdSL38md1inZlV4Js8tyGX4S/yZviIwNc+fjhKkgbH+HYlmRqOKQnU9+4FgORa4568bHLOB4JkhcQMMe8=
X-Received: by 2002:a37:278d:: with SMTP id n135mr15719786qkn.486.1596460691093;
 Mon, 03 Aug 2020 06:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
 <20200803095720.GC1375436@lahna.fi.intel.com> <CAD2FfiFt6=OueX3E0g2ckPU+7F69yCmM0+bzF_6UD1sd4E_k_A@mail.gmail.com>
 <20200803102711.GK1375436@lahna.fi.intel.com> <CAFmMkTHSjQZJNzvUzLHHJ7sUTVX4BV6TwB=P8EO-HNk_cv8RKg@mail.gmail.com>
 <20200803130532.GY1375436@lahna.fi.intel.com>
In-Reply-To: <20200803130532.GY1375436@lahna.fi.intel.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Mon, 3 Aug 2020 10:17:59 -0300
Message-ID: <CAFmMkTH8TpezraD2d3_rpaPt+hoO3gpJrRPs56-aGHupm6iNtQ@mail.gmail.com>
Subject: Re: [PATCH] Module argument to control whether intel-spi-pci attempts
 to turn the SPI flash chip writeable
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 10:06 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Aug 03, 2020 at 09:58:23AM -0300, Daniel Gutson wrote:
> > On Mon, Aug 3, 2020 at 7:27 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Mon, Aug 03, 2020 at 11:18:12AM +0100, Richard Hughes wrote:
> > > > On Mon, 3 Aug 2020 at 10:57, Mika Westerberg
> > > > <mika.westerberg@linux.intel.com> wrote:
> > > > > I think instead of this we should simply make it so that the driver
> > > > > never tries to make the chip writable.
> > > >
> > > > I think this is a good idea, but I wasn't sure if it was an acceptable
> > > > behaviour change. Should the driver still try to set BCR_WPD when
> > > > writing an image (i.e. defer the setting of write enable until later),
> > > > or just not set the BCR register at all? I think your last comment was
> > > > the latter, but wanted to check.
> > >
> > > I would say not set it at all. I think it was (my) mistake to set it in
> > > the first place.
> >
> > Do you want me to remove the module parameter from intel-spi too and
> > do the same?
>
> No, I think that should still be left there. Then by default it is
> read-only and you can only enable writing if the BIOS allows it and that
> the user actually requested it.

OK. Patch heading your way in 1h.



-- 
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
