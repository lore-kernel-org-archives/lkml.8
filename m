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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C0FC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A7422522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe4J1sCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgA1SCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:02:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51299 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1SCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:02:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id t23so3546696wmi.1;
        Tue, 28 Jan 2020 10:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VC3TO5/0Tj7TYkQFu/49yUTn5mFLsk+gjlGItx13KFE=;
        b=pe4J1sCdY1ENOKFA2YazUE4nljYGxGj4AIrMeHPN54rZ+4dYm98NYvolDe8TLNiIV4
         mRKgzJpyRJj4Asx2rcYtkdmBzH8R18f5kR5kBkARWBi+QBnrPkZXq3dHz061WT6KXHqg
         6urlbWQaVjaOLILmvZ4fciKDcaxji/lMIWzTAxnrTQTPUkNjWYz3iuNH8q/0oM3CY7g2
         UVSHQEYmA90GcfxvbyF0Lg7YWYkCYYx1t58XyjvuDMc2ahsx+CQ6UJdz0M31xZBAxJ/A
         N9wH5bp9vdWfLMNU6JkeYjaz9WEzsYK6SZ19ezK15ldstFn+bO8js4m4wQcrTN4ZuvGd
         deRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VC3TO5/0Tj7TYkQFu/49yUTn5mFLsk+gjlGItx13KFE=;
        b=P2YpBctGx6qiAPV0qXEwIbRMk4LSmQSfkjP09QKave8VRAtFDYE81dM379eY2QqsI8
         0z/1vahugP3u4bVG12Q+MJQ1OQTX4tLrwI3NQiVnGe+b8X9/XZ3L5Iiv0bK2P/+HoZS0
         /N8H0mFUlq/4Tc6PDe0bxJ2KCoholkr/40blB6/iYybJ7UOr0EnT2Wqm0Of4BPg9qRmO
         LHiqMPVAfPRS7t2m3Xvja4e0asmyBKhyhfMQDLgjSUzOmO1/M5UBorpqbrXdp1ermaY6
         D3G2Vh4jbeDxc4qK+ufNBujNKsZLFgJsYGjuyf4v7f3OX6ZtJ+1gaoAeBZUhOvVu74fb
         eiuQ==
X-Gm-Message-State: APjAAAXrJLqu0FWN/Su41uhjaUGbm3K9ccJ8wq+ozbHY61zoZ6/Duqdm
        78OFekUv2tFB79mBDC/2bd0=
X-Google-Smtp-Source: APXvYqxGDhnLvh5HcR0xAD8xuIpSXXgYAsf69YCj8ezpImos1V7vsvlZ0Jr3q5UES7ix6j+0QgLvyQ==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr6264071wmg.20.1580234535590;
        Tue, 28 Jan 2020 10:02:15 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id d10sm27037095wrw.64.2020.01.28.10.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:02:14 -0800 (PST)
Date:   Tue, 28 Jan 2020 19:02:13 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3 10/18] usb: gadget: tegra-xudc: Add usb-phy support
Message-ID: <20200128180213.GH2293590@ulmo>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-11-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Content-Disposition: inline
In-Reply-To: <1577704195-2535-11-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 04:39:47PM +0530, Nagarjuna Kristam wrote:
> usb-phy is used to get notified on the USB role changes. Get usb-phy from
> the utmi phy.

s/utmi phy/UTMI PHY/

>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2-V3:
>  - No changes in this version
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 39 +++++++++++++++++++++++++++++++=
++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc=
/tegra-xudc.c
> index 6ddb974..0f27d57 100644
> --- a/drivers/usb/gadget/udc/tegra-xudc.c
> +++ b/drivers/usb/gadget/udc/tegra-xudc.c
> @@ -26,7 +26,9 @@
>  #include <linux/reset.h>
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
> +#include <linux/usb/otg.h>
>  #include <linux/usb/role.h>
> +#include <linux/usb/phy.h>
>  #include <linux/workqueue.h>
> =20
>  /* XUSB_DEV registers */
> @@ -488,6 +490,9 @@ struct tegra_xudc {
>  	bool suspended;
>  	bool powergated;
> =20
> +	struct usb_phy *usbphy;
> +	struct notifier_block vbus_nb;
> +
>  	struct completion disconnect_complete;
> =20
>  	bool selfpowered;
> @@ -678,7 +683,22 @@ static void tegra_xudc_usb_role_sw_work(struct work_=
struct *work)
>  		tegra_xudc_device_mode_on(xudc);
>  	else
>  		tegra_xudc_device_mode_off(xudc);
> +}
> +
> +static int tegra_xudc_vbus_notifier(struct notifier_block *nb,
> +					 unsigned long action, void *data)
> +{
> +	struct tegra_xudc *xudc =3D container_of(nb, struct tegra_xudc,
> +					       vbus_nb);
> +
> +	dev_dbg(xudc->dev, "%s action is %ld\n", __func__, action);

I'd add the parentheses here, too. Maybe also a colon:

	"%s(): action is %ld\n"

> +
> +	xudc->role =3D (enum usb_role)action;
> =20
> +	if (!xudc->suspended)
> +		schedule_work(&xudc->usb_role_sw_work);
> +
> +	return NOTIFY_OK;
>  }
> =20
>  static void tegra_xudc_plc_reset_work(struct work_struct *work)
> @@ -1949,6 +1969,9 @@ static int tegra_xudc_gadget_start(struct usb_gadge=
t *gadget,
>  		xudc_writel(xudc, val, CTRL);
>  	}
> =20
> +	if (xudc->usbphy)
> +		otg_set_peripheral(xudc->usbphy->otg, gadget);
> +
>  	xudc->driver =3D driver;
>  unlock:
>  	dev_dbg(xudc->dev, "%s: ret value is %d", __func__, ret);
> @@ -1969,6 +1992,9 @@ static int tegra_xudc_gadget_stop(struct usb_gadget=
 *gadget)
