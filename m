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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0680EC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A1024683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIiY7X96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgA1R6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:58:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33015 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgA1R6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:58:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so17143881wrq.0;
        Tue, 28 Jan 2020 09:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eWf4MXWVgZzIS0IZLkTlSOrHyMxMK8Uw5fPfm31lEIo=;
        b=cIiY7X96l0myp67rQoU2bHaiBzweJIOzsQyHee31HZjG86I2hkcFGe6CwUyWLlOidi
         Ltm8okcTQTButUUps2r8v12QKAfos18VV4jIdWFajZ3zoaAMmWrfCpAGZSD/WfDcCSs0
         uqlI621LoI7k0snqsv94waXdDFpYOy7S/quDGfBE8N02afGjN3Giggxhq60C59e9oUJ5
         RSqMKUpDB2xRq3GuHnSZn03NK66aVBXz9C164+DifT6zkYeJoh1qa/ld5XyXo6o6sdXs
         fg/zNz7ptv3q1oFfFNtgKsktUHkMp59q7lnlharC9U3JZqJh9Xs7YhBFNmkcUzzHINdb
         nB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eWf4MXWVgZzIS0IZLkTlSOrHyMxMK8Uw5fPfm31lEIo=;
        b=pmY0FfEkhtkD4R3J/pOeOEulQ01dVfETHq9GVI+7KBHii6CRP8AJ9cYupVsHuRhXy8
         mzt9obb33XzAT0KIGbXVzamU8RWg/IwZyINTIfOH858p9G7A6kBTN9/dbheWkVhX6Idq
         i/q2FFfiMSl3bhHdxifLC1JLMcUoAQLP87eyVoHXhvekKNy+L6INT+X4qoEQJCdEW7sZ
         e8G5HlK0rtm+3zjZ9t9UHt+8WcBGy6PZNjBsDkSLz6Evc+3cO2cvyswogWGrgsZDt1Zo
         clytZe5Qbd+yc5dEYPXLP4XiymJ8SOYdMfggZ0UEfXVtCmvaW/0CKPFhj/pl2SDDtKL3
         mbRw==
X-Gm-Message-State: APjAAAWBM+zKhaaeANkGQH48Vt58I8ML4/pLKn/MKUWjlX6UYDJD5GXI
        fEGe/k9nyWSKgtqXw9fZHa4=
X-Google-Smtp-Source: APXvYqyAEJijNPKlYmwOtBzJbpVHJiIIb2oN7tLD/yOA+lQqA5bJsqR3tiCD7By+x30x3a7eo1YtxQ==
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr31431241wrs.179.1580234286290;
        Tue, 28 Jan 2020 09:58:06 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id g7sm26427157wrq.21.2020.01.28.09.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 09:58:05 -0800 (PST)
Date:   Tue, 28 Jan 2020 18:58:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3 09/18] usb: gadget: tegra-xudc: Remove usb-role-switch
 support
