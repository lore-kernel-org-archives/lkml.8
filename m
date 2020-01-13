Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E3EC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E177207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH8PxRJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgAMPHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:07:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35827 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgAMPHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:07:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so10053981wmb.0;
        Mon, 13 Jan 2020 07:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AwN2IRmBbgF51wtzzucPKwlBt/f3JlaSzZFnNgcNVdw=;
        b=fH8PxRJ8A4LPfKZfoSVUvflX4RSFeMP6AICq5d2z4yNRj4uL571tI1AZ/I+FlV/CZ6
         uwrtr0sciAXwcNn8aohd8HXqL9Hirqa1ySpmYDtpuEAr0I4OmOLDO2YWm7q6cD4pA7hL
         D/mqFN9Wvtba8rfvAT+2Cew4TzFwGfR7yFiQMdCs0k2b/zflOBFjyAVl91lB3yynYQlb
         oXt7NL6VU61o2Qj2FGu/57l3KqawZCvg8UZLGkbwIOVdGYVqe+XekEzYT87LIWUHjv2R
         hLmI29JQokzMVbsXw7f1bjUN4pRL9CfmVyByK9yaAp5xk2AVIJ593wsf+Mc6T+GY4UQc
         5RnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AwN2IRmBbgF51wtzzucPKwlBt/f3JlaSzZFnNgcNVdw=;
        b=dx4d3FuIFPxPq6EhefjmGULPtjjwlpnLzkdM04j9dP6s9Bh3RqQzS6kEIg3UwmWiDN
         sVvgfdTCPaO6rUEpEXeniPcNOGUHu7qj4yUxCm8hb9aE6haCB16LJ5jkQgacC5urU+Cu
         9D5yFPfXLihwAdqNlTw/yZZab8y/6IsH7CGmCqqPugI2KgILido5O5xiOQOu7YEiDoWQ
         k2XO24I9I1O9ytPa+RtL+7qSGLHBjwTKxJpXJHqQ6oLYmFuK6X/5Y6FgeOPMg319afWt
         Dpaao0TvVrPd7pMRs3BBQQsJjHuv3AtZhS3JlbtVVD+tvJ6w5flf0Ga0Mwf8z/27Behx
         umSA==
X-Gm-Message-State: APjAAAU17Wk0em0iTOAckhmAOft04Vbuoii9p3D42lBp0O1lVv5FKSo/
        zCcJHRHi834IvnigtStCb+4=
X-Google-Smtp-Source: APXvYqxc+/c9wA/gbPWZ+Ltiu+ig50WRaCqSeSAy/w1p+OZq6Zsre8YPC0LCBl2zKbLeMPViJmOKfw==
X-Received: by 2002:a05:600c:251:: with SMTP id 17mr19923698wmj.88.1578928018314;
        Mon, 13 Jan 2020 07:06:58 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id r68sm14640221wmr.43.2020.01.13.07.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 07:06:56 -0800 (PST)
Date:   Mon, 13 Jan 2020 16:06:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     JC Kuo <jckuo@nvidia.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V2 01/18] dt-bindings: phy: tegra-xusb: Add
 usb-role-switch
Message-ID: <20200113150656.GB2436168@ulmo>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <1576660591-10383-2-git-send-email-nkristam@nvidia.com>
 <20191219130503.GG1440537@ulmo>
 <fe47fd52-efd0-4f84-d1e4-4bce5571e425@nvidia.com>
 <20200110111633.GA2233456@ulmo>
 <6eb31a50-472f-439c-3bc7-bcad1c0c9ff4@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <6eb31a50-472f-439c-3bc7-bcad1c0c9ff4@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 10:07:08AM +0530, Nagarjuna Kristam wrote:
>=20
> On 10-01-2020 16:46, Thierry Reding wrote:
> > On Fri, Dec 20, 2019 at 04:08:30PM +0800, JC Kuo wrote:
> > > On 12/19/19 9:05 PM, Thierry Reding wrote:
> > > > On Wed, Dec 18, 2019 at 02:46:14PM +0530, Nagarjuna Kristam wrote:
> > > > > Add usb-role-switch property for Tegra210 and Tegra186 platforms.=
 This
> > > > > entry is used by XUSB pad controller driver to register for role =
changes
> > > > > for OTG/Peripheral capable USB 2 ports.
> > > > >=20
> > > > > Signed-off-by: Nagarjuna Kristam<nkristam@nvidia.com>
> > > > > ---
> > > > > V2:
> > > > >   - Moved usb-role-switch to seperate Required section as suggest=
ed by Thierry.
> > > > >   - Added reference to usb/usb-conn-gpio.txt for connector subnod=
e.
> > > > > ---
> > > > >   .../devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt    =
     | 6 ++++++
