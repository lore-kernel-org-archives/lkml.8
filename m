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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0993C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7243920663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZTAYoHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgA1Riq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:38:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34041 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1Rip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:38:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id s144so2289657wme.1;
        Tue, 28 Jan 2020 09:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GnYFBAaFnnGzHcsks3jSKPZysR18EJ0wZgAV7KKesFM=;
        b=rZTAYoHSHrba8Z7DNYHA918TtWNr5BVbM54IRrkBBsWmtLxzj1GdOTTW3XftGrtDx0
         vOgYsCXuWX3PoNwlTASQaw965+9SlXepfhETICxarKDHV1rgXtJd3EBIJ5bl2khUg0YB
         80AVPHIELjRHxUOVnCtM+NEdFtXH2yk1CUNHak+R+whwanHy2cEjtWYw7NrXsaxhBAi8
         ciD8atOcDwSwABMYwTncIcTWkZe6hgMasEliSim1iHAwVM6FFtHaOBUGz6hp+dODfmjj
         SZNwxHx5HFuydTufVOYXFWrrJtluhshij+p0h4SN177Er50k+BlikI0PgRxdXL1m3gKN
         D+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GnYFBAaFnnGzHcsks3jSKPZysR18EJ0wZgAV7KKesFM=;
        b=Dr80RlTIHl5NNk+7CvtDl7XYjG5o8aL07OA0WbttNqQLePjhflol8TvefgEdFGfeZq
         YiJO5918uzb/ysVWyKu3ap/BVowJRlAS4/zp1UlJzi0hkcqaasLyvLhX3Er2mbM+DdY7
         d6Zx3eWXJNaLh942evKL4dr9aAMgPruKY+WuaJMY1z+U8s8vToI+NsFgjE7GNDrRdqj5
         +UA97bkhQpX0uNwrvsERilJkU9FNYtChwN7FkQR7eAwaw/UCDIEnipcLeRsg17uRnA7W
         NOGYHRh21x+Vo8MSrXaK+qMgRy/XSqwol+dZ9IIozuj5IZtxi+g9eNoDjpOVpN/ZRwNf
         gPoA==
X-Gm-Message-State: APjAAAXgRYUbWwEchL/mFIF0aG2v9XWnOZ4Mr4SDuj73S2yQ4V5Tjajb
        tT/hPmoCXbs4lhuhk/b8c1ics3OO
X-Google-Smtp-Source: APXvYqxfQt5IedveVyAuZ/qqzLLYu+ghb1S9AdnmHazJtGo/Q0TWlP8WbiXqjx1/A+vHc4seQf9ivg==
X-Received: by 2002:a05:600c:145:: with SMTP id w5mr5998934wmm.157.1580233121984;
        Tue, 28 Jan 2020 09:38:41 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id z8sm26094821wrq.22.2020.01.28.09.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 09:38:40 -0800 (PST)
