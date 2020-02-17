Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A56C7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E872064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJvhZWoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgBQJ3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:29:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34886 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgBQJ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:29:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so17603684wmb.0;
        Mon, 17 Feb 2020 01:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ygQEjnreDqvnmGNj2DZkRS0YGCjqrJ+JUNJhBuaOTHQ=;
        b=fJvhZWoarx9Te1j7kUH6G/b7nApLWbYy0d8am58XRlArApOBWoQafTkPT8IlNRzKpP
         3l4bQM6p23SPdnt5Vrw9/enU05LcnsDZskGNmdJa0m80AwTD3T3ZhKtvmCB3z3c+dsaQ
         q8dTTSg73mjjv/ZvicXwUwm7twJQwFEdfzJJcMHuUHXlwU0uGSZ7Jw6NTGzxBV9UYEai
         UuZkLUtxSYbjgqFG5XSifnUOOPx3ErRYxAP+p+qG6/9FbYDk76CGERRYAJH4JELvgx9l
         24iQGKOymq7o7hWRPKS/8AFtqoek4iABoCMlvS0z/pSe+y2HARQKX8VM+X0lLRgqlFCf
         rTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ygQEjnreDqvnmGNj2DZkRS0YGCjqrJ+JUNJhBuaOTHQ=;
        b=BlV2JxAefktyEZZc5R0TyXQ7gQqzyfeLVzJtUr+f1V2iZFs3CE3qucYbL7AIvBB/G2
         rYBHf3gU72qPyEzoXfJGhXxKKtAQm+3NCYhmoun+QxiMNDT2z0fh1iLDCH4hXFOvMCM+
         juT5xgShGWWTUxMmOFzBkMopZSQbuVOg6rVUr69/cCDx0Q1N9JWSYg6rnaRu88+pW95p
         2Re2agec2ZizVAyN7JY/88eX4aPZIc7VxywsnQn8mdQM1mfaNzWp/RRXfQofaPsTNIhc
         p1s9LHWbPKJL6+y4NaVynXBODnTFkAv2FLa5C8KlI7wLYzm8SfXYs92k8R8QjsUbETuM
         CXwA==
X-Gm-Message-State: APjAAAUl5RLYPbAW7aDU9nceiye1AweYE/0OZ/4RFF34Pve1f/9RgOmM
        r9yNh+TGsz99jXTJpeDqnSU=
X-Google-Smtp-Source: APXvYqxMkGCU/uQK2bbvFO8LO1+YjUKLpa+HGhtSALCq8j2iNpXu2ZHtWWkTf+nCmVG+8lqZx5+9yA==
X-Received: by 2002:a1c:7919:: with SMTP id l25mr20656612wme.135.1581931775918;
        Mon, 17 Feb 2020 01:29:35 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id z8sm86233wrq.22.2020.02.17.01.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:29:34 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:29:33 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/22] ASoC: tegra: Add fallback implementation for
 audio mclk
Message-ID: <20200217092933.GL1339021@ulmo>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <1578986667-16041-12-git-send-email-skomatineni@nvidia.com>
 <aef36b46-789a-c44e-4cd1-9d4183435ba9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vTUhhhdwRI43FzeR"
