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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C457BC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9338220725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYq/KBaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgBQI2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:28:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45048 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQI2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:28:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id m16so18468410wrx.11;
        Mon, 17 Feb 2020 00:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9rFsequpH76DAtQ1WbcvoIpLURMUTLhX5O9SDTxFjLA=;
        b=FYq/KBaafOhX8b06HqeyN/r4s8wMr8T0UwZY/auZpH6NifkNb6dwE6h4HF/EYb2jBr
         l/splI9kXPAKOUNX037/nvVT4aDF/Bco7Ujnm5Z98GOvxFEn6LYM6oREY6L2YftEgY45
         /JsUAY2FB7Fh+ATSEQcWK6b5wpQ9S77dMZJNVfaLjSeTrMJRDeYXaOwy8y8z8Oh7XNg6
         xOBmzaYE62PnC2q87xUlW/Z2ucFz7uwojcRMMM3ITtD8bFeZpdKdj+7iZqvCfiuZH0Nm
         P1iPDcwnnUB5TaYvcKKaDs5fClnjdqngFb9Dp21OjA4uh6TSUykta4YxeLTxHHiYeP+K
         mqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9rFsequpH76DAtQ1WbcvoIpLURMUTLhX5O9SDTxFjLA=;
        b=F/wU4T0Pv7bIfop0dnA/TXSoHEQmAMk/W1TKpQpQhD2DNMmyHYdn5pMWbdzUIa3s56
         Bt7Rk49nxSZQfXrfvwctEUiiCs6bIn/CNKSqiUh14JbaheELR8jyd8r3smtrOXc73cZN
         g7BPllaKmpp91Q6RgKO/owSVQk1u14lebL/zeKMPktPJy/HfYNWEccCO9RvUQRrgprQ9
         ShELKrcu64XsYSd8ISlLhhuirPtm6Evd98dWIwpOdd3WssHt2nDS1AjOXSNMbwpjKnYK
         OpMZRncuAyNhAzwV3vHiQG7/XvI40nWBR+BvKBmxEPsu2K4p4cTVzehxlR4gkBNZSbqg
         bwzQ==
X-Gm-Message-State: APjAAAWF8/GlJ3G66YCC5UQEGI8SYCOZ5aAI7WDrIC/rE46YgntfEgLs
        P0Y42HMf+RX9PtjihFlS2ik=
X-Google-Smtp-Source: APXvYqzKm22rvogCW4ws794pTbFLC0vfZGvHv955egTGrcRBJIn53cERFXAfAMvwAVTQmuDXkMXOoA==
X-Received: by 2002:adf:80cb:: with SMTP id 69mr19754614wrl.320.1581928130230;
        Mon, 17 Feb 2020 00:28:50 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id g17sm19942472wru.13.2020.02.17.00.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:28:49 -0800 (PST)
Date:   Mon, 17 Feb 2020 09:28:48 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh@kernel.org, jonathanh@nvidia.com,
        kishon@ti.com, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nkristam@nvidia.com
Subject: Re: [PATCH v6 2/5] phy: tegra: xusb: Add Tegra194 support
Message-ID: <20200217082848.GA1339021@ulmo>
References: <20200212061133.11665-1-jckuo@nvidia.com>
 <20200212061133.11665-3-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20200212061133.11665-3-jckuo@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2020 at 02:11:30PM +0800, JC Kuo wrote:
> Add support for the XUSB pad controller found on Tegra194 SoCs. It is
> mostly similar to the same IP found on Tegra186, but the number of
> pads exposed differs, as do the programming sequences. Because most of
> the Tegra194 XUSB PADCTL registers definition and programming sequence
> are the same as Tegra186, Tegra194 XUSB PADCTL can share the same
> driver, xusb-tegra186.c, with Tegra186 XUSB PADCTL.
>=20
> Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it
> is possible for some platforms have long signal trace that could not
> provide sufficient electrical environment for Gen 2 speed. This patch
> adds a "maximum-speed" property to usb3 ports which can be used to
> specify the maximum supported speed for any particular USB 3.1 port.
> For a port that is not capable of SuperSpeedPlus, "maximum-speed"
> property should carry "super-speed".
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
> Changes in v6: none
> Changes in v5:
> - re-use "maximum-speed" instead of adding "nvidia,disable-gen2"
> Changes in v4: none
> Changes in v3: none
> Changes in v2:
> - removed unnecessary #if/#endif pairs
> - introduce new soc->supports_gen2 flag which indicate whether or not
>   a soc supports USB 3.1 Gen 2 speed
>=20
>  drivers/phy/tegra/Makefile        |  1 +
>  drivers/phy/tegra/xusb-tegra186.c | 73 +++++++++++++++++++++++++++++++
>  drivers/phy/tegra/xusb.c          | 17 +++++++
>  drivers/phy/tegra/xusb.h          |  5 +++
>  4 files changed, 96 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KTrwACgkQ3SOs138+
s6GXxA/8D37/XlTzbjLKco4jPyFn81sBehbABl9f415ypjEivpMsR9KaXQSd1G+b
TGftxQLo/ZCqSEbbPmLRqn+v0XS/Qv/Q0Bgyam7JzU5xPpZlVB4p7B/dGGySQCEJ
HbHOhB5KkKjqfhyjwaM0CCGOqieynpgWMd3Ij3hLIAGCGVuwt4hUs7E3VVHBwIbr
VAjULUBCn4oIBzUsF+LEe6WiCPzy9/+9YRyK2O1UR9QnfFNInqHbDAhOWsifAkm8
L/FdzT5n514MZwGB+99AJ3sC36BNUYJ6IeOvmEAxIxqHDoISzE/+EvUPDgGzZLnS
6qRkohCb9Hj43h2hrCLLoYEr0oHmDULGRIqR6O2yJXLsitU94JcdefH1zoNqyO9X
EbxQysIyfN5BVvonrESuVZfqGy7QgaZj5TzIskGRWYWXaBgPRnv5zBP5i8f2D9Rf
Vq9MX72/9O6v42O3pQHj9A6BLFICX/Aa+l1PQhjWTSolCbHG54vnJfa+c6gsfa1O
2200pnRcv4qhq0UNYdm36M2GdTmN2eCvSxcv/grui5qHN/PmXSlE8m265Dg0Nir1
jx0a8nuanyZ52p9N0YVCPGu2Dndc7yNgQUwg8t3iWAtRTI6u0tl5DR8Wgt352rUA
dAbewl7akPXh9Hew7SsK9Jgv8E9VLuoCtNIuSHPQIcXSrpZaRt4=
=NIJH
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
