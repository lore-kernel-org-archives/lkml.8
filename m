Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF13C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5947822522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmqNp7nS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgA1RpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:45:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33485 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1RpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:45:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id m10so2302230wmc.0;
        Tue, 28 Jan 2020 09:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AsU4oisPNET6Lf5qi/oLznBouup1gLkn7VJp7ZQuhgk=;
        b=bmqNp7nSJkBSkMKWLnrzF/vaSNUxAh9RuakS1ndq3HWETVlt3l8kOJ4D0JSiCKoW8v
         R3uo7ZY8R8tQYjF0E63Q2b6zM6YWzzwL20rPZd6jcWNFli/pN9v7U3sJ8oJyUK0M5sfw
         4uYxQ0poiwGxau50n4G6Dv+hhSCYwCpuqW4+aNI00Mln8kp4o2o73UoE48NUwG8llu4Q
         9VwWZm+PCgjA5IiLzAbuMLE4LxhPCE/XMd3lA38c4cP7ABkrMsDRKIsB81kI3WMJYdE1
         xW5BrpMVOs1+WAXT7je9L7to5RqMoxvonyGi1jfVndfwu9MhuBPGrPLvBCifeVQmsawI
         m+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AsU4oisPNET6Lf5qi/oLznBouup1gLkn7VJp7ZQuhgk=;
        b=tuNfRUDTtNGgmXVp+NYCDmzWIKskBh5t5u3UWFJbBPPMLKnSnn5rQenFEUJHySTz4j
         KMk4EjdLnyImVJ30r/PfQRb/LPgCmClgwngzIHWRyM8Wa/vGn37YjVAUlKmpWDGtjX/2
         MecWa96tOice7H6v+W5oCPA56wjpCDtCM8h4EWycS1UBGA38l609ostaDhrdIQuZysP4
         QHMt1DnwheaclKwpoB/ZTpibmuTJjy68ZxX5veU+4er9OZInDITJnHMBlXqtwSfB3ZdG
         vHhstLpTM9/FHZzf6KMe1hWWbxacQMUqsJnWVqwr8arsNiC8sCG69iFRux1oQcLcltUm
         VHgQ==
X-Gm-Message-State: APjAAAXL2hq2kktWwPTb1vtwv+EnkzjQ2e4I+2VRmdEQz1Xt854Kxdii
        qRjcw2foxMzDKcMemTc9WcQ=
X-Google-Smtp-Source: APXvYqzsSGCrWRPrSEA4duRR8xfG35cw96+gQt6yZo+ytXjU3Y2r0Gpdde/JTNGwxUBMhS+r6GlyeA==
X-Received: by 2002:a05:600c:30a:: with SMTP id q10mr6330155wmd.84.1580233508808;
        Tue, 28 Jan 2020 09:45:08 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id e6sm27770072wru.44.2020.01.28.09.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 09:45:07 -0800 (PST)
Date:   Tue, 28 Jan 2020 18:45:06 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3 07/18] phy: tegra: xusb: Add set_mode support for utmi
 phy on Tegra186
Message-ID: <20200128174506.GE2293590@ulmo>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-8-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline
In-Reply-To: <1577704195-2535-8-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 04:39:44PM +0530, Nagarjuna Kristam wrote:
> Add support for set_mode on utmi phy. This allow XUSB host/device mode
> drivers to configure the hardware to corresponding modes.

"utmi" -> "UTMI" in the subject and the commit message.

