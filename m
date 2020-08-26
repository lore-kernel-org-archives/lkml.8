Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E71C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4681720707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=puresoftware-com.20150623.gappssmtp.com header.i=@puresoftware-com.20150623.gappssmtp.com header.b="FB+t+sVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgHZPN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgHZPNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:13:24 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62439C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:13:24 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id q21so850103edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=return-receipt-to:from:references:in-reply-to:mime-version
         :thread-index:disposition-notification-to:date:message-id:subject:to
         :cc;
        bh=oKNHl4Ny4sbuCKjpuRdgyZBkTgWLx5UkA3LoZG6V0lk=;
        b=FB+t+sVO1/ukFnYVyxTChBvyLa9GO6obbOPr9SKpuFup/4ZpcKuf8oUyzovXq85LJn
         PMr7eKU64znflOOOZMHs2rxL+u2r1ECZGrY573Am4BkapgOukgtfFVpIZptIJrI+NAWS
         LqneKqDYE0pj1LYEzHA/rPRFTXnq7pwFEjbz0rsfdDmfJzAHl+jnB6Mwaxgt/DofJG1V
         P7Hq2FrCoCtMvck+9N13aUemZGluAFC1Za44VxUz/z9+EETIFI4CwhFucg+6kfR2ZgE1
         O7E5gwAk8ZEeIZai2ngoCB9yHMfkP7Y4ixQ1VzauUwQIDiwH6MV3WENW37VfyVjIGisx
         6A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:return-receipt-to:from:references:in-reply-to
         :mime-version:thread-index:disposition-notification-to:date
         :message-id:subject:to:cc;
        bh=oKNHl4Ny4sbuCKjpuRdgyZBkTgWLx5UkA3LoZG6V0lk=;
        b=cHdmKr2ScQtI0+4Gsp+7EOIe+DUFc5MadkWwsWdRGk0c7koDeio3bWoAylHOCXUIms
         9Sp/6Kfx7oHrtI4sBrvgRIDHo5kfYlQ+QnMS0gGAsPjzRhfXKfCowjt5ey8PG3FgFaVH
         yBIOMwfdhdR89R35bcul1KcHDF4xf7JmSKYn0pDbwi/JvoNTvJ4XRBcYl1FyyVRFPrss
         uap7b87GMQIY6Pq9XhAGtVyrOFIhSn44uwxl3peoXufnCMMUSr42naV0EB4s8TSqJQJX
         pvMe5Gyq2Dg7DKrLlieBJA0eKDknGuJPfxJuW9v2iBUWOCq5Nj7yfgGBKF/LiQKsbhJe
         nhjA==
X-Gm-Message-State: AOAM532a3ONx1e1gzTHK8/0Jq2qlxWtV2mSOtCJSLpADOs0XHYGGqY4S
        JujN5FCIo7k7ISrGo54HMXNVAw8+F2pWBfd4FqSHFQ==
X-Google-Smtp-Source: ABdhPJzsRVGSLe4lpmQnlT3HvkKy/20pNcOp7WTKLjOO89AFrfG0IzVA4X1dUrgiUuwohWHrh+PafH6GPl/mKHJR8rI=
X-Received: by 2002:a05:6402:1d17:: with SMTP id dg23mr15482591edb.198.1598454802941;
 Wed, 26 Aug 2020 08:13:22 -0700 (PDT)
From:   Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk> <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf> <VE1PR04MB6768699B6D7A507A5BF82F9191540@VE1PR04MB6768.eurprd04.prod.outlook.com>
 <20200826114758.4agph53ag2fin6um@skbuf> <20200826142312.GH4965@sirena.org.uk> <20200826144744.c4yzgoovk6f4t3id@skbuf>
In-Reply-To: <20200826144744.c4yzgoovk6f4t3id@skbuf>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF7/ycK6cTpjLXBKD+ruXNZEs6GEAE4wSq+AcJdu4sBqH1NLAEjPgFbAgU/99oCtsCFlAIqZ5/wqZoKVKA=
Date:   Wed, 26 Aug 2020 20:43:20 +0530
Message-ID: <2e19f8979be4f962045a1597bdbe7886@mail.gmail.com>
Subject: RE: [PATCH] spi: spi-fsl-dspi: Add ACPI support
To:     Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Vladimir Oltean <olteanv@gmail.com>
> Sent: Wednesday, August 26, 2020 8:18 PM
> To: Mark Brown <broonie@kernel.org>
> Cc: Qiang Zhao <qiang.zhao@nxp.com>; kuldip dwivedi
> <kuldip.dwivedi@puresoftware.com>; linux-spi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Pankaj Bansal <pankaj.bansal@nxp.com>; Varun
Sethi
> <V.Sethi@nxp.com>; Tanveer Alam <tanveer.alam@puresoftware.com>
> Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
>
> On Wed, Aug 26, 2020 at 03:23:12PM +0100, Mark Brown wrote:
> > On Wed, Aug 26, 2020 at 02:47:58PM +0300, Vladimir Oltean wrote:
> >
> > > - The compatible string plays an integral part in the functionality
of
> > >   the spi-fsl-dspi driver. I want to see a solution for ACPI where
the
> > >   driver knows on which SoC it's running on. Otherwise it doesn't
know
> > >   what are the silicon parameters of the DSPI module (XSPI present
or
> > >   not, DMA present or not, FIFO depth). I don't see that now. I just
see
> > >   something hardcoded for:
> > >   { "NXP0005", .driver_data =
> > > (kernel_ulong_t)&devtype_data[LS2085A], }
> >
> > Based on some other stuff I've seen with ACPI on NXP stuff it looks
> > like they're following the same scheme but only caring about that one
> > SoC for the time being.
>
> So, no argument about caring only about ACPI on one particular SoC for
the time
> being, but there's a big difference between a solution that works for
N=1 and one
> that works for N=2...
>
> Showing my ignorance here, but is there something equivalent to
> of_machine_is_compatible() for ACPI?
Just a query, Can't we use meaningful HID for different SoC just like
compatible strings in DT ?
In this way Silicon parameters can also be added in fsl_dspi_devtype_data
structure , which is
already exist in driver
>
> Thanks,
> -Vladimir
