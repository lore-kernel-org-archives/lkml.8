Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558E8C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D6920781
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgDFJNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:13:22 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55548 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgDFJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:13:21 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 575E91C4527; Mon,  6 Apr 2020 11:13:19 +0200 (CEST)
Date:   Mon, 6 Apr 2020 11:13:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        jacek.anaszewski@gmail.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64: dts: rockchip: rk3399-roc-pc: Fix MMC
 numbering for LED triggers
Message-ID: <20200406091313.GF31120@duo.ucw.cz>
References: <20200327030414.5903-2-wens@kernel.org>
 <684a08e6-7dfe-4cb1-2ae5-c1fb4128976b@gmail.com>
 <CAGb2v65ayZwN14S-Pzu2ip1K=fgzTbNB=ZzUcpou-jtv8m6vBA@mail.gmail.com>
 <ccf35a92-7005-9c6d-a8a2-c17b714a60bc@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Content-Disposition: inline
In-Reply-To: <ccf35a92-7005-9c6d-a8a2-c17b714a60bc@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml: leds:
> > > diy-led:linux,default-trigger:0: 'mmc2' is not one of ['backlight',
> > > 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pat=
tern']
> > > arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml: leds:
> > > yellow-led:linux,default-trigger:0: 'mmc1' is not one of ['backlight',
> > > 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pat=
tern']
> >=20
> > Maybe we should just get rid of linux,default-trigger then?
>=20
> In this particular case, I'd say it's probably time to reevaluate the rat=
her
> out-of-date binding. The apparent intent of the "linux,default-trigger"
> property seems to be to describe any trigger supported by Linux, so either
> the binding wants to be kept in sync with all the triggers Linux actually
> supports, or perhaps it should just be redefined as a free-form

It is enough to keep it in sync with all the triggers we actually use :-).

> I'd be slightly inclined towards the latter, since the schema validator
> can't know whether the given trigger actually corresponds to the correct
> thing for whatever the LED is physically labelled on the board/case, nor
> whether the version(s) of Linux that people intend to use actually support
> that trigger (since it doesn't have to be the version contemporary with t=
he
> schema definition), so strict validation of this particular property seems
> to be of limited value.

But freeform seems acceptable, too.

> > > > -             diy-led {
> > > > +             diy_led: diy-led {
> > > >                        label =3D "red:diy";
> > > >                        gpios =3D <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> > > >                        default-state =3D "off";
> > > >                        linux,default-trigger =3D "mmc1";
> > > >                };

This label probably should be "mmc1:red:activity" or something like that.

> > > > -             yellow-led {
> > > > +             yellow_led: yellow-led {
> > > >                        label =3D "yellow:yellow-led";
> > > >                        gpios =3D <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
> > > >                        default-state =3D "off";

And this label should be changed, too.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXoryqQAKCRAw5/Bqldv6
8ulxAJ9JvBVEpW4qxrGrRgIxyoWrDXPWaACglhyoV7FLpZSAdi34M9to1ysGuB4=
=FV4E
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--
