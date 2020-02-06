Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4623C352A3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741DC21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="umbtkvnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgBFW1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:27:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42362 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBFW1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:27:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so302096wrd.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 14:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNds49IcWx4nfR2y5vEmKA96Wni6tdn8XwP9GpCdGmk=;
        b=umbtkvnIwclCPt3UU0MxXi1sKX6Z4RURUTaypSwYLTsotPQC/vhtVE8Rp7LK1q6laJ
         YqnMjYPZ95gA+6NRsrCMUkYRe6Z2wPKdDZ7eqhmuj0vaJoVsj4t5cgclTUqFXY9nS/hY
         0pl4OszNVWVu6xRsYBLNNYpjtuSVpvH1io2HehhxZa1AdLt8vfWuJNLX8WePAmwdtdXN
         rSnC+vqlbTkvOExIRa7j1s4klGJNzAVtCob5UD04VZd2ThOy/4VC1L4rG8t0SM5AJML0
         9I8EQDgV2dM3L1G6dDhi5UD5iY6PJQGWmLAphruH4Zdvo4fad48AH0G2s6Z2R8etBUru
         6yYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNds49IcWx4nfR2y5vEmKA96Wni6tdn8XwP9GpCdGmk=;
        b=is3l/P/Ixua/bibSN3wFSkLvHrNZ0+pY6vGXc88oLNvCkKeSn4XkpkCDYOp3e9v3sl
         HOSPvKh+4mKdbull04GPAKfpHm6L3uv4YX31h1TN/s720tWyvPNQKT5koLa/cHno4TCk
         2yw63cW2UA4mzLiYjh2O5n10LD5kqXtbSHWLpUkG88Qw/4yevUc3DttdqdlIwy4Xv/N2
         Yt/uaBDTEkDnRAX/h5CYqx865XXEl3fLkQKaOBQ71gV28Ukk3JLK4ka5Dav6ENQnt2KM
         cx9cta4VaoCSxyAETRKWoWDFPpGeovHjsf87LIhUJ9nlTzXDyWtNjifTkyzfX4LXl1bQ
         0ysg==
X-Gm-Message-State: APjAAAXTb822OANvv0BUnx6MbWTzyW9ktF2Sxfe4vevYbl35dGnpJ225
        30wJDnAPZoIs4j7/BXTIZo2oMe51sJ7/HUKZ9culsQ==
X-Google-Smtp-Source: APXvYqxUCp/JBFhD831bn2alN/uVeNrgyIAVbjvFEIr2YFrvvlqq5ugPf1xEfY1aKbMa7eYQC2HkgJrigsjyy5cJ+s8=
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr189290wrn.344.1581028025651;
 Thu, 06 Feb 2020 14:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20200205194804.1647-1-mst@semihalf.com> <20200206083149.GK2667@lahna.fi.intel.com>
In-Reply-To: <20200206083149.GK2667@lahna.fi.intel.com>
From:   =?UTF-8?Q?Micha=C5=82_Stanek?= <mst@semihalf.com>
Date:   Thu, 6 Feb 2020 23:26:54 +0100
Message-ID: <CAMiGqYi2rVAc=hepkY-4S1U_3dJdbR4pOoB0f8tbBL4pzWLdxA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: cherryview: Add quirk with custom translation of
 ACPI GPIO numbers
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stanekm@google.com,
        stable@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>,
        levinale@chromium.org, andriy.shevchenko@linux.intel.com,
        Linus Walleij <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com, rafael.j.wysocki@intel.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 9:31 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Wed, Feb 05, 2020 at 08:48:04PM +0100, Michal Stanek wrote:
> > Dropping custom Linux GPIO translation caused some Intel_Strago based Chromebooks
> > with old firmware to detect GPIOs incorrectly. Add quirk which restores some code removed by
> > commit 03c4749dd6c7ff94 ("gpio / ACPI: Drop unnecessary ACPI GPIO to Linux GPIO translation").
>
> Hi,
>
> Can you elaborate this? I was under the impression that all the
> different Strago systems have been already worked around by patches from
> Dmitry (Cc'd).

Hi Mika,

The previous patches from Dmitry handled IRQ numbering, here we have a
similar issue with GPIO to pin translation - hardcoded values in FW
which do not agree with the (non-consecutive) numbering in newer
kernels.

> What GPIO(s) we are talking about and how does it show up to the user?

As an example, the issue manifests itself when you run 'crossystem
wpsw_cur'. On my Kefka it incorrectly reports the value as 1 instead
of 0 when the write protect screw is removed.


> > +             /*
> > +              * Some Braswell based Google Chromebooks need custom ACPI GPIO
> > +              * number translation due to hardcoded GPIO numbers in firmware.
> > +              */
> > +             .ident = "Intel_Strago based Chromebooks (All models)",
> > +             .matches = {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> > +                     DMI_MATCH(DMI_PRODUCT_FAMILY, "Intel_Strago"),
>
> Same comment here. Are you saying all Stragos are broken in the current
> mainline?

Yes, I believe all Braswell based Chromebooks are affected.
Yes, I believe all Braswell based Chromebooks are affected.
