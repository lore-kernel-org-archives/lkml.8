Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2864C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BA92082F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUPRzwJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgDCUNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:13:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36690 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCUNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:13:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id d202so9112179wmd.1;
        Fri, 03 Apr 2020 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wsEJM52FjqITgdsSf429CsSk0TPwiRZ68aZtzFN94Hw=;
        b=vUPRzwJcj/YDM1qbu8KWbUbauPHxA67cq+7rTy39mSosD00RlQyFrUwuJGiXYbyaaf
         x5nTJQTQtSr6KmW2+MpuNj24HBENlRnMS472BN4NbQl+4LjVI6Qhi/ritflKqEj0GslX
         VvU0FNaJLmhwL11mqFGiNmxZI6UvvBHm0oBgpmiXpDyz2PAq5k4+OrfCRh3Q8xxX0X7n
         T5UtXpEuq9piEho+Fcum5P01RnMaW+6Wq15sKHaOFpDfCV5WYk7codYol6Nkb5cIv4Ge
         SWJh9f24rE0h6amq6qDEV4Ev/GcvRR5V1ZT6u8XIrREOHFRXSDQX3Ps0ts3MM0Daw7W1
         92sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wsEJM52FjqITgdsSf429CsSk0TPwiRZ68aZtzFN94Hw=;
        b=SwHu7aJerWkEIsbLn6zQPAO/HAI6q1u3on+/KV/oqYHjV3WtImvIp8hCQ9aUh5IZvJ
         WLrBFN3JRu0xG0FXUDR+db3tJlRvVHix/4O/yFdGROiAkumAyJ3QbY7ZHbSE82bjPSzv
         NBLnKM75i8rfXGILxHTiasxRrmKRH9ZS21pj2NZGkPfbeOhLB728dUQTFzUv0xAQ4RBw
         pUd4VXyxoF9upqotgK7Ay02e0vVU3siC7NuW9g9sAXcCaATkEOLv/5eFUT1NhB5kVBHy
         6cvOYB9shMxMcHRXseuQFOaCNjQ3TvKZ/pKCR5zoFu5GmptRno9e7B+v6GBi045f6OrC
         6w1A==
X-Gm-Message-State: AGi0PuYXwZg2UBzZC05lmHrul3G7qK0bw08sj0oARHibxNbYvFSzqx3k
        +LB/mW7ZZrGCNKCppRjNPKE=
X-Google-Smtp-Source: APiQypKILP/vBQ5+0eV259Poz6Ghn9DabvKahRgXG9lNUVPt/FINQVCDPcL+q733jXJTslmM8GmYtg==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr10250771wme.88.1585944792841;
        Fri, 03 Apr 2020 13:13:12 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id o9sm13188464wrx.48.2020.04.03.13.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:13:10 -0700 (PDT)
Date:   Fri, 3 Apr 2020 22:13:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] clocksource: Add Tegra186 timers support
Message-ID: <20200403201309.GA282587@ulmo>
References: <20200331221914.2966407-1-thierry.reding@gmail.com>
 <20200331221914.2966407-3-thierry.reding@gmail.com>
 <de97ce0c-3fa3-9f13-2b0e-f4369f94e113@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <de97ce0c-3fa3-9f13-2b0e-f4369f94e113@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2020 at 07:14:33PM +0300, Dmitry Osipenko wrote:
