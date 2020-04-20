Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9090AC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7EC2072B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="uBoGN2Fw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gNaP1jkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgDTMrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:47:52 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54523 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729125AbgDTMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:47:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A9497469;
        Mon, 20 Apr 2020 08:47:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 20 Apr 2020 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=4O8pI+mDeEP3GbZSfNlfRq+qy/A
        6N194naVgCStRxOk=; b=uBoGN2FwOjBwpNvmwTjyWtqbYsuLde7J2Y8XTEpI9Ta
        4McxRqkGLHrkzq8OprRf/Ulp18Ysy8p+wbaDpILB+/L/FPIrpTFOEYLSx36fBLht
        T/46gjMH1CX05uyMlUpvbIq2KLMMQqF0y3F7ffga7UlXSMoKE78ysA3xM4K0lkAV
        +Ap2O1keGtNJr0XLG1bn5v0rPZARd/+uBVW+TdeVpuNnuo+MOP87TeBHdYIFrnXa
        B3C34BkulDE8c4emdsQtfAG8IGSD78z8Ggq0IAmYCbVpl2uM61cP7s5sKpTjDa+H
        RUG9n6/jw0UBkVk9Mx6hGsgxG8fjEsv0aSBI52d7Odg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4O8pI+
        mDeEP3GbZSfNlfRq+qy/A6N194naVgCStRxOk=; b=gNaP1jkpxSv/Gv3pLb66gR
        8F0WzDNSraxCbyqsocm4jE3yav+GbMeiF8CbUXMsDlpdJR9HtBhGhGjWcCnXCIuH
        v+xPVfQbRX6FJtCE8s+50gdxUevGCEsjaKjwJ/dvxPZoz4eDjQXSIAfsp0XPOREk
        tA6O8LFRFLSa94HIC1C6wyhviTwmXlygsKBxM0IKJ6T8dlUdgmgivY1kdg1WIKGD
        vcFlCYDZlbiyfnMUrPK0RzrIOwtuhQ4H8hSIs6aWAyzMo06j1lNxL3D3KRH37ive
        foLAfumFIYfI+/ARqrbRiJToo9nr3nEgtrtxDhNu1NxolNdEp622NUAzZQrYZ91g
        ==
X-ME-Sender: <xms:7JmdXtOLCUrfWTgU8jhJ9SOwQW393IJQO-cqAEbAuvpVAYr1MF2s4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeefgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epghhithhhuhgsrdgtohhmnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnh
    hordhtvggthh
X-ME-Proxy: <xmx:7JmdXrGDpz7U_FD6dP_tJaSkUTeKJ6Joptp74Hdn_77MUWVAya58Ow>
    <xmx:7JmdXiq_faWCS2Zu5oaZHuSGVz8VI2V8sAq7Aq8m94MkbY_dMQBavQ>
    <xmx:7JmdXkoRlVm-3Y73ZLaYhepwpHC5-rL_5dKFkYlnTNQyRqTg4zbeyw>
    <xmx:7ZmdXi3N5BiZobBekln9v08DtnUuwxohc1Dqo3v709IxZc8AP95UVg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 552C63280060;
        Mon, 20 Apr 2020 08:47:40 -0400 (EDT)
Date:   Mon, 20 Apr 2020 14:47:39 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v3 0/7] Add support for Allwinner H6 DVFS
Message-ID: <20200420124739.pxmtvktlyt7ppfjb@gilmour.lan>
References: <20200419135011.18010-1-peron.clem@gmail.com>
 <20200420084547.q5xqlbnmug7l45p2@gilmour.lan>
 <20200420103927.uvzotrolz2inz6q2@core.my.home>
 <CAJiuCcdDge21pRmN8LzKv_tMqBoD9KHg96MUxDS9gp0+xbroJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kp6c2uiwchhfgvss"
Content-Disposition: inline
In-Reply-To: <CAJiuCcdDge21pRmN8LzKv_tMqBoD9KHg96MUxDS9gp0+xbroJg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kp6c2uiwchhfgvss
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 02:36:32PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> Hi Ondrej, Maxime,
>=20
> On Mon, 20 Apr 2020 at 12:39, Ond=C5=99ej Jirman <megous@megous.com> wrot=
e:
> >
> > Hi Maxime,
> >
> > On Mon, Apr 20, 2020 at 10:45:47AM +0200, Maxime Ripard wrote:
> > > Hi,
> > >
> > > On Sun, Apr 19, 2020 at 03:50:04PM +0200, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > Now that required drivers are merged we can contibute on DVFS
> > > > support for Allwinner H6.
> > > >
> > > > This serie is based on Yangtao Li serie[0] and Ond=C5=99ej Jirman w=
ork[1].
> > > >
> > > > Most of the OPP tables are taken from original vendor kernel[2].
> > > > Plus there are new CPU frequencies at 1.6GHz, 1.7GHz and 1.8GHz.
> > > >
> > > > I wrote a simple script to randomly set a frequency during
> > > > a random time[3]. This script is quite stressfull and set some high
> > > > frequency without checking temperature. This can result on behavior
> > > > that whould not occurs with the real cpufreq framework.
> > > > As Maxime point out I also tested with cpufreq-ljt-stress-test
> > > > (found here https://github.com/ssvb/cpuburn-arm).
> > > > This script doesn't trigger any issue.
> > > > I also test that that offlining CPU0 and doing DVFS on other CPUs
> > > > works. As CPU regulator is only set for CPU0.
> > > >
> > > > The GPU devfreq was drop as the regulator is still not properly
> > > > drive by panfrost driver[4].
> > > > I will re-introduce it later.
> > > >
> > > > Ond=C5=99ej Jirman has an Orange Pi 3, Jernej has a PineH64 and a T=
anix
> > > > TX6 boards and I have a Beelink GS1 board so I have enable these
> > > > boards. But CPU Devfreq is really touchy has it depends on:
> > > > board design, SoC speed_grade and environement which can affect
> > > > thermal cooling and have different behavior for different user.
> > > >
> > > > If people can test this serie and give feedback, I will try to
> > > > introduce this in LibreElec tree, so LE community can test it.
> > >
> > > Applied all of them, thanks!
> >
> > Please also apply "[PATCH v2 1/7] arm64: dts: allwinner: h6: Add
> > clock to CPU cores" from the v2 series, otherwise cpufreq will
> > not work.
> >
> > I can also send a missing patch adding the trip points, and cpu
> > as a cooling device, that I linked in my other reply to this patch
> > series afterwards, if Cl=C3=A9ment wants.
>=20
> Indeed I have sent using the following cmd : "git send-email --to=3DXXXX =
HEAD~7"
> from the previous version.
>=20
> I should had do Instead: "git send-email --to=3DXXXX next/master "
>=20
> Sorry for that :(

I haven't pushed anything yet, can you resend the proper branch?

Thanks!
Maxime

--kp6c2uiwchhfgvss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXp2Z6wAKCRDj7w1vZxhR
xXoXAP0Wa0t3EnXDf6veNECaAM7Mc/wslH1BMhCQ0Z0+C2JW4AD/VIJlxoE3NFRZ
R97rKIRBipUXmveGudSVP2ZFhDihHwY=
=+hUu
-----END PGP SIGNATURE-----

--kp6c2uiwchhfgvss--