Date:   Tue, 28 Jan 2020 18:38:40 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3 04/18] phy: tegra: xusb: Add usb-phy support
Message-ID: <20200128173840.GB2293590@ulmo>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-5-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <1577704195-2535-5-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 04:39:41PM +0530, Nagarjuna Kristam wrote:
> For USB 2 ports that has usb-role-switch enabled, add usb-phy for
> corresponding USB 2 phy. USB role changes from role switch are then
> updated to corresponding host and device mode drivers via usb-phy notifier
> block.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V3:
>  - Updated arguments and variable allignments as per Thierry inputs.
> ---
> V2:
>  - Added dev_set_drvdata for port->dev.
> ---
>  drivers/phy/tegra/xusb.c | 71 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/phy/tegra/xusb.h |  2 ++
>  2 files changed, 76 insertions(+)
>=20
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index 11ea9b5..536b2fc 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -533,6 +533,8 @@ static int tegra_xusb_port_init(struct tegra_xusb_por=
t *port,
>  	if (err < 0)
>  		goto unregister;
> =20
> +	dev_set_drvdata(&port->dev, port);
> +
>  	return 0;
> =20
>  unregister:
> @@ -545,6 +547,8 @@ static void tegra_xusb_port_unregister(struct tegra_x=
usb_port *port)
>  	if (!IS_ERR_OR_NULL(port->usb_role_sw)) {
>  		of_platform_depopulate(&port->dev);
>  		usb_role_switch_unregister(port->usb_role_sw);
> +		cancel_work_sync(&port->usb_phy_work);
> +		usb_remove_phy(&port->usb_phy);
>  	}
> =20
>  	device_unregister(&port->dev);
> @@ -563,15 +567,62 @@ static const char * const usb_roles[] =3D {
>  	[USB_ROLE_DEVICE]	=3D "device",
>  };
> =20
> +static void tegra_xusb_usb_phy_work(struct work_struct *work)
> +{
> +	struct tegra_xusb_port *port =3D container_of(work,
> +						    struct tegra_xusb_port,
> +						    usb_phy_work);
> +	enum usb_role role =3D usb_role_switch_get_role(port->usb_role_sw);
> +
> +	dev_dbg(&port->dev, "%s: calling notifier for role %s\n", __func__,
> +		usb_roles[role]);

Nit: I'd add parentheses into the above message, after %s, to highlight
that this is the name of a function.

> +
> +	atomic_notifier_call_chain(&port->usb_phy.notifier, role,
> +				   &port->usb_phy);
> +}
> +
>  static int tegra_xusb_role_sw_set(struct device *dev, enum usb_role role)
>  {
> +	struct tegra_xusb_port *port =3D dev_get_drvdata(dev);
> +
>  	dev_dbg(dev, "%s: role %s\n", __func__, usb_roles[role]);
> =20
> +	schedule_work(&port->usb_phy_work);
> +
>  	return 0;
>  }
> =20
> +static int tegra_xusb_set_peripheral(struct usb_otg *otg,
> +				     struct usb_gadget *gadget)
> +{
> +	struct tegra_xusb_port *port =3D container_of(otg->usb_phy,
> +						    struct tegra_xusb_port,
> +						    usb_phy);
> +
> +	if (gadget !=3D NULL)
> +		schedule_work(&port->usb_phy_work);
> +
> +	return 0;
> +}
> +
> +static int tegra_xusb_set_host(struct usb_otg *otg, struct usb_bus *host)
> +{
> +	struct tegra_xusb_port *port =3D container_of(otg->usb_phy,
> +						    struct tegra_xusb_port,
> +						    usb_phy);
> +
> +	if (host !=3D NULL)
> +		schedule_work(&port->usb_phy_work);
> +
> +	return 0;
> +}
> +
> +
>  static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
>  {
> +	struct tegra_xusb_lane *lane =3D tegra_xusb_find_lane(port->padctl,
> +							    "usb2",
> +							    port->index);

Nit: This looks slightly awkward. It might be worth just declaring the
variable here and move the initialization to a separate line following
the declarations because then it fits on a single line.

>  	struct usb_role_switch_desc role_sx_desc =3D {
>  		.fwnode =3D dev_fwnode(&port->dev),
>  		.set =3D tegra_xusb_role_sw_set,
> @@ -587,6 +638,29 @@ static int tegra_xusb_setup_usb_role_switch(struct t=
egra_xusb_port *port)
>  		return err;
>  	}
> =20
> +	INIT_WORK(&port->usb_phy_work, tegra_xusb_usb_phy_work);
> +
> +	port->usb_phy.otg =3D devm_kzalloc(&port->dev,
> +					 sizeof(struct usb_otg), GFP_KERNEL);

Nit: typically you try to fill up a line as much as possible before you
wrap, so the sizeof(...) can go onto the first line.

> +	if (!port->usb_phy.otg)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Assign phy dev to usb-phy dev. Host/device drivers can use phy
> +	 * reference to retrieve usb-phy details.
> +	 */
> +	port->usb_phy.dev =3D &lane->pad->lanes[port->index]->dev;
> +	port->usb_phy.dev->driver =3D port->padctl->dev->driver;
> +	port->usb_phy.otg->usb_phy =3D &port->usb_phy;
> +	port->usb_phy.otg->set_peripheral =3D tegra_xusb_set_peripheral;
> +	port->usb_phy.otg->set_host =3D tegra_xusb_set_host;
> +
> +	err =3D usb_add_phy_dev(&port->usb_phy);
> +	if (err < 0) {
> +		dev_err(&port->dev, "Failed to add usbphy: %d\n", err);

Nit: "failed to add USB PHY: %d\n", to make this more consistent with
the existing error messages.

Other than that, looks great:

Acked-by: Thierry Reding <treding@nvidia.com>

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4wcZ8ACgkQ3SOs138+
s6EffQ//UdnjEtNVNKfHdQYj5Uj6j5MwVFl6K4Yqba6a/Ju5y/BTc0QCJ4qbInsj
w6g19X3jypklMuswztnYQEWsvfh2RHQ5nt734acXM8pBYMWQP+3OhRR/KZI1I4LP
pMyhpghZ8fIV5bCiu51+eN8ak5qtFj/YmLlgCOFQu5WwcLd/J+/q5j0UWoAhn/d0
G2PpyFQjyy34y4VCEgbVjCrk4vYhzsRYca1cLvDYYX0bGRHHelPqlhlf2wz12M/w
osJF0B7XRTNi7+neoqMQDfjNLYs9OtqNn0GkyrzN0dXhhVGN+kUD5eF5kf+gSYJC
a6rJXHM56IKWrrnEhc5BqFO6CIEyjMWdTTLvd8a1z92DdWorpav8o7iQl8NkIXFf
8vJv78HCq1pzpMzrYFsvYLnKPM1oP7tOyHUdXLqefhzKE6Dl2qdYw0S/kB7MxBr8
vyO5sVTvY64WY8iXnQklMaJiw7tqfsScJSNeF3Z+R1rfKbCuJfhqXmPDTfbCn6Ht
3YMxHSBtCLJ642sID0VQQEfmHPhpMhS6jhBTXtD9RDt8EdwSTT8n8yiXJBKPadd3
WGNLWTtiG9DNWX8AzXYkz4Xm49MUJ9zSTjuAs3AbKkG6scNnJECgsM4hxxfiw9sI
mPnC6+OqfxMGJkMR5civhYF66mfumx3ZpegxWTcjAsjjsIwH9Og=
=wSAb
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
