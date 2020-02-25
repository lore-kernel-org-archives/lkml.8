Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE16FC35DFB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9449421744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="TZaDZcAF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uwmZqFGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgBYJyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:54:40 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:55727 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgBYJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:54:39 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id BC9317EF;
        Tue, 25 Feb 2020 04:54:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 25 Feb 2020 04:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=JAYKQg/2/pReKqLMtOt2QZ5ljpW
        EB8Yt2uKvNb6wtl4=; b=TZaDZcAFLyFYVTbhFTg5Cbffetr0kG+aNiHfZsYtAYh
        4RHOt3ESWbp0UNA35oQ7ReHSvQ0O/FQ/FmFHcbp51NMSUrQFdRNDmrvpDH4AydvR
        1CAjZK24+51ZJIj+SItsUnVsUN5geJy5Ypvxr7dgcUznAsdM2QgN7MH5u/AHxtY1
        BUwoyLQKd1KDEnuLlbGPNIXQDF4Br/POSM0CTI/U+OvNNHlIEToNGZA23gHO0P4c
        0x9bREpdX150RzlELOr0kbsHzli7AmJNij9h5sOrWjaKlnChte7l/O/0Pw6ElgiH
        dM0yRoTkE7J+HpIyg5pGbg5rTNYOGpcO3jCMfBeyhXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=JAYKQg
        /2/pReKqLMtOt2QZ5ljpWEB8Yt2uKvNb6wtl4=; b=uwmZqFGGyQlOvdxmlh2joF
        z5tZZLICEsG6PqP6+R+0WoHLsZM6w5HXH7k+AjBG17FxT/aIB+xOOaHD7YP7821O
        Uhnoj2X6uc2MCEs59S1X64Iye+PTF06qmsvesZKNN+EVU0HDhk+388h6acqLth7g
        fqx4gY3tcf4QM4/f1hwIGUTSBf4QhD6XObHpPoE8t8pKy5eyCBl0X7nNL8/Ihyha
        3NnMMNdvgmLSrfXzRDbZ/VDEdfj1M+SQYjld61JWI2j/OTEy9sZKxpBaUovOT7zS
        RQpGKUX4ch0kVgsYQk93xfvIHo7xfMGo6/MA8WwKg63jRXe1Wh4oxzC67a/3Yvcg
        ==
X-ME-Sender: <xms:2-5UXkC8pbDcvZ5FDf69OjgiYFoI35kQ2IzlibCGg3TLCSa0X5EDzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledvgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:2-5UXq9LqHD_2Q0ARIC9phWW_maXwIbZDgfXkmdwPHIhY-XpvcUmBg>
    <xmx:2-5UXkWr3XiMoId8kYw9dw-eCJtqobpS-Hb4u-tdZcUQZqsOBKmOXw>
    <xmx:2-5UXsu9oef_xyvfvVKU1Uf-BqsgRUl4vQmc6zg4V5znV7rUWvHytg>
    <xmx:3e5UXuPkmDgmvkdlUZQk5esXbnCn-kKH0e0QJOHXi7FjLJiyNJG875dgpyM>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BF1173280068;
        Tue, 25 Feb 2020 04:54:34 -0500 (EST)
Date:   Tue, 25 Feb 2020 10:54:33 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 16/89] clk: bcm: rpi: Add clock id to data
Message-ID: <20200225095433.tyxamibqyrgw5355@gilmour.lan>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <3028e04887c7b8a6ffc150c016aa63281461b434.1582533919.git-series.maxime@cerno.tech>
 <67855a10-f7cb-b6b3-7b9f-d9c9baa5f105@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dyrskase4qcevtmb"
Content-Disposition: inline
In-Reply-To: <67855a10-f7cb-b6b3-7b9f-d9c9baa5f105@i2se.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dyrskase4qcevtmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stefan,

On Mon, Feb 24, 2020 at 08:25:46PM +0100, Stefan Wahren wrote:
> Hi Maxime,
>
> Am 24.02.20 um 10:06 schrieb Maxime Ripard:
> > The driver has really only supported one clock so far and has hardcoded the
> > ID used in communications with the firmware in all the functions
> > implementing the clock framework hooks. Let's store that in the clock data
> > structure so that we can support more clocks later on.
>
> thank you for this series. I looked through it but i couldn't find an
> explanation why we need to expose firmware clocks via DT instead of
> extending clk-bcm2835. The whole pllb / clk-raspberrypi stuff was an
> exception to get cpufreq working. I prefer to keep it an exception.

Thanks for pointing this out, I indeed forgot to address it in my
cover letter or my commit log.

I'm not quite sure what the situation was with the previous
RaspberryPi, but the RPi4 firmware does a bunch of things under the
hood to make sure that everything works as expected:

 - The HSM (and V3D) clocks will be reparented to multiple PLLs
   depending on the rate being asked for.
 - Still depending on the rate, the firmware will adjust the voltage
   of the various PLLs.
 - Depending on the temperature of the CPU and GPU, the firmware will
   change the rate of clocks to throttle in case of the cores
   overheating, with all the fallout that might happen to clocks
   deriving from it.
 - No matter what we choose to do in Linux, this will happen so
   whether or not we want to do it, so doing it behind the firmware's
   back (or the firmware doing it behind Linux's back) will only
   result in troubles, with voltages too low, or the firmware trying
   to access the same register at the same time than the Linux driver
   would, etc.

So all in all, it just seems much easier and safer to use the firmware
clocks.

Maxime

--dyrskase4qcevtmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlTu2QAKCRDj7w1vZxhR
xRbDAQDg9duHVr6F1bLDyXu+fLq7M8EsNZkJLMHJvpIZct0OlgD/dqxz9PtiJncr
wQ4ig9zsvApmBo3OuJBAcmZ7CXYSLQA=
=nXkx
-----END PGP SIGNATURE-----

--dyrskase4qcevtmb--
