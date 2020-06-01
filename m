Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E992C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC4EC20657
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgFALJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:09:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:48246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFALJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:09:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CA4F2AAC7;
        Mon,  1 Jun 2020 11:09:40 +0000 (UTC)
Message-ID: <9aea19124817a3d9fa004ec495ea6d1036d2dc8d.camel@suse.de>
Subject: Re: [PATCH v3 0/2] usb: xhci: Load Raspberry Pi 4 VL805's firmware
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Marek Vasut <marex@denx.de>, mbrugger@suse.com,
        u-boot@lists.denx.de, bmeng.cn@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl
Date:   Mon, 01 Jun 2020 13:09:37 +0200
In-Reply-To: <bf73b73e-c251-7ac8-c245-a3b3d2be2420@denx.de>
References: <20200505162607.334-1-nsaenzjulienne@suse.de>
         <2a8f0190c9d418cee89451c7dc3a227b9d0b5f45.camel@suse.de>
         <bf73b73e-c251-7ac8-c245-a3b3d2be2420@denx.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Nn5vb/UM3fX7gE/kCMj2"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Nn5vb/UM3fX7gE/kCMj2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-01 at 12:53 +0200, Marek Vasut wrote:
> On 6/1/20 12:47 PM, Nicolas Saenz Julienne wrote:
> > On Tue, 2020-05-05 at 18:26 +0200, Nicolas Saenz Julienne wrote:
> > > Newer revisions of the RPi4 need their xHCI chip, VL805, firmware to =
be
> > > loaded explicitly. Earlier versions didn't need that as they where us=
ing
> > > an EEPROM for that purpose. This series takes care of setting up the
> > > relevant infrastructure and run the firmware loading routine at the
> > > right moment.
> > >=20
> > > Note that this builds on top of Sylwester Nawrocki's "USB host suppor=
t
> > > for Raspberry Pi 4 board" series.
> > >=20
> > > ---
> >=20
> > Please don't forget about this series. The new 8GB RPi4 contains this H=
W
> > design
> > change and USB will not work without it. See this discussion on the
> > downstream
> > kernel github, where other OS/bootloaders are hitting the issue:
> >=20
> > https://github.com/raspberrypi/firmware/issues/1402
> >=20
> > Otherwise, the Linux version of this is already in linux-next:
> >=20
> >=20
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
drivers/usb/host/pci-quirks.c?h=3Dnext-20200529&id=3Dc65822fef4adc0ba40c37a=
47337376ce75f7a7bc
>=20
> We're already at 2020.07-rc3 , so unless this is a bugfix (does not look
> that way), this will have to wait for next release cycle.

Of course. As long as it eventually gets in I'm happy (not implying this
specific series is flawless, but the overall mechanism). I'm just worried t=
his
gets lost.

> Also, it seems
> there was a lengthy ongoing discussion, is that already sorted out ?

Well, there was some discussion on how to incorporate the platform specific
callback into XCHI's code. Which this revision of the series addresses. But=
,
IIRC, that's pretty much it as far as discussion is concerned.

Regards,
Nicolas


--=-Nn5vb/UM3fX7gE/kCMj2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7U4fEACgkQlfZmHno8
x/5GMgf+I/o1/RHDqKU7lDAoEnd3xBVgyQAL8OOTe/VP7gd2qFz6+X2+n4AZEaJc
F5AAIPX8EQI8xqhrNvVeuHo+BG81++PENDKtd4QUtUmqjSIByY2D4MlCQSAQ//9k
5RES2GIIjUFED2qEK2RviVXfJE27Zhx0FUzxw+eb0OScHcoihZYcENVKkgLnsc3e
X9zMyBv7ptEqoL3WOHbHSVtOQbDqYrxLfHDWR+wIBwOMKabzrhy7TFJhuO1Ity9F
3EO/+b3fXW49obCBXdDVOxRgsMfW685s1s5kOBCC2scd3osoNNSH/damYDkxOhhb
PZ+SqvTGfeKO9vG813uu4Pt8iajKcg==
=MLl3
-----END PGP SIGNATURE-----

--=-Nn5vb/UM3fX7gE/kCMj2--

