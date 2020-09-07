Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1322AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4321820757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbgIGQQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:16:50 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:39163 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730469AbgIGQOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:14:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 64344938;
        Mon,  7 Sep 2020 12:14:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 07 Sep 2020 12:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=y3uHfRZw+5Gz3Ka30vws1hOsu/J
        Ass4/0jIBLDK53qQ=; b=Y3LRXGdaQBcC+WaeQYBB4hZG1dgAxEAMZ0FKTZlUSx/
        wV0UYUmA8yvx5g3zwZ4ZBC1/OGNaqE4tpT6dvpcRKahUYY23GoLqNoaWYwVPgaEQ
        BfxsobOB2FIXX2LWpNYi/zwcUZ1el+uOh2FaB5LfY+BBFn0hfVJK84MGwYrQMTrw
        l8cQURRtOcxeRUGf+23vBMSs9iG1mSgY2+1ItTtJN2Ky3/3j1rkY5aSDnHFzJyHC
        ce2FO8NyBnlqH75Yag2Z8AMsuJDgUmRL3aF3kspJgPg8tNbEbtTaDqKLRDSVcUqs
        cvyCm92kNkW6B17YlMSanl5dL9VC+vDs0yN8HLQQfJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=y3uHfR
        Zw+5Gz3Ka30vws1hOsu/JAss4/0jIBLDK53qQ=; b=MlQ2NHj9l0Z+IZ+t/rJhZ9
        WN3kRbULikovTJ44vc+PZdL3LjAiZSlaRefGxNkRKY5QF8ytDCn1t9I0yH1cnsgt
        Yi/bXSGTWBIcJ3xFCJgOidh2MI3rWjY+4QpXIPY+fO6k/fG2Mtnc3TeYiqRn8fBu
        uJU0hZI5FAM+tmi/A7W+vm6nC+ct/wIxOHTQ+FRdV3AjY/f12ZohUdI8119zhk2X
        /a73B6y0739qET3zb2Sg5f9RRHzkfa1gjYqhApHgprYcvUjoZLv3J8IGzfMKUnHF
        nPBJ81VZ8zEEjJ+q0ZFxiKR6WaWGpoofNATf/UaEG9dQ6tzlQWB71PU2ru78GI9w
        ==
X-ME-Sender: <xms:YlxWXzhbrnt0ovKIFbGGLrgfZP-LJg9Cm6_RWPHDGBgk3UYtmav-Nw>
    <xme:YlxWXwBDxz6cMgC29ilBWG90hBNK2WlB--juAFPA8f5ODz2AaXFhAXyVluiuiH3dZ
    h1d7anF-QDkAIzBSGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehtddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepveevfeffudeviedtgeethffhteeuffetfeffvdehvedvheetteehvdelfffg
    jedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:YlxWXzHfaXxsd-TiiNtBi_pjR41MMNHY29tK4II7EwKAG8-Kxmz4Kw>
    <xmx:YlxWXwR6qZvXaylD48hKMqHqxsPf07RKwCTrCTd2M6jtAxVvEw1nyA>
    <xmx:YlxWXwxQvLpLz-pAiWwfYjpLsjmthYS4oEi6bFxUcgGs3xUBL7a63A>
    <xmx:ZFxWX1LcZVCiJ8FUqi-3B1RJ5S0BPFahr3rsoNpLr_ogjgqFN9G6nlorR4Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A21A3280066;
        Mon,  7 Sep 2020 12:14:26 -0400 (EDT)
Date:   Mon, 7 Sep 2020 18:14:24 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, eric@anholt.net,
        kdasu.kdev@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        nsaenzjulienne@suse.de, p.zabel@pengutronix.de,
        phil@raspberrypi.com, robh+dt@kernel.org, sboyd@kernel.org,
        tim.gover@raspberrypi.com,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [PATCH v5 00/80] drm/vc4: Support BCM2711 Display Pipeline
Message-ID: <20200907161424.okjolk5v7pdiyoqu@gilmour.lan>
References: <CAPpJ_efY2=qmaAtuYVfWhZNBhzTAtAxm9CS5jb_sTpca97jkpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jipczgpyckh77ast"
Content-Disposition: inline
In-Reply-To: <CAPpJ_efY2=qmaAtuYVfWhZNBhzTAtAxm9CS5jb_sTpca97jkpA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jipczgpyckh77ast
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Fri, Sep 04, 2020 at 06:16:16PM +0800, Jian-Hong Pan wrote:
> Thanks for version 5 patch series!
>=20
> I applied it based on linux-next tag next-20200828 and build it with
> the config [1] to test on RPi 4
> However, It fails to get HDMI state machine clock and pixel bcb clock.
> Then, vc4-drm probes failed. Full dmseg [2]:
>=20
> [    2.552675] [drm:vc5_hdmi_init_resources] *ERROR* Failed to get
> HDMI state machine clock
> [    2.557974] raspberrypi-firmware soc:firmware: Attached to firmware
> from 2020-06-01T13:23:40
> [    2.567612] of_clk_hw_onecell_get: invalid index 14
> [    2.567636] [drm:vc5_hdmi_init_resources] *ERROR* Failed to get
> pixel bvb clock
> [    2.567664] vc4-drm gpu: failed to bind fef00700.hdmi (ops vc4_hdmi_op=
s): -2
> [    2.567731] vc4-drm gpu: master bind failed: -2
> [    2.567755] vc4-drm: probe of gpu failed with error -2

Sorry, I should have mentionned it in the cover letter. This series
depends on that patch from Hoegeun:
https://lore.kernel.org/dri-devel/20200901040759.29992-2-hoegeun.kwon@samsu=
ng.com/

Maxime

--jipczgpyckh77ast
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX1ZcYAAKCRDj7w1vZxhR
xYwCAQDm6F6h2pwNs7Q8EP9XiO/LnXQS0wkHQt2icHMNkTpDBQEAxZclGsOEUXAz
POMH62A+x8HcwntZ9CRAtQ42hIa3zw8=
=Mzu7
-----END PGP SIGNATURE-----

--jipczgpyckh77ast--
