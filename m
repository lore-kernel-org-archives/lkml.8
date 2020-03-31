Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D989FC2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5A421655
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzMxVGwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgCaUEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:04:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36619 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgCaUEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:04:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so27624185wrs.3;
        Tue, 31 Mar 2020 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UHdtpmNlEgWbecKIVlq+Ov+Rk+ScycQMzISoFavuEvQ=;
        b=IzMxVGwBBhIiTVO1CMZDD1n2kizDmKME5oawb+ZWELISu0sky9Simloc6nR2q0U3iF
         K4KoAP4/anysHUpqwPS244Sc4KdqaElaWJ2hb/RB9vcN2wmCi2e+JWCekUxRW6VnY5uR
         CT6ZWGnbpc03LQqAt3IQerRAJv3cOasxtX5ctMfTqkVFU6G9F+8ysDRka4p5NgX2Ecia
         qHMf++wDU3r7ib5RdlxfdaO5i+AVmAkvBWfGMp0v6RBioUDbxeOjPzs0ThZ9etMc8kZ3
         mearePTOKXEd7sdy+XtEWJZD4YE2BddKMX3e+Ck2OyDwbEORNnbwLtY/IRj1+0iMeS2q
         MwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UHdtpmNlEgWbecKIVlq+Ov+Rk+ScycQMzISoFavuEvQ=;
        b=uZvB366YZHwY3NJi8a/jxBT/dTISwifRq52M5V3hRyv90FmmC1pxYBmxj15GVIAE+z
         2x5LlvQ2l9M3JPq5jBOzo+x2mMWcqb6NYhh6jX+J6IKAHrKALOh/65u4YEVP2TGpOSZi
         pT7P1ZVxmcfHt83qN4XbPQSHkUpfZvtERM1GZ42VPqev3UczRl5DLf/T9Gh5OTUlq4XM
         bEIcYJobuGF0lhI5dNjoRqJSNsrgsTokQq3JzHbli7+ClYzzCsvAPYEcduyzjA3qSOEn
         ca4H1tRBnvFYAckcJN3x+S59C7aDqU2sKTVfvGbYQJYXdJUf2Rz1gIjKuVehuvresnCe
         mRgg==
X-Gm-Message-State: ANhLgQ0pTR9NsOA0dOSxkGfnahbs357f4kz/quPymzQ/9dt6Oope88DF
        Fg/UpHYQ2HttFHvQLTEC8kQ=
X-Google-Smtp-Source: ADFU+vsoqPUeoceCBc0tJmFLtT6fk3aBXnPYxuCk3EqhlxfkRaqgChkdeyRBzCSYfsTb56ApoJt+Xg==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr21893111wrp.130.1585685059219;
        Tue, 31 Mar 2020 13:04:19 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id a64sm5182188wmh.39.2020.03.31.13.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:04:17 -0700 (PDT)
Date:   Tue, 31 Mar 2020 22:04:17 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] clocksource: Add Tegra186 timers support
Message-ID: <20200331200417.GB2950334@ulmo>
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
 <20200320133452.3705040-3-thierry.reding@gmail.com>
 <df532fef-1533-9da7-d676-f4671746fde3@gmail.com>
 <20200320150406.GA3706404@ulmo>
 <5a559950-0497-b24f-6484-c2513375fe62@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <5a559950-0497-b24f-6484-c2513375fe62@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 06:23:35PM +0300, Dmitry Osipenko wrote:
