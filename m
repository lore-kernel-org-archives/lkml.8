Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFFDC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CAE206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="HysOTXkW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wGcySNYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408643AbgDOKaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:30:52 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38675 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408615AbgDOK2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:28:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 01926896;
        Wed, 15 Apr 2020 06:28:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 15 Apr 2020 06:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=RoUMH5uplHJzYnyqDXTZLy21XNl
        /ku4HaCRXVlORw0M=; b=HysOTXkWgZt8klXzuHbITMV6pPNvsM3fbLVH+dZNxuo
        P02L58NPlrhVbP/aodTlSufTMf4U12br9zammRkmrFT0KIJXRA4VKesfQl5qKg0y
        me7hvY/yRTHge4za2aWQSU4VT3R1bZBL7wLwATk/K+kGCATENISVZmQ1b6BI8EiR
        656hT075HCC6WP/SNOIPjwbbPQbnKqKPo+ka4xZNyT9RA3ucTwjsforP9e0aV9qF
        6OgKgMq/U0elSDcrvUThoyYovfyPggbL03z5Z0zMFNN/v9G59H96bm22kMMc/N/a
        /0tA8+fFGcLacD7Xlo91KaGpF8euv0BqcVOD7Q76UAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RoUMH5
        uplHJzYnyqDXTZLy21XNl/ku4HaCRXVlORw0M=; b=wGcySNYHWD23Ogd4P+7Wqw
        ZL2FM8pu5ihO9+vIcaW4vKpIyJOjDnWY06NI0TKgMOexeXT0/XBjCq30YIiFZCb0
        5WOk99ppUtI4Gs6nM38GwckmtFBcUXIHrvSt7MO0wLWOJ0TogKql+TlXWt0eeTNF
        JU3km9EmE2zcNM9Dk90jUv1mtcBnIUxofckup125Szf8ijLTI1mNzeCfWDiweyP5
        QGsz+irvZpDcRlu0QG+F+Us/WpLZul5ilJxj7e/B7pcCQlCGOv8RGZ2jS2DbjY5z
        HYCGFoTOj2PLvZUAbXpOh49RCBV7mZdJTnTgZ+fSkdUg4j8tCFMk8xY1nWPM+hfw
        ==
X-ME-Sender: <xms:x-GWXqwZmpuUFCMkuvUlpab-GVJ1uYjfCiFZputQ7CPELfeHRbDwZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrfeefgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epghhithhhuhgsrdgtohhmnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnh
    hordhtvggthh
X-ME-Proxy: <xmx:x-GWXh-v4_ktdhiqILsyNkYz8Cseb7nwQR9b5LnAqkIgToZSBcp0hQ>
    <xmx:x-GWXoxrUHggCrh4H-FChfczyTyR-IrpebLyWBG79c_VIl_g1IT12g>
    <xmx:x-GWXppqC2TA_QOoZTo-mT68PoXBxCWngX58qZBXk0O2Gy1WutcDjw>
    <xmx:x-GWXsBL4SCr4q_SQ0X3-HmNBoramB9RqFwhcsatm_ceUg-2LZeskA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D9AA8328005A;
        Wed, 15 Apr 2020 06:28:22 -0400 (EDT)
Date:   Wed, 15 Apr 2020 12:28:21 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v2 0/7] Add support for Allwinner H6 DVFS
Message-ID: <20200415102821.t4vm5y7zggxc3ezm@gilmour.lan>
References: <20200405173601.24331-1-peron.clem@gmail.com>
 <20200406081007.k6wlaampgbe46yts@gilmour.lan>
 <CAJiuCccPxnW-YMjENr5-_XMMu_gs5pRnCtYvpXQtHTAVj1QQqw@mail.gmail.com>
 <CAJiuCcdqv=mGmUvZ8=35P7fC=sePCpXFWw0_K7rEH+qPQT7W+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cfxk5euq6ylkqauh"