>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2-V3:
>  - No changes in this version
> ---
>  drivers/phy/tegra/xusb-tegra186.c | 109 ++++++++++++++++++++++++++++++--=
------
>  1 file changed, 87 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-t=
egra186.c
> index 84c2739..9a45160 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -301,6 +301,92 @@ static void tegra_phy_xusb_utmi_pad_power_down(struc=
t phy *phy)
>  	tegra186_utmi_bias_pad_power_off(padctl);
>  }
> =20
> +static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *=
padctl,
> +					       bool status)
> +{
> +	u32 value;
> +
> +	dev_dbg(padctl->dev, "%s vbus override\n", status ? "set" : "clear");
> +
> +	value =3D padctl_readl(padctl, USB2_VBUS_ID);
> +
> +	if (status) {
> +		value |=3D VBUS_OVERRIDE;
> +		value &=3D ~ID_OVERRIDE(~0);
> +		value |=3D ID_OVERRIDE_FLOATING;
> +	} else {
> +		value &=3D ~VBUS_OVERRIDE;
> +	}
> +
> +	padctl_writel(padctl, value, USB2_VBUS_ID);
> +
> +	return 0;
> +}
> +
> +static int tegra186_xusb_padctl_id_override(struct tegra_xusb_padctl *pa=
dctl,
> +					    bool status)
> +{
> +	u32 value;
> +
> +	dev_dbg(padctl->dev, "%s id override\n", status ? "set" : "clear");
> +
> +	value =3D padctl_readl(padctl, USB2_VBUS_ID);
> +
> +	if (status) {
> +		if (value & VBUS_OVERRIDE) {
> +			value &=3D ~VBUS_OVERRIDE;
> +			padctl_writel(padctl, value, USB2_VBUS_ID);
> +			usleep_range(1000, 2000);
> +
> +			value =3D padctl_readl(padctl, USB2_VBUS_ID);
> +		}
> +
> +		value &=3D ~ID_OVERRIDE(~0);
> +		value |=3D ID_OVERRIDE_GROUNDED;
> +	} else {
> +		value &=3D ~ID_OVERRIDE(~0);
> +		value |=3D ID_OVERRIDE_FLOATING;
> +	}
> +
> +	padctl_writel(padctl, value, USB2_VBUS_ID);
> +
> +	return 0;
> +}
> +
> +static int tegra186_utmi_phy_set_mode(struct phy *phy, enum phy_mode mod=
e,
> +				      int submode)
> +{
> +	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
> +	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
> +	struct tegra_xusb_usb2_port *port =3D tegra_xusb_find_usb2_port(padctl,
> +								lane->index);
> +	int err =3D 0;
> +
> +	mutex_lock(&padctl->lock);
> +
> +	dev_dbg(&port->base.dev, "%s: mode %d", __func__, mode);
> +
> +	if (mode =3D=3D PHY_MODE_USB_OTG) {
> +		if (submode =3D=3D USB_ROLE_HOST) {
> +			tegra186_xusb_padctl_id_override(padctl, true);
> +
> +			err =3D regulator_enable(port->supply);
> +		} else if (submode =3D=3D USB_ROLE_DEVICE) {
> +			tegra186_xusb_padctl_vbus_override(padctl, true);
> +		} else if (submode =3D=3D USB_ROLE_NONE) {
> +			if (regulator_is_enabled(port->supply))

I vaguely recall that we discussed this before, but I don't recall. Why
do we need to check that the regulator is enabled? Regulators are
reference-counted, so as long as the reference count is balanced, there
should be no need to check for this.

If there's really no way to avoid this check, perhaps add a comment that
points out exactly why this is needed?

With that fixed:

Acked-by: Thierry Reding <treding@nvidia.com>

--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4wcyIACgkQ3SOs138+
s6E37Q//bbam3CY/x1HTAfm1BwM7131zZzp7TC9NqqFuDL7ie5bJ+EZ/JaEeZTwp
4gfAOPTtzGO3zMFUh8pBCwGuNiUpJtwQMgddekFWeQqeo4R1ssWOSOvYrnVVIt+N
vhcG29TTUQ0EHGUwnJbkB8AG811QauUGXgjA+mabg7fUt91/W9T4gbsgeXCyVtfg
UTjDjhy1Anx8dMaMWrEygse2tnXpXOCZ23YJVr6r3ssxy5+YzP4D81xuhkMLnf9Y
6SSnTgvVwRKVbTeTydl1RlKmvEDJf6DqgpcORh4HGouCFwZL96pK1witeJAXcpjj
3xPH1l5K4VSEWM+c1UQR6UXyHajv6FCmk5By2uoRscrcsObp2JxoEMO/Ofj60kpx
7HChBDhGu2Tg/m3w3tLoZg/DQDVvn+gVwaoqcPSvZC7/fklKB3tXMHkSZOj4qFmp
y4j1EkdzRPhN4cvFl+bRUYk0/dqlOr48SpiZvo5OqxVV/bJDcdl1qKNViw6hSVUh
Ezs77PGwD1xKmur6Mge4qiUVvxfECmKcsqa/Bzmn/DgCTpFDSwuDx4Ehqkq19nI+
dKcpPDIA8WMPXwLagQCTSedosaTE5Nxkgw9IWrnUJuAgZr7dPopEzcwAG19mMqun
8po9CavfSDm4hesW1+T1BK70alG1ykujHWSUTUjVBD2pwYeeCas=
=ILly
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--