> > > > >   1 file changed, 6 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra12=
4-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-x=
usb-padctl.txt
> > > > > index 9fb682e..23bf354 100644
> > > > > --- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-=
padctl.txt
> > > > > +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-=
padctl.txt
> > > > > @@ -174,6 +174,12 @@ Required properties:
> > > > >     - "device": for USB device mode
> > > > >     - "otg": for USB OTG mode
> > > > > +Required properties for OTG/Peripheral capable USB2 ports:
> > > > > +- usb-role-switch: Boolean property to indicate that the port su=
pport OTG or
> > > > "supports", and also, why if it supports OTG*or*  peripheral? Doesn=
't
> > > > OTG imply peripheral? OTG means it can be either peripheral or host,
> > > > right? So I think the end of that sentence can be just:
> > > >=20
> > > > 	"... the port supports OTG."
> > > An USB OTG port is capable of both USB host and peripheral operations=
=2E An USB
> > > peripheral port can only act as an USB peripheral.
> > >=20
> > > The micro USB ports found on Jetson TX1/TX2 platforms are micro-AB po=
rts which
> > > should implement both host and peripheral capabilities. We say such p=
orts
> > > support OTG. The micro USB port found on Jetson Nano is a micro-B por=
t which
> > > should implement peripheral capability only. We say such ports support
> > > peripheral, rather than OTG.
> > I the port supports only peripheral mode, why do we need to have a
> > usb-role-switch property? Shouldn't we in that case have a mode property
> > with value "device"?
> >=20
> > usb-mode-switch is only needed if mode =3D "otg", isn't it? In all other
> > cases the functionality is fixed (either host or peripheral) and the
> > mode cannot be switched.
> >=20
> > Thierry
>=20
> usb-role-switch is needed when mode =3D=3D "otg" or "peripheral".
>=20
> Device mode is detected via vbus GPIO irrespective of mode being peripher=
al
> only or OTG.
> Host mode is detected via id-gpio, in OTG case.
>=20
> When mode is peripheral, role changes happens between USB_ROLE_DEVICE and
> USB_ROLE_NONE, which are generally based on Vbus GPIO(hot plug) detection.
>=20
> When mode is otg, role changes happens between USB_ROLE_HOST,
> USB_ROLE_DEVICE and USB_ROLE_NONE, which are detected via id-gpio, vbus-g=
pio
> and no detection respectively.

Right, that makes perfect sense. Thanks for putting it so clearly. With
the "support" -> "supports" typo fixed, this patch:

Acked-by: Thierry Reding <treding@nvidia.com>

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4ch40ACgkQ3SOs138+
s6EXWxAAhA3qkr4dwr/BpJvUBpto03CcTHQ3yV4woWvaZxHs63oSXPuCwPH7i/xS
e65s0sn9EV9QKBqxv6SehSlutGOnY108jbFEee9rHs0kidOEqJ9KXHCpXcEb6aX7
LqRNHrJbZAqJaxE8ESl3L07qDGl8SaAtdfZEIB0taqON2jvg2nALXU3QeCMG9WRZ
0TXhUqQdBIGopsh5rAo68YnYR9M72x/IRoE1Qa4t0o/FlnkuL3yA/3YwLP5epT/4
tSThMSmuVCh9vF5TqbnRkXBzKCbAGBJt91odL1WkCJpVKM7VaNcRAJJY8p4/Qwlo
m52OPNzfNPTtPbs+DbO+1PvDSJ3KR5yZbt42eIUtBVOt+R1P+EbDvKAwz1pAxvyO
dT3++fDIuRnnNCKt4n76tpEg5j8jN0ll3MDlo21iSjTuIt3tgIXiRggsc9Oc5ZQ7
FFhfX6hRZ62KTw5ivbmstgQTxeFecvN7JE7e14SBgkg4i7UakcVcxUDJDuS6A+IL
psXp1i7TURnb61hlKmSry91JagO0edTxEoxKGgL5dgCe/SmyLFmI6W3T8PtaW+L9
td4eKAhi3AP3Y8tUVXJykCy06nD57vna1GJ/ku/PbYNiV5ge2amZMECdz0kKaGQP
PvTUxuCaCeFfvHRU4fGuTn/D7XfHD95gr9e8TQFddsQWwt8Xmzs=
=/QZt
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
