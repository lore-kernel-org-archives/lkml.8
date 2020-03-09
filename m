Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3969C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6CE222C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCITWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:22:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:52992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgCITWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:22:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 55DADB06A;
        Mon,  9 Mar 2020 19:22:47 +0000 (UTC)
Message-ID: <9e685fce547d808f269e59e2290331e75c66f3e4.camel@suse.de>
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
Date:   Mon, 09 Mar 2020 20:22:45 +0100
In-Reply-To: <ddcb8fd5-9e35-454c-b38d-d36e7b41ef07@i2se.com>
References: <20200303173217.3987-1-nsaenzjulienne@suse.de>
         <736f0c59-352b-03b2-f77f-bfc22171b3fb@i2se.com>
         <03fcb1e2bc7f3ff389b6dfbf3964e159a93ae835.camel@suse.de>
         <d3d40174-9c08-f42f-e088-08e23c2dc029@i2se.com>
         <f2ec22160ac86aec8d252ade7d6eb8789777cc42.camel@suse.de>
         <01ceb60e-a791-b6ca-352e-ad2e79f264e3@i2se.com>
         <ddcb8fd5-9e35-454c-b38d-d36e7b41ef07@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-tZ303xiG7cDiGT02SWOp"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tZ303xiG7cDiGT02SWOp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Mon, 2020-03-09 at 16:41 +0100, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> On 06.03.20 21:33, Stefan Wahren wrote:
> > Hi Nicolas,
> >=20
> > Am 05.03.20 um 11:44 schrieb Nicolas Saenz Julienne:
> > > Hi Stefan,
> > >=20
> > > On Tue, 2020-03-03 at 20:24 +0100, Stefan Wahren wrote:
> > > > > > > Note: I tested this on RPi3b, RPi3a+ and RPi2b.
> > > > > > as i already wrote this prevent X to start on current Raspbian =
on my
> > > > > > Raspberry Pi 3A+ (multi_v7_defconfig, no u-boot). We must be ca=
reful
> > > > > > here.
> > > > > >=20
> > > > > > I will take a look at the debug UART. Maybe there are more help=
ful
> > > > > > information.
> > > > > It seems we're seeing different things, I tested this on raspbian
> > > > > (multi_v7_defconfig) and on arm64. I'll try again from scratch
> > > > > tomorrow.
> > > > My modifications to the Raspbian image (from 13.2.2020) are little:
> > > >=20
> > > > - specify devicetree to config.txt
> > > > - change console to ttyS1 and remove "silent" in cmdline.txt
> > > > - rename all original kernel7*.img
> > > > - copy dtb and kernel7.img to boot partition
> > > > - copy kernel modules to root partition
> > > Would you mind retesting with the latest linux-next? I validated an i=
mage
> > > based
> > > on 5.6.0-rc4-next-20200305-00001-g285a7a64cd56 and a fresh raspbian
> > > download on
> > > RPi3a+ without X issues.
> > i retested with todays linux-next and the issue persists on my RPi 3A+ =
/
> > HP ZR2440w with this patch applied.
>=20
> I tested my display with a RPI 3B, 3B+ and a Zero W. All of them had the
> same issue. Btw i used this display the last years for testing the
> Raspberry Pi.
>=20
> After that i connected the RPI 3B to my TV screen and it works with the
> patch applied.

Thanks for taking the time on this. I guess all we have left is looking dee=
per
into it. I'll add it to my backlog for now.

Regards,
Nicolas


--=-tZ303xiG7cDiGT02SWOp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5ml4UACgkQlfZmHno8
x/43iAgAkAzhEC+LqzxtkdHiNML8ngJfJVRbuYYwyH9gHGl/3lrYW1ecvisK9ZwB
aJkbQkDEpPceupdXb9TsNr98lJ1Idhk4b8yZbm2FCzVFnHuIYc2NsxlkGc6fvp9a
S6BIgQYnfRyBzmMBpLofF7rDmdcd9SBtLqkLTKmJx4WROMK17jREEkOSYLF3//RO
Z1urTNh2l1hUHq5DGyJvGQX5KMPGYfxoZ1IL4FgLB54DelxscpQxxdgli2RNHKxA
9WkI0l6XlcL1b5ke6KcoU0lKbPQ3SEcLrZUukqd37JxhgIXu8ow1RK5dAtWOGZVK
oo6I7gSafUtvGrFpqlNpc9hepfltCQ==
=/qXY
-----END PGP SIGNATURE-----

--=-tZ303xiG7cDiGT02SWOp--

