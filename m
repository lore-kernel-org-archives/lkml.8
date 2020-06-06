Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2323C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 19:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B413C20723
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 19:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgFFTFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 15:05:09 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:57602 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbgFFTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 15:05:09 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DAC641C0BD2; Sat,  6 Jun 2020 21:05:07 +0200 (CEST)
Date:   Sat, 6 Jun 2020 21:05:07 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc:     Pavel Machek <pavel@denx.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] sr: dwc2/gadget: remove unneccessary if
Message-ID: <20200606190507.GA13421@amd>
References: <20200606153703.GA18931@amd>
 <4057a9d1-2cf4-78a1-9f29-587a87b523b4@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <4057a9d1-2cf4-78a1-9f29-587a87b523b4@synopsys.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > We don't really need if/else to set variable to 1/0.
> >=20
> > Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
> >=20
> > diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> > index 12b98b466287..f9f6fd470c81 100644
> > --- a/drivers/usb/dwc2/gadget.c
> > +++ b/drivers/usb/dwc2/gadget.c
> > @@ -1761,10 +1761,7 @@ static int dwc2_hsotg_process_req_feature(struct=
 dwc2_hsotg *hsotg,
> >   	case USB_RECIP_DEVICE:
> >   		switch (wValue) {
> >   		case USB_DEVICE_REMOTE_WAKEUP:
> > -			if (set)
> > -				hsotg->remote_wakeup_allowed =3D 1;
> > -			else
> > -				hsotg->remote_wakeup_allowed =3D 0;
> > +			hsotg->remote_wakeup_allowed =3D set;
> >   			break;
> >  =20
> >   		case USB_DEVICE_TEST_MODE:
> >=20
>=20
> It's good catch, but 'set' declared as 'bool' while=20
> 'remote_wakeup_allowed' is 'unsigned int'. Maybe update 'set' type to sam=
e.

I know set is bool. But that should not matter, code is okay and
compiler will do the right thing:

pavel@amd:/tmp$ cat delme.c
#include <stdbool.h>

void main(void)
{
  bool a =3D false;
    int b =3D a;
 }
 pavel@amd:/tmp$ gcc -std=3Dc99 -Wall delme.c
    delme.c:3:6: warning: return type of =E2=80=98main=E2=80=99 is not =E2=
=80=98int=E2=80=99 [-Wmain]
     void main(void)
           ^
	   delme.c: In function =E2=80=98main=E2=80=99:
 delme.c:6:7: warning: unused variable =E2=80=98b=E2=80=99
 [-Wunused-variable]
	      int b =3D a;
	             ^

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7b6OMACgkQMOfwapXb+vIAkgCbBl+YDyjbiVKGd/FPzUAZ9GGS
k38An3L6MIqY6jEslnK2cA8CtA9ye3uS
=0uPk
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
