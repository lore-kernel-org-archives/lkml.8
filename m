Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D06C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA142080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPYcoJko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbgCaT6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:58:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40373 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgCaT6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:58:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id a81so4316486wmf.5;
        Tue, 31 Mar 2020 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LwQT3yXKfI7uwUaB654mC4X+UBiWgwF7UPf2l2JMMFw=;
        b=aPYcoJkod2WP1CpE+qUzc0AuVUuUZjrRWqAOnTs8vD31A3EwJvccLdgGDQpueHGeYm
         KRmGSwZY20EfRKzFFU6TQCsakLg8jzDOf24PqhsQe2orVdmV5Jo8y0aADaU5HJ/x6agz
         NYBRbmPhrQqXEpHMKvkK2qpJ6ZUW113yPWrKVhCU+ZbQdINhzq5IVMmBt0uPcJqnLGhI
         2FNfv+iFB+7fhcjw8g15QfSSONRQaRaAAhu5YzcWKQrqU5GbzAdFyAfZTWc4rE6nKuKT
         ZdQUwK1OicEyxoid1ybOTTnzfMmAwTrlHKRogpK2i8fIXCsVtEKmrjFPYWw8tV/ASLJB
         i00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LwQT3yXKfI7uwUaB654mC4X+UBiWgwF7UPf2l2JMMFw=;
        b=KLOJ5zkDif0TAZnpk2LBGLer+FZ/FDIRFxb1ljEYtUQXpUh3ApaGYDNvLpYRQf+7U3
         yx9HHIgU8Udkn8oqd8SLlNIRBaihrPk50ZjE4K/1Pghk+TXiF/wJNggeEw6o2NdQpW12
         02BgDsD8xCRgBcr0RHtlNDWFjUa0GZRNqrqOaYiiuo9K1s4JkSeTvy5fHCYXdfmJ3yZ1
         oRkc/c84u9YGqoPWuJC7ZAk+Zf8HYbWMrurfA0L9zNeRjxMUZs/qwbCo9NIqjcUSjArS
         qsP9wTtdWzUd+a6dEBZ2Y1z5TuRcLSwULGOd+TT09EMQ/4lHdZ4Rh6d4nNlZxhy90d5Z
         8t1w==
X-Gm-Message-State: AGi0PuaQ0S1dKhWnR9gGxfaJ5b+ptejOMctXiuQeVk2ftn1fOJxx7yOX
        wEr44Sx0ejBwoxP5IMOBevi9S9jw
X-Google-Smtp-Source: APiQypK9ivnKRKmOutetEtHF/osxgWbDh/gs7scWWuULcoUMR2pgPDyX8P5NVn6/G3NKH8eIv9aDmw==
X-Received: by 2002:a1c:8103:: with SMTP id c3mr506404wmd.166.1585684723081;
        Tue, 31 Mar 2020 12:58:43 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id a73sm4886148wme.47.2020.03.31.12.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:58:40 -0700 (PDT)
Date:   Tue, 31 Mar 2020 21:58:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] clocksource: Add Tegra186 timers support
Message-ID: <20200331195839.GA2950334@ulmo>
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
 <20200320133452.3705040-3-thierry.reding@gmail.com>
 <48b2099c-dd83-d4dc-aab4-8c6f68a215cf@gmail.com>
 <da2a0501-664a-c5d0-7b13-174e5347eaf7@gmail.com>
 <20200323134221.GI3883508@ulmo>
 <b3859b98-02a3-d197-735c-2c9a9fbe597c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <b3859b98-02a3-d197-735c-2c9a9fbe597c@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2020 at 04:45:57PM +0300, Dmitry Osipenko wrote:
> 23.03.2020 16:42, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, Mar 20, 2020 at 06:38:32PM +0300, Dmitry Osipenko wrote:
> >> 20.03.2020 18:11, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> 20.03.2020 16:34, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>> From: Thierry Reding <treding@nvidia.com>
> >>>>
> >>>> Currently this only supports a single watchdog, which uses a timer in
> >>>> the background for countdown. Eventually the timers could be used for
> >>>> various time-keeping tasks, but by default the architected timer will
> >>>> already provide that functionality.
> >>>>
> >>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >>>> ---
> >>>
> >>> ...
> >>>> +config TEGRA186_TIMER
> >>>> +	bool "NVIDIA Tegra186 timer driver"
> >>>
> >>> tristate?
> >>>
> >>>> +	depends on ARCH_TEGRA || COMPILE_TEST
> >>>
> >>> depends on WATCHDOG && WATCHDOG_CORE?
> >>
> >> Actually `select WATCHDOG_CORE` for the WATCHDOG_CORE.
> >=20
> > WATCHDOG_CORE is user-visible, so it's not safe to select it. Any reason
> > depends on WATCHDOG && WATCHDOG_CORE wouldn't work? I guess a dependency
> > on WATCHDOG_CORE would be enough because that itself already depends on
> > WATCHDOG.
>=20
> It looks to that should be much better if you could factor out all the
> watchdog functionality into the drivers/watchdog, like it's done in a
> case of MC / SMMU drivers for example.

For MC/SMMU this was done for historical reasons. Both drivers already
existed in the respective subdirectories, so it seemed best to keep them
there in order to avoid churn.

This being a completely new driver I don't think the same argument can
be made. There are plenty of drivers that register interfaces for
multiple subsystems (e.g. there are a couple of watchdog drivers in the
RTC and hwmon subsystems).

Daniel, Thomas, do you have any objections to merging watchdog support
via this driver, or would you have me split that off into a separate
driver. I could potentially do that using a shared regmap, but it seems
a bit of a stretch for something this simple.

Thierry

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6DoOwACgkQ3SOs138+
s6G5pg/8D1jG9NxLILYfObR9KHJBvL1p27eq0x6zFEgQ8dAgKAElH8BijZcAA3Wz
ce4T22d1hTejR1rgRUVSB874iq087zuKLDZxCyb1GxWjBFsElWdDIc1gApNDTOjK
RekWsJP5RrEwjEU5al18UsUXRPwCw5c8A+R8md4LKoowPKOYiX3UWOvFFFKLtkU2
DmT1TDbnErgiMZaiQT8Bon+kiRcoX9e15CWwP62GVIW3ZnJ57H2OyJNs8xcCfAmg
O3OGa4zfibmcWmQKgvYEoR2GYBpMn5EXTZNi3ldacRt9MByV9hacm4GQRlWcMzQa
umA3knZiTpaNFUKBCyTLJeTw7d8Qs0rkcX9cDZZQMAzN4y8EbVnLkbsTK7FudKR7
kma3ByCG9VYIf7TOqMBBBTyhqX+6bR4jSgizzCNg3PjWgcq9ZsmeM0FiEPSuRKTy
W/kFXMKInEfZaQAIOI/QiZmZy4Gwu904kCuvxaLJkOpNpc/JmOzwurfTc+1psDNZ
BhiC2D+gN9r4SKBlkf6aPjaEUuORoswEUoQ6WOClsrqB0PujhzTfNEIt0GS3oPVr
XdjYUlX0EHFJLVUtTyZm6YB6TM3J93fNqIJLgu/Zusyy9oZieL61wiQYh3Jn/5SX
63JrNxBszqDA22k3aaUaSYXMyTz+HgCyC2iP0cCPDuNQpRAYVeU=
=tG6K
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
