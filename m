Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520FEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C62206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592981130;
	bh=JaMz/SzknIAUKnyoCiE3/rGajs0KZMSRd8r0Z6FVt/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=yART66Wu44vFm68eizSANbsbyAZB6oP73sbPs/bOEjFL9j58bNoq6max9SK575Nzy
	 vRNBAKE6Ch60aC17A/PWB7IUNgmKFaFs5msRxcyDm1dRC9dmEUPO70mdEwIdNV+oBc
	 FvynIg4RwBabDf6ESkG20AJWUhiCJcIvcU/0mS2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389326AbgFXGp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389064AbgFXGp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:45:28 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA9C061573;
        Tue, 23 Jun 2020 23:45:27 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y18so677854lfh.11;
        Tue, 23 Jun 2020 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Fjxf+qb/ItzZQx4UrXWnTnAOQAUVXNTVGaqzPkrb5BM=;
        b=msnIdUqZEAbCO7jGLREZ88fClfVszcU6jAksn4YZ/GPkqEzWJEB15kdqjfrO/dNQ6U
         uyZgMfn9uoM929hL56CNJp3xY26AYayRH28vt9BiQCXjYet7sddjmCUUUv0tfgniGdo5
         f8TeCU7jO6LGJGNwiM/rJ2S3evzAnSbr0t10z/osTeW/s/Uc1ytNcdlB24oWJMsqA8nk
         e+EwRAx3vNzJabOxkId2vM0XMBqn+MVAcrJuxn9tBbb49x7Nh3vI5sqLy1+OXxC7JzY5
         HV5XEMpL/zQqwihLoAinN4dbqvnjfxkJqEwInCakl8tgEJTkTxuPErlQjHKBw6OJ9InV
         Ey+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=Fjxf+qb/ItzZQx4UrXWnTnAOQAUVXNTVGaqzPkrb5BM=;
        b=eyTE1ZJQu2VAU7svDu0RY/C4OqnvQKMLUonbnE7usP8nx8Nk8nlwDjsLMPupdg3vgf
         AcDN5oUN2cGMWKc/T2MjaOUCSsEuvuvweb3BRNPiAzzAy8034eTHTPHxBzvG8cnGaKoT
         saJDkqAkIYQeNLfDRaxw77K8TODYfrVPASlomJ/Ku4P4PhXzbqp/NHPf4NCcW7CrFyaL
         yBY7iKfSHD6xzmVGgQA+uKqjHe/VTCzy3+JjeeVQJ5jpaUR0RyyptmQp/3jF9Izdj6Vi
         coP2UGOemii4cru5+VFY4ACkrgJOqlzJxUK8+7YMGGAE1h34aDRUeXQ/qVeTXh8AgCR4
         v/jA==
X-Gm-Message-State: AOAM533tPKES7y4DrOPAJVpqwmBjiGGCixdNhXlyWctrVXNWGkUxt7UL
        tLahPSj7afdgz6RDpfYOuCw=
X-Google-Smtp-Source: ABdhPJznq4+gIqQpwokKLThoiq214WyJzojbNV5jZnBkHxJeZA6MpkpEK5uoGCsu/7vyy7Kk65Letw==
X-Received: by 2002:a19:ccd0:: with SMTP id c199mr12060659lfg.194.1592981126108;
        Tue, 23 Jun 2020 23:45:26 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id f21sm1879109ljg.85.2020.06.23.23.45.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2020 23:45:25 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] usb: phy: tegra: Remove unnecessary spaces and tables
In-Reply-To: <20200528112859.6160-1-tangbin@cmss.chinamobile.com>
References: <20200528112859.6160-1-tangbin@cmss.chinamobile.com>
Date:   Wed, 24 Jun 2020 09:45:20 +0300
Message-ID: <87zh8tvu67.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Tang Bin <tangbin@cmss.chinamobile.com> writes:
> The macros in phy-tegra-usb.c have inconsistent sapces between
> the macro name and the value. Thus sets all the macros to have
> a signal space between the name and value.
>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/usb/phy/phy-tegra-usb.c | 214 ++++++++++++++++----------------
>  1 file changed, 107 insertions(+), 107 deletions(-)
>
> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-=
usb.c
> index 6153cc35a..c294dc617 100644
> --- a/drivers/usb/phy/phy-tegra-usb.c
> +++ b/drivers/usb/phy/phy-tegra-usb.c
> @@ -30,124 +30,124 @@
>  #include <linux/usb/tegra_usb_phy.h>
>  #include <linux/usb/ulpi.h>
>=20=20
> -#define ULPI_VIEWPORT				0x170
> +#define ULPI_VIEWPORT	0x170
>=20=20
>  /* PORTSC PTS/PHCD bits, Tegra20 only */
> -#define TEGRA_USB_PORTSC1			0x184
> -#define TEGRA_USB_PORTSC1_PTS(x)		(((x) & 0x3) << 30)
> -#define TEGRA_USB_PORTSC1_PHCD			BIT(23)
> +#define TEGRA_USB_PORTSC1	0x184
> +#define TEGRA_USB_PORTSC1_PTS(x)	(((x) & 0x3) << 30)
> +#define TEGRA_USB_PORTSC1_PHCD	BIT(23)

the idea was the line up the definitions. I'm not taking this, sorry.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl7y9oEACgkQzL64meEa
mQbi1w/+MTIv4tIMgZim0yPtzrtJUSjxtFHBZzzmIj9J2W6LiwfvtfkDiX7Sww9o
KXfigdY2/GQRFZHLTOtlnK/VBmXBoM/W3OF6lZv6/QtJ4DbYmAY/LwXdOAA4VRg6
vtwzYUJ0rnCv6jFU2CBKCyL5gNmWreFUXF4elbrFLHhjggGxmz3wBgXeGGSPTmF6
qmL8qo95kjyP1DuPsWWLtsEzZb4mCm/c4xps5u+Ig8g3eKTYAMn2TPqTj/0LZrZH
ZR1Blcinzv42j6jK8R30HlrRZUxKhsf85G2uzGoUQsRoipZwPtBqka0bVyudpBUZ
ZpvWKLmx9DuCysKTIpd7PXhwgQhTQwigauEQIzg5rlkaZ6TWH5iQsCij1v9piSA8
swtgqN6sEvnCtQ6/mtrlSGzzRilxIIf2rEm3cCHIdVyHx2b9x49jTAS0RrFibJHI
Qfp0e1MscQRW3cCmrtBHZ9BLGPTXxyTZBIyACduW3/TB3jTQTbCipOxeBmnO34km
ggzzI/e41b8BfI6Aeo35ktZjiOCJiJ6ZWLAdi9pXpD8mohwk/wuP+rGM0OnHXKqZ
yRLJTs7tPfCR7x3N9Pkbu49DW31AAPhL0Hw7CNIQ7yV6NsYTysQgtK+E9e/HsMkv
LWh7rOVFaEnWNLTLNpgituZalVT1p1V5zVrMpsxhRJYlU/QXD1Y=
=SZhD
-----END PGP SIGNATURE-----
--=-=-=--
