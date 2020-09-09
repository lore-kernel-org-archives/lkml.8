Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E9BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406D02087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgIIQzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:55:24 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37209 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730477AbgIIPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:53:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E71AFDFE;
        Wed,  9 Sep 2020 11:53:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 09 Sep 2020 11:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=JCFzVNE05bPmOFgi/CGcorXge8/
        Kg5QW/7D2hsM1y1A=; b=NjEyn4t7D8jp2KObl6caTS0+DOIUK6tq3cQXDCIf+5n
        MGdSy68RCy2DTJ8jNzFy8TIzXZ/oNyyPiZvDnrCIoWacR6YcC6Ev4hqKf2bcqliM
        2RbF9f9CYCoqmC25CYVW/VtvjbUP3i07W4Ld4VuC6/QCAClKUYUayqRb4gM0ehxN
        l2h2Gh0ppzo03dSTuuec7WLfwOuutiXJEPV+/N/B7MZHgGEYqZZ3ZKEU9BZgAu54
        RUMrXguPSdKAfrhjIuGcJyvv20dCY75yxCGSRCmG2cIfDnRwpp2jISq9nArnyhmy
        E4Zh2Bqg1XwtOM4sWIxmjPj0oLwEqoXXnFH3XwHBBrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=JCFzVN
        E05bPmOFgi/CGcorXge8/Kg5QW/7D2hsM1y1A=; b=MGnPnGML9kg5M8bH4XuNNN
        eMQzMZz3nD9wI24E9h0dyO87udOhah0CGZ3GdUJyTxKHl9bhx7wcfozXZvlIWrTw
        +A8gX/DcbPRzWPF+Y7K7RE3pEkyqF8YR2/Esw7z4C6G+EOnJYFE0QFOJb+yuE5du
        6C3G/STvKs55zqB1am7YtfhBnswq4zTtg5CNeRbw7mRfvUh1/WsN2NXSpo3//Vwg
        BixPIMN9Q7vFny5jUheLdCMzqJgnibpSAvfFRhHaLnEvPNQxzOGbgDBbpyhNtWmZ
        FD9EP3GwK4JWuz8kjpDG2tyoKfNRqhmETy6cVKXPNeJDz6/O5IxiqdS+mWEW1bNw
        ==
X-ME-Sender: <xms:ZvpYX_vqYDEQg0M4Cs3Pvu860GrdXtEtaApxIqN6kVSB4jo7_A633g>
    <xme:ZvpYXweru6opq_lMfes0YalDzkPEfVGIDjQb-NqTu7ftDSWx7gZPmSZNgCzIkszjr
    BeR1oSCs0ZSFuB-9pk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepveegudetkeethfetgffgtdekkefghefhffefgeduleehgeehieeuveefgedv
    ieegnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ZvpYXyx0ZAFnJhyy-N5AJwgsNz2uys0JBTsqPgzX4DViUmySjbKKig>
    <xmx:ZvpYX-NqmF3NyQdIc7Id4MG6v09Qac4f3WzCWQ-68sY8y-rJ_XLB3g>
    <xmx:ZvpYX_84dWnUwILJWep3bY53ZVn_Nt58rBvdwvJiMJfR7c8yLQTTRA>
    <xmx:afpYX5nPLkZMOdDKZzrKpM94TFGBS0JfKW-s6UU9u3zBQ0M0s2b3dg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2BFC0328005A;
        Wed,  9 Sep 2020 11:53:09 -0400 (EDT)
Date:   Wed, 9 Sep 2020 17:53:07 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] dt-bindings: arm: sunxi: update H2+/H3 cpu clocks
Message-ID: <20200909155307.pjlebalzo3jqqhfj@gilmour.lan>
References: <20200903100708.GA466735@monster.powergraphx.local>
 <20200909120859.yosl2vgs3rj34stu@gilmour.lan>
 <20200909155446.382cf06d@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s6fflxmnaiafoupk"
Content-Disposition: inline
In-Reply-To: <20200909155446.382cf06d@monster.powergraphx.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s6fflxmnaiafoupk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2020 at 03:54:46PM +0200, Wilken Gottwalt wrote:
> On Wed, 9 Sep 2020 14:08:59 +0200
> Maxime Ripard <maxime@cerno.tech> wrote:
> > Hi!
> >=20
> > Thanks for contributing
> >=20
> > The prefix isn't right though.
> >=20
> > dt-bindings is used when you're modifying the binding itself, ie the
> > description of what the node is supposed to look like, not when you
> > actually use that node in a DT.
> >=20
> > In that case, that would be ARM: dts: sunxi:
> >=20
> > (we're on the ARM architecture, modifying dts's, for the sunxi platform)
>=20
> Ah, I see, it was my first attempt to contribute and wasn't 100% sure, ju=
st
> took the line from similar patches on the LKML. Thanks for the correction.
>=20
> > On Thu, Sep 03, 2020 at 12:07:08PM +0200, Wilken Gottwalt wrote:
> > > Change H2+/H3 clocks to 8 steps from 528 MHz up to 1200 MHz to suppor=
t a
> > > more fine-grained powersave setup. The SoCs are made for 1296 MHz, so
> > > these clocks are still in a safe range. Tested on a NanoPi Duo and
> > > OrangePi Zero.
> >=20
> > How was this tested?
>=20
> This is a longer story. It actually runs on hardware which is in producti=
on
> for about 2-3 years, some use H2+ with full voltage regulators and some a=
re
> similar to the NanoPi DUO, where the voltage regulator can only switch
> between 1.1 and 1.3 volts. It runs in two ways: A fully dynamic setup whe=
re
> the ondemand scheduler is used and the second way where it is switched to
> fixed values (based on load and temperature) using the cpufrequtils. The
> devices running a 4.14.x kernel and are tested against 4.19.x kernels.
> These devices are routers running a custom tcp/ip stack and have a high I=
/O
> load. I also prepared devices based on a custom H3 design, which ran stab=
le
> at 1.392 GHz (but had passive coolers attached). Do these explanations
> help?

