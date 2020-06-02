Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08768C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 02:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16DC2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 02:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="r2kV2Hhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgFBCRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 22:17:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50059 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgFBCRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 22:17:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49bbKW6Jncz9sSJ;
        Tue,  2 Jun 2020 12:17:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591064256;
        bh=NQkeWgxvrc5bDW6xcAlwVko/45XXVKKSZtWco6AydyE=;
        h=Date:From:To:Cc:Subject:From;
        b=r2kV2Hhsh5pqP1VR/R0VhDOCfXx0eRukYYNWYFJvIun6RDJBrhxdz4mhtlS2ZbPi+
         WopNVcTyI9BczWLZ9Rbt9QsCwMGOJvmFVwq5oNqZq4MTVXwbPOAjT413WxtBkp5/Xn
         e3wqXAUR+8WfP+BQ1uIS/z2/x3ZPChqWChW240uKYzcNetgzN7jexXTXQAaJ5/uj/u
         LTOXCFPi6DUEQoekPUEt/S+lSev+qaebTi+22XUk5rRQlF5NeDJ9/2mxicPst5yvFF
         vxpN0QSvXmUmY1VCsPRSPaXJgQ0Lik/bx8tzZMujs8r928hfv/1kYqXyaCguSFzOJA
         4KS5dA0joTLFA==
Date:   Tue, 2 Jun 2020 12:17:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rohit Maheshwari <rohitm@chelsio.com>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20200602121735.1a2e5d0f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O+F9y2hA8jhXXkOdAj=1Ljo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O+F9y2hA8jhXXkOdAj=1Ljo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c:666:13: warning: 'cxgb4_uld_=
in_use' defined but not used [-Wunused-function]
  666 | static bool cxgb4_uld_in_use(struct adapter *adap)
      |             ^~~~~~~~~~~~~~~~

Introduced by commit

  a3ac249a1ab5 ("cxgb4/chcr: Enable ktls settings at run time")

CONFIG_CHELSIO_TLS_DEVICE is not set for this build.

--=20
Cheers,
Stephen Rothwell

--Sig_/O+F9y2hA8jhXXkOdAj=1Ljo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7Vtr8ACgkQAVBC80lX
0GwTgQf+N1E7JfLN6CfTX+HRa2FoFOc0dIPjx1pnPB3+ewI0Y0GtwIcbLbeZFoaa
uxdhw9EQ8SYHATbftOaAFEE3wbCSAlcZRHHWf20bOLNuMKgpS8MIkwdyqa79v/u/
yk8E33Y5CDqB/AeCMRPAVUOfPrGl2ZSIYXmIo6M42FXfQ2L2IvRFcxDnrpqaLBVg
UGDQSW8lYOQ+hJQasUvTGOnGqz+3oGHO/CbV2H4PUw1vkWBox3pUHc2lQTt1yBWa
DGPPmmzT9HDN3IKOHYL8kVJDFq40mQXJ3dgLTkGRZL9iWoeMeHQ6JTDgyJqJGGap
tmx/SdtqkVzJsKuGS/iQuhqzI/bfmg==
=GDoB
-----END PGP SIGNATURE-----

--Sig_/O+F9y2hA8jhXXkOdAj=1Ljo--
