Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93081C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 23:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDD320721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 23:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhWO1YFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgDCXuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 19:50:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36779 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgDCXuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 19:50:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id k18so7784572oib.3;
        Fri, 03 Apr 2020 16:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXdcqrAdiSxima2XcozxNqRPj0pqP4ss3zDOgQD4mx4=;
        b=UhWO1YFIfHTznbNhajAUv64cFNintquNZGXcJ8Z2HYUQmri9FqbJuNYOrtuovUsWht
         jQZt+yRDjEnZ5cmOVtEgCCzlffDTWgcyiOTsnFIGRKKiBoraP/AY6MMPLWte78FNyaEz
         6HUWNmq82a6rQNPtKaBezY3U64n0P24Zc4zoiLHTv5tJffks9Dt/+lsMAH70AhcReeL7
         Tp5kZeK9Blv0L1Ne/0BpGfQOCToBQAJAmtxe7F9/b2BE8ihPsb6b/OxIHgwYExLEM60w
         J4b2EpI6g4plsTWM3xHEplCuePabooOEneBg2ocge7f2HVf/m7mD3PAwUJjDiyKbDSIK
         3urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXdcqrAdiSxima2XcozxNqRPj0pqP4ss3zDOgQD4mx4=;
        b=L1+0vnJD3jQjybXrn/4iRcGgaS6GcuHFQtOwlGf4vyaVO79+44QJDl2dg3E4+cSSdm
         1oSQsxyJgnbIRiTmory19f6x6UVijpAuJFItK2IsFfsDfLQTiPkX3XNopHwCfc0yuOv6
         HXZKkxkUJrCCLGdFnPkWAPQT0QGrT60xdP9tR4La/Hi+5DTEp8OE9Mv5ZeUSjck7VSau
         xZ+fZ8xXaLTH8x3XreV3GHdYHxXLwfGcKS3XC/0JeJ1vcWjd2jQweVroVZAbwtORzQJx
         hDF6odrTpSKkkBvjo0CUXOTnm2iqTFMlXaMKm7fIghZDR18seUvih69WpU7m9hhvrL2m
         UNFQ==
X-Gm-Message-State: AGi0Pub0UpLUI4Dh128K8jT/EZ4WSTAzNFAs/a4GsOUyJpNdME0zDF4R
        p5eN0FraDwkwFO3I10e6QG0i7ifvQ9+n/fLei7uf/A==
X-Google-Smtp-Source: APiQypJV3OB/eUwke7DNWeBdA2bwA1uZVW8eSCd+syKg1ekw2VvuiZpMTRlqMhM6EqTn6RI+MzGFju5SOhdQ1SJ1Ty8=
X-Received: by 2002:aca:b803:: with SMTP id i3mr4976678oif.92.1585957817931;
 Fri, 03 Apr 2020 16:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226151034.7i3h5blmrwre2yzg@pengutronix.de> <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
 <20200330151231.GA1650@workstation.tuxnet>
In-Reply-To: <20200330151231.GA1650@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 3 Apr 2020 19:50:07 -0400
Message-ID: <CAGngYiUe-tihBJUcXQ738_5aA9pzgp_-NSs4iCrz3eWO6rMukA@mail.gmail.com>
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 11:12 AM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> On Wed, Feb 26, 2020 at 06:03:02PM +0100, Matthias Schiffer wrote:
> > As it turns out, this driver is broken in yet another way I didn't find
> > before: For changing the global prescaler the chip needs to be put into
> > sleep mode, but the driver doesn't follow the restart sequence
> > described in the datasheet when waking it back up. In consequence,
> > changing the period of one PWM does not only modify the period of all
> > PWMs (which is bad enough, but can't be avoided with this hardware),
> > but it also leaves all PWMs disabled...
>
> I am unable to reproduce this: If I set a specific duty cycle on a
> channel and then change the period, the channel stays active.
> I can see the brightness of an LED decrease if I increase the period.

What happens when pwm channels 0 and 1 are both enabled, and
you change the pwm period of channel 0. Does channel 1 remain
on?
