Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05C8C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75EE2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="r1IZzCJF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kC5ZbUN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgG0Nix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:38:53 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39845 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgG0Niw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:38:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E7FF5C00E0;
        Mon, 27 Jul 2020 09:38:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 27 Jul 2020 09:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=0mmwIwgCXcA2dLIOd7pzgN6JF1A
        xROb9VRXpNp325Uk=; b=r1IZzCJF5qcf1q4OhChsQEWrQi1+zYfkczWSi7WlCB2
        G1kkK1fLKULCt8KOUFPoV3LiHTstEdm0AXA5+JP/84AG5K5Nv+8XD2WWpVrfMsM2
        bnDgEYuR3Ir61diMJ6liy+NmJ+CwDp3N1e5u2d34AO4CUVeaGeIETz6Ld148h4E6
        JF461XU53MT/E8W+fOe3X32y0E7vt8QOm6Gl0wyMq723ymP0p9IbR2ybdRETJgHg
        X8RQX2vlq+yRpVYhuP55AN4dhxF8J+nUzOJ0jb6T/xDUTsMXgui6G5J8wKyULzWA
        6VX8LuiE4OKbQCBdpaKNe0tMaL2CPt81BqWMLAfz8xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0mmwIw
        gCXcA2dLIOd7pzgN6JF1AxROb9VRXpNp325Uk=; b=kC5ZbUN5VKsNRlHfT4hyRq
        +9s1RjzN8U8oK1xydmS7+LmE42bXXEdKEU64ZKeREitABfOpetusBnN+UtaVR3SH
        u657PWG6qnn2JQKsc0KedmKP4nwYJmWjEx/3FAuazWQU57uK8h+VfjqjTox6JL6q
        EaotPP7HZwBww209tJ/0HcRg0D1jnbDVAJZiwHk6UUYLbtGoFwtPpxwiFaLU6ahA
        ktTuR1hCYJkRcG9xHj9WjtyBab4ZENGuyM7GmL6jIJVy2qoDSqH+LlWk1Jvu3e3g
        +N/HHh9/ZyLvwWSEDi8Vm3k8OzgT3j53vV2/cNRFy4/5nflqS+8ZB1/rS0HKgLZA
        ==
X-ME-Sender: <xms:6tgeX-M4SRc7K4cUrap3WIMIB6yXtBS26yufduvnfhosxwVdOklqng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedriedtgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:6tgeX89Gg0a4-HsUqX9jxNltxxR6eZhaN5YMER_r9somoRFQIze7lw>
    <xmx:6tgeX1R4t7ddwta9z4dR6t4Eni1RrgZVpkwJVuRJD3bGcBEiaU7QWQ>
    <xmx:6tgeX-sfjRk_O1EHTbHcwLSE-0CFOc0XMfPYgjvlgXJ6pjCuHqXdiw>
    <xmx:69geX163RMYHF3O0McF6TuOjH_R3X6tWJRu_iTjk3BDBULuO4Es8QA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E9DD23280064;
        Mon, 27 Jul 2020 09:38:49 -0400 (EDT)
Date:   Mon, 27 Jul 2020 15:38:46 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] drm/sun4i: mixer: Enable register value caching
Message-ID: <20200727133846.kgrnmsocy4pel6cn@gilmour.lan>
References: <20200724203549.35893-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rkf3mebagvwl47n5"
Content-Disposition: inline
In-Reply-To: <20200724203549.35893-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rkf3mebagvwl47n5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Jul 24, 2020 at 10:35:49PM +0200, Jernej Skrabec wrote:
> It was discovered in the past by Ondrej Jirman that mixer register read
> may occasionally return wrong value, most likely zero. It turns out
> that all mixer units are affected by this issue. This becomes especially
> obvious with applications like video player. After a few minutes of a
> playback visual glitches appeared but not always in the same way. After
> register inspection it was clear that some bits are not set even when
> they should be.

There was a similar issue on the earlier backend stuff, and it turned
out to be because we were accessing registers while the registers
"commit" wasn't completed yet.

It looks that in the DE2, it's the register GLB_DBUFFER that controls it
(offset 0x08). It would be worth looking into whether it happens only
when the bit 0 is still high.

I ended up writing a small program using devmem back then to write a
known value in known to be faulty register and checking it in a tight
loop (and then with a poll on that bit) to see if that fixed it or not.

> Best solution would be to shuffle the code a bit to avoid
> read-modify-write operations and use only register writes. However,
> quicker solution is to enable caching support in regmap which is also
> used here. Such fix is also easier to backport in stable kernels.

It only partially fixes the issue though. None of the volatile registers
would be covered, and this includes GLB_CTL too at least.

Maxime

--rkf3mebagvwl47n5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXx7Y5gAKCRDj7w1vZxhR
xTpvAQDC2aWjXyPe2xdJ6WjwIF72CckAJTJco3V8uth5Idw8TgEA1Hvn6WJiVmO5
Et+T33XmkAq7D1qTPjEHncGpqQ4USgU=
=9gPP
-----END PGP SIGNATURE-----

--rkf3mebagvwl47n5--
