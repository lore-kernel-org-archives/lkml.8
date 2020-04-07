Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6E8C2BA1B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650F5206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="XsjePcnH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="grugulOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgDGIgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:36:54 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:36721 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725817AbgDGIgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:36:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4A951651;
        Tue,  7 Apr 2020 04:36:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 07 Apr 2020 04:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=4JjD4nhCeDSm8qKCj697mUQU3e9
        hRBe6jxcMGNOUYSk=; b=XsjePcnHJcDSz+mYUIJGJ5B/aG0e7XbHR08R6oCdAsh
        QzvpBvr7/otb8MdKszbYdUvJ7mJAWq7WpZQgnlOOMTg22tCIBfg7s9G01I0Q70ph
        y1FE4ni4is/9D0LSw986qIl42FmIYyaFix9y0BwtS4p+0ngYe1UEr/Ie7si7UjNR
        U1n/WC8YxMmA1Coa5sJ+nRcGFGtdGDflzZMwjJWxXV8Y10va4JA1QUSjp03mOn6C
        InAfGS6Jt9poszH1Rm2Yy+7dcaFn6Dd0EJ9ClcKU91jLgsRYFVjmBBL7pqhly6kw
        XsIs5uuvAVm2szqC/GLE+9mXtSJMV89w8YP8sV07Ixg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4JjD4n
        hCeDSm8qKCj697mUQU3e9hRBe6jxcMGNOUYSk=; b=grugulOlKGnUpe+cw9Zfr2
        9f2qnI/N4GTrxJEk0reU+x7fgJTGrv6wk3aCrPY50tZN80Ig4ttN7IF6rsgccwTV
        +wgWBnn37c+X94Whcfgu7RIxNRzkXxH4tKj2/0/lW/q0447RJ8JfZRgXmysK35kI
        CLOrtNnLZi8AdoU+nA/2yREnra6Kj4zuQl8rvf16uzxgIZYmblNObIdLiizjKalP
        koluwaGEoGmeCrRY0s/NEnN9ZqeQapx1jj1OI6qyGhfmiEzV1CgOIMc3EOaetgy2
        ug25xi+X6xeAMuuhXMwsyY0jUeUmJu6ZivSU+3MP9N9CA6XtTyD3+kLrx+VLPkFA
        ==
X-ME-Sender: <xms:oDuMXoh2gp59uxcEAj3duYH0-yhYXLWYbH_tMDlcGxbbasASAygIXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:oDuMXqu1vN_TtHjH1yewbxSIyz-7NK8R3TKr_clhgUVp8D_GoQUnlQ>
    <xmx:oDuMXnDbrU0wWq_pGftuSHZP0-87qyEQS3GsGRlmlE5cYkmG7xgQFQ>
    <xmx:oDuMXtUrpVVLtUG4WTD8ytEBgDGLlRkz8Hjt3NkjCYH7JzfxNMeksA>
    <xmx:oTuMXopADU6Av-QC84MI_1SCEhUc3OOEpfHx_3Y1DF3uYJPNjABlFg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 787A6328005A;
        Tue,  7 Apr 2020 04:36:48 -0400 (EDT)
Date:   Tue, 7 Apr 2020 10:36:47 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/3] media: dt-bindings: ov8856: Document YAML bindings
Message-ID: <20200407083647.4mocdl7aqa3x737q@gilmour.lan>
References: <20200331133346.372517-1-robert.foss@linaro.org>
 <20200331133346.372517-2-robert.foss@linaro.org>
 <20200401080705.j4goeqcqhoswhx4u@gilmour.lan>
 <CAG3jFyvUd08U9yNVPUD9Y=nd5Xpcx34GcHJRhtvAAycoq3qimg@mail.gmail.com>
 <20200403232736.GA6127@valkosipuli.retiisi.org.uk>
 <20200404093446.vuvwrhn5436h4d3s@gilmour.lan>
 <20200406083506.GE6127@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tdgovq5ccaqtherr"
Content-Disposition: inline
In-Reply-To: <20200406083506.GE6127@valkosipuli.retiisi.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tdgovq5ccaqtherr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sakari,

On Mon, Apr 06, 2020 at 11:35:07AM +0300, Sakari Ailus wrote:
> > But that 19.2MHz is not a limitation of the device itself, it's a
> > limitation of our implementation, so we can instead implement
> > something equivalent in Linux using a clk_set_rate to 19.2MHz (to make
> > sure that our parent clock is configured at the right rate) and the
> > clk_get_rate and compare that to 19.2MHz (to make sure that it's not
> > been rounded too far apart from the frequency we expect).
> >
> > This is doing exactly the same thing, except that we don't encode our
> > implementation limitations in the DT, but in the driver instead.
>
> What I really wanted to say that a driver that doesn't get the clock
> frequency from DT but still sets that frequency is broken.
>
> This frequency is highly system specific, and in many cases only a certain
> frequency is usable, for a few reasons: On many SoCs, not all common
> frequencies can be used (e.g. 9,6 MHz, 19,2 MHz and 24 MHz; while others
> are being used as well), and then that frequency affects the usable CSI-2
> bus frequencies directly --- and of those, only safe, known-good ones
> should be used. IOW, getting the external clock frequency wrong typically
> has an effect that that none of the known-good CSI-2 bus clock frequencies
> are available.

So clock-frequency is not about the "Frequency of the xvclk clock in
Hertz", but the frequency at which that clock must run on this
particular SoC / board to be functional?

If so, then yeah, we should definitely keep it, but the documentation
of the binding should be made clearer as well.

assigned-clock-rates should still go away though.

Maxime

--tdgovq5ccaqtherr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXow7nwAKCRDj7w1vZxhR
xQstAP0TwTb8HQCIY1hTWh6ICjLurf3wji32l8sqvhKN/kS2bAEA/QsgQ8BIfzU3
wxJ2Dwt128qujydSVIFZL5Uk7XAwJgY=
=IafI
-----END PGP SIGNATURE-----

--tdgovq5ccaqtherr--