Message-ID: <20200128175803.GG2293590@ulmo>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-10-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline
In-Reply-To: <1577704195-2535-10-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 04:39:46PM +0530, Nagarjuna Kristam wrote:
> Padctl driver will act as a central driver to receive USB role changes via
> usb-role-switch. This is updated to corresponding host, device drivers.
> Hence remove usb-role-switch from XUDC driver.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2-V3:
>  - No changes in this version
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 65 ++++++++++---------------------=
------
>  1 file changed, 17 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc=
/tegra-xudc.c
> index 634c2c1..6ddb974 100644
> --- a/drivers/usb/gadget/udc/tegra-xudc.c
> +++ b/drivers/usb/gadget/udc/tegra-xudc.c
> @@ -477,8 +477,8 @@ struct tegra_xudc {
> =20
>  	struct clk_bulk_data *clks;
> =20
> -	enum usb_role device_mode;
> -	struct usb_role_switch *usb_role_sw;
> +	enum usb_role role;
> +	bool device_mode;
>  	struct work_struct usb_role_sw_work;
> =20
>  	struct phy *usb3_phy;
> @@ -596,6 +596,8 @@ static void tegra_xudc_device_mode_on(struct tegra_xu=
dc *xudc)
>  {
>  	int err;
> =20
> +	if (xudc->device_mode)
> +		return;

Could use an extra blank line after the block.

>  	pm_runtime_get_sync(xudc->dev);
> =20
>  	err =3D phy_power_on(xudc->utmi_phy);
> @@ -610,7 +612,8 @@ static void tegra_xudc_device_mode_on(struct tegra_xu=
dc *xudc)
> =20
>  	tegra_xusb_padctl_set_vbus_override(xudc->padctl, true);
> =20
> -	xudc->device_mode =3D USB_ROLE_DEVICE;
> +	xudc->device_mode =3D true;
> +

But this blank line is gratuituous.

>  }
> =20
>  static void tegra_xudc_device_mode_off(struct tegra_xudc *xudc)
> @@ -619,6 +622,9 @@ static void tegra_xudc_device_mode_off(struct tegra_x=
udc *xudc)
>  	u32 pls, val;
>  	int err;
> =20
> +	if (!xudc->device_mode)
> +		return;
> +
>  	dev_dbg(xudc->dev, "device mode off\n");
> =20
>  	connected =3D !!(xudc_readl(xudc, PORTSC) & PORTSC_CCS);
> @@ -643,7 +649,7 @@ static void tegra_xudc_device_mode_off(struct tegra_x=
udc *xudc)
>  		xudc_writel(xudc, val, PORTSC);
>  	}
> =20
> -	xudc->device_mode =3D USB_ROLE_NONE;
> +	xudc->device_mode =3D false;
> =20
>  	/* Wait for disconnect event. */
>  	if (connected)
> @@ -668,31 +674,13 @@ static void tegra_xudc_usb_role_sw_work(struct work=
_struct *work)
>  	struct tegra_xudc *xudc =3D container_of(work, struct tegra_xudc,
>  					       usb_role_sw_work);
> =20
> -	if (!xudc->usb_role_sw ||
> -		usb_role_switch_get_role(xudc->usb_role_sw) =3D=3D USB_ROLE_DEVICE)
> +	if (xudc->role =3D=3D USB_ROLE_DEVICE)
>  		tegra_xudc_device_mode_on(xudc);
>  	else
>  		tegra_xudc_device_mode_off(xudc);
> =20
>  }
> =20
> -static int tegra_xudc_usb_role_sw_set(struct device *dev, enum usb_role =
role)
> -{
> -	struct tegra_xudc *xudc =3D dev_get_drvdata(dev);
> -	unsigned long flags;
> -
> -	dev_dbg(dev, "%s role is %d\n", __func__, role);
> -
> -	spin_lock_irqsave(&xudc->lock, flags);
> -
> -	if (!xudc->suspended)
> -		schedule_work(&xudc->usb_role_sw_work);
> -
> -	spin_unlock_irqrestore(&xudc->lock, flags);
> -
> -	return 0;
> -}
> -
>  static void tegra_xudc_plc_reset_work(struct work_struct *work)
>  {
>  	struct delayed_work *dwork =3D to_delayed_work(work);
> @@ -729,8 +717,7 @@ static void tegra_xudc_port_reset_war_work(struct wor=
k_struct *work)
> =20
>  	spin_lock_irqsave(&xudc->lock, flags);
> =20
> -	if ((xudc->device_mode =3D=3D USB_ROLE_DEVICE)
> -			      && xudc->wait_for_sec_prc) {
> +	if (xudc->device_mode && xudc->wait_for_sec_prc) {
>  		pls =3D (xudc_readl(xudc, PORTSC) & PORTSC_PLS_MASK) >>
>  			PORTSC_PLS_SHIFT;
>  		dev_dbg(xudc->dev, "pls =3D %x\n", pls);
> @@ -3457,7 +3444,6 @@ static int tegra_xudc_probe(struct platform_device =
*pdev)
>  {
>  	struct tegra_xudc *xudc;
>  	struct resource *res;
> -	struct usb_role_switch_desc role_sx_desc =3D { 0 };
>  	unsigned int i;
>  	int err;
> =20
> @@ -3587,23 +3573,10 @@ static int tegra_xudc_probe(struct platform_devic=
e *pdev)
>  	INIT_DELAYED_WORK(&xudc->port_reset_war_work,
>  				tegra_xudc_port_reset_war_work);
> =20
> -	if (of_property_read_bool(xudc->dev->of_node, "usb-role-switch")) {
> -		role_sx_desc.set =3D tegra_xudc_usb_role_sw_set;
> -		role_sx_desc.fwnode =3D dev_fwnode(xudc->dev);
> -
> -		xudc->usb_role_sw =3D usb_role_switch_register(xudc->dev,
> -							&role_sx_desc);
> -		if (IS_ERR(xudc->usb_role_sw)) {
> -			err =3D PTR_ERR(xudc->usb_role_sw);
> -			dev_err(xudc->dev, "Failed to register USB role SW: %d",
> -					   err);
> -			goto free_eps;
> -		}
> -	} else {
> -		/* Set the mode as device mode and this keeps phy always ON */
> -		dev_info(xudc->dev, "Set usb role to device mode always");
> -		schedule_work(&xudc->usb_role_sw_work);
> -	}
> +	/* Set the mode as device mode and this keeps phy always ON */
> +	dev_info(xudc->dev, "Set usb role to device mode always");

This doesn't seem useful. This is going to be always printed, but it's
not a special case or anything. If it's normal behaviour, no need to
explicitly mention it.

Thierry

> +	xudc->role =3D USB_ROLE_DEVICE;
> +	schedule_work(&xudc->usb_role_sw_work);
> =20
>  	pm_runtime_enable(&pdev->dev);
> =20
> @@ -3643,11 +3616,7 @@ static int tegra_xudc_remove(struct platform_devic=
e *pdev)
>  	pm_runtime_get_sync(xudc->dev);
> =20
>  	cancel_delayed_work(&xudc->plc_reset_work);
> -
> -	if (xudc->usb_role_sw) {
> -		usb_role_switch_unregister(xudc->usb_role_sw);
> -		cancel_work_sync(&xudc->usb_role_sw_work);
> -	}
> +	cancel_work_sync(&xudc->usb_role_sw_work);
> =20
>  	usb_del_gadget_udc(&xudc->gadget);
> =20
> --=20
> 2.7.4
>=20

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4wdisACgkQ3SOs138+
s6H6xRAArJGVRB+GkU3P40fijPlK0JeeXNX1gv3gYvkEqKEhNh2EHt4Q0INH9z7b
BdtKuwAy3mMuCT2CuL4gAyi6OlFhLPt2W9t7ZZLfwOd5jEXCGS1VJtIlCaH0t3MC
DTf+5DpOKikXK7Sz4sVtDc9MK2UHSsZpuuFsDGJBgDe2WXgyAdMH2sM3I2WK6EHi
ot1L7MIxftkHSneBNCbD+Fh1sghgVp1NXEuMl19yoBpkqPFwaUygSrpoM9yDpZ3e
oquOBY5ai7LC4C4a6CaLfV12/j61HJY8uDjVoJOD/gJDMegeSOV4oDnujh4CAkos
26qxoYrvUub/yp8ImxvKe+aOrKxnl1YxLXqp/xKBh33EwnuF8qeyy9bJHMXPWqny
1AYH+DBqX34c+hU7RtwGFnGz8a18RBNkgtWV4gMD2Dz/09jqyU6+rF6XfrABdp1b
QwQWdAKLCmXy26TqTZzZoj/0jQNpLlWsBsTkU1UTEOjylCJYJE/iTmzdscpLt5VD
OkFxILQLZD7GVQcLqrE2b3OxKMmEIhKakJ2AtN+4wk5DYMu+0FVvjTDS1255L1xj
6dyMEffCzYK+elFcRrMeB3Z5Lq+9GvXq9a3erBO4S7y+2xrRS+QEf7Swqleu8MzS
ORjZgCsz/vGX1mbqMBXjdMgiZ1eJuKt7UNUM6jcY4+qUg8I3ngo=
=fDEh
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
