Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CB5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C72D21739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7uF7JGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgA1RyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:54:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34746 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1RyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:54:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so17091979wrr.1;
        Tue, 28 Jan 2020 09:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SrzicRAis6re1h034c57OpFjFBc41U65t0HnB2tj5Kk=;
        b=Q7uF7JGbH/EOkqCLzKGUtAyJ+u5/WSWr9mM8JBYDxv37YfwdXmEHhAciTTS75ZaG35
         uEFFP42GDemPm1uT3WGle/WDgKaVmkAxjp5aHPDZoQGHIvgc77glASo4SIYkDBlzbzjX
         57KMsBonekO03tYL0+PG94cs1OtpE31gBmzLcyUKxwr7qGbwWv8YqKP3yBSuZaBQ2DlI
         8if1sXTL6iey4hHEMs0Qt9QhsWqUo8ClPANf6uFS9MVMPUNI4ooyFCWRw7h7lwD0CpSY
         XIob7sA8RDXFpRrpPfA+oGG+T9EcDts6jO92Xxxy17M6Bi+jVPtdbMLOALcPYJBjttU+
         ZjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SrzicRAis6re1h034c57OpFjFBc41U65t0HnB2tj5Kk=;
        b=oXkI83u4sByr0FlTiVi3wHvnHw1agtQaX4k9LLS6C2DzH6s5L7po3y//EW/GjDjdog
         EcW+RyUv8VYBosXzPTgNBnqBXr5fAU2z9cUUpdM+3hkT8cSMzbaSnQ7TPpvbNaAuSW6z
         xznwLvDQ+aYx+h1UYj8wTtStiCp1nXRBJTMCbzaUsl1fGa3Sah3+rH3pacw2QZtuGQ1P
         WXUmyLGbG1pWwGLCgCe7OOYpDx3uqjXYOuHENqBuwMlimhZCC+WLwjmkWvLwV6OIFQmt
         /m3ko0ESTg9788Umzo91fyx6CuYfoTAAS57YvPPYhec0fCvgHYc2ZMW9xMJLYc6pPeFg
         VI1w==
X-Gm-Message-State: APjAAAVXvrblRmpp9vZLOyl0u6r95MJnNXzYOMrzfGNKEr7rbv6BqYCZ
        kwOfkunBtG2VKECG9lhTa18WiHh8
X-Google-Smtp-Source: APXvYqyAeaJGBc/a0Osg9D/hD0Txdpy/pfAC+q4ysATYDk15HnLcJM5K1JLxQLiZNpvQkcL5PGQkgg==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr29818532wrq.331.1580234045313;
        Tue, 28 Jan 2020 09:54:05 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id q124sm6429868wme.2.2020.01.28.09.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 09:54:04 -0800 (PST)
