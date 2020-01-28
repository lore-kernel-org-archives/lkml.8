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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A9FC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CAD2465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCOoAVHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgA1Rcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:32:51 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:37690 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1Rcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:32:51 -0500
Received: by mail-wr1-f48.google.com with SMTP id w15so17053934wru.4;
        Tue, 28 Jan 2020 09:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UEHKbjV0nqlBA9um3vA2rHSRrf9BUyNOWdNP0/CH1zQ=;
        b=rCOoAVHUuXEwpmWpZvFfgWUGpJd5f9Co2EQ/jOAaZkSBXnB1B5H2apc95dtNF/YDzv
         5D4yYxYnElORcJr62gw5/mS6XRokF81sBCeBps2Q9rhKwqF9dB7MEdUdtOD6Y4ST7ioS
         4g7pJgbGV8j9vlXOoiNUu1wl9vhD/VIzxfskS2/jZtCaLcq8Bh/gGj+LxqhKHMTuGPZd
         hSqZK0cyvBMcFqRwa38gBnMf7Zg8Zmvd7t0Hg0x5a2FCZU4gpDNx80VHFa261ntDXmP5
         wJ+u+gtTyEGib8iMN+LMfDR4TVaBMCbqx7BGuQdj/HJuVP9TYWXgtqNhEUmqLDd+/w1+
         k/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UEHKbjV0nqlBA9um3vA2rHSRrf9BUyNOWdNP0/CH1zQ=;
        b=g6yIk38JzP12Uw2n9fMHlbzPHiIiCjk0WAaJmgdCx+8PjsVTAMRJwJTa2bs/nQTL9U
         +TqMhBmXz2k8rDsbulGeqgYBqkOvPGxweetw3qoU4YCt14DHUnDSdU2Agi9PH85Kj5oQ
         mvfUS1F3a1bbTmmYTtwfpQPjgWLm/vXPJe3Dl5Uu58jfFdGI3Mhuk2mk10IvkR3uxQna
         dguMBhNHpSP7QNYICZQrcFydaA4LCg4jkNx3CeJP3hxIaHU5FBko/lnNxIucr/OD27Wz
         Bw1kxFbcZQIUEg4QosDBS8Az70LwUnSiPqONM7qIVo/9FD1VuYBjBr13XrAinhdohpxQ
         dxkA==
X-Gm-Message-State: APjAAAWcoSC4TShO7v7SJAaXfWWe2uStNT7OSASIFu0GQ9uG5xFbqbLe
        8Mpoyzs8b7BephrTE+GkZIE=
X-Google-Smtp-Source: APXvYqxxzLuT1opuigpzIK4xWjOJqPCVVVG/JSzAUmGeqpPZWeTYrAqozisOsy3R9YNvm17hGd4H1A==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr28613441wrm.13.1580232768634;
        Tue, 28 Jan 2020 09:32:48 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id d14sm28185347wru.9.2020.01.28.09.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 09:32:47 -0800 (PST)
Date:   Tue, 28 Jan 2020 18:32:44 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3 03/18] phy: tegra: xusb: Add usb-role-switch support
Message-ID: <20200128173244.GA2293590@ulmo>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-4-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <1577704195-2535-4-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 04:39:40PM +0530, Nagarjuna Kristam wrote:
> If usb-role-switch property is present in USB 2 port, register
> usb-role-switch to receive usb role changes.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V3:
>  - Driver aborts if usb-role-switch is not added in dt forotg/peripheral
>    roles.
>  - Added role name strings instead of enum values in debug prints.
>  - Updated arguments and variable allignments as per Thierry inputs.
> ---
> V2:
>  - Removed dev_set_drvdata for port->dev.
>  - Added of_platform_depopulate during error handling and driver removal.
> ---
>  drivers/phy/tegra/Kconfig |  1 +
>  drivers/phy/tegra/xusb.c  | 57 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/phy/tegra/xusb.h  |  3 +++
>  3 files changed, 61 insertions(+)
>=20
> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
> index f9817c3..df07c4d 100644
> --- a/drivers/phy/tegra/Kconfig
> +++ b/drivers/phy/tegra/Kconfig
> @@ -2,6 +2,7 @@
>  config PHY_TEGRA_XUSB
>  	tristate "NVIDIA Tegra XUSB pad controller driver"
>  	depends on ARCH_TEGRA
> +	select USB_CONN_GPIO
>  	help
>  	  Choose this option if you have an NVIDIA Tegra SoC.
> =20
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index f98ec39..11ea9b5 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -523,6 +523,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_por=
t *port,
>  	port->dev.type =3D &tegra_xusb_port_type;
>  	port->dev.of_node =3D of_node_get(np);
>  	port->dev.parent =3D padctl->dev;
> +	port->dev.driver =3D padctl->dev->driver;

This looks wrong. I don't think driver's are supposed to set this
because it basically means that the device is being attached to the
driver, but in this case it doesn't get probed by the driver and in
fact the ports don't match the pad controller, so they can't really
be driven by the same driver.

Is there any particular reason why you need this?

Thierry

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4wcDkACgkQ3SOs138+
s6FsghAAoD/UomjaeZd8bY2R43NpHXrHIRhlcnRJUrm2NQzod8kdj9tkUH093usf
t+oPi+lizbJqV3P8wJUrk0wNPAz1B+2TchrcpuWXzc/orwcMhQVhV4Vw/B3psEo3
jxL0UE5bhSdErLS4enDP8lu9XiKfDBM5rXwroRYYWogQK86I3RLPeW+WJEzLbDfR
gJH47XBA7ZMTP3EmBXd92NZZA0+2CSiAjwoT5QC4+EJpYdhJTDPjmxQbZY/dHB37
TKu7s1tJMSz14Vkypgh2ExUufbk+f3JlYEka2R+DWXHSN3e2vLixoMtVIwYlaM33
AWAlBHW7iJPxGmoZLY3QyjF3fZOMvOzRRI/GwIbY+F6kwPFEiZHmoPruBVLKyg4a
4q0hkBD/O2Q/8A/boju/7eUVw3WXRFzVvSYHoKVvl3rsY6o4hIlAuGj6crkaDarh
gPJYvJh6eDY5snTEM98/Xmrme82PKLaXJGcf8FBZ1ZCUQoak4EX2mop+30Ml38Ly
ABLHIaubha4ciqJ4DZwX5lwuUQyEXSgr1IKeLklGBuIvK6ffvsjSK9fYHasGUrmz
V2W+urskYuFQPefo0zND/vBGFtYTWbFz+cQxNWz/F4uU1j8adbVb5txSgOleRutF
lXfIGLpnOk+eGhf/it6b6phm/AKz2FgJt3d2E4xNMq27JuMUsuk=
=nbqn
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
