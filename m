Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C8EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C4320663
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgFDLSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 07:18:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:33388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgFDLSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 07:18:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EF205ABF4;
        Thu,  4 Jun 2020 11:18:42 +0000 (UTC)
Message-ID: <d1f54bfccb7aa91949ddb2c1643308a52ab0c161.camel@suse.de>
Subject: Re: [PATCH v3 0/2] usb: xhci: Load Raspberry Pi 4 VL805's firmware
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Marek Vasut <marex@denx.de>, mbrugger@suse.com,
        u-boot@lists.denx.de, bmeng.cn@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl
Date:   Thu, 04 Jun 2020 13:18:37 +0200
In-Reply-To: <ec76c8bb-63c1-8ccc-c1d5-5878bc01343b@denx.de>
References: <20200505162607.334-1-nsaenzjulienne@suse.de>
         <2a8f0190c9d418cee89451c7dc3a227b9d0b5f45.camel@suse.de>
         <bf73b73e-c251-7ac8-c245-a3b3d2be2420@denx.de>
         <9aea19124817a3d9fa004ec495ea6d1036d2dc8d.camel@suse.de>
         <c32541a5-2dce-1fb2-7f3d-dfe03bcfb52c@denx.de>
         <c29968027d3a555de89eae7599dcfd513744076f.camel@suse.de>
         <ec76c8bb-63c1-8ccc-c1d5-5878bc01343b@denx.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rz87Kq66AL3pHD2lR4/F"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rz87Kq66AL3pHD2lR4/F
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-01 at 17:27 +0200, Marek Vasut wrote:
> On 6/1/20 4:41 PM, Nicolas Saenz Julienne wrote:
> > On Mon, 2020-06-01 at 13:12 +0200, Marek Vasut wrote:
> > > On 6/1/20 1:09 PM, Nicolas Saenz Julienne wrote:
> > > > On Mon, 2020-06-01 at 12:53 +0200, Marek Vasut wrote:
> > > > > On 6/1/20 12:47 PM, Nicolas Saenz Julienne wrote:
> > > > > > On Tue, 2020-05-05 at 18:26 +0200, Nicolas Saenz Julienne wrote=
:
> > > > > > > Newer revisions of the RPi4 need their xHCI chip, VL805, firm=
ware
> > > > > > > to
> > > > > > > be
> > > > > > > loaded explicitly. Earlier versions didn't need that as they =
where
> > > > > > > using
> > > > > > > an EEPROM for that purpose. This series takes care of setting=
 up
> > > > > > > the
> > > > > > > relevant infrastructure and run the firmware loading routine =
at
> > > > > > > the
> > > > > > > right moment.
> > > > > > >=20
> > > > > > > Note that this builds on top of Sylwester Nawrocki's "USB hos=
t
> > > > > > > support
> > > > > > > for Raspberry Pi 4 board" series.
> > > > > > >=20
> > > > > > > ---
> > > > > >=20
> > > > > > Please don't forget about this series. The new 8GB RPi4 contain=
s
> > > > > > this HW
> > > > > > design
> > > > > > change and USB will not work without it. See this discussion on=
 the
> > > > > > downstream
> > > > > > kernel github, where other OS/bootloaders are hitting the issue=
:
> > > > > >=20
> > > > > > https://github.com/raspberrypi/firmware/issues/1402
> > > > > >=20
> > > > > > Otherwise, the Linux version of this is already in linux-next:
> > > > > >=20
> > > > > >=20
> >=20
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
drivers/usb/host/pci-quirks.c?h=3Dnext-20200529&id=3Dc65822fef4adc0ba40c37a=
47337376ce75f7a7bc
> > > > > We're already at 2020.07-rc3 , so unless this is a bugfix (does n=
ot
> > > > > look
> > > > > that way), this will have to wait for next release cycle.
> > > >=20
> > > > Of course. As long as it eventually gets in I'm happy (not implying=
 this
> > > > specific series is flawless, but the overall mechanism). I'm just
> > > > worried
> > > > this
> > > > gets lost.
> > > >=20
> > > > > Also, it seems
> > > > > there was a lengthy ongoing discussion, is that already sorted ou=
t ?
> > > >=20
> > > > Well, there was some discussion on how to incorporate the platform
> > > > specific
> > > > callback into XCHI's code. Which this revision of the series addres=
ses.
> > > > But,
> > > > IIRC, that's pretty much it as far as discussion is concerned.
> > >=20
> > > Oh, right, since the firmware loading hook looks like a reset hook, w=
hy
> > > isn't that implemented via reset controller API instead ?
> >=20
> > That could be pretty clean, I hadn't though about it that way. Some
> > questions:
> >=20
> > - Being a PCIe device the XHCI controller doesn't show up in the device=
-
> > tree. I
> >   guess it could be added as a child node of pcie-brcmstb, but is that =
even
> >   acceptable?
>=20
> Yes, there are other such DTs .
>=20
> > - Same goes for xhci-pci being a consumer of the reset controller. Give=
n the
> >   reset scheme is board specific (the chip can be found all over the pl=
ace,
> > but
> >   the firmware loading scheme is 100% RPi specific), to what extent we =
can
> >   introduce that as a binding?
>=20
> I'm not sure what you're asking me here, you'll just have some reset
> controller in a DT and a phandle from the xhci-controller to this reset
> controller.

Sorry I wasn't clear, overall my concern here is that xhic-pci maintainers,
both in u-boot y linux (as I'd like to have the same solution on both sides=
,
since it involves changes in dt), might see it as too platform specific to =
add
it into an otherwise generic xhci-pci implmentation.

But nevermind, I'll just post the series and see what happens :).

Regards,
Nicolas


--=-rz87Kq66AL3pHD2lR4/F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7Y2I0ACgkQlfZmHno8
x/7tiQgAlYpWM4m3PSWPJdp1KwO3Por2fHNbKzjlqimLUrsgr79OFqZsK57qZowc
Oszt7W/gV0NlVanYKaL7pIphgJq25H0f95TEM+hfQpNCRdAmBmIbF346dGD0rx/Q
t+OcjafuC2I8V0TFYlqk+xCIrmwsDQ/Ee+s3PL+TpVkbN8XGhhPHMLMjHBCpF/0u
y4Na9QSwpoK2bRnITH7j7YaUZi1bsOaCN/xv05JT+0oIK339J5CruNK4Na7LWQ1f
L4nqwH02nF3z+SxCFonC0rVLvLamQI93qzwMUwlBGIAbvmoYFRw+jmz2Fz9ylR52
r+3YjBCTLDB/FZFzdl1uiJ12ziRNgQ==
=/X9Y
-----END PGP SIGNATURE-----

--=-rz87Kq66AL3pHD2lR4/F--

