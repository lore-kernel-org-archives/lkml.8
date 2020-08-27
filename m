Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAA3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AE32087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="OqlFpDbi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NG/oHsox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgH0QSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:18:41 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:35927 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726929AbgH0QSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:18:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 64AE7D3C;
        Thu, 27 Aug 2020 12:18:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 27 Aug 2020 12:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=/wJ+GjNODeC+pwuurvtcGc283Mi
        0BLoYQFGbdBCsBis=; b=OqlFpDbiRKfP+EP+VthwNU9M+e8dAb0HehCuRtJib9r
        7FZoPCJuQN6ywFe7lgq66PH/s0ft25hGF0VX86CII+eebJE6vEzZKu3Wr7K8cko5
        pO6lV15vzBTxAlJyPtkPslwEiHLdqhgZMz7abSN9hOZanQTnhadeTWEuuemjW1p0
        7XxFmRDmUTvgPx5/DAytPnHu/Zdu6MmUG2BBCm7Js1FDrSmM3NjbGmhaMVxWZEhO
        OI7bb657DzRglly9tYJomHbaJ4s+w/BGQaxSuN0biwfXMBAFkT9/bpL+K3c62vLV
        nZNl3HV2YdUd113XF1LaO5iN9UBB+GcSwWSUzqFUqmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/wJ+Gj
        NODeC+pwuurvtcGc283Mi0BLoYQFGbdBCsBis=; b=NG/oHsoxH1nK80dmJSzoj9
        xgbBnto6CLL1P1KszuLGZ7i4I+fVbmLSMAgY/jxnLwcl79HNKnEhHOX39WlEfW+9
        ZBQKfA0iNLVX22ejGu+nVAYxZBMlR9qkVztrmFmjDyc5ryfc/rPGkZpoIE0Hz3va
        WVAQn1uAqw4jD7Q9oj1CQe/ejomDdxrdqxkpcyHl3fPwiXUa1ePPgbkYRhkoBP9s
        4vg/qaPWlplIosk0GGah1FUbI3Zg7KD/mGmXnao2vPtlfqwLjWO10dYqC9zVpkmb
        +YrnjQlGAgwjXPCs6OuuG8MVU9XQumbLFMQ2AE07gOzdQmyt6xVDzdYHUgpB52IA
        ==
X-ME-Sender: <xms:2dxHXzjtYsiaRbMejqYEFT71l4eLeNtWBLWUmaNXRSnBijWXtmRoJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:2dxHXwBt1bpEfqc-SL21jc5YvaM-rSabe2yDCoRQ5UFt_WoWsFziLQ>
    <xmx:2dxHXzHBLcDwIvcdRnaPTLLOZJpu1yVRXu5GQdR_EYluYgzi9SOqDg>
    <xmx:2dxHXwS0HMsmskgQEpVi4iSpyslsT58KdrWOA844rW_pk6zhDCdHbQ>
    <xmx:3txHX_olOW0hy34_4UVNJjaDayzR5x-nOpABZqJGfv6TuqilFGd7GA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C376F3280059;
        Thu, 27 Aug 2020 12:18:32 -0400 (EDT)
Date:   Thu, 27 Aug 2020 18:18:30 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH V2] drm/sun4i: add missing put_device() call in
 sun8i_r40_tcon_tv_set_mux()
Message-ID: <20200827161830.eqjsmq37u67zb3vl@gilmour.lan>
References: <20200826010826.1785487-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4t7lkxbq6tfplcxx"
Content-Disposition: inline
In-Reply-To: <20200826010826.1785487-1-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4t7lkxbq6tfplcxx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 09:08:26AM +0800, Yu Kuai wrote:
> If sun8i_r40_tcon_tv_set_mux() succeed, sun8i_r40_tcon_tv_set_mux()
> doesn't have a corresponding put_device(). Thus add put_device()
> to fix the exception handling for this function implementation.
>=20
> Fixes: 0305189afb32 ("drm/sun4i: tcon: Add support for R40 TCON")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied, thanks!

Maxime

--4t7lkxbq6tfplcxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0fc1gAKCRDj7w1vZxhR
xYwvAP92KgHVYUPdnM2VvZuzhYmmh/HjKq1HLEC+NNTG4Ge73gD/ZbGdhLP6WHBY
ViKxSMEbdjleAS5WCWtx2pKypvTeagQ=
=QYTg
-----END PGP SIGNATURE-----

--4t7lkxbq6tfplcxx--
