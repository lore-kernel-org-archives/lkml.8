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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59141C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD8C20735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrPg7/C7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgCWNmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:42:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39126 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbgCWNmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:42:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id a9so11807018wmj.4;
        Mon, 23 Mar 2020 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dvv5KYSeov008fjUZCDYRHsqDtzSr80A/lH3aSDQD5E=;
        b=RrPg7/C7thNc8X/4PiA5n/W5hrKfI7MPm0nvlwemPmWTKwPoP3NLiuGw9Sqw+Jmn7Z
         tOt4YX066ke1FyUiB1FTDl7OCDL1xd16p24y1dlAElec9E4RXulc2soY1hDTpz7y1Rev
         vAm6lCHCZPhs95Ph9kLOlLkApkZfeSSzyqWot9EIaa98GMoYJiTk/s+0PvA4RP2gMynG
         vGF24ilfDnW3rowMdHf8Yu6dvF71Flers3bbyPiC30kxObdITZ4hlAG2uUnncM+kMNKs
         XnKOQWiFd0e5OqKa4hofFihWKOFiZLTjzhM0NAePhccdxo23pzLcmjWxwNxsEijQFrsR
         7eiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dvv5KYSeov008fjUZCDYRHsqDtzSr80A/lH3aSDQD5E=;
        b=ovJa6EBc6o9/8bR1gAKurgePhKLdud11xGsloTncqK6a24d7QBOTwCJDjoB4nzeCCz
         hY6Uvl6X7z0jk9qOHAy6fQm5pVVqz4tRc+A1ANUh1z96C2s33JB534P/0oBe3NB6+UP5
         SRaj+c9AMd3dBauPMCokJMrKvlO54M7C31/8yEdD+mfRmkuYXxhQwhTyxj1KSul4cpZl
         ZhxfusG8sq+P3kXITDhTgpvNektfgTx1GQp2ixebxh5l7DBvICeA1f+R2bWP4zxA+A3X
         FuKDB/+uk4ke+tm+c7wmyV71iCfvYTsjbNQ4ojj0L4LiPF6Rxbhe0up3bUjwNgmvfK0R
         3RZw==
X-Gm-Message-State: ANhLgQ3WNE8aBjPVcBxRSE4qkBTrxVDyOrqUvHwQuvR1P4hLXNkeAzq0
        X5PBbyA5sQafdhqaLHpdv8E=
X-Google-Smtp-Source: ADFU+vtufi/fRnjgu+sdiS+TXN9VAeQgZRDtSwHzjcT1C05POrW5So60IPYjv6wBJnt0M/RgA/GUFw==
X-Received: by 2002:a1c:1b51:: with SMTP id b78mr27326933wmb.8.1584970942965;
        Mon, 23 Mar 2020 06:42:22 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id s15sm25038525wrr.45.2020.03.23.06.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 06:42:21 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:42:21 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] clocksource: Add Tegra186 timers support
Message-ID: <20200323134221.GI3883508@ulmo>
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
 <20200320133452.3705040-3-thierry.reding@gmail.com>
 <48b2099c-dd83-d4dc-aab4-8c6f68a215cf@gmail.com>
 <da2a0501-664a-c5d0-7b13-174e5347eaf7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BWWlCdgt6QLN7tv3"
Content-Disposition: inline
In-Reply-To: <da2a0501-664a-c5d0-7b13-174e5347eaf7@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BWWlCdgt6QLN7tv3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 06:38:32PM +0300, Dmitry Osipenko wrote:
> 20.03.2020 18:11, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > 20.03.2020 16:34, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> From: Thierry Reding <treding@nvidia.com>
> >>
> >> Currently this only supports a single watchdog, which uses a timer in
> >> the background for countdown. Eventually the timers could be used for
> >> various time-keeping tasks, but by default the architected timer will
> >> already provide that functionality.
> >>
> >> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >> ---
> >=20
> > ...
> >> +config TEGRA186_TIMER
> >> +	bool "NVIDIA Tegra186 timer driver"
> >=20
> > tristate?
> >=20
> >> +	depends on ARCH_TEGRA || COMPILE_TEST
> >=20
> > depends on WATCHDOG && WATCHDOG_CORE?
>=20
> Actually `select WATCHDOG_CORE` for the WATCHDOG_CORE.

WATCHDOG_CORE is user-visible, so it's not safe to select it. Any reason
depends on WATCHDOG && WATCHDOG_CORE wouldn't work? I guess a dependency
on WATCHDOG_CORE would be enough because that itself already depends on
WATCHDOG.

Thierry

--BWWlCdgt6QLN7tv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl54vLwACgkQ3SOs138+
s6Hm6w/7B3Ghz0ANr2BofgzITgnu5EWzIVG8pCMCtGBR/7mX8IPwLWoO4VG/6ku2
Q23YgLA2+IGMRsLJ83Ln7T5ErjdPZ/r903q4d3DMp6EdKRdaqU45dDrbYyf7Zi/4
sU2xati6QaZxxUEOtQbg+8B+2y1lLSqo5f90dIZu8P/6Jf1oAyvgSyzvWXf77936
6595a5kOSRGfl5/X+0cZ8am6o+zr6Pf3MdZ6+znzSG4PRqGh8UrccEg7oQvmsuib
ZOk5Ka5ZZQ7I8fw6vGIAoGaBKY2wnr/SnWGQNCaqf+PW2wrtMiHLeqhrPtk92IDK
pSQvAuxHHAuO2S/gPC+BAVBkrm2MuGuMzdYg+4HRxrjsb7nKwiei7sCGx3uCirEh
JLLAfG+wV4XpwuswLW5ZWM+IwIvI2JmrUYn1lFyFwfqf5G82zh236fdhNsZI4iK0
jYrGdGLAnHg0B8BJIUC5VAWvpnibsslVMcAYMuS/q98mfbul7uRFK7teqnXsj7mw
i2nc1CLzPmaJPLNxpmCQOeNReiCmOM4jvhMY+qY0bjw8jx3RWLT1g8P4tsO5shXT
17YjuI0aJ5G5iBXcsjHEi8SVVWximHxgYCQpk5kILgwOchRn+58h7YF9b6rBVdU/
K5wOe5gXnVKaD6lyI2AjbPtWp/Dhk89nY2DnO4q+tdopRhze+S0=
=AZjC
-----END PGP SIGNATURE-----

--BWWlCdgt6QLN7tv3--