Date:   Tue, 28 Jan 2020 18:54:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3 08/18] usb: xhci-tegra: Add OTG support
Message-ID: <20200128175403.GF2293590@ulmo>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-9-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Content-Disposition: inline
In-Reply-To: <1577704195-2535-9-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 04:39:45PM +0530, Nagarjuna Kristam wrote:
> Get usb-phy's for availbale USB 2 phys. Register id notifiers for availab=
le
> usb-phy's to receive role change notifications. Perform PP for the receiv=
ed
> role change usb ports.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V3:
>  - No changes in this version
> ---
> V2:
>  - Removed extra line before tegra_xusb_probe API.
> ---
>  drivers/usb/host/xhci-tegra.c | 225 ++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 224 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index 0b58ef3..22f1d36 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -24,6 +24,9 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> +#include <linux/usb/otg.h>
> +#include <linux/usb/phy.h>
> +#include <linux/usb/role.h>
>  #include <soc/tegra/pmc.h>
> =20
>  #include "xhci.h"
> @@ -203,6 +206,7 @@ struct tegra_xusb_soc {
> =20
>  	bool scale_ss_clock;
>  	bool has_ipfs;
> +	bool otg_reset_sspi;
>  };
> =20
>  struct tegra_xusb_context {
> @@ -250,6 +254,14 @@ struct tegra_xusb {
>  	struct phy **phys;
>  	unsigned int num_phys;
> =20
> +	struct usb_phy **usbphy;
> +	unsigned int num_usb_phys;
> +	int otg_usb2_port;
> +	int otg_usb3_port;
> +	bool host_mode;
> +	struct notifier_block id_nb;
> +	struct work_struct id_work;
> +
>  	/* Firmware loading related */
>  	struct {
>  		size_t size;
> @@ -1081,6 +1093,205 @@ static int tegra_xusb_enable_firmware_messages(st=
ruct tegra_xusb *tegra)
>  	return err;
>  }
> =20
> +static void tegra_xhci_set_port_power(struct tegra_xusb *tegra, bool mai=
n,
> +						 bool set)
> +{
> +	struct xhci_hcd *xhci =3D hcd_to_xhci(tegra->hcd);
> +	struct usb_hcd *hcd =3D main ?  xhci->main_hcd : xhci->shared_hcd;
> +	int wait =3D (!main && !set) ? 1000 : 10;
> +	u16 typeReq =3D set ? SetPortFeature : ClearPortFeature;
> +	u16 wIndex =3D main ? tegra->otg_usb2_port + 1 : tegra->otg_usb3_port +=
 1;
> +	u32 status;
> +	u32 stat_power =3D main ? USB_PORT_STAT_POWER : USB_SS_PORT_STAT_POWER;
> +	u32 status_val =3D set ? stat_power : 0;
> +
> +	dev_dbg(tegra->dev, "%s:%s %s PP\n", __func__, set ? "set" : "clear",
> +							main ? "HS" : "SS");

Perhaps add parentheses after the first %s to make it clear that it's a
function name. Also, maybe spell out PP to make it a bit clearer what's
meant by it?

> +
> +	tegra_xhci_hc_driver.hub_control(hcd, typeReq, USB_PORT_FEAT_POWER,

Can we replace tegra_xhci_hc_driver. by hcd->driver-> here and below?
That's slightly shorter and decouples the implementation from this hard-
coded name.

> +					 wIndex, NULL, 0);
> +
> +	do {
> +		tegra_xhci_hc_driver.hub_control(hcd, GetPortStatus, 0, wIndex,
> +					(char *) &status, sizeof(status));
> +		if (status_val =3D=3D (status & stat_power))
> +			break;
> +
> +		if (!main && !set)
> +			usleep_range(600, 700);
> +		else
> +			usleep_range(10, 20);
> +	} while (--wait > 0);
> +
> +	if (status_val !=3D (status & stat_power))
> +		dev_info(tegra->dev, "failed to %s %s PP %d\n",
> +						set ? "set" : "clear",
> +						main ? "HS" : "SS", status);
> +}
> +
> +static struct phy *tegra_xusb_get_phy(struct tegra_xusb *tegra, char *na=
me,
> +								int port)
> +{
> +	int i, phy_count =3D 0;

These can be unsigned int. Same elsewhere.

> +
> +	for (i =3D 0; i < tegra->soc->num_types; i++) {
> +		if (!strncmp(tegra->soc->phy_types[i].name, "usb2",
> +							    strlen(name)))
> +			return tegra->phys[phy_count+port];
> +
> +		phy_count +=3D tegra->soc->phy_types[i].num;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void tegra_xhci_id_work(struct work_struct *work)
> +{
> +	struct tegra_xusb *tegra =3D container_of(work, struct tegra_xusb,
> +						id_work);
> +	struct xhci_hcd *xhci =3D hcd_to_xhci(tegra->hcd);
> +	struct tegra_xusb_mbox_msg msg;
> +	struct phy *phy =3D tegra_xusb_get_phy(tegra, "usb2",
> +						    tegra->otg_usb2_port);
> +	u32 status;
> +	int ret;
> +
> +	dev_dbg(tegra->dev, "host mode %s\n", tegra->host_mode ? "on" : "off");
> +
> +	mutex_lock(&tegra->lock);
> +
> +	if (tegra->host_mode)
> +		phy_set_mode_ext(phy, PHY_MODE_USB_OTG, USB_ROLE_HOST);
> +	else
> +		phy_set_mode_ext(phy, PHY_MODE_USB_OTG, USB_ROLE_NONE);
> +
> +	mutex_unlock(&tegra->lock);
> +
> +	if (tegra->host_mode) {
> +		/* switch to host mode */
> +		if (tegra->otg_usb3_port >=3D 0) {
> +			if (tegra->soc->otg_reset_sspi) {
> +				/* set PP=3D0 */
> +				tegra_xhci_hc_driver.hub_control(
> +					xhci->shared_hcd, GetPortStatus,
> +					0, tegra->otg_usb3_port+1,
> +					(char *) &status, sizeof(status));
> +				if (status & USB_SS_PORT_STAT_POWER)
> +					tegra_xhci_set_port_power(tegra, false,
> +								  false);
> +
> +				/* reset OTG port SSPI */
> +				msg.cmd =3D MBOX_CMD_RESET_SSPI;
> +				msg.data =3D tegra->otg_usb3_port+1;
> +
> +				ret =3D tegra_xusb_mbox_send(tegra, &msg);
> +				if (ret < 0) {
> +					dev_info(tegra->dev,
> +						"failed to RESET_SSPI %d\n",
> +						ret);
> +				}
> +			}
> +
> +			tegra_xhci_set_port_power(tegra, false, true);
> +		}
> +
> +		tegra_xhci_set_port_power(tegra, true, true);
> +
> +	} else {
> +		if (tegra->otg_usb3_port >=3D 0)
> +			tegra_xhci_set_port_power(tegra, false, false);
> +
> +		tegra_xhci_set_port_power(tegra, true, false);
> +	}
> +}
> +
> +static int tegra_xusb_get_usb2_port(struct tegra_xusb *tegra,
> +					      struct usb_phy *usbphy)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < tegra->num_usb_phys; i++) {
> +		if (tegra->usbphy[i] && usbphy =3D=3D tegra->usbphy[i])
> +			return i;
> +	}
> +
> +	return -1;
> +}
> +
> +static int tegra_xhci_id_notify(struct notifier_block *nb,
> +					 unsigned long action, void *data)
> +{
> +	struct tegra_xusb *tegra =3D container_of(nb, struct tegra_xusb,
> +						    id_nb);
> +	struct usb_phy *usbphy =3D (struct usb_phy *)data;
> +
> +	dev_dbg(tegra->dev, "%s: action is %ld", __func__, action);
> +
> +	if ((tegra->host_mode && action =3D=3D USB_ROLE_HOST) ||
> +		(!tegra->host_mode && action !=3D USB_ROLE_HOST)) {
> +		dev_dbg(tegra->dev, "Same role(%d) received. Ignore",
> +							tegra->host_mode);
> +		return NOTIFY_OK;
> +	}
> +
> +	tegra->otg_usb2_port =3D tegra_xusb_get_usb2_port(tegra, usbphy);
> +	tegra->otg_usb3_port =3D tegra_xusb_padctl_get_usb3_companion(
> +							tegra->padctl,
> +							tegra->otg_usb2_port);
> +
> +	tegra->host_mode =3D (action =3D=3D USB_ROLE_HOST) ? true : false;
> +
> +	schedule_work(&tegra->id_work);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int tegra_xusb_init_usb_phy(struct tegra_xusb *tegra)
> +{
> +	int i;
> +
> +	tegra->usbphy =3D devm_kcalloc(tegra->dev, tegra->num_usb_phys,
> +				   sizeof(*tegra->usbphy), GFP_KERNEL);
> +	if (!tegra->usbphy)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&tegra->id_work, tegra_xhci_id_work);
> +	tegra->id_nb.notifier_call =3D tegra_xhci_id_notify;
> +
> +	for (i =3D 0; i < tegra->num_usb_phys; i++) {
> +		struct phy *phy =3D tegra_xusb_get_phy(tegra, "usb2", i);
> +
> +		if (!phy)
> +			continue;
> +
> +		tegra->usbphy[i] =3D devm_usb_get_phy_by_node(tegra->dev,
> +							phy->dev.of_node,
> +							&tegra->id_nb);
> +		if (!IS_ERR(tegra->usbphy[i])) {
> +			dev_dbg(tegra->dev, "usbphy-%d registered", i);
> +			otg_set_host(tegra->usbphy[i]->otg, &tegra->hcd->self);
> +		} else {
> +			/*
> +			 * usb-phy is optional, continue if its not available.
> +			 */
> +			tegra->usbphy[i] =3D NULL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void tegra_xusb_deinit_usb_phy(struct tegra_xusb *tegra)
> +{
> +	int i;
> +
> +	cancel_work_sync(&tegra->id_work);
> +
> +	for (i =3D 0; i < tegra->num_usb_phys; i++)
> +		if (tegra->usbphy[i])
> +			otg_set_host(tegra->usbphy[i]->otg, NULL);
> +}
> +
>  static int tegra_xusb_probe(struct platform_device *pdev)
>  {
>  	struct tegra_xusb *tegra;
> @@ -1254,8 +1465,11 @@ static int tegra_xusb_probe(struct platform_device=
 *pdev)
>  		goto put_powerdomains;
>  	}
> =20
> -	for (i =3D 0; i < tegra->soc->num_types; i++)
> +	for (i =3D 0; i < tegra->soc->num_types; i++) {
> +		if (!strncmp(tegra->soc->phy_types[i].name, "usb2", 4))
> +			tegra->num_usb_phys =3D tegra->soc->phy_types[i].num;
>  		tegra->num_phys +=3D tegra->soc->phy_types[i].num;
> +	}
> =20
>  	tegra->phys =3D devm_kcalloc(&pdev->dev, tegra->num_phys,
>  				   sizeof(*tegra->phys), GFP_KERNEL);
> @@ -1384,6 +1598,12 @@ static int tegra_xusb_probe(struct platform_device=
 *pdev)
>  		goto remove_usb3;
>  	}
> =20
> +	err =3D tegra_xusb_init_usb_phy(tegra);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "failed to Init usb-phy: %d\n", err);

s/Init/init/, s/usb-phy/USB PHY/

> +		goto remove_usb3;
> +	}
> +
>  	return 0;
> =20
>  remove_usb3:
> @@ -1420,6 +1640,8 @@ static int tegra_xusb_remove(struct platform_device=
 *pdev)
>  	struct tegra_xusb *tegra =3D platform_get_drvdata(pdev);
>  	struct xhci_hcd *xhci =3D hcd_to_xhci(tegra->hcd);
> =20
> +	tegra_xusb_deinit_usb_phy(tegra);
> +
>  	usb_remove_hcd(xhci->shared_hcd);
>  	usb_put_hcd(xhci->shared_hcd);
>  	xhci->shared_hcd =3D NULL;
> @@ -1733,6 +1955,7 @@ static const struct tegra_xusb_soc tegra210_soc =3D=
 {
>  	},
>  	.scale_ss_clock =3D false,
>  	.has_ipfs =3D true,
> +	.otg_reset_sspi =3D true,

I'd prefer if these were initialized to false for the other per-SoC
structures. This has the advantage of making it clear what exactly is
supported and helps clarify whether this was done on purpose or whether
it was just omitted by accident.

With the nitpicks addressed, feel free to add:

Acked-by: Thierry Reding <treding@nvidia.com>

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4wdTsACgkQ3SOs138+
s6HIcQ//TM4dGzeRrE5FxxyjGflOslTBP7rtHkOpIHikeXQoFsnG+Uqnuok1bzs4
z1lI+aNsGvNWSWGbDEBU8r8kmEdvG87990pMT71D706PNiwuFllHbMX8Lciij71J
S30elCGY7uzynOOb+0DAIWYsO91r1wOddZMzI4jo8S+Kqn4hCeWmGXr791kGIqWS
2DV9/sHoRtOJ/oFcuIWaFuVT8MC5whGMgzESsF2UQnhYjuE/MjJ+i9O7AQis3ApC
J/fGg44FWcAN9T48/kVsoQ4k//hjxrICp5e4QEls1nhhMQBUNBlzXKlBCzB4/i7M
XJir/SJdkEa0bOIHYVm92SHtGuKRXLS1tQhm6o8SdQcnIP2cLmHYJOzOFpn/u0Jh
1pktTDfCX2tTpT6dF/o2ltzfHsws0zPbqdKnhp5rRAiGTWoL5vIMyLtPU9qgB/JX
2I0oVQr+YDr7R4f5qpKs8JAitjWUXiMuJH06OnezDosa2UwHhGd1HxPOckYvVs1x
QE8sCHc/t7pettdOLBAJF5ARBSLHKuZ3eYFl1L48yoqhKRhPATo2AhX0wZtLE+xy
TmM23e+mtvJWmNHCb2Y3f9nHL9Edt7lUUPFDpl7BqBzUm5h0i4FR3Ugb38bD50Yz
CMGAHgHDbVqwpFe6wZM/L4tc9K85GF2iQZnOn6cZAFg/iD9eEbI=
=k9Ol
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