> =20
>  	spin_lock_irqsave(&xudc->lock, flags);
> =20
> +	if (xudc->usbphy)
> +		otg_set_peripheral(xudc->usbphy->otg, NULL);
> +
>  	val =3D xudc_readl(xudc, CTRL);
>  	val &=3D ~(CTRL_IE | CTRL_ENABLE);
>  	xudc_writel(xudc, val, CTRL);
> @@ -3573,10 +3599,15 @@ static int tegra_xudc_probe(struct platform_devic=
e *pdev)
>  	INIT_DELAYED_WORK(&xudc->port_reset_war_work,
>  				tegra_xudc_port_reset_war_work);
> =20
> -	/* Set the mode as device mode and this keeps phy always ON */
> -	dev_info(xudc->dev, "Set usb role to device mode always");

This obsoletes my comment in the previous patch, but maybe consider not
adding it in the first place.

> -	xudc->role =3D USB_ROLE_DEVICE;
> -	schedule_work(&xudc->usb_role_sw_work);
> +	xudc->vbus_nb.notifier_call =3D tegra_xudc_vbus_notifier;
> +	xudc->usbphy =3D devm_usb_get_phy_by_node(xudc->dev,
> +						xudc->utmi_phy->dev.of_node,
> +						&xudc->vbus_nb);
> +	if (IS_ERR(xudc->usbphy)) {
> +		err =3D PTR_ERR(xudc->usbphy);
> +		dev_err(xudc->dev, "failed to get usbphy phy: %d\n", err);

I'd make this: "failed to get USB PHY: %d\n", which is easier to read
than the above.

Thierry

> +		goto free_eps;
> +	}
> =20
>  	pm_runtime_enable(&pdev->dev);
> =20
> --=20
> 2.7.4
>=20

--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4wdyQACgkQ3SOs138+
s6GaCRAAmrVKiyZCDWEDR3PdiJ3VE3YYPM3f58d1P0nRXp+vOyC4M7UXVag34+20
x4xZcLy48iV594Y+LDJ+2PW1rgkUrcTQD7ml5giSYU0FBwVsnlqThgamxakxoKVG
ifAVmyPeX0okwcIz3+5I/FGWUyiOhWFZmXxsIep5Qc6OjyyiSfS1W6xTJ8y+c4D0
yc0NHJbFzRbQE3H8FlZQxIK07YBbIQ9puTsuxFywHFhaodYc4ZMynTCXuzRWVyzD
1T4GRYQtarwzvMmzZOP5XxhAF2YXdAv3LoFf+5SKemNpr2vt7+wbPFK+uUFNQRE0
vRrcpDp+Dqc8t6Orz5RR8w5l3R/hjTIV/rsU4hASAw3Sz/YSRZs3Xuc9/z0XdBC/
AGKIIWbx45Twte0tGFqqcekRY7EhI7jfSF/Qd9FEP/xK07yc+uHAw2ezF+FbVJlE
zmSI8ZAcTawjaxPB9GPT/Y1NqJzKkc+fmH7DbeVJJ4db/17pED4uf9qjuS4qhVG7
1au429N1SZB/QQAmIbiuaE53xEnsP1WRrUAu8aJZaJpMFg7U1JSj8rKIRQ6kUq3O
cDvczjGJO9YWWeEF4uazbiR/x/MNovWGl4o8Yv/4tG6jL3fPjVZalIZzp39dwv0e
ovsEes/Q3vzrXMZwk+tdFRmNwiWDkjymzi1Q2zO/rBKhi/PKQHw=
=QHyJ
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--
