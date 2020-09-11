Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFC0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53591208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgIKJaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:30:46 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54049 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgIKJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:30:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C4D665C0143;
        Fri, 11 Sep 2020 05:30:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 11 Sep 2020 05:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=4eZPvAv3U0ei+14UtDDh27zONnm
        UsYhV4QCkXaiv95U=; b=cVg7pVYoHtQ+hvwb8cQNsrps9G+IF7pfPQK1slBQDA3
        Sqnfc6mEd9yCy7mCj8OT27z6uydy8YS+CN9RNql7puGeDfxmu+B8KgxfdzyKp5H4
        ygqfEBhL3749W7eFNkiNxGUk5Thv7u7/Ibf6IGSCSWGXfn/O9Kpo/JiXdf9u/96u
        FMig7f7cdI+LMJjDaZsJa8hUd7J9hrSN3AzgJaO7McVkCAj0cF7LcaGhShTnfP9X
        I3ubBZz3YkmBF74ZmevyMUzMCHLalm7f5mCt4cE313bvsWL0IrmA1yzKCpEKYK/Y
        /ajWu/Kf454TjtlLVnjLoQWa4oFaTKgJxi1nSEq/7/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4eZPvA
        v3U0ei+14UtDDh27zONnmUsYhV4QCkXaiv95U=; b=dfH6sYtjoYu1rDC3NGm9lm
        M58DQ6AeSrVF6hJM2j+RArhBSzI78eEtW3N1o++2CudQMGd4EFE8m1iaOS8vCvg+
        s28ZWb853EHp2j8ZcWgmsOuP2zxQWwRscRAJDGLr2GN1kXxn5cI1R77nxKZV+l7W
        ZB9Bd9IGj/PxLDFgYx3GLIl2xTyR2dhtSIFCk2gXYHQckO5K4/gLe+dF1kT9QPWq
        gkTk6fY94LdMZHqswXoDLV2m+PGWExUASlZb58qAG7iWVXI+/LQXyoCBe1BMK/2Z
        LSJzz5SYIA1K/UgHUEtY9pPCOAC/f4zoFadBUGbKCWIOVGPcvw6OFpiwCPf9hJ6w
        ==
X-ME-Sender: <xms:wUNbX8wTwySe2pk7F3uY_ycdHvh6M32Ek5BDfp8yw12tMp5Wt2wrNQ>
    <xme:wUNbXwTS3lqYLsAyXhMID8LOWX1GMui7u9Eaa-9IvuMWJrfnx67Ckkgr9EiTJl14Q
    0MLNc83iZ9GFpEl_oI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehledgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepveegudetkeethfetgffgtdekkefghefhffefgeduleehgeehieeuveefgedv
    ieegnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:wkNbX-Vbn-y9gfr4apn-2UJzARWpt7QDKtizO8NjacHKtr5UwdWhEg>
    <xmx:wkNbX6hKaX5TlaS1j-Qb5OTHly_xAkRqZ2ylmIOpiGRFU060p30BMg>
    <xmx:wkNbX-B9CytH0zvYuu0RizjFeVFOQhNCyz7RPkvoKLuT_L5486YJ5g>
    <xmx:wkNbX5P-jTbyqZgGslD1VBdWSjMfVNvOkPVz2iLuiUytkIIynCtqGw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B14243280059;
        Fri, 11 Sep 2020 05:30:41 -0400 (EDT)
Date:   Fri, 11 Sep 2020 11:30:39 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] drm/vc4: Fix bitwise OR versus ternary operator in
 vc4_plane_mode_set
Message-ID: <20200911093039.ki55jtui5z5pftax@gilmour.lan>
References: <20200910171831.4112580-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4mr3dssagjsp7qtp"
Content-Disposition: inline
In-Reply-To: <20200910171831.4112580-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4mr3dssagjsp7qtp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 10:18:32AM -0700, Nathan Chancellor wrote:
> Clang warns:
>=20
> drivers/gpu/drm/vc4/vc4_plane.c:901:27: warning: operator '?:' has lower
> precedence than '|'; '|' will be evaluated first
> [-Wbitwise-conditional-parentheses]
>                                 fb->format->has_alpha ?
>                                 ~~~~~~~~~~~~~~~~~~~~~ ^
> drivers/gpu/drm/vc4/vc4_plane.c:901:27: note: place parentheses around
> the '|' expression to silence this warning
>                                 fb->format->has_alpha ?
>                                 ~~~~~~~~~~~~~~~~~~~~~ ^
> drivers/gpu/drm/vc4/vc4_plane.c:901:27: note: place parentheses around
> the '?:' expression to evaluate it first
>                                 fb->format->has_alpha ?
>                                 ~~~~~~~~~~~~~~~~~~~~~~^
> 1 warning generated.
>=20
> Add the parentheses as that was clearly intended, otherwise
> SCALER5_CTL2_ALPHA_PREMULT won't be added to the list.
>=20
> Fixes: c54619b0bfb3 ("drm/vc4: Add support for the BCM2711 HVS5")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1150
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied, thanks!
Maxime

--4mr3dssagjsp7qtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX1tDvwAKCRDj7w1vZxhR
xX0EAP47LWuq4yevIMaFjUP73PiNl7Exoby6G4mj8QuRY4gduQEAhkTXFPSjmzvw
gZ5q4Rxbxl+PYtOOngPfqyuIAelmZw4=
=WjzN
-----END PGP SIGNATURE-----

--4mr3dssagjsp7qtp--
