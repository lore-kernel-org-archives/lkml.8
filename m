Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58774C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B6C2072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR8dYcme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgD1K42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD1K42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:56:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51032C03C1A9;
        Tue, 28 Apr 2020 03:56:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so24050221wrm.13;
        Tue, 28 Apr 2020 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4zpVgjm2qz8Yk84jtRhI29r5qWnFI2aIok8af8uxT+w=;
        b=bR8dYcmeGV6okIwGPvMa/C7avObywMMdpI/uPeHNdFolfzrZBLpoWSC1pdWayMDfxz
         CVIVRl8IJtyWHI1AKIWAJThyBgeGwC47z8oRLwOY1zJEDnksFx96I7I7aNdqAurCUfAu
         hvd/M3djVaeW8IPVgDGrHekIe59qvwfmLcOawThoQa1iA9nor/aXCDyIqlXLBZAHmaj8
         BGReTz5JdvKRbUGLhkS+Cm1oj5ShE894qdpZqyodDBOzfnyuSoMdn7EOqmctyXcZjgr0
         IExhUHcN+kTCpTQGrdQ7h3It3yqLMnV1wqtTRIE6YEjCRVdkOarq/c81dBCtILzmJ+Be
         8bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4zpVgjm2qz8Yk84jtRhI29r5qWnFI2aIok8af8uxT+w=;
        b=t2TBLe3YIuRMmFH2yrLcT5gOF3nYS2NMY207qZR1BWXWu3sYHaIWMU0h19iltvF2B0
         lWh0f5HvSp26f2OLWQZbHTuK5CHBcaRbyiKUrJSlJ0fLgZbFnGV4xMtcno1zYkvjSBz3
         FY1mINrtIIxLtSewSa5fI6NysWEnVXSuwGwhw0Sd5RLu8sZTWlwRHDwZ+lBfPa7uOst2
         PtKzAJik+mQ8lucy9fZDJCm7BPRBIGdnKbcC+JALEEqWOmiNOcupegLxqyAt4FPHYa1f
         JEEW2m7VwTYXi+PiOQ5lWXIrbRbQAFglltg5rCrdZgU44HVAoeYZ1rozcOY9swmGhP8U
         5ceA==
X-Gm-Message-State: AGi0PuYfVi77HeT0qrTG7VuQjL39kXCjgnevrQ4ufkr2NFK2jSGXE87Q
        q3krUJ/R/I7jYsd+eEdjLnc=
X-Google-Smtp-Source: APiQypLwIuKAXoo9AyGa7dKXr0iBnmXjImrheIvP+4/+QEKyuX8rMorm720uVhOB+E/z3Eyr66pN8A==
X-Received: by 2002:adf:ed0e:: with SMTP id a14mr32325586wro.400.1588071386077;
        Tue, 28 Apr 2020 03:56:26 -0700 (PDT)
Received: from localhost (p2E5BEDBA.dip0.t-ipconnect.de. [46.91.237.186])
        by smtp.gmail.com with ESMTPSA id w4sm8593373wro.28.2020.04.28.03.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:56:25 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:56:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 7/8] phy: tegra: xusb: Enable charger detect for
 Tegra186
Message-ID: <20200428105624.GI3592148@ulmo>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
 <1586939108-10075-8-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Content-Disposition: inline
In-Reply-To: <1586939108-10075-8-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 01:55:07PM +0530, Nagarjuna Kristam wrote:
> Tegra186 SoC supports charger detect, set corresponding soc flag.

"SoC flag"

>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
>  - Patch re-based.
> ---
>  drivers/phy/tegra/xusb-tegra186.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-t=
egra186.c
> index 03bdb5b..12ff492 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -1041,6 +1041,7 @@ const struct tegra_xusb_padctl_soc tegra186_xusb_pa=
dctl_soc =3D {
>  	.ops =3D &tegra186_xusb_padctl_ops,
>  	.supply_names =3D tegra186_xusb_padctl_supply_names,
>  	.num_supplies =3D ARRAY_SIZE(tegra186_xusb_padctl_supply_names),
> +	.charger_detect =3D true,

And this may require an update for the change I suggested in patch 6/8,
but with that and the typo above addressed, this is:

Acked-by: Thierry Reding <treding@nvidia.com>

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6oC9gACgkQ3SOs138+
s6FaaBAAmP6cTMD/VpL2q1kX4bzPvzGA+/czi9xUXRWAjNA+OxVvRIdtGKsJOsxm
YMLW2EBA/g5dBCCvwiA4Ut1QVZBv58vA7hh06C/8lNpo9tJ0pfbmr/knGcD9KQxa
/JMbscYirr5oYEXUp/lJbFftjzFTg3JoJA7EqPtrv0LWmjuJ18eJwfZbsyjx3G+X
syGXPc8RJ4/s2Ir5cSZ82ymIb3JShhmNw48SozOdN00PPbBFl+oplCnQKXLxb9QU
3tSUVwTHalzZQ9mcEKblCWA4G/cRtNa/EK8PdOzW3keLtLM/7N5yZt3By3xQSKFt
mkKhSch9wCrG88Ks8OlXEsNjnu+DyJ0MdDynWKrlGaCjuL5hkIYOS05q/YF6S3U3
JmVEYg1r9hOlVNHe1/aVuvgnlT/Ned+zJQnQq6FbjgcYpJBd3V41O5EDnJEuwybY
QtITnAkeBBPgde0St+AXvreiz9AyzKLTJzGslvWOKR1uV/WroOJRoj3dCGFmhAXy
v13eNhu+2Kwn1Fa8Qqoc5RhYniTk+0jJqPaVXsJlk1IGeYVmt8IqE1boILE2mSd5
zCvTbn/lbu56qS7RSx9kneH0yPbQYh6CN1L6jpiHyQKPAW4hiRdeyFayyb9VjWsf
oOsz+qzEdNi2DUzdPNCMsrAf90QXFhXU+3DZvP8RjbGpKrHHWgA=
=scSv
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--
