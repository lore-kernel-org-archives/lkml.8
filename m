Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D602C2BA1B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4487420719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Vz1oyh07";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mvDi/utu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgDGIrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:47:16 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:57085 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbgDGIrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:47:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 138776A3;
        Tue,  7 Apr 2020 04:47:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 07 Apr 2020 04:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=+r7E2sih1Sc6rl7ZjA85HKrYKcR
        XrhWjnKqfOs7riwI=; b=Vz1oyh07UZtEO+4lHO3DJsBcHYWppi1bS81AH5lk/ua
        8Ic2cC2Q/9qsKRqR/syrfuIiceNm3xQ4KKdgqGAhRezBcZEochNuMg5fiM7Chqry
        i72mA577HHjeVsHAWiHFMbGAyWhM53CLMaXn4tSV6sUmekDIN2sHXBSf0byahgjl
        3fuAjkWzE1vwnqBK1PafX1NTIIDXRhi9TncxNGx3Y6kBE/QBJdh73ahKNCEUo8zT
        VumRGaR8glFBa0GLp5zlOj5zutqxozYlxi0/17dubsg2vGlEXpkm/S1dAe9YSN3r
        GL11wCsmRaKZhU11Hoo6dNiLbqfJQoiCcpnNLtkw9bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=+r7E2s
        ih1Sc6rl7ZjA85HKrYKcRXrhWjnKqfOs7riwI=; b=mvDi/utuYv3ZST7eZ8B1rB
        JHiaD2qHJMyx5RJ6EE6RpVJ30s6uKoE5zD2hyY2EVBy5BEck9DGl0yqp+pBxsb35
        sGsiF+ckaQf8i+iBj2D9TLZFlkzAghq3uhn94ni+BtKkdpbnJ4CRdEV2EW3TEAt7
        h1Y0p76Wa/nqBMSyhMM0yfBPHkLCr7D3g0ggWww+l/HnPBSOzsr7IA+DahdM97a7
        15Pq4Q4R89xNwpG3LE+Ng51ShndZozWa6N1Pb4NIZpDkSrND/jvU1uM39Bya1Fps
        Hdm/BECnpFrqPJcwUoOXG+dQggR1zNU0x7DlwWS5/SLvWGyyvNz8fXMUwH7uN/GQ
        ==
X-ME-Sender: <xms:ET6MXnq-9dP9HLR4P9u9gz4S19WyNfcDtqnrpxwbzjrrQvbsqW7mEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ET6MXnwuMLxrUSVul9xC_9hMzk8BGtb4EpMrb2RDgqALG_OZ0n9n6A>
    <xmx:ET6MXpVnYtllvCwYgZCn1OlJXCGTiJdwNLdiM8_NMaR1PEN6On0Buw>
    <xmx:ET6MXhKu6fIj6bIFpTiHT2Oi-4pku10GhCi6ZsFhhUsMFuCDKPQHZw>
    <xmx:Ej6MXrtnqvTgUIRR7UWOMs2rrsExaEGVK-qknW3UcK06e-TKvsccuw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 775FD328005E;
        Tue,  7 Apr 2020 04:47:13 -0400 (EDT)
Date:   Tue, 7 Apr 2020 10:47:12 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH v2 3/7] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
Message-ID: <20200407084712.lhvrotihtxr5rqxa@gilmour.lan>
References: <20200405173601.24331-1-peron.clem@gmail.com>
 <20200405173601.24331-4-peron.clem@gmail.com>
 <20200406081412.ubdogkjknlofynei@gilmour.lan>
 <CAJiuCcdTQHGhZ=7Z_Du-zcZ_OWdGO1iEpYOBD4z=eNDYzMA5tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="obs3nniolwwu6iqt"
Content-Disposition: inline
In-Reply-To: <CAJiuCcdTQHGhZ=7Z_Du-zcZ_OWdGO1iEpYOBD4z=eNDYzMA5tg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--obs3nniolwwu6iqt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2020 at 08:03:34PM +0200, Cl=E9ment P=E9ron wrote:
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > @@ -253,6 +253,10 @@
> > >                       #address-cells =3D <1>;
> > >                       #size-cells =3D <1>;
> > >
> > > +                     speedbin_efuse: speed@1c {
> > > +                             reg =3D <0x1c 0x4>;
> > > +                     };
> > > +
> >
> > You should order this by address, so after the THS calibration. Also,
> > using a less generic node name than "speed" would be great. What about
> > soc-bin ?
>
> Indeed it's too generic.
> I will keep coherency with i.MX8 and use "cpu_speed_grade"

It works for me, but remember that you can't use underscores :)

Maxime

--obs3nniolwwu6iqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXow+EAAKCRDj7w1vZxhR
xYhmAP9HFTxiuLkTGD9dyTe3MbP31mksKDRSBxrC27AhkLIqyAEAoQzGYqLtOzOR
1r04CfnUwInSdC9XI1/sFFXlhvD7+AU=
=oCF1
-----END PGP SIGNATURE-----

--obs3nniolwwu6iqt--