> 20.03.2020 18:04, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, Mar 20, 2020 at 05:39:01PM +0300, Dmitry Osipenko wrote:
> >> 20.03.2020 16:34, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> From: Thierry Reding <treding@nvidia.com>
> >>>
> >>> Currently this only supports a single watchdog, which uses a timer in
> >>> the background for countdown. Eventually the timers could be used for
> >>> various time-keeping tasks, but by default the architected timer will
> >>> already provide that functionality.
> >>>
> >>> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >>> ---
> >>>  drivers/clocksource/Kconfig          |   8 +
> >>>  drivers/clocksource/Makefile         |   1 +
> >>>  drivers/clocksource/timer-tegra186.c | 377 +++++++++++++++++++++++++=
++
> >>>  3 files changed, 386 insertions(+)
> >>>  create mode 100644 drivers/clocksource/timer-tegra186.c
> >> Hello Thierry,
> >>
> >> Shouldn't this driver reside in drivers/watchdog/? Like it's done in a
> >> case of the T30+ driver.
> >=20
> > The hardware block that this binds to is primarily a time-keeping block
> > that just so happens to also implement a watchdog. Moving this to
> > drivers/watchdog would put us into an odd situation if we ever added
> > code to also implement the time-keeping bits for this hardware.
> >=20
> > I also think that the way this is done on Tegra30 was a bad choice. The
> > problem is that we now have two drivers (tegra_wdt.c and tegra-timer.c)
> > that both access the same region of memory. This seems to be relatively
> > safe to do on those chips because there's no overlap between the timer
> > and the watchdog interfaces, but on Tegra186 and later the watchdog is
> > actually using one of the timers, so we'd have to be extra careful how
> > to coordinate between the two. It seems much easier to do that by having
> > everything in the same driver and have that register multiple devices in
> > the system.
>=20
> Sounds like a watchdog on Tegra20, where one of the timer is shared with
> a watchdog function and there are no other free timers. Well, yes, it's
> not nice.
>=20
> But, will you really ever need an additional clocksource on T186?

Actually there are a couple of interesting clocksources that this IP
block exposes. It contains both a microsecond clock that might come in
useful because it is used as a reference by some other blocks that work
with microsecond counters (some hardware sequencers have this). Another
one is the OSC, which is the system's main oscillator that most clocks
are derived from.

Perhaps the most useful source from a software point of view is the TSC.
It's a timestamp counter that can also be used as a reference for HW
timestamping of certain system events, which is something that we want
to upstream eventually. Having the TSC exposed as a clocksource can be
interesting because it allows us to correlate these hardware timestamps
with code path execution.

I've implemented the three clocksources above for v2, which makes this a
bit more of an actual clocksource driver that additionally provides a
watchdog.

Thierry

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6DokAACgkQ3SOs138+
s6FMIxAAoCYsWe+IY3ytIC/02QyzX5KnRb+IX1AY0MHh2kyj81Hob63jYaQ0HrtP
ymISbPdFdAX4y3eLAQlMnwJVHXuunQYFR2DbRcPwPKGPyZV+pqZvq4w48SZOZj1f
VermH6f4blRHRU1ZCFFJ+TK9DT68/pDwJIZ0jyraH+/25Agks8cvdvsARi68CASv
V5PYYFO26EgxEXRUJXJYUtRgBTvvOFyaFjb9VitzI0kyO9F9CFKUkAcH6rdaWxXX
3xabjHFoQ3Rzt2O3ySW8vdGgPU0Aermhi37yW3Wk8hsHWoLyReewyjPOe5vXt1cA
l488PX9IqRxWuX2IGu/8JQJZKBdy2P3N0Y/PubdYa3fHYtGmnKtLbTL1cxVgJOg7
SVJaJF0HPvBznlagVc3SOo6qSla7VBEmjocUiS661edkcMOuh9HzlzQNYiRNfsep
eITV/txmuwv4uaCq0BIDPtmUlMFbskSSPXOhM1k+Qac/36Ut8WzCPVwmdcgnDv/1
V2KdWemZx87cDNl6f2ZiVSZMxaQDPj3qef/Gx6xCvoFri1SkJ57TUBVXSqCgdONw
rbIHVc5Vwper63O4N+vDngUVhaTsoxhBnxmvzp06K8EG5QcB6SE1Qih3L5YFzyRo
V4LJgEpG/mweeOUe2HH0QvPZZR59508vU+xklRXRvicTDGk7Q40=
=mTk7
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