Content-Disposition: inline
In-Reply-To: <CAJiuCcdqv=mGmUvZ8=35P7fC=sePCpXFWw0_K7rEH+qPQT7W+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cfxk5euq6ylkqauh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Clement,

On Mon, Apr 13, 2020 at 03:37:19PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> On Mon, 6 Apr 2020 at 11:07, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.co=
m> wrote:
> > On Mon, 6 Apr 2020 at 10:10, Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > Hi,
> > >
> > > On Sun, Apr 05, 2020 at 07:35:54PM +0200, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > Now that required drivers are merged we can contibute on DVFS
> > > > support for Allwinner H6.
> > > >
> > > > This serie is based on Yangtao Li serie[0] and Ond=C5=99ej Jirman w=
ork[1].
> > > >
> > > > Most of the OPP tables are taken from original vendor kernel[2].
> > > > Plus there is a new CPU frequencies at 1.6GHz, 1.7GHz and 1.8GHz.
> > > >
> > > > I wrote a simple script to randomly set a frequency during
> > > > a random time[3].
> > >
> > > If you ever need to do that ever again, cpufreq-ljt-stress-test (found
> > > here https://github.com/ssvb/cpuburn-arm) has proven to be very
> > > reliable to detect cpufreq related issues. stress-ng might not be
> > > enough since the (at least older) Allwinner SoCs tend to create cache
> > > corruption when undervolted, and that might not be unnoticed by
> > > stress-ng but will be catched by cpufreq-ljt-stress-test.
>
> The test seems good (see result below) :
>
> # cpufreq-ljt-stress-test
> Creating './whitenoise-1920x1080.jpg' ... done
> CPU stress test, which is doing JPEG decoding by libjpeg-turbo
> at different cpufreq operating points.
>
> Testing CPU 0
>  1800 MHz ............................................................ OK
>  1704 MHz ............................................................ OK
>  1608 MHz ............................................................ OK
>  1488 MHz ............................................................ OK
>  1320 MHz ............................................................ OK
>  1080 MHz ............................................................ OK
>   888 MHz ............................................................ OK
>   816 MHz ............................................................ OK
>   720 MHz ............................................................ OK
>   480 MHz ............................................................ OK
>
> Testing CPU 1
>  1800 MHz ............................................................ OK
>  1704 MHz ............................................................ OK
>  1608 MHz ............................................................ OK
>  1488 MHz ............................................................ OK
>  1320 MHz ............................................................ OK
>  1080 MHz ............................................................ OK
>   888 MHz ............................................................ OK
>   816 MHz ............................................................ OK
>   720 MHz ............................................................ OK
>   480 MHz ............................................................ OK
>
> Testing CPU 2
>  1800 MHz ............................................................ OK
>  1704 MHz ............................................................ OK
>  1608 MHz ............................................................ OK
>  1488 MHz ............................................................ OK
>  1320 MHz ............................................................ OK
>  1080 MHz ............................................................ OK
>   888 MHz ............................................................ OK
>   816 MHz ............................................................ OK
>   720 MHz ............................................................ OK
>   480 MHz ............................................................ OK
>
> Testing CPU 3
>  1800 MHz ............................................................ OK
>  1704 MHz ............................................................ OK
>  1608 MHz ............................................................ OK
>  1488 MHz ............................................................ OK
>  1320 MHz ............................................................ OK
>  1080 MHz ............................................................ OK
>   888 MHz ............................................................ OK
>   816 MHz ............................................................ OK
>   720 MHz ............................................................ OK
>   480 MHz ............................................................ OK
>
> Overall result : PASSED

Awesome, thanks for taking the time to do it :)

Maxime

--cfxk5euq6ylkqauh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXpbhxQAKCRDj7w1vZxhR
xeJFAQCRpXa5/WGOWfd5YXXrqOCzk7cnB4h+JQSnMqmMLY0Z2QD9GOOUOwmBTZj2
n3nqsY0/ztwdWeKtudJpz9pTOa6zxAE=
=VDi4
-----END PGP SIGNATURE-----

--cfxk5euq6ylkqauh--
