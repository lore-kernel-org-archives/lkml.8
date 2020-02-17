Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C543C761A1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DC0206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSDX6BGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgBQJsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:48:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43157 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQJsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:48:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id r11so18790581wrq.10;
        Mon, 17 Feb 2020 01:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mRzhu4FuDGLh80x5UO0rDFw65MYmAaxUcoBtzYtkWxk=;
        b=TSDX6BGAs3Qkn46ZWpOSekS5iahlNNJ49ygptHlstiI3PQLXt7LamxtveGKsgUp8ol
         XRJPirlPRQms90vlTjDwKnQFYqX2IzKu8XlkmcAazijEFuAWDCRNqmx1+iECQxt3bMi+
         HHOTK6UNc/m2TDhxU2Kl/zCoskH5NzuoHMpzOzBX9hciE8DS/uTHKP/8DSKomA6bZ/CS
         6ZZ5Ed6yBdeZ3xHgRrLDq06M06GPEhEpUtgE8q0JoSQo79n4vuE3FDmifiAegoByjSmN
         ZFYBWH5t5/FXo7Kd1ONkv9IhnJdouKyURMc9Izgi8WIOKBkSiwf/x921NlsU4qpGlTBl
         rL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mRzhu4FuDGLh80x5UO0rDFw65MYmAaxUcoBtzYtkWxk=;
        b=LahFMuPZbtDvacHuM7+VbcksmILfj7XTPgMWHPzP8QkyPcTP3oOsjgBxZYsL92oAHu
         8AUPPm5ismw3+G7eKpzfKqGx0tsHxxJAB26+GThICnlVHsGGU16CPvv4d1kQQ6wOjxb0
         qWyyx55ENl8iReyRWsWCW0LUradwbjO603XU0KQ5yZ3SMrh6TYdlkWFhUOm00RQWwPyW
         PyBMs609CxSKKb+4JrPvIP5H8T+/QB8G7hjD6Rn2NdnD+NlqNzJGwZOiQXitR3QpNttU
         froAR01xXswtU2Xo6p/0bwI+6D9Dbtt/XtRY+hxjs5o2qRFUPSKhv6rXTqC73FVcMw42
         xQmQ==
X-Gm-Message-State: APjAAAVZOnFzW6ECmCstZLXm0qK3BTrrgkUW7cQf6XmLmFAqd0b+pH+c
        rFZrTnIxi7ppfXDxQcMK6is=
X-Google-Smtp-Source: APXvYqwpWLMXEwOYrzCAyMCmt4QalBChgcLXQWUSaHA6rCffoHKWV9UywHWIC+4UvgfQCxeJ3zBfcA==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr20884290wrp.321.1581932909095;
        Mon, 17 Feb 2020 01:48:29 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id a13sm104558wrp.93.2020.02.17.01.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:48:27 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:48:26 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, broonie@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, digetx@gmail.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/22] ASoC: tegra: Use device managed resource APIs
 to get the clock
Message-ID: <20200217094826.GN1339021@ulmo>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <1578986667-16041-13-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WeDu0lr7bteb/II5"
Content-Disposition: inline
In-Reply-To: <1578986667-16041-13-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WeDu0lr7bteb/II5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 11:24:17PM -0800, Sowjanya Komatineni wrote:
> tegra_asoc_utils uses clk_get() to get the clock and clk_put() to
> free them explicitly.
>=20
> This patch updates it to use device managed resource API
> devm_clk_get() so the clock will be automatically released and freed
> when the device is unbound and removes tegra_asoc_utils_fini() as
> its no longer needed.
>=20
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Sameer Pujar <spujar@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  sound/soc/tegra/tegra_alc5632.c    |  7 +------
>  sound/soc/tegra/tegra_asoc_utils.c | 39 +++++++++-----------------------=
------
>  sound/soc/tegra/tegra_asoc_utils.h |  1 -
>  sound/soc/tegra/tegra_max98090.c   | 22 ++++++---------------
>  sound/soc/tegra/tegra_rt5640.c     | 22 ++++++---------------
>  sound/soc/tegra/tegra_rt5677.c     |  7 +------
>  sound/soc/tegra/tegra_sgtl5000.c   |  7 +------
>  sound/soc/tegra/tegra_wm8753.c     | 22 ++++++---------------
>  sound/soc/tegra/tegra_wm8903.c     | 22 ++++++---------------
>  sound/soc/tegra/tegra_wm9712.c     |  8 ++------
>  sound/soc/tegra/trimslice.c        | 18 ++++--------------
>  11 files changed, 42 insertions(+), 133 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--WeDu0lr7bteb/II5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KYWoACgkQ3SOs138+
s6GK5A/5AcdDL/94+MLDuWQO9rtvoWy8z68TTio7XPaP1m3tLsAWmOrO4b+QPfyp
pnyHtrq8rW9fRShCzBPf6DM5tAKALPrwoJSBWABqZNr0vupPZKcDCc47xRyz0VSI
oeT4BuDIjYJtEQyzvUibM3ZsnbKJ0Iis8ZKQZK2b5UjGKt3/mO2sf6HmrXrUjAnn
fo3FNwCiEvIkBkcyEu7NIZN7BzpHHWKRni7BgBnu+2Tr7cdqKwxkr9Eek52AVFV6
IBY7pn2JSCd3Yf82RadY/lpLmQ2i5M/ZKFhraMnVGfBYFr73B56sv69XEtv+I3do
GP7t8FimcM2Nj+yNERQidOxBTT4JaF5lt6lXFEqqz3OYFcJ2GVc/3BNpEwrsL2z+
s0mv00ALzbrSdifmLYE+JbSBdscZArJDzs4aOJmNEbJUXEo3ucMkRVBwFoGcHtjQ
4RrvHR/pvGX85Cyhjmo0Z+uNi0Nr/JciRePBelXdjdeLn0LRCaSqntQ90rHnCi3V
txQ33jOfO2Q5VlEsHBwuRYYzlqhIVVnIW8WII8cPSso91NM99QyI6tY+BLXJqT6p
kqQw2OzXfCBdO/xCFLGu1LLsVFmFe9HPI+Yh5tde07/OutCgQ0hl5BnEDzg9ywnl
CLdRdoUHbVoZdwg7R8QzMuUZ+nYTslcYQYYOBW5r/iBkd7u36Co=
=yMLv
-----END PGP SIGNATURE-----

--WeDu0lr7bteb/II5--
