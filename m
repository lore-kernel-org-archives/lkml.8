Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58074C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C26B2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCEKoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:44:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:45842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgCEKo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:44:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BEF25B239;
        Thu,  5 Mar 2020 10:44:26 +0000 (UTC)
Message-ID: <f2ec22160ac86aec8d252ade7d6eb8789777cc42.camel@suse.de>
Subject: Re: [PATCH] ARM: dts: bcm283x: Use firmware PM driver for V3D
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wahrenst@gmx.net
Date:   Thu, 05 Mar 2020 11:44:23 +0100
In-Reply-To: <d3d40174-9c08-f42f-e088-08e23c2dc029@i2se.com>
References: <20200303173217.3987-1-nsaenzjulienne@suse.de>
         <736f0c59-352b-03b2-f77f-bfc22171b3fb@i2se.com>
         <03fcb1e2bc7f3ff389b6dfbf3964e159a93ae835.camel@suse.de>
         <d3d40174-9c08-f42f-e088-08e23c2dc029@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1e/ycMxHHlpwCahVXF7n"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1e/ycMxHHlpwCahVXF7n
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Tue, 2020-03-03 at 20:24 +0100, Stefan Wahren wrote:
> > > > Note: I tested this on RPi3b, RPi3a+ and RPi2b.
> > > as i already wrote this prevent X to start on current Raspbian on my
> > > Raspberry Pi 3A+ (multi_v7_defconfig, no u-boot). We must be careful =
here.
> > >=20
> > > I will take a look at the debug UART. Maybe there are more helpful
> > > information.
> > It seems we're seeing different things, I tested this on raspbian
> > (multi_v7_defconfig) and on arm64. I'll try again from scratch tomorrow=
.
>=20
> My modifications to the Raspbian image (from 13.2.2020) are little:
>=20
> - specify devicetree to config.txt
> - change console to ttyS1 and remove "silent" in cmdline.txt
> - rename all original kernel7*.img
> - copy dtb and kernel7.img to boot partition
> - copy kernel modules to root partition

Would you mind retesting with the latest linux-next? I validated an image b=
ased
on 5.6.0-rc4-next-20200305-00001-g285a7a64cd56 and a fresh raspbian downloa=
d on
RPi3a+ without X issues.

> The debug UART works fine, maybe the dmesg gives us a hint:

[...]

> [    8.451520] vc4_hdmi 3f902000.hdmi: vc4-hdmi-hifi <-> 3f902000.hdmi
> mapping ok
> [    8.451541] vc4_hdmi 3f902000.hdmi: ASoC: no DMI vendor name!
> [    8.465617] vc4-drm soc:gpu: bound 3f902000.hdmi (ops vc4_hdmi_ops
> [vc4])
> [    8.466033] vc4-drm soc:gpu: bound 3f806000.vec (ops vc4_vec_ops [vc4]=
)
> [    8.466159] vc4-drm soc:gpu: bound 3f004000.txp (ops vc4_txp_ops [vc4]=
)
> [    8.466292] vc4-drm soc:gpu: bound 3f400000.hvs (ops vc4_hvs_ops [vc4]=
)
> [    8.466649] vc4-drm soc:gpu: bound 3f206000.pixelvalve (ops
> vc4_crtc_ops [vc4])
> [    8.466889] vc4-drm soc:gpu: bound 3f207000.pixelvalve (ops
> vc4_crtc_ops [vc4])
> [    8.467154] vc4-drm soc:gpu: bound 3f807000.pixelvalve (ops
> vc4_crtc_ops [vc4])
> [    8.467262] vc4-drm soc:gpu: bound 3fc00000.v3d (ops vc4_v3d_ops [vc4]=
)
> [    8.467272] checking generic (1e330000 8ca000) vs hw (0 ffffffff)
> [    8.467278] fb0: switching to vc4drmfb from simple
> [    8.473639] Console: switching to colour dummy device 80x30
> [    8.473714] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013)=
.
> [    8.473718] [drm] Driver supports precise vblank timestamp query.
> [    8.476777] [drm] Initialized vc4 0.0.0 20140616 for soc:gpu on minor =
0
> [    8.534359] Console: switching to colour frame buffer device 90x30
> [    8.550245] vc4-drm soc:gpu: fb0: vc4drmfb frame buffer device

I get the exact same results as you here.

Regards,
Nicolas


--=-1e/ycMxHHlpwCahVXF7n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5g2AcACgkQlfZmHno8
x/4IlQgApYGk9IyBIGZXZU7cjQ4U0IGcYwkZZIy8r4vLrNLOKHCg8uEZpLk8Kvim
wux9hWhjqbuYV1Q7/MEgioV+IUv4mkKOZxZodXy8/cf8Zq8mPV3FgY6hX2IlVXdt
CkSlN4cth5Kq35oQm+W6NNWAdOQTabix30MRbfZ4sL8JAoL12DBdt1DQpMkEN2az
zsxwZDV5LBe655F75XcBBCnWnrSQWeAZySsBtwsJidSqfepsdiVSAlYonoD+4tiW
a05qYn+C51jrnxQqMtkfuFxfz8q5Kjd+zS8Mb9lhAqtS7mVPM1XMlJd401+fYdq4
RMUXbtQ0juTl/b7yJowqjUiacvGwWg==
=Rxs/
-----END PGP SIGNATURE-----

--=-1e/ycMxHHlpwCahVXF7n--