> 01.04.2020 01:19, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
> > +static void tmr_writel(struct tegra186_tmr *tmr, u32 value, unsigned i=
nt offset)
> > +{
> > +	writel(value, tmr->regs + offset);
>=20
> relaxed?
>=20
> > +}
> > +
> > +static void wdt_writel(struct tegra186_wdt *wdt, u32 value, unsigned i=
nt offset)
> > +{
> > +	writel(value, wdt->regs + offset);
>=20
> relaxed?
>=20
> > +}
> > +
> > +static u32 wdt_readl(struct tegra186_wdt *wdt, unsigned int offset)
> > +{
> > +	return readl(wdt->regs + offset);
>=20
> relaxed?

Done.

>=20
> > +}
>=20
> ...
> > +static irqreturn_t tegra186_timer_irq(int irq, void *data)
> > +{
> > +	struct tegra186_timer *tegra =3D data;
> > +
> > +	if (tegra->wdt) {
>=20
> Why this check is needed? Please see more below in regards to
> devm_request_irq().

We don't need it. However, I've changed all of these instances to
watchdog_active() calls instead to make sure we only ping the WDT
when we need to.

>=20
> > +		tegra186_wdt_disable(tegra->wdt);
> > +		tegra186_wdt_enable(tegra->wdt);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int tegra186_timer_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct tegra186_timer *tegra;
> > +	int err;
> > +
> > +	tegra =3D devm_kzalloc(dev, sizeof(*tegra), GFP_KERNEL);
> > +	if (!tegra)
> > +		return -ENOMEM;
> > +
> > +	tegra->soc =3D of_device_get_match_data(dev);
> > +	dev_set_drvdata(dev, tegra);
> > +	tegra->dev =3D dev;
> > +
> > +	tegra->regs =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(tegra->regs))
> > +		return PTR_ERR(tegra->regs);
> > +
> > +	err =3D platform_get_irq(pdev, 0);
> > +	if (err < 0) {
> > +		dev_err(dev, "failed to get interrupt #0: %d\n", err);
>=20
> Duplicated error message isn't needed for platform_get_irq().

Dropped.

> > +		return err;
> > +	}
> > +
> > +	tegra->irq =3D err;
> > +
> > +	err =3D devm_request_irq(dev, tegra->irq, tegra186_timer_irq,
> > +			       IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
>=20
> Why IRQF_ONESHOT?
>=20
> And IRQF_TRIGGER_HIGH?.. the interrupt-level should come from the
> device-tree.

Yeah, I don't know how I came up with these. Probably copied them from
somewhere else. I've dropped both of these since they aren't needed.

> > +			       "tegra186-timer", tegra);
> > +	if (err < 0) {
> > +		dev_err(dev, "failed to request IRQ#%u: %d\n", tegra->irq, err);
> > +		return err;
> > +	}
>=20
> Interrupt should be requested at the end of tegra186_timer_probe(),
> otherwise probe order isn't correct, leading to a potential race conditio=
ns.

I don't think there's an actual issue here because the watchdog that is
initialized below is disabled by default and won't be enabled until the
userspace explicitly asks it to. Since the watchdog is the only one to
currently generate an interrupt, this should be fine.

That said, you're right and it's safer to initialize the interrupt as
late as possible, so I've moved this to the end of the function.

>=20
> > +	/* create a watchdog using a preconfigured timer */
> > +	tegra->wdt =3D tegra186_wdt_create(tegra, 0);
> > +	if (IS_ERR(tegra->wdt)) {
> > +		err =3D PTR_ERR(tegra->wdt);
> > +		dev_err(dev, "failed to create WDT: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	err =3D tegra186_timer_tsc_init(tegra);
> > +	if (err < 0) {
> > +		dev_err(dev, "failed to register TSC counter: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	err =3D tegra186_timer_osc_init(tegra);
> > +	if (err < 0) {
> > +		dev_err(dev, "failed to register OSC counter: %d\n", err);
> > +		goto unregister_tsc;
> > +	}
> > +
> > +	err =3D tegra186_timer_usec_init(tegra);
> > +	if (err < 0) {
> > +		dev_err(dev, "failed to register USEC counter: %d\n", err);
> > +		goto unregister_osc;
> > +	}
> > +
> > +	return 0;
> > +

And added an unregister_usec: label here to clean up the USEC
clocksource if we fail to request the IRQ.

> > +unregister_osc:
> > +	clocksource_unregister(&tegra->osc);
> > +unregister_tsc:
> > +	clocksource_unregister(&tegra->tsc);
>=20
> Looks like there is an opportunity for devm_clocksource_register_hz().

Yeah, I guess I could follow up with a patch to do that. I suspect that
there's no such implementation because very few drivers actually end up
unregistering their clocksources. A quick grep shows that only about
one fifth of the users unregister the clocksource.

If Daniel and Thomas think this is a good idea I can look at adding that
and converting some of the users.

> > +	return err;
> > +}
> > +
> > +static int tegra186_timer_remove(struct platform_device *pdev)
> > +{
> > +	struct tegra186_timer *tegra =3D platform_get_drvdata(pdev);
> > +
> > +	clocksource_unregister(&tegra->usec);
> > +	clocksource_unregister(&tegra->osc);
> > +	clocksource_unregister(&tegra->tsc);
> > +
> > +	return 0;
> > +}
> > +
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
>=20
> Could tegra->wdt ever be NULL?

No, it can't. But as above, I've used watchdog_active() here to make
sure we only enable the watchdog when we should.

Thierry

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6HmNIACgkQ3SOs138+
s6GYMxAAufE2qXxJ1UQEFKwK3GL9IcMyAbAM+cYitG7CepVBBK3aC1dMy3SoElMn
Gy4EnhtnB1DV1idPEWUOmPfW7tdBKRAyzSz4h1r07SZKjvYEKQCK3Qr4z3VTnEPl
dMEfToMQ9ThWXLsvTq/JzigDRsPOvTyHoN39XEvLBAPKhPBpM7GJGuPvnej/agDw
KUT1GVgE+UJP0c7XKnqd4yGfUze4m3NxbmSo4I6Y6ybItAx76iz3mhjYdvp4rNX1
gRR+PANpoJUXvT34/fgVFMxDUWlk9lKR/I1lUP2IMJhOG1F0Gl03L7rga4Oi7Xev
1/VrUhkXJeH5WR7PNzUZnyyzFk0ag7BrJHboEXz56v0hQF3LzlJUV/CnbAeUugh/
hyDTyQdLyH5qDYWhzdnRbQqJSgGUdHd2g5+xacVBpSlGEhk/Lx78BCHwfr51oPTk
MtwQTBea7VVCNNN8zVSL+kj1IcJlFby2RiLWlQCqLx/6wgcd6vyg7McxBmpaOLYg
Rp8UdygVsqCzmAKoh7teKdfmFew8nkyVryOJkqc+LCJLpx/arp21ezmDaDXWie+3
KC8m5ZwnQhcHFCJbXMepztalMPLP42Fx1UD1/acHYlvSJrGp7H1Y+kGf7TbGQo6c
KOKI8we2kVZSR507kewMx6CRX+8rdOKpHZFMId6uw2QEP6KJP2c=
=rLH6
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
