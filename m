Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC710C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8FF2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8oLm4/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDCUOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:14:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42076 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCUOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:14:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so9981458wrx.9;
        Fri, 03 Apr 2020 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NoBEXm3PM7ViLuA7xdCYEzaMez2zPl2CAWaYAKT35qo=;
        b=u8oLm4/u6yhguQiY5GBjDNzNtA5FKa3/SGbDE/zNXAOn66bh1m4H6G1SuZ5szmFiVV
         21LbiUR7FLGlZSKiLxPg3k4ThBOECagOsIvdHl8TMIndDKHafy4Z+gl82DSoN7d4E5li
         p9gR8BjnnW9nNgUzDk60PZOch1m2CE5uHpfbY5ODnVFiS0l/9KS5P2q6XSyEqU8Q+4nW
         n+SLJY1AfPefvgOrKrgktkgoar7j4XUr5G8JsHio/YJGXAVIJlUb6cQY2AYV+ru7V6rO
         KYVGVmzGZt2Be3aK8sbz81jejUHiaS6ZJ+WJCDpYIu11RNlR5tQCZq89gqPNw68gsE13
         U3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NoBEXm3PM7ViLuA7xdCYEzaMez2zPl2CAWaYAKT35qo=;
        b=oJN96oftl0yFJGQSZ547m2xuITMxrKf7MjnkY16pI6y9ni1J2iHdPKKugQmPWsUpCO
         zc3CPPH0iKGO5a6ZDmueNa6uRwpoq413hYHwFTdrVMhEHRdT34QJ2/hzLF9Zpj8wXoEP
         Te2OqxJ8XciiFWamuVoMuN94ox7Y+F6elvdW/L92rvlwpRumWxR7B514GIlqSJe8Cz1X
         2H9/UWncUg9fCihMaM+36CI5Wita6L1GbuVCDwO6ZhXdF4pf2GVQZRwIa75XRWHtm8P3
         J9LWKC0WZvLIl9arnDpU/3mVNVRFlK/oY9z6FIS2Xao0Ql3UzLcBdB8FvjNk1uNWUKgu
         IFmg==
X-Gm-Message-State: AGi0PuYvxIb7IWFBS1RI4dtDc/8BuhkEVvf5Ag7oJQwc8FMP4zUb745h
        d+v1xYdOV8RAstekPCSF9gM=
X-Google-Smtp-Source: APiQypKIvi/R/MRCGgyXwqhz7VgOqKDwXIL3i/xWKBtpZeTMgJ7o9HVK2E6+mhjM//qsYh2R4giPMA==
X-Received: by 2002:a5d:4305:: with SMTP id h5mr10387381wrq.69.1585944877094;
        Fri, 03 Apr 2020 13:14:37 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id d7sm13081031wrr.77.2020.04.03.13.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:14:35 -0700 (PDT)
Date:   Fri, 3 Apr 2020 22:14:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] clocksource: Add Tegra186 timers support
Message-ID: <20200403201435.GB282587@ulmo>
References: <20200331221914.2966407-1-thierry.reding@gmail.com>
 <20200331221914.2966407-3-thierry.reding@gmail.com>
 <edf08b18-ad19-7191-020d-a06d57747c45@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <edf08b18-ad19-7191-020d-a06d57747c45@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2020 at 07:24:55PM +0300, Dmitry Osipenko wrote:
> 01.04.2020 01:19, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
> > +static int tegra186_wdt_set_timeout(struct watchdog_device *wdd,
> > +				    unsigned int timeout)
> > +{
> > +	struct tegra186_wdt *wdt =3D to_tegra186_wdt(wdd);
> > +
> > +	tegra186_wdt_disable(wdt);
> > +	wdt->base.timeout =3D timeout;
> > +	tegra186_wdt_enable(wdt);
>=20
> Why changing timeout enables the watchdog?

We have to disable and enable to make it accept the new settings and to
restart the counter. But you're right, we should only do that when the
WDT is actually active, so I've conditionalized the disable/enable calls
on watchdog_active().

>=20
> > +	return 0;
> > +}
> > +
> > +static const struct watchdog_ops tegra186_wdt_ops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.start =3D tegra186_wdt_start,
> > +	.stop =3D tegra186_wdt_stop,
> > +	.ping =3D tegra186_wdt_ping,
> > +	.set_timeout =3D tegra186_wdt_set_timeout,
> > +};
>=20
> ...
> > +static int __maybe_unused tegra186_timer_suspend(struct device *dev)
> > +{
> > +	struct tegra186_timer *tegra =3D dev_get_drvdata(dev);
> > +
> > +	if (tegra->wdt)
> > +		tegra186_wdt_disable(tegra->wdt);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused tegra186_timer_resume(struct device *dev)
> > +{
> > +	struct tegra186_timer *tegra =3D dev_get_drvdata(dev);
> > +
> > +	if (tegra->wdt)
> > +		tegra186_wdt_enable(tegra->wdt);
>=20
> What if watchdog is in a stopped state? Why it's enabled unconditionally?

Same as above.

Thierry

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6HmSoACgkQ3SOs138+
s6FW4RAAivFPt4wmSN/9pbmq+eZfLIcpD3oZlXbL4yI4SqecIYtiMjv406AYhe7r
yFWTJLJHguzw721iKzgMLjC8wKocFxXv5o98PIW/+TQbNHTtYdOyI9ecHgVU009s
M9u/5nIgdDvHr1eotPo3ROJB+rkud4x4ocXpdbMiJOGemaBZcvkeg1OXX5L5tLoM
8HTkYDPxe1nTnyQZkrlIESN+Eo2HxUge/7lCs99fmoERJmyziqpc2Z3wuKMJ6ZLz
s6/AniQ4Bz5qHsLH7/H2Hwgvyqnx8uBQT2lwEajqDORaBr4LY4NXo2Gvu+mUmCGn
BkLssHrRI5+eSBF7vAJVqbd+xDZUIlFp1CYl7Sm0ujBPdy8JdJMtfyIwhtgPlSqW
PfDade0gHQVHIkDJm6DO9SC/4ox1hE9Q0T+XcFetXnLMa5Rvu2RPFgdp74P62dLF
kOEVQWh537QPMq0RHe8IIwo82WrXjasaOeg0Mp6mJ57AAYLSfRmVuGYvKecL9yyk
OMDLxevX8oMKVcoEOZTBVE+g3Z5JdSnmQAcC48H44TDYYdrVnM4sCZGD93PPtsZS
R6rOBDdfDq9GAEUPSN1i1dE7pROecd31g/DgTUiU8UGo4kO/NKEeCrQ0w82f5U7R
cqO7VJVCj0pX0VQ4vV59/vR6pj9TUt4IMZ+uQD5DT3FuU+zmH+c=
=2meF
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
