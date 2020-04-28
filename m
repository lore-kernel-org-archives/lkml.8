Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9AFC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD4B2063A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="o/zLeawy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="plxc6RQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgD1Qp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:45:29 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46579 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728022AbgD1Qp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:45:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A942B5C00ED;
        Tue, 28 Apr 2020 12:45:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 28 Apr 2020 12:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=S+DukyifHC2vsrH7Z+Bw4PDmgSK
        o2q4QVE9pfyHeloc=; b=o/zLeawy0XQRg1eQ7+597/fdWE/olg18atu9Wo9OpAV
        qzO2RXEsn8o6ljpJCmcHtU3aSPv8TGrdRsl3C/di7b6qEVeuxn++mSeRZJUIp8Q0
        VuIaPoYH/IqD7GHhKdZWddRa4sVZR4nlrzdkOlVmTxn0n264NaAyWmqKlWUEKxCn
        yh/sgs4yR53G17xdi+bSLGHGBtSeqL1knY4u70hTGH1JP4nL6yv6GM2qogkN1O8c
        J3245jYrz9gp0GTvqjJkuTDsSgCXECue0dmOsZKFgPbXAMKTFbDlP2Tcpm76UWZj
        gxaONyZPXsd6+I5GDkWhO84dpc9daW0yT8vfxKAVilA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=S+Duky
        ifHC2vsrH7Z+Bw4PDmgSKo2q4QVE9pfyHeloc=; b=plxc6RQUfAVXjjOqju4TEk
        p87bIvcNyBu/Oy2aIbCzsLzgKQbl1Joq1ZXevIR3YiEbg51CvULI62q8NcFHbpK9
        jaMKj9+Jjmd4LGLLje5rNhbeTT/xEfGyW9CG/wa/V7N4YSRgqEFn8OGkJmypQ9N6
        0aeYbI5LaGFw8Efc/psgzzWILoJ77Gt/ITRR7VBh/m2AC4FfcSRMjWwW70Qgry8n
        9rQZhr8htYwKizqSiDtXu66fCRB9F+yGtpVqEhEcEZC0bPCZEcj2iCMb0QEG1PpI
        trihGpHK0Ozvl7BDXAdP1Gm0lHDbM3k12EoCOtWaaVK3Qmmd8TBTj+vQ+rJB0C3Q
        ==
X-ME-Sender: <xms:pF2oXpnWDItsLSB1PqG7oa1lq9AlwFoCa-vwz5IQl3xjBQNi-BJvJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedriedugddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:pF2oXidgBl28_W9q_r39J5Gz9hOsjAmhKRbR8RsLmONfdxOOMUALdA>
    <xmx:pF2oXlPAhCNv08hbAdBrrxQieLsf0xwGIamgkJrrSdDdK8Wr0MNu6w>
    <xmx:pF2oXtOIsWGSMIntahD8XJCDI99GsCuImlHHCdMry537_ogbB-v5HA>
    <xmx:p12oXmy8Q_Vesgwl9mt6FFYzJ-tX4A6A5Ifj1l4w4eR3eW18vRMs1Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 125803280059;
        Tue, 28 Apr 2020 12:45:23 -0400 (EDT)
Date:   Tue, 28 Apr 2020 18:45:22 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Piotr Oniszczuk <warpme@o2.pl>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [linux-sunxi] Re: [PATCH v2] arm64: dts: allwinner: h6: Use
 dummy regulator for Tanix TX6
Message-ID: <20200428164522.p7ypca7zwocc7alq@gilmour.lan>
References: <20200428142629.8950-1-peron.clem@gmail.com>
 <98246e5d-ebef-bcb5-f0b8-d74b3834b835@arm.com>
 <CAJiuCcco0d_UoWeHqh6oc0rFNAMFynXjLRQ6APsT0WBh7m+GQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cbn7zzdgl2fsor3b"
Content-Disposition: inline
In-Reply-To: <CAJiuCcco0d_UoWeHqh6oc0rFNAMFynXjLRQ6APsT0WBh7m+GQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cbn7zzdgl2fsor3b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 06:23:35PM +0200, Cl=E9ment P=E9ron wrote:
> Hi Robin,
>=20
> On Tue, 28 Apr 2020 at 17:21, Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2020-04-28 3:26 pm, Cl=E9ment P=E9ron wrote:
> > > Tanix TX6 has a fixed regulator. As DVFS is instructed to change
> > > voltage to meet OPP table, the DVFS is not working as expected.
> >
> > Hmm, isn't that really a bug in the DVFS code? I guess it's just blindly
> > propagating -EINVAL from the fixed regulators not implementing
> > set_voltage, but AFAICS it has no real excuse not to be cleverer and
> > still allow switching frequency as long as the voltage *is* high enough
> > for the given OPP. I wonder how well it works if the regulator is
> > programmable but shared with other consumers... that case probably can't
> > be hacked around in DT.
>=20
> Like you, I thought that the DVFS was clever enough to understand this
> but guess not..
>=20
> Maybe they are some cases where you don't want to leave the voltage high =
and
> reduce the frequency. But I don't know such case.

I assume the intent was to prevent a regulator driver to overshoot and end =
up
over-volting the CPU which would be pretty bad.

I guess we could check that the voltage is in the range opp < actual voltag=
e <
max opp voltage ?

Maxime

--cbn7zzdgl2fsor3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqhdogAKCRDj7w1vZxhR
xf6IAP9w+DY1O6bT4B3lg/+eirUFYM1skafnWKyx1f2y49KdYQEA2gJSF//W+64e
k+em/HwQHNH7fcP/zuv+U6G30n1Ocgs=
=CEt2
-----END PGP SIGNATURE-----

--cbn7zzdgl2fsor3b--
