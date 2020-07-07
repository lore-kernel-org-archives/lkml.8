Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C7620738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594095702;
	bh=qVg1MjWrVI9DfjNv4Ao4HPc9Jf2pqIFaJmN60tjjBzM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=dS9n5+cSy4w3ZGJjOq+PMNlrO1Su5aGRO9dgXys0kOujf0Cg/NkMVfnMrSOvvMhFn
	 oBU4B2lHzrADLuToIkqrHvWrCsFJqiUSFCbUAs74l2v64z9TbvDfWG8xm5BHFB7uui
	 vycfQ4ox8tV1QwXCnT3fb6maIECoTMLFDavVKITg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGGEVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 00:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgGGEVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 00:21:41 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DE7C20702;
        Tue,  7 Jul 2020 04:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594095700;
        bh=qVg1MjWrVI9DfjNv4Ao4HPc9Jf2pqIFaJmN60tjjBzM=;
        h=Date:From:To:Cc:Subject:From;
        b=qAEngF0K0pwGlCNy7c8sNwQqZJFe/NWcl8pcyFIGvtCb369CijvXoQxXs0Ji8GE/d
         246J4na/cmtlUaYWY1VCNjPjbuVwkX002alCubelUjP4axvJTwb7Uw8cr2nj5lBSqV
         xGpuTXg52hVQcdbpEd+tQDyiIe54Ej4vG6VtTQ90=
Date:   Tue, 7 Jul 2020 09:51:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: fixes for 5.8
Message-ID: <20200707042134.GA676979@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Please pull to receive fixes for phy for 5.8. Kishon is bit busy and has
asked me to send the PR for phy this time around.

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-5.8

for you to fetch changes up to 38b1927e5bf9bcad4a2e33189ef1c5569f9599ba:

  phy: sun4i-usb: fix dereference of pointer phy0 before it is null checked=
 (2020-06-25 18:25:37 +0530)

----------------------------------------------------------------
phy: fixes for 5.8

*) Fix for intel combo driver for warns or errors
*) Constify symbols for am654-serdes & j721e-wiz
*) Return value fix for rockchip driver
*) Null pointer dereference fix for sun4i-usb

----------------------------------------------------------------
Arnd Bergmann (1):
      phy: intel: fix enum type mismatch warning

Colin Ian King (1):
      phy: sun4i-usb: fix dereference of pointer phy0 before it is null che=
cked

Dilip Kota (1):
      phy: intel: Fix compilation error on FIELD_PREP usage

Rikard Falkeborn (2):
      phy: ti: am654-serdes: Constify regmap_config
      phy: ti: j721e-wiz: Constify structs

Tiezhu Yang (1):
      phy: rockchip: Fix return value of inno_dsidphy_probe()

 drivers/phy/allwinner/phy-sun4i-usb.c            |  5 +++--
 drivers/phy/intel/phy-intel-combo.c              | 14 ++++++++------
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c |  4 ++--
 drivers/phy/ti/phy-am654-serdes.c                |  2 +-
 drivers/phy/ti/phy-j721e-wiz.c                   | 10 +++++-----
 5 files changed, 19 insertions(+), 16 deletions(-)

Thanks
--=20
~Vinod

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl8D+E4ACgkQfBQHDyUj
g0fb7RAAvkIQgZXcwIV2uB/AA7hFffbXopmmR3GjHYt9B7Ci3euMNo+uLNEf7464
GwoD3NLFLRLDYefOKKOrsUCIenpcD0PSnaUl2rhEmFl/6mEXtRqprU0FXPIudwpc
0cXvGFgcdo2prgKcpyvOI3OVEHknLYjxD3fH3bxHsFcltzrDoxm40JbfGUw7VIZv
boChjVSGbhUxKcr7YLqrK1Q7Kg3NznoeYOBosFoXeB/MsipoDcej3zJntLSHMWKt
C9pKqXC7xoiBal2SvVxHVeS9fauZwPZX78e6njZC9WWnSqJoskzUKEI2d1qsP5Pm
8z6Lce9E8z3LMw6w6c/3aDFftvus5xQj41EhSnZ8L6a2IeIDTeDbEZAjLg4Zl5FT
3DVM1XDM0X91oAS6/ufXQWpCJqBrB+++jFU+w2ZMCpEnDeBFcjvU4lmTg1+AgEtn
WYGRSWsBomcHkIR3FuyCqunpUlfI0u6LzjhpZDCOkLazJjiecMmHN7AJNrlfOXOy
mg5wCtOjfRngSWHu9Vs10WZUn3QVtAbbERli7bALpVhTpLfT7Kuax7HOBaKZR9ti
yhgTc5RhE6aqyKkmRC74U7TCxooG+Gk2uUfJxF9TIO6DZQjdQoSz7brGx9Ekfll/
MjLlz/sxD0cErxm1eIFrdEbsroVbHAxFZ+Cl2uY2MhiuzMH1T84=
=i5mq
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
