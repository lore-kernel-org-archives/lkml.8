Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AA6C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E921F206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEjqd6X2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgDCUPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:15:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40163 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgDCUPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:15:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id s8so7873420wrt.7;
        Fri, 03 Apr 2020 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NFzoMKhf5fXeo+6k3A7plsOyq2vhoiv1IpjF6ainKL4=;
        b=KEjqd6X2U2AC+oZJG/BTOb63GtFtJ4CmhUoKQvbKDW5mLP2hE36IegSKUQdB9HnpZ7
         tolIN67bAsY6LYrWWG/ezEyLs/01d1BtHJ4a1Sm4jdRyQzxHi9tBRdO1n9QbHBt5JNGW
         HLrMYhq0TqLsbbLDiiZNVyrwt6PcsoS0ziDPAkcP6GsjDblWRIXqq5y3Ui6NOut8xJSc
         s6gnPxwGLk+9R0DqheabINScZTZLdvQElXaWHaBo4gLikF0ETL6f6PO9UZmUxamhoVOB
         4700hA7ql3uJ81CRgQiu903HOQheDtq6K9NOwWSRUJ8bQVfw2tIoDBcjj2N9nep3lWlG
         guAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NFzoMKhf5fXeo+6k3A7plsOyq2vhoiv1IpjF6ainKL4=;
        b=grV3wcgehM8KUY2UhpyglVp7KUrwSOw9va+VvCa+tqcm+fFhkXP62e2qoNb0GghBit
         EELCl4AIlHXg6chUV4yeD6JlMF4RWcv6n1kvh3tYnzZ1d4sACJydo0Dz4Fb9jDJL6HJD
         5NLmVznahK8TDd3l/TGTlB1KVk5q7Xak8AWuNihUwZm3NKYdSHk2Izug6qQbOyunryK+
         mcNfgI0T9tirVv/GBYf5nyOwxOGJlqBjLhbq2N7kE+X+X5YRZsXZPOibgeMjV+rrVKL0
         uqO+340HT1WDnQwi9TDT6691I6CMYm1pnNOdjeaatRkN/VzLCxaQ5JKtH7J0qdOcjGkE
         y1Ug==
X-Gm-Message-State: AGi0PubFI4F4gDXsSm4pmtmM25Zax0+1UWfjBTNZpA6/NslJY950aCJY
        m9UlqtFbVxOCdFIzRlfWVJM=
X-Google-Smtp-Source: APiQypIDpJuV8BSFiZiA+G/mWzbpUaHwnZfM3dJy88tOmyDFsnSdUhShdwGFg/cl/vcyL0PvfoUtKQ==
X-Received: by 2002:a5d:6204:: with SMTP id y4mr11385362wru.410.1585944943426;
        Fri, 03 Apr 2020 13:15:43 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id b127sm10900731wmd.2.2020.04.03.13.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:15:42 -0700 (PDT)
Date:   Fri, 3 Apr 2020 22:15:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] clocksource: Add Tegra186 timers support
Message-ID: <20200403201541.GC282587@ulmo>
References: <20200331221914.2966407-1-thierry.reding@gmail.com>
 <20200331221914.2966407-3-thierry.reding@gmail.com>
 <a982d831-fc59-f705-8f8a-9370b897adb8@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <a982d831-fc59-f705-8f8a-9370b897adb8@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2020 at 07:33:24PM +0300, Dmitry Osipenko wrote:
> 01.04.2020 01:19, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
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
> > +		return err;
> > +	}
> > +
> > +	tegra->irq =3D err;
> > +
> > +	err =3D devm_request_irq(dev, tegra->irq, tegra186_timer_irq,
> > +			       IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > +			       "tegra186-timer", tegra);
>=20
> Looks like there is no need to store tegra->irq in the struct
> tegra186_timer.

After moving devm_request_irq() to a later point in ->probe() we now
have to store it somewhere because err is being reused. But I can store
it in a local variable instead.

Thierry

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6HmW0ACgkQ3SOs138+
s6Go3Q/+OPtu0XdhKbM8c43FPsGnTxNWpedF00lGCxN2A+W+ngo9DIZtSVwS+jVI
lIAUzXH/ZNvfziaNfnQZSFeBnKigiY9/PSGliXT502ysfc8zk5wZ93ESYEbwwrd7
l38dIDqzx3A7Y7eJpAyacC7RvBRHEh9e6bXw+qJ5+MKgZYwdqQQv4dTjqNqaYq+u
7cyD3MpIqKgurGxhzhOImsEZK/i3YLNn95tNTTdsiaqtckrK+cDSNVk414ecreoW
JsrXGYmPc3vE5YkuVeeB1wCxLArnv80/u4PYrhzhNom7eENl7zMhVs2US1B1pivF
iPEp5Z/7DKUUiGCcZppSuK5FyIoL5JEdUIbNOAxZAsEA6yG+9GACwV/5qEv4RRbG
ydZLh2pdN3rEzrxfOdYYuqq/EfUypcCUg4BhxMpF3WQtqR/B4z5Yc2dpuMkEEaNq
9iwQ+e/fp3g1oxsQy03fZ9HVDaq89lQzH5szH44n0qgDDg/D17OzL73NeU2JxnrK
QtORluwWHwbSgY+oxQs5VYotlvsaRoXXotHGg9ZNlQdHPvMwpXNSW5ejhFErAjHM
2ZDZqOYK2mxAVR6RJ9Mmulaqg2sTJS1J6ae8ujHuQP9MzE4qUDAdT+y3VCNbCcH1
WUl6WmuFxEGQrVWC5IRocmXhpzLuct9RGh45cqrSSqYhvx163TE=
=mTDH
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
