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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FDEC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701F0206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czz4llsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgD1K4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD1K4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:56:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE53C03C1A9;
        Tue, 28 Apr 2020 03:56:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so2349205wmg.1;
        Tue, 28 Apr 2020 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cu9V92swPgMoQVrGbkOnzB0mFpeAhIxz6fT8lwhvXp4=;
        b=czz4llshIebOCEiGJP40AlVibD04vg+/rozKAVOvpHVL8fHv6sNTWeT9mdK2nJWB0G
         hZyQ8/g0Ei9w0xlpAB+Imk2Vh2P3AammDUKXGTD1kCIvahtiXDnowS9XYI/rgXndhhQ8
         ka89E6IO7o9wRCrK3tQCA5VgZNByZUXQwOGFQGWBBQzg1o2RYfQ/i3Kw64eMNn1onspX
         6uZQ3EZ8kf9koMUzgCDrt+v8qLDdMz7sQzDsCDyQ2weGGgSvePfjyX1PaMLtqRB7PdMU
         Tm+ntr4ljBWFra5PyMx8T2f1q4CcyeagUayTh5CpJUa3pARcUmN8PXhzzRVQe+aX2RG9
         nE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cu9V92swPgMoQVrGbkOnzB0mFpeAhIxz6fT8lwhvXp4=;
        b=rfsJlVQc2un4dLL+h+v2r17Xl7oDTYPFulAQXY7BlnZavkg7PGtuJo+fmJyuZpi1Ua
         MDYWkKMOrwXza1AX3AUTrSFaTwt29doLarRJWgWnKOyI+2x4gI1uF+b+p12c0Qh3I37u
         /UfNa5ZiiMMHXV8HqHq0tQMCyvL/eo5zXPayIzwPPIFsNQNKf/NQkXFbrYINiSf4Qstv
         7Y3tNuPkyc0k/h5BtRbVCdBjT3PkrHbszPOfhHuuQWY1FFH7wpaMo01uAn8gG23ytv6+
         F+i03Ns6Yut9wCo+v9NhVVdez31dYkTd3QUp8/Ml3IpzF13/2pNOP3A65GpdYyeP0mkG
         W/aQ==
X-Gm-Message-State: AGi0PuYVKhaEZhEmSAcQm+HaZ28rvbRbWS9gfnq0xBKPIJ0BN7oaNzfD
        IbDwd2kXd9Bft6RkIT2BNp8=
X-Google-Smtp-Source: APiQypIqMecRY6oj6W0DN7WkgSfgWk1ppCZAwj08D4KFd8m+Q50ALtWtZk3LJiZvZUrYi+awMrgCfg==
X-Received: by 2002:a1c:a9d3:: with SMTP id s202mr3965015wme.160.1588071410005;
        Tue, 28 Apr 2020 03:56:50 -0700 (PDT)
Received: from localhost (p2E5BEDBA.dip0.t-ipconnect.de. [46.91.237.186])
        by smtp.gmail.com with ESMTPSA id c20sm2965920wmd.36.2020.04.28.03.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:56:48 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:56:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 8/8] phy: tegra: xusb: Enable charger detect for
 Tegra210
Message-ID: <20200428105647.GJ3592148@ulmo>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
 <1586939108-10075-9-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qD3brAgIG4LbUq6d"
Content-Disposition: inline
In-Reply-To: <1586939108-10075-9-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qD3brAgIG4LbUq6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 01:55:08PM +0530, Nagarjuna Kristam wrote:
> Tegra210 SoC supports charger detect, set corresponding soc flag.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
>  - Patch re-based.
> ---
>  drivers/phy/tegra/xusb-tegra210.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-t=
egra210.c
> index 7d84f1a..2be5201 100644
> --- a/drivers/phy/tegra/xusb-tegra210.c
> +++ b/drivers/phy/tegra/xusb-tegra210.c
> @@ -2352,6 +2352,7 @@ const struct tegra_xusb_padctl_soc tegra210_xusb_pa=
dctl_soc =3D {
>  	.supply_names =3D tegra210_xusb_padctl_supply_names,
>  	.num_supplies =3D ARRAY_SIZE(tegra210_xusb_padctl_supply_names),
>  	.need_fake_usb3_port =3D true,
> +	.charger_detect =3D true,
>  };
>  EXPORT_SYMBOL_GPL(tegra210_xusb_padctl_soc);
> =20

Same comments as for patch 7/8, with those addressed:

Acked-by: Thierry Reding <treding@nvidia.com>

--qD3brAgIG4LbUq6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6oC+8ACgkQ3SOs138+
s6GgYRAAqZ1IWFuvAMyyIhS3Tm7ZAX3mXGSz2pXgTdb72C4U/EN4fwsaGLdM/qAb
+BFMZQL0uH8xyOJSZYERL2rI1eYlJaLM6ovkbzeuUjOpf5y9yjMATjOTpIccubhf
a/g37osHQ0LnXiZbM4kGCLGssLF4DmwYLMEwcTrUjaptX35yHs1eXAPQDcg0K7gv
+SvIW4PiLTGpJMlVq19BPxsAaHs57Z0n7G09e+gT4Hq24SVbxhd1beL4tqwaiWB0
3oIyejEtyZB9zbg5Vxlhpt8LoIoqxh+J5h7BHG7o+et81Pd2j0G5JTgdvCpakC48
jxFzdkSYBxAduQx26vC5/N88TMjILSspL/CARemnszKBJFU7r/OACAqPrkxvtVow
EQzCB77tv5X0z0v1QErPc+E+WvSzhhuHRvidRjDwztrG7qx8uMfPPZVnGSRiCSOp
qrNGqnKXgtbws9+LhAFlo8R2EyAZ5v7ZoymAmk9aWfVlhr+ohMp8+jWce2A3LgVs
Hc4vEbb/3CrEDdrVGq+4zMLpzdSbIDvQVyAi4Jivv7SwfZ/XbkkCdXHeBmOzgqGk
z86CqPXyD03zNU3SY9Rty3aWCMs0DTuTzW7AYK5TvJXmeij6wLvAwjzsmP/vhZzf
Qh9EO4JYlAD2HuuLQraSISM3g6m5NcHMaHhrVbwH0FF8ey0kKTY=
=+2YA
-----END PGP SIGNATURE-----

--qD3brAgIG4LbUq6d--