Content-Disposition: inline
In-Reply-To: <aef36b46-789a-c44e-4cd1-9d4183435ba9@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vTUhhhdwRI43FzeR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2020 at 02:56:45AM +0300, Dmitry Osipenko wrote:
> 14.01.2020 10:24, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > mclk is from clk_out_1 which is part of Tegra PMC block and pmc clocks
> > are moved to Tegra PMC driver with pmc as clock provider and using pmc
> > clock ids.
> >=20
> > New device tree uses clk_out_1 from pmc clock provider as audio mclk.
> >=20
> > So, this patch adds implementation for mclk fallback to extern1 when
> > retrieving mclk returns -ENOENT to be backward compatible of new device
> > tree with older kernels.
> >=20
> > Fixes: 110147c8c513 ("ASoC: tegra: always use clk_get() in utility code=
")
> >=20
> > Tested-by: Dmitry Osipenko <digetx@gmail.com>
> > Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > ---
> >  sound/soc/tegra/tegra_asoc_utils.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra=
_asoc_utils.c
> > index 536a578e9512..74d3ffe7e603 100644
> > --- a/sound/soc/tegra/tegra_asoc_utils.c
> > +++ b/sound/soc/tegra/tegra_asoc_utils.c
> > @@ -191,9 +191,21 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_=
data *data,
> > =20
> >  	data->clk_cdev1 =3D clk_get(dev, "mclk");
> >  	if (IS_ERR(data->clk_cdev1)) {
> > -		dev_err(data->dev, "Can't retrieve clk cdev1\n");
> > -		ret =3D PTR_ERR(data->clk_cdev1);
> > -		goto err_put_pll_a_out0;
> > +		if (PTR_ERR(data->clk_cdev1) !=3D -ENOENT) {
> > +			dev_err(data->dev, "Can't retrieve clk cdev1\n");
> > +			ret =3D PTR_ERR(data->clk_cdev1);
> > +			goto err_put_pll_a_out0;
> > +		}
> > +
> > +		/* Fall back to extern1 */
> > +		data->clk_cdev1 =3D clk_get(dev, "extern1");
> > +		if (IS_ERR(data->clk_cdev1)) {
> > +			dev_err(data->dev, "Can't retrieve clk extern1\n");
> > +			ret =3D PTR_ERR(data->clk_cdev1);
> > +			goto err_put_pll_a_out0;
> > +		}
> > +
> > +		dev_info(data->dev, "Falling back to extern1\n");
> >  	}
> > =20
> >  	ret =3D tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
> >=20
>=20
> I tried to double-check if audio works using the updated DT works with
> this fallback and unfortunately it is not (maybe I actually missed to
> test this case before).. the driver doesn't probe at all because of the
> assigned-clocks presence, which makes clk core to fail finding the MCLK
> and thus assigned-clocks configuration fails, preventing the driver's
> loading.
>=20
> I'm not sure what could be done about it. Perhaps just to give up on the
> compatibility of older kernels with the new DTs, missing audio isn't
> really that critical (perhaps).

Compatibility of older kernels with new DTs isn't really something that
we strive for. The whole point about ABI stability is to avoid requiring
DT updates with new kernels because a DTB may not be in a writable
location. Practically I'm not aware of such a case on Tegra.

However, the kernel is always assumed to be in a writable location, if
for nothing else but to ensure it can be updated to fix security issues.
So if a new DTB is flashed it can be assumed that users will be able to
also flash a new kernel to work with that DTB.

Thierry

--vTUhhhdwRI43FzeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KXP0ACgkQ3SOs138+
s6EMFA/+MsPxtQWJ/LcWb+hOO7yfe0+a6qkf2SlyimYpwg8DtZ3PfqlTa/wKULLa
tgVfjjvAFVXQAqSNnVYMVTGYD+amqH031ija71qBEbsBtnz097DZz9elifGZC3nt
PvT42UC14wd+7W2wJXHC2OhZadDi7tBC/8aXhpTvN4YLn1YZajxbeQWBwhg91LYX
ojC16xdjBsIPIWLU+uhDcSKDN6JJ+YD4h5+OC/LaIer9Pjasm+vZQejGiictgYC9
u0rmBTkFR+HtFzJF2JalhhH/JnrbssA8d+yb1z2In4XAMmq/ybvOzTTrfin1kNYB
5c6xVy5qg23aua/LbK082oFZuWTHPui2wLGdsi+S5Xw8RtKaAaPZ+JWk7gjkG0DF
NlD3k3Sf9xhQUTQ+QmZvHIc0W7Sk+P17exjkuwI0XvCHK661QbwGRG7d94ogTW/A
KaNEw/823asRFAFGVxJkcxl+rUZ1CrC1qvO7XLSoCK1jqnPsKrJ+l3HqSIJvuULQ
pelJz2YvSpdcGcfa3Xwt7pNZfA5S01g9W+KgzM+E4gX83U8MomKF3h4KV5R4JhBd
Z4CycNYWSOzENmsq+CqsOSwbsR0LUb1OoyajE7pik9aUJTxWBZ0Tk+KiMIGf6sMA
RTVb8GORKf/l6LJfrBhKS3YL2hNOXhog11UaPot1KPuooOHo1yw=
=ylAB
-----END PGP SIGNATURE-----

--vTUhhhdwRI43FzeR--
