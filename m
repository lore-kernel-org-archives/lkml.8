Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0194AC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8E621473
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="EfMEFse8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1XLjA/zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgCaJAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:00:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41739 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729955AbgCaJAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:00:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EF59D5C0403;
        Tue, 31 Mar 2020 05:00:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 31 Mar 2020 05:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=4yK+oP+E2ftKY87Z70nWv7pkOnp
        cr42m5qvb6XN0sv8=; b=EfMEFse80Brg3++mtTk/jXn7Ia+YfgRfJP02Uqgsy7Y
        o8HMWuvbAYTprqpTldRl0DxfEjvtRSj41/kcKZm2tu9q5AtboB5isRoepZzDYazx
        TNS1hddO2D3lqa469nqwy0+i0whJUMrfmO5656Fa+IG6Bchi4nnwxgljHTr+bOpu
        /n97Qw+SYQ6U5U6fX7LmXWQdlvF3/sJ/eddLY2a/QQ6HRFHmuV50Z8GwlT+C3KtG
        CLAo6t72z9czfVGsQFx35bEjGYTz1FASVycASyKy9HW+cXXEGBMpckj+gKSgNUwR
        8bfVUitx4y46bnXj560YaYJQX9tIG0V2vgsempKPj6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4yK+oP
        +E2ftKY87Z70nWv7pkOnpcr42m5qvb6XN0sv8=; b=1XLjA/zuGwIG91NbBthKh1
        Qd8nkCr+URZAfk9YkH2JxD2nTQ5pidhhGv5ULJ2QU0PSgb7VG7LwIclq0B6DfnlS
        GSIOMlnF1FW+S8Zfmp6z7TwSUNL077HIsryilnR2vZsf8jIgQZ2jYEba22K8nnTp
        8NzOlMO8WfyHGztp0NytHfKhIbdRJ2rRVzXqg0HB5brw4kIEdjmQk2T/AO6dEIJM
        9FuuQVpTI/BYcYMvXsI97LUa7hjFIXYYdgwFLRH9M2D4s54hJTfcYH8i18A9cSLT
        NWq52BnZpgJSwzlxc2JfwjPXFPmkRGTt4UMsiRSudLbpSpytF8wd0sCP/NXUaPww
        ==
X-ME-Sender: <xms:swaDXsTXGQwyQp7Ha2yKqIyxrRrdKIsHH_oAIXhEhZwH4p8xL57cFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeijedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:swaDXmn2HDslN0DRy-LsdgpX9lk_XN3vfss8M9RS7zsBEtMk4arEVQ>
    <xmx:swaDXsEehcshyce6J6mSKwOCwwaaiV3-c4rQ0ZFairilIuaodId1Nw>
    <xmx:swaDXgJ_jr3Dr5j0-MY85W1MyoRbLJRDGFEFArLDqeOX6xTUwbN1cQ>
    <xmx:twaDXumD2A9NJS4QTAxSnmAzrqi-YSfw-LqgJ2XMlPR01cQ2pYp2JA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4039D3280065;
        Tue, 31 Mar 2020 05:00:35 -0400 (EDT)
Date:   Tue, 31 Mar 2020 11:00:33 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: olinuxino: add user red LED
Message-ID: <20200331090033.463xytloqn3fdgtz@gilmour.lan>
References: <20200325205924.30736-1-ynezz@true.cz>
 <20200330175347.r4uam7cybvuxlgog@gilmour.lan>
 <CAGb2v66+oT=qfu7oHTs3d_e2hd_8Fc_0ULhHRfMLmrdcfOoe=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q6zww7gd7ff5vqam"
Content-Disposition: inline
In-Reply-To: <CAGb2v66+oT=qfu7oHTs3d_e2hd_8Fc_0ULhHRfMLmrdcfOoe=A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q6zww7gd7ff5vqam
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2020 at 09:19:57AM +0800, Chen-Yu Tsai wrote:
> On Tue, Mar 31, 2020 at 1:53 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Wed, Mar 25, 2020 at 09:59:24PM +0100, Petr =C5=A0tetiar wrote:
> > > There is a red LED marked as `GPIO_LED1` on the silkscreen and connec=
ted
> > > to PE17 by default. So lets add this missing bit in the current hardw=
are
> > > description.
> > >
> > > Signed-off-by: Petr =C5=A0tetiar <ynezz@true.cz>
> >
> > QUeued for 5.8, thanks!
>
> The gpio-led binding seems to prefer "led-0" up to "led-f" (^led-[0-9a-f])
> as the child node name. This was recently brought to my attention. Do we
> want to follow suit here?

I've fixed it up, thanks!
Maxime

--q6zww7gd7ff5vqam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXoMGsQAKCRDj7w1vZxhR
xXsgAP9qUq9MJFLKyC2XsD9mNjGT3ZF7vmPVTAVvOezdjv0BkgD7BAo+Q29VGh1q
IISh60xTBwcV54TuffpFZIulHONf5gg=
=qXte
-----END PGP SIGNATURE-----

--q6zww7gd7ff5vqam--