To some extent, but not entirely. Depending on the governor / workload,
some OPPs might never be used at all.

> > cpufreq OPP misconfiguration on Allwinner SoCs has been known to create
> > some errors that are fairly hard to spot and be quite easy to go
> > unnoticed (like caches corruptions).
>=20
> Yeah, I noticed that in the beginning where I prepared the first kernels
> for these devices. But after switching to multiples of 48MHz and bigger
> steps these issues disappeared. I'm aware that this does not proof that
> these issues do not appear, but thougth I share the values which I
> consider stable.

The only really reliable test we've had so far is the one I pointed out,
so please run it on one board at least

> > The only reliable test we have is:
> > https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-test
> >=20
> > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
> > > ---
> > >  arch/arm/boot/dts/sun8i-h3.dtsi | 34 +++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 32 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8=
i-h3.dtsi
> > > index 4e89701df91f..5517fcc02b7d 100644
> > > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > @@ -48,23 +48,53 @@ cpu0_opp_table: opp_table0 {
> > >  		compatible =3D "operating-points-v2";
> > >  		opp-shared;
> > > =20
> > > -		opp-648000000 {
> > > -			opp-hz =3D /bits/ 64 <648000000>;
> > > +		opp-528000000 {
> > > +			opp-hz =3D /bits/ 64 <528000000>;
> > > +			opp-microvolt =3D <1020000 1020000 1300000>;
> > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > +		};
> > > +
> > > +		opp-624000000 {
> > > +			opp-hz =3D /bits/ 64 <624000000>;
> > >  			opp-microvolt =3D <1040000 1040000 1300000>;
> > >  			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > >  		};
> > > =20
> > > +		opp-720000000 {
> > > +			opp-hz =3D /bits/ 64 <720000000>;
> > > +			opp-microvolt =3D <1060000 1060000 1300000>;
> > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > +		};
> > > +
> > >  		opp-816000000 {
> > >  			opp-hz =3D /bits/ 64 <816000000>;
> > >  			opp-microvolt =3D <1100000 1100000 1300000>;
> > >  			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > >  		};
> > > =20
> > > +		opp-912000000 {
> > > +			opp-hz =3D /bits/ 64 <912000000>;
> > > +			opp-microvolt =3D <1140000 1140000 1300000>;
> > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > +		};
> > > +
> > >  		opp-1008000000 {
> > >  			opp-hz =3D /bits/ 64 <1008000000>;
> > >  			opp-microvolt =3D <1200000 1200000 1300000>;
> > >  			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > >  		};
> > > +
> > > +		opp-1104000000 {
> > > +			opp-hz =3D /bits/ 64 <1104000000>;
> > > +			opp-microvolt =3D <1240000 1240000 1300000>;
> > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > +		};
> > > +
> > > +		opp-1200000000 {
> > > +			opp-hz =3D /bits/ 64 <1200000000>;
> > > +			opp-microvolt =3D <1300000 1300000 1300000>;
> > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > +		};
> > >  	};
> >=20
> > IIRC U-Boot will start the CPU at 1008 MHz on the H3, so in the
> > situation where a board doesn't list the regulators attached to the CPU,
> > the kernel will happily use the 1104 and 1200 MHz frequencies, even
> > though it won't adjust the voltage accordingly, causing errors.
>=20
> Yeah, I know that. The u-boot running on the mentioned devices also have
> these modifications, including a higher clocked DRAM (actually running at
> 624 MHz).
>=20
> > The way we worked around that is to provide the extra OOPs in a separate
> > DTSI so that the boards with regulator support can opt-in.
>=20
> Oh, did I overlooked something? I was working on 4.14 up to 4.19 kernels
> and may be a bit to eager to post the modifications.

It's not really my point :)

My point is that since it's in the DTSI, every board using an H2/H3 will
now get to use those OPPs, even if they don't have the regulator support
and the voltage set for the highest frequency, so you can end up on
those boards with the CPU running at 1.2GHz and the voltage associated
to 1GHz

Maxime

--s6fflxmnaiafoupk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX1j6YwAKCRDj7w1vZxhR
xTRZAP9aO8Hhtg37XPej7CGIRZmLt7+BWsWhaNZfSQj5wgLKVAEA33djfyzO9dp7
JHsyv//gGTaUCVevFS4nBHVxEU6OIQc=
=DhXK
-----END PGP SIGNATURE-----

--s6fflxmnaiafoupk--
