Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391ACC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07FD20732
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWPs3Yfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgA2J0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:26:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40817 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgA2J0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:26:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so5564932wmi.5;
        Wed, 29 Jan 2020 01:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C5FR3KDweP6mgB/gUrjId83AFc5dsG2FHxcfHuDP3Nk=;
        b=XWPs3YfhoZhgZ49WSridwi1KL+p6zWe4PrD0xfpxieWsY/sye5pk9qb3nJTy7EB4pJ
         mpJrvC9koAEjr0WWj9Xj6MoqQBe0OrnVmwwoy/K352EFLAud7HicR0FLCJB7oE+0KX+1
         3H++iI9hyoLPstvU96Vd8q+nkogZvjYTGBHLg76ZTmb3lHwgoi33wgloQlMEWU8Z+APz
         AuwAW+aJQSGppGdqgACTps+67h/yGPnfbMQtb96DffgW29jNj4JKe1S0btshPiRDR+kj
         JQ2Qu+GND23OaCHSEzOonYb8oPawtwhxtBCfSsn3xKO8PKFopfqrp9thrUVtiQAes5Dz
         FbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C5FR3KDweP6mgB/gUrjId83AFc5dsG2FHxcfHuDP3Nk=;
        b=lsRsssBvKmpH3myuNd9QmvERc24m78oFoQpx1NW0dDof9iJ8WzeH4WetKRfY2a1PD2
         +PoSg13AIEHrRk3IQrmipND9pXL1zvDJYWlj97wEK3ZvbR4lvZ1gayPFa/vRXY+T3jNJ
         wCQFCVGLYTZpxFrg6mHjM8z6FuSMOUg17z8UfC5eODhqLU3oxonnatCzoMzc5+51D4oj
         lBy6e8UIjX0qh6elGr6o3RIMUOh6Auav0pa4+74E9+Ca3pFsnEPiFnnQ2d6r3LF2hCZm
         DJoUGDC5PZrM9+LxN2TzNmJCWHS91Bd2uF4/4ex+CH0dyMe1df6m0IMuTzKxAXNejtb3
         VfNQ==
X-Gm-Message-State: APjAAAW1zv7W7AKaTVFT6YK14H5yl+gk1GXehoxp36SVUTXV8IGnMXiA
        oH7ypE9oWf31o3TreQRfVbY=
X-Google-Smtp-Source: APXvYqxRIXERmuEjll6+nCJOcZ8zT2G/LmRprlxssw2+Z9UuQupmkMh6GjWfWtXgajV1GbXVe6eCbQ==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr10206267wmg.20.1580289970274;
        Wed, 29 Jan 2020 01:26:10 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id h2sm2107589wrt.45.2020.01.29.01.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 01:26:08 -0800 (PST)
Date:   Wed, 29 Jan 2020 10:26:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3 03/18] phy: tegra: xusb: Add usb-role-switch support
Message-ID: <20200129092607.GA2479935@ulmo>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-4-git-send-email-nkristam@nvidia.com>
 <20200128173244.GA2293590@ulmo>
 <b6de0078-f1cd-31a1-70bd-dfc320eab70e@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <b6de0078-f1cd-31a1-70bd-dfc320eab70e@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 02:45:38PM +0530, Nagarjuna Kristam wrote:
>=20
>=20
> On 28-01-2020 23:02, Thierry Reding wrote:
> > On Mon, Dec 30, 2019 at 04:39:40PM +0530, Nagarjuna Kristam wrote:
> > > If usb-role-switch property is present in USB 2 port, register
> > > usb-role-switch to receive usb role changes.
> > >=20
> > > Signed-off-by: Nagarjuna Kristam<nkristam@nvidia.com>
> > > ---
> > > V3:
> > >   - Driver aborts if usb-role-switch is not added in dt forotg/periph=
eral
> > >     roles.
> > >   - Added role name strings instead of enum values in debug prints.
> > >   - Updated arguments and variable allignments as per Thierry inputs.
> > > ---
> > > V2:
> > >   - Removed dev_set_drvdata for port->dev.
> > >   - Added of_platform_depopulate during error handling and driver rem=
oval.
> > > ---
> > >   drivers/phy/tegra/Kconfig |  1 +
> > >   drivers/phy/tegra/xusb.c  | 57 ++++++++++++++++++++++++++++++++++++=
+++++++++++
> > >   drivers/phy/tegra/xusb.h  |  3 +++
> > >   3 files changed, 61 insertions(+)
> > >=20
> > > diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
> > > index f9817c3..df07c4d 100644
> > > --- a/drivers/phy/tegra/Kconfig
> > > +++ b/drivers/phy/tegra/Kconfig
> > > @@ -2,6 +2,7 @@
> > >   config PHY_TEGRA_XUSB
> > >   	tristate "NVIDIA Tegra XUSB pad controller driver"
> > >   	depends on ARCH_TEGRA
> > > +	select USB_CONN_GPIO
> > >   	help
> > >   	  Choose this option if you have an NVIDIA Tegra SoC.
> > > diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> > > index f98ec39..11ea9b5 100644
> > > --- a/drivers/phy/tegra/xusb.c
> > > +++ b/drivers/phy/tegra/xusb.c
> > > @@ -523,6 +523,7 @@ static int tegra_xusb_port_init(struct tegra_xusb=
_port *port,
> > >   	port->dev.type =3D &tegra_xusb_port_type;
> > >   	port->dev.of_node =3D of_node_get(np);
> > >   	port->dev.parent =3D padctl->dev;
> > > +	port->dev.driver =3D padctl->dev->driver;
> > This looks wrong. I don't think driver's are supposed to set this
> > because it basically means that the device is being attached to the
> > driver, but in this case it doesn't get probed by the driver and in
> > fact the ports don't match the pad controller, so they can't really
> > be driven by the same driver.
> >=20
> > Is there any particular reason why you need this?
> >=20
> > Thierry
>=20
> Yes, port->dev.driver->owner is accessed in USB role switch driver in API
> usb_role_switch_get. If driver param is not updated, it causes NULL point=
er
> exception. Based on your inputs, since this assignment is not supposed to
> used, I believe option available is to create a new device_driver structu=
re
> and assign the same here.
> Please share your thoughts.

Sounds to me more like what we want is to make the module_get() and
module_put() calls conditional to avoid the NULL pointer dereference.
Another common variant that I've seen in other subsystems is to make
drivers pass in an owner explicitly via some operations structure to
allow more fine-grained control over the reference count.

In this particular case one option to do this would be to add a struct
module *owner field to usb_role_switch_desc and that's copied to struct
usb_role_switch in usb_role_switch_register() so that that can be used
for reference counting (perhaps with the current code as fallback).

That would allow using simple devices (i.e. not bound to a driver) to
work with this framework as well.

Thierry

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4xT60ACgkQ3SOs138+
s6G/uA//YgHnzWFjeDa1ZwWsKGhC1WNt8IJjC2xeJ/pryhlhg2NeANB+/JosYFWz
RRLRUYZ13Z4uvB/j2I437JXluVs3QZ9GKtdjxbWDqpJYX4l0c4Nk3ZBnxLeoG1Zn
QFM6j+ZLfbYTeSacA0EX+sKC/qK5EJuFZ8pW+D8wf9EE2VO6O8qB6/k4/sKHUwyv
hUokfc6zwlVfrZ7YDKRtleaiPbABS7frYnel5Mio6tFpyEKSw94KyyD5wBFSF6K+
En806WquNFG8c9LgfFszwLBinbCOML93TbFiz4gLuWtwqzik5XtwBdkOQVAQoHK7
kPp6D91/1PuG9zIVe6WWePjiCWXdbka9ScfYKdYMFDkRnkETsThbKZfdmien3X3H
Zzn4iFU4PzoRpLP//ctdv4PtX8TbEbdD/fmkMI1LxyqflF3XTNujpqQ8XOM1+ifg
BwNrM+MvfHdo4iCgZVMKF38QRKzRdTaq8G9NlDBqy06pZwKsDBWuAIydybwvfw9b
PekrIuhSRHWaKvtznDKBKy/pHv0RFdjVx6DYb8SNGJ3U28kXeYyjqi0RHX7VzENF
FlIGWZLbFmWa6TNipcN5GvlKfi8oCHy+hcpVUBLf0OBCzvkOAIjano7Mf7xugcHt
ea/keKxOJjLCdgMD1kpOVhbbgrjtlLVoYA0JLzq3OqXGXUf1c3E=
=exCt
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
