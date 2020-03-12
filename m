Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871D5C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643BC2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxRW7T4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCLJWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:22:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46378 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgCLJWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:22:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so6388984wrw.13;
        Thu, 12 Mar 2020 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HHo+aNY+ItMgLZP3gvXST00KCY8R68wpUmYZqeWvHHU=;
        b=lxRW7T4LBzXo1kWzFk6u+QGMGo2x4fwOpjqAolDnEMB+z+jSrygE3gjIvrSspfJHBD
         yoL4KvabJ6thodLNwwrYxCbr88vK2ahpVQ7sp0dqerLUEBMPFRn1eoK4yZUHKiKj/k9r
         LmLzAs+zUi6hrgJSTr3HUjJEF7ra46B4vRBn1d2x3xfxLqeHRpnh7eAgNd+c+NBnzd+N
         2C1UwqqjI6MZzYWBve5ZH1jEOU43TnQX1tuBb9c/i9rCa9BTzkhZDNhU/0Ppfr79jm+x
         UyrZIjUT1oIhVhRuYzIra6K80yT11l4tKDJCViyotTucHimfPqdvOvN3nHN7ab7cxOgf
         3CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HHo+aNY+ItMgLZP3gvXST00KCY8R68wpUmYZqeWvHHU=;
        b=l8J+lYTvjBil8EDO76B8o4rxfbjqg2e+k5U1vmo9RUbNGQuD0XEgBRFlRD387JN2eN
         D140ifXtT79ZRBHCUkVWNJEKaCFmoy2VxA+OazC1brV/3sN13g7JWpae5W7rnnnGG2IF
         ndz16ga7id/BXHWJGgKT1qS3bQ4NzdJd6iBY+K8SyTo4MHoVG4DyqQbApNqDvNOMWQgz
         ws2y4TVLsqizANxopY6sidzoql6bWbRrpKwLoN4dww5829+GF7J7LwDf/eo9xe/lvZ1B
         oFCwxIkR3yVhiJv2F/16a7xaIiULXH5NpfbOgm1kW/fxh/e7m0AgKvEiWtJN4lOmIexa
         hcLA==
X-Gm-Message-State: ANhLgQ2vol6O0hnUoE/QRmDGgTdxXjE73RA2EWVMdXeTdRpa8NjlZJaU
        S+M00MDHlL3Xrrp21QywPWA=
X-Google-Smtp-Source: ADFU+vu+H+W/kbDo5m03E1ZndkH8CbtAimq06IQy/GCG4aI1sj02lg6E/ZZsbkef8gkBlgqAfDOr2g==
X-Received: by 2002:adf:f652:: with SMTP id x18mr9857970wrp.299.1584004956982;
        Thu, 12 Mar 2020 02:22:36 -0700 (PDT)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id v10sm1700802wmh.17.2020.03.12.02.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 02:22:35 -0700 (PDT)
Date:   Thu, 12 Mar 2020 10:22:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V5 00/21] Tegra XUSB OTG support
Message-ID: <20200312092232.GA1199023@ulmo>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
 <20200217085130.GJ1339021@ulmo>
 <20200227173226.GA1114616@ulmo>
 <20200304070100.GA1271591@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20200304070100.GA1271591@kroah.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 08:01:00AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 27, 2020 at 06:32:26PM +0100, Thierry Reding wrote:
> > On Mon, Feb 17, 2020 at 09:51:30AM +0100, Thierry Reding wrote:
> > > On Mon, Feb 10, 2020 at 01:41:26PM +0530, Nagarjuna Kristam wrote:
> > > > This patch series adds OTG support on XUSB hardware used in Tegra21=
0 and
> > > > Tegra186 SoCs.
> > > >=20
> > > > This patchset is composed with :
> > > >  - dt bindings of XUSB Pad Controller
> > > >  - dt bindings for XUSB device Driver
> > > >  - Tegra PHY driver for usb-role-switch and usb-phy
> > > >  - Tegra XUSB host mode driver to support OTG mode
> > > >  - Tegra XUSB device mode driver to use usb-phy and multi device mo=
de
> > > >  - dts for XUSB pad controller
> > > >  - dts for xudc for Jetson TX1 and TX2
> > > >  - dts for Jetson-TK1
> > > >  - dts for Jetson-Nano
> > > >=20
> > > > Tegra Pad controller driver register for role switch updates for
> > > > OTG/peripheral capable USB ports and adds usb-phy for that correspo=
nding
> > > > USB ports.
> > > >=20
> > > > Host and Device mode drivers gets usb-phy from USB2's phy and regis=
ters
> > > > notifier for role changes to perform corresponding role tasks.
> > > >=20
> > > > Order of merging Patches:
> > > > Please merge DT changes first followed Tegra PHY driver changes and=
 then
> > > > USB driver changes.
> > >=20
> > > Felipe, Greg, Kishon,
> > >=20
> > > Given the runtime dependencies between these various parts, I could p=
ick
> > > these up into the Tegra tree if you provide an Acked-by.
> >=20
> > Ping. Are you guys okay if I pick these up into the Tegra tree?
>=20
> That's up to Felipe, I have no opinion :)

Felipe, Kishon,

I've picked up the device tree changes into the Tegra tree. Let me know
if you also want me to pick up the USB and PHY driver changes.

Thierry

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5p/04ACgkQ3SOs138+
s6EaeRAAlYPSUblcoth+8aD57Q5QnSCc7cNHu/mUZZSec1OvLuHKqKs74gAcDa38
fbTqyMY/OlKiZ4RIixrST8bZ+VT+IDp/4GHFS3G0nC6wlK340+NpE2RxtPAeS+Oh
WuAg+p5PnLd7JwixjUuJPAVe+J/jt3l4BD5KN2cibwMdeV+jwlEZJ1OJrx+s0GW0
eAnAAQmb/yZlYneiR2y1NRSW2qbWfv6D81ZR5f7xAkuZHjF3+d/L0EZdsZHgH3gR
3KRfEY0On0s+oWrDR3d4y3h3cfJJIYegpqA6PaFcTjMdNEFcR+R/BGter/OQDbVE
HeaFN8FBIUl2r+hgf33t4sT2EvYx5DJtxoDv/u7kwpDxXA53BLHDnEfXyyOU8JeN
nuuipt+DOGyFfgmQNgx0aqaabl04wXEpUvBWxECp8IYB2gmiXL0PPzNC/qDIE8id
z5p0H6GxXHWTiwsU5JwfHG9zNwppRl9I+XqgHIaSS4jWcmyQC0QwJysPBudXwy2c
mqWjrd+/q3cqBByBVMslEssxvURdOmnDQ0NYXTPMnWWUWOpizZWxFHBEHh/DGQ3z
W6pxj8LePB/B7bu7c9BeoR3mhs65sJsalbge2xk1nrYL1q1hat+3udkCcu71JGG1
W+Sl2jl5CtuW9XE8PYYm0vEhV7FRJqbo6a5/Dea9L/aEISKpL4A=
=l/y7
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
