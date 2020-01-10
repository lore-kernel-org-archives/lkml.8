Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A72C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92BF2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GINyUwAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgAJLQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:16:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40161 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgAJLQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:16:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so1547340wmi.5;
        Fri, 10 Jan 2020 03:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZG+EStm5IgNAI24XeFd3AN/KFSTm5LItH5WtKVMTLFw=;
        b=GINyUwAhFa7AIa85UuM2z2aoKJAle2Cq6PrjcQpl/W+AK2JMG+a3gSDIRbS2v4ePwy
         3qPLYwP8vumW2y/b01i4fAGv3RP2tuy7oSX+TdsiQ9OM/uAOIEm1ysuBs6bqoxEfkUDW
         SPvFDxPdda1wEuEgKVijiX0ED86+guKd3OrZBkUcxQxxyufPQfxFrw3H73pQJnbRrkOV
         hIT7TIQgVxU6XBw9xCi/0IZdxDrpwugq3NSerFK/lDIJdyJj9CQI4uTGBgj2jghhaX2E
         dNKX2tocfyKtAFu2I4f193tJExaMxsrcP5DqXV9MRcZ3ChRss9QJ0zr33pWQm0PPwJac
         XNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZG+EStm5IgNAI24XeFd3AN/KFSTm5LItH5WtKVMTLFw=;
        b=pLPYtK+dkmQbrKUWmXiHz5awHjUKYHbZzUp7qZ+NXvQsAnoszS0HQirx/WlSumm1mn
         Wtm2PUH3on49NkUvVSnzol6iH0tgWybvNM769WqZInmINkN5QfD3uyAdw89n9JDtlnAc
         xcKlL1ySPqqspaCh7VaUpxxvYavL7KcRUng9YFFzpdoqjO2mr+fMdI7YsnOnaAwPNbPV
         xgj3VRcWsB/0cuuvnZnuzJVKm6LGTprJjxmsBKVQXuca6uA4MsSnkdGHLrhc0+eXn4YF
         KsRETTorLq+u1jnZuDARWeFfyhoKz4eSYOIJqPa3ypTQeJYW/rBE9gheyq1cCkAi8nXS
         N5nQ==
X-Gm-Message-State: APjAAAV2BkEVkqGZCi2rgCINA+H0apmgQnCOr4I6wohspExGyWS0KUTG
        HoREIP4jlumLkC0wXz4aIcU=
X-Google-Smtp-Source: APXvYqyHLl4P+MvmZjNLZBASg5tB2yr098D4jDMd94EbQ03gYKrQ9PfTCtdvIr4mEJX9p35G7gvIFA==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr3663987wml.107.1578654995517;
        Fri, 10 Jan 2020 03:16:35 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id s16sm1827624wrn.78.2020.01.10.03.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 03:16:33 -0800 (PST)
Date:   Fri, 10 Jan 2020 12:16:33 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     Nagarjuna Kristam <nkristam@nvidia.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V2 01/18] dt-bindings: phy: tegra-xusb: Add
 usb-role-switch
Message-ID: <20200110111633.GA2233456@ulmo>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <1576660591-10383-2-git-send-email-nkristam@nvidia.com>
 <20191219130503.GG1440537@ulmo>
 <fe47fd52-efd0-4f84-d1e4-4bce5571e425@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <fe47fd52-efd0-4f84-d1e4-4bce5571e425@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2019 at 04:08:30PM +0800, JC Kuo wrote:
>=20
> On 12/19/19 9:05 PM, Thierry Reding wrote:
> > On Wed, Dec 18, 2019 at 02:46:14PM +0530, Nagarjuna Kristam wrote:
> >> Add usb-role-switch property for Tegra210 and Tegra186 platforms. This
> >> entry is used by XUSB pad controller driver to register for role chang=
es
> >> for OTG/Peripheral capable USB 2 ports.
> >>
> >> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> >> ---
> >> V2:
> >>  - Moved usb-role-switch to seperate Required section as suggested by =
Thierry.
> >>  - Added reference to usb/usb-conn-gpio.txt for connector subnode.
> >> ---
> >>  .../devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt         |=
 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xus=
b-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-p=
adctl.txt
> >> index 9fb682e..23bf354 100644
> >> --- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padct=
l.txt
> >> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padct=
l.txt
> >> @@ -174,6 +174,12 @@ Required properties:
> >>    - "device": for USB device mode
> >>    - "otg": for USB OTG mode
> >> =20
> >> +Required properties for OTG/Peripheral capable USB2 ports:
> >> +- usb-role-switch: Boolean property to indicate that the port support=
 OTG or
> >=20
> > "supports", and also, why if it supports OTG *or* peripheral? Doesn't
> > OTG imply peripheral? OTG means it can be either peripheral or host,
> > right? So I think the end of that sentence can be just:
> >=20
> > 	"... the port supports OTG."
> An USB OTG port is capable of both USB host and peripheral operations. An=
 USB
> peripheral port can only act as an USB peripheral.
>=20
> The micro USB ports found on Jetson TX1/TX2 platforms are micro-AB ports =
which
> should implement both host and peripheral capabilities. We say such ports
> support OTG. The micro USB port found on Jetson Nano is a micro-B port wh=
ich
> should implement peripheral capability only. We say such ports support
> peripheral, rather than OTG.

I the port supports only peripheral mode, why do we need to have a
usb-role-switch property? Shouldn't we in that case have a mode property
with value "device"?

usb-mode-switch is only needed if mode =3D "otg", isn't it? In all other
cases the functionality is fixed (either host or peripheral) and the
mode cannot be switched.

Thierry

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4YXREACgkQ3SOs138+
s6GSDA//Yw+iQiAYCgTYvc8Y87l6JkMSfV5RQCKnFtHwPuevL/EIVxztqcP6eia0
ejTKfTSjVgF03rW7wGevtgY/g/xrn2K0IcaIYOwFqNZiOKY7lCcGjvuqOKbg+jsz
TKJJR+Y3NTyGHYHmsv9vGjqpLgIzIWNaRc6Ena5HoZZ0o0CW8TmLTynK2a6mG/OO
k7WT6fbFB6eGykl/KlnCghg5p/tgLwRFNhPI9I6eOO6w2BNvKhOqPc1isblZdQ1v
Ct4XyitxtqdCSvHtO8X3B7aNDtgn/n9ch2Gu5Ws1Y3ZK94iNFK8x29RV9Z+DoHbb
253u4npM88dzRNj2UOT9Q3RVh0E1a58RwNq3PIA9VPbzPyRo0X7eOqA5SiGGKspo
zXCiEGwBonv0dK9iBNUsceDuf5eQHHBDpujLGAyvSMFKQOTVw35i2T+29Nul6XFT
rJ35Dnp1wCzRA3FYGfYZMfDHTQJzFFhy4pPvOCU5wqv+Oi1BThLjrWcVHoQWvUCr
0lH/1ceX0A+c0bRMmRVZxZCCEk0xz5oafmFcp89oGwX1rQxtfh4uxeU6VrihTl3O
Yvyk9Rx5HxcZ0zyytaE5NdVlKOdQKuRS7w+ayeX6iVKN3453YLO+oWVZ0DQc/IKJ
eiN/eOfcl2ZckowJ5ITjilaL35vwRe95RYVtTS1YRgqfe1Gz+4Y=
=8Zk5
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
