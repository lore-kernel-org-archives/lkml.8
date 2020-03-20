Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388ABC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C73120714
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRA19fu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgCTPEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:04:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39772 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCTPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:04:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id a9so3640268wmj.4;
        Fri, 20 Mar 2020 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1GiuJyGsjNtM5Phmoe9KIrVPCocH82oEHgJOFMBlmMU=;
        b=JRA19fu3A7tVl3C/HfzPH0yH6mIxqw4uN6dSCDae6n9/50Fb3iYQZREKKEgJZfFvew
         shodPiJ1gXPhXbfb2PMc32wUp1XmyUybtIcSFtnVK+cHtsu1CjLzG2F00oG8rZJmihU2
         PhmkbYrVCSs4L8PZs19CXYTI7DujTDsBEh9A3X5e9t07hpan290jnj2Saxd4MM2IHDVH
         sdCOZ+kGnVquwUWiURXRuycWyKPjMJWV57baIwGRsNWriGhtXbfwQn1bza2E+HVeeS4A
         +xwJoMmvvuC3T1xpKw0E+O221EDR7JReo/qOtOM9YwW7qbJS0jBJ1vfSn1iVFQtupMRr
         xG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1GiuJyGsjNtM5Phmoe9KIrVPCocH82oEHgJOFMBlmMU=;
        b=O7jDU6cqerOwPU1H/bdMiYKJe654MvKPrzwKAOYaXsrVxlPoLCPXm4JHm3QQpuw/qT
         9j5hNmCr+s86o2hvTKPzmUBtnq6tHP68Rvwp4UYrEfujFOV3WQGOUcdSGU0IpmTezJWF
         jNCO9djckUO+5Ku2cYpQY25m9vu6pImyJ1/VDk4AOI77bZ7JU71pB4cco//5t8yuRIWM
         Cyxci+58i4Uei7WGjgC0VFcnni+oiBh1VBJIjPt6VlANDY/8KV2d1+vthoo457tqkOSL
         GAbozaotAzBkZ+a5OAHkCbytaFFR3zJAa5FOG7xFBZD3mTpnXrmxitSM+jhqy/piDHES
         gBPw==
X-Gm-Message-State: ANhLgQ1VbsMWxR2Q6yOzCi5JDZaSpK5RwO1KEAt703BNtmHY5q630ego
        XaK5K5L8lWvR6XcA3EGvaMk=
X-Google-Smtp-Source: ADFU+vt81cc2imJ8fmVCYWyWgOo/Va53SVBE3LCF/FO0W0+y1YgXKqU1rL+UUzuGw5RDjiep4PtnEw==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr10532034wmc.156.1584716649358;
        Fri, 20 Mar 2020 08:04:09 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id c85sm8259057wmd.48.2020.03.20.08.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 08:04:07 -0700 (PDT)
Date:   Fri, 20 Mar 2020 16:04:06 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] clocksource: Add Tegra186 timers support
Message-ID: <20200320150406.GA3706404@ulmo>
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
 <20200320133452.3705040-3-thierry.reding@gmail.com>
 <df532fef-1533-9da7-d676-f4671746fde3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <df532fef-1533-9da7-d676-f4671746fde3@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 05:39:01PM +0300, Dmitry Osipenko wrote:
> 20.03.2020 16:34, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Currently this only supports a single watchdog, which uses a timer in
> > the background for countdown. Eventually the timers could be used for
> > various time-keeping tasks, but by default the architected timer will
> > already provide that functionality.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/clocksource/Kconfig          |   8 +
> >  drivers/clocksource/Makefile         |   1 +
> >  drivers/clocksource/timer-tegra186.c | 377 +++++++++++++++++++++++++++
> >  3 files changed, 386 insertions(+)
> >  create mode 100644 drivers/clocksource/timer-tegra186.c
> Hello Thierry,
>=20
> Shouldn't this driver reside in drivers/watchdog/? Like it's done in a
> case of the T30+ driver.

The hardware block that this binds to is primarily a time-keeping block
that just so happens to also implement a watchdog. Moving this to
drivers/watchdog would put us into an odd situation if we ever added
code to also implement the time-keeping bits for this hardware.

I also think that the way this is done on Tegra30 was a bad choice. The
problem is that we now have two drivers (tegra_wdt.c and tegra-timer.c)
that both access the same region of memory. This seems to be relatively
safe to do on those chips because there's no overlap between the timer
and the watchdog interfaces, but on Tegra186 and later the watchdog is
actually using one of the timers, so we'd have to be extra careful how
to coordinate between the two. It seems much easier to do that by having
everything in the same driver and have that register multiple devices in
the system.

> > +static int __maybe_unused tegra186_timer_suspend(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused tegra186_timer_resume(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(tegra186_timer_pm_ops, tegra186_timer_suspend,
> > +			 tegra186_timer_resume);
>=20
> Perhaps will be better to remove these OPS for now?

Yeah, I suppose I could remove those. Although... perhaps I should just
try and make this work properly.

Thierry

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5022MACgkQ3SOs138+
s6FsBQ//Ri1u6rKgOJuYjvW33oLfxl/pb6GVz9aRl6ejeEQtO8CN8QmHsXz5kvSa
YVjGMinw5iqwSHHvSL7gs1GM13V4xCe3MkJ/N4BIkeXstty6xEM3hHPhBjLGvQEp
oRxvQ8q+pOhRBwqM7qQqOGs+wBhsP2w62zguSbZPo/uQdf7rZ+7FaTc2qUDITtgh
gZaxzE7XOoDuRy2xCahMQgcJqmQk0X27cr62Zis1tSrIudx6UxUgnv5Pey1cvpCB
a7wUSeOab+tLy4AG2ujBkQjz8O8s1pYrcRwy+XamzyqLGU+bcpAgSXqk5E13uhjG
L8LT0yfFRoIRSW1pGjAHo+LdhxF3jBHThH66yfcn7epBscwygmAwYbOZKskVrwuL
updpuGcZ29v7nWxG8dVrz/gDKbmzMSAmS5E2XBCK+eNLnYSnW6eaLf9rcYcZgMG0
HErtuhhsRtUaaALt1sDtyy9rhtUACktCK5biH+xgjVU+o84/gM6bYK7mOD6ATMgb
Z2atcIMJZK1b+K1luk60X3Yno2XSuwHKUp9HQaQhXR0ABdsKV7iMSooa8jmuLXaC
9UTrVD9owoF0uz73HSb9Ch9rPGG7Nb/uB7A2sPWmf3S3SnPfDimSelkaSH9jKzH3
CKSUHhALPD38t+kV5IzdfeIfXLbvtM+JXE5Njw2GVQfUS0m7cK8=
=f02j
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
