Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D623EC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D5B20735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNUzSNGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgCWNik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:38:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46265 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbgCWNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:38:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id j17so13705347wru.13;
        Mon, 23 Mar 2020 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mB1YokxVBqP8LBRJbFIhaNMH04KnhGNaz7RjxY84kjs=;
        b=GNUzSNGM3NfvFnA2phx1nZ3F7XeM06VgJ09maRproeAYkhJRs0KgNMi5LuWhIqQO6V
         l9y+kNDAAUSWfjR3J6plbj3kwKP7FbAljSADb+papgmSDYWQ6RFjhY19og/C1NudsI1s
         zR33tEF11ot4yinqFHCWjvDiXGVyQgc8GuEblrMUA19/hN8Ss5ZgVvDUUeMIh9aNYjYz
         U/ztPvnlPtjmJyuhI5DYZXFQiHHy02Aq9vGN4C3TONqJQU8yy3T+Nu/uVZsbCw88G2iK
         MZ2e5d4w5HKcGogDWmy9FGh96AUy90NNyTw1TDfvT1cptPM9hn5aaelC6mkME9U/Sm98
         yBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mB1YokxVBqP8LBRJbFIhaNMH04KnhGNaz7RjxY84kjs=;
        b=SFhH8K1aVUurlKCWmF4q5e/k7t5cnaQWREtYDE3o0bHxXeeT/MIKalBciAzvg5BmgT
         Q1mBHKJhIINjFHrbLl2+nHGHdBmJLtQbb25rWYcqpW1ebVMB+y0C4lawa4huTwlMMV0g
         Yzs7emWEi5iW3+/cnZUTc/kjrJWPNkTIHkJQxqhKHKGX34leNwqO88Px00jkIu903vKM
         aI9yq0yx2ddCj3k1fKfvx2bBncz0JvGGP4xrhc9Rcss5DDcfJE2xirCoozlMVAdt5CE2
         aGd8VGr3irxZKpDXnJg91FYBBahvAMw2zOwIuugqciaX9FINVZuz9dSxxzOd7pMreD0o
         DrLA==
X-Gm-Message-State: ANhLgQ0FJL5sQBd++Eb4BR8fpuuho8ANwVcH61LH3guwFhqdq+duwtXo
        ldkMtCgKIfY8BXadvnuDTcY=
X-Google-Smtp-Source: ADFU+vvKINuj0Pk6ZBI/AFTWwaMtddjaDwM5Zwj58tpuGQNPXYq6gYWorGio39rOMeRt4RAeSNoh1A==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr30855152wrm.306.1584970717995;
        Mon, 23 Mar 2020 06:38:37 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id a73sm20893289wme.47.2020.03.23.06.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 06:38:36 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:38:35 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] clocksource: Add Tegra186 timers support
Message-ID: <20200323133835.GH3883508@ulmo>
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
 <20200320133452.3705040-3-thierry.reding@gmail.com>
 <df532fef-1533-9da7-d676-f4671746fde3@gmail.com>
 <20200320150406.GA3706404@ulmo>
 <5a559950-0497-b24f-6484-c2513375fe62@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ecMC0kzqsE2ddMN"
Content-Disposition: inline
In-Reply-To: <5a559950-0497-b24f-6484-c2513375fe62@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ecMC0kzqsE2ddMN
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

I don't know. It's possible that they will become useful at some point.

Thierry

--3ecMC0kzqsE2ddMN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl54u9sACgkQ3SOs138+
s6HhmxAAlcQJPxMadaHu5SXzYWXICljQrwPSVzxl0B1ALvIUVRQNswXyEcmtWBQ2
jZ4hHyPoUuQoiFr5D5gfvYPigp39RNCxijn9kDL/QwzbLld270PZvpQIuosuhTrN
737BcaHkhzy+sdlqf7HQC/OWPd5qwMegVL1If2UwvoyB8ENeHngTuH9PQClVXwsf
IPeC1ewK5l0kJGnpwUNPURjCXT2vhbyG7fGWDFfkF7muqOWG8eVQLzZLfVTE47p8
Jq81lMF/u+Bwk/GVtMDQfS4SIH97wBbuSJYb/qRiD/mO3ojdaBq6N33GfeBlhs0v
zgFdQqFgh+hBQPf9S1kX7ViciQZAJDYxQ2pQw4Cq0MYxWur4g0Ke5UWWRWmWqmrp
ab0DbqmsaMopG2tlKkcuFUucET4szrP0wTS3X2wqNqYp96LBECD9bvnPvjJo1Dro
Yi9kB4GCGy+YQJSeMPnHPz7siZ+OIsMluEardSz65G37CHA/DbiZLi2v8NS4h37K
+qeOyILxXclDn54NpV13hIdvTBfDn/iysaVSBbWfNiy02UX+4a8jDe7tdkoHp4cg
ZinamyX87pzkAOJYO1UgpbdjjGK93pClLZn5JLacJW9/QUIiag2LoeImZIM9a/hX
YFThiI6Guo9EGewLfjuKu7sYdK5GL+LUtzHrZ6W0SfLLWSu60yA=
=wIxO
-----END PGP SIGNATURE-----

--3ecMC0kzqsE2ddMN--
