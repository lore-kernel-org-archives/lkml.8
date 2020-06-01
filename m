Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED9AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD32E2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgFAOlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:41:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:39660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgFAOlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:41:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C840EAD5B;
        Mon,  1 Jun 2020 14:41:09 +0000 (UTC)
Message-ID: <c29968027d3a555de89eae7599dcfd513744076f.camel@suse.de>
Subject: Re: [PATCH v3 0/2] usb: xhci: Load Raspberry Pi 4 VL805's firmware
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Marek Vasut <marex@denx.de>, mbrugger@suse.com,
        u-boot@lists.denx.de, bmeng.cn@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl
Date:   Mon, 01 Jun 2020 16:41:05 +0200
In-Reply-To: <c32541a5-2dce-1fb2-7f3d-dfe03bcfb52c@denx.de>
References: <20200505162607.334-1-nsaenzjulienne@suse.de>
         <2a8f0190c9d418cee89451c7dc3a227b9d0b5f45.camel@suse.de>
         <bf73b73e-c251-7ac8-c245-a3b3d2be2420@denx.de>
         <9aea19124817a3d9fa004ec495ea6d1036d2dc8d.camel@suse.de>
         <c32541a5-2dce-1fb2-7f3d-dfe03bcfb52c@denx.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JyGRrdJKFpC11cXvvy6o"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JyGRrdJKFpC11cXvvy6o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-01 at 13:12 +0200, Marek Vasut wrote:
> On 6/1/20 1:09 PM, Nicolas Saenz Julienne wrote:
> > On Mon, 2020-06-01 at 12:53 +0200, Marek Vasut wrote:
> > > On 6/1/20 12:47 PM, Nicolas Saenz Julienne wrote:
> > > > On Tue, 2020-05-05 at 18:26 +0200, Nicolas Saenz Julienne wrote:
> > > > > Newer revisions of the RPi4 need their xHCI chip, VL805, firmware=
 to
> > > > > be
> > > > > loaded explicitly. Earlier versions didn't need that as they wher=
e
> > > > > using
> > > > > an EEPROM for that purpose. This series takes care of setting up =
the
> > > > > relevant infrastructure and run the firmware loading routine at t=
he
> > > > > right moment.
> > > > >=20
> > > > > Note that this builds on top of Sylwester Nawrocki's "USB host su=
pport
> > > > > for Raspberry Pi 4 board" series.
> > > > >=20
> > > > > ---
> > > >=20
> > > > Please don't forget about this series. The new 8GB RPi4 contains th=
is HW
> > > > design
> > > > change and USB will not work without it. See this discussion on the
> > > > downstream
> > > > kernel github, where other OS/bootloaders are hitting the issue:
> > > >=20
> > > > https://github.com/raspberrypi/firmware/issues/1402
> > > >=20
> > > > Otherwise, the Linux version of this is already in linux-next:
> > > >=20
> > > >=20
> >=20
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
drivers/usb/host/pci-quirks.c?h=3Dnext-20200529&id=3Dc65822fef4adc0ba40c37a=
47337376ce75f7a7bc
> > > We're already at 2020.07-rc3 , so unless this is a bugfix (does not l=
ook
> > > that way), this will have to wait for next release cycle.
> >=20
> > Of course. As long as it eventually gets in I'm happy (not implying thi=
s
> > specific series is flawless, but the overall mechanism). I'm just worri=
ed
> > this
> > gets lost.
> >=20
> > > Also, it seems
> > > there was a lengthy ongoing discussion, is that already sorted out ?
> >=20
> > Well, there was some discussion on how to incorporate the platform spec=
ific
> > callback into XCHI's code. Which this revision of the series addresses.=
 But,
> > IIRC, that's pretty much it as far as discussion is concerned.
>=20
> Oh, right, since the firmware loading hook looks like a reset hook, why
> isn't that implemented via reset controller API instead ?

That could be pretty clean, I hadn't though about it that way. Some questio=
ns:

- Being a PCIe device the XHCI controller doesn't show up in the device-tre=
e. I
  guess it could be added as a child node of pcie-brcmstb, but is that even
  acceptable?

- Same goes for xhci-pci being a consumer of the reset controller. Given th=
e
  reset scheme is board specific (the chip can be found all over the place,=
 but
  the firmware loading scheme is 100% RPi specific), to what extent we can
  introduce that as a binding?

Regards,
Nicolas


--=-JyGRrdJKFpC11cXvvy6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7VE4EACgkQlfZmHno8
x/4shAf+JnCsopYmoiA2M5wbHGfdg8yoBgkqHyYn1AuTDCzqlrv7MEGHcv+oOatj
IhN8gi9w2k7xkyEy0tHOmul3b1nniUCDHQIH0FWPuEzWn6sKfvfDSN0i5185ZrT6
VqAL/u1WVVS8xxZe1e4AsehRgXinm7Us0sthAxIdDEHgorxex0SCVUEN3TlINUY0
Tt4T/oc68JhNyH0MBMLdC936Olf19K0VHZzo7T0lEYxWC/nh7MMpfddffAyihEO+
k8W3QGby3ZuU9XeHb6pRzbMlA+7W2nCTrIynS/wse5wU/AwLJzECziL5GfE+6c8w
ZV5+Je/Gzx8Okz++IVZcx8OarrNJdg==
=LnXc
-----END PGP SIGNATURE-----

--=-JyGRrdJKFpC11cXvvy6o--

