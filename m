Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823FFC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 20:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC6C2086A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 20:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="imkZ7L7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgBBUmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 15:42:19 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54713 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbgBBUmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 15:42:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 489jZ07344z9sPK;
        Mon,  3 Feb 2020 07:42:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580676137;
        bh=B2hLmk31JryAktx7MdlUn59snzXyCALDvA6eVwGUbTg=;
        h=Date:From:To:Cc:Subject:From;
        b=imkZ7L7p/Z5IaoyjkP8QVFDMzlx0ljB47+qJBMLXeZyg/TkzFS/aqN+Es0jZdNsR/
         FJTJpxAzacaxdHpaMpP2AvOm3faM+Ikt/V0nmWT6/180lPF67zAt2RIh+Q7NsbXoDa
         fqdqpgtmSRKg9N3O12eHtI6EoEnYRPRRzIemktTc4i/oCgDHnRVOzRbZ0A8zUE+NCw
         GEmDmSawwwro/LCMax0aTRK76Sk1LrV3/tNy5j5RcbGnZzbtt0V1fjphLnF37YEs/0
         tOYjivOB0UrGNqGVWu0K+/Y77cbA1j22tKQaCzV36rxg7SuqQ6kdrlmMhM91FjxPH2
         +Z5OgZ8C21kfA==
Date:   Mon, 3 Feb 2020 07:41:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: bad rebase of the csky tree
Message-ID: <20200203074151.05bfe914@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lriMuSHaFGbuffbes_tc9eC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lriMuSHaFGbuffbes_tc9eC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The rebase of the csky tree has rebased some of the commits from Linus'
tree as well.  Please do not rebase your tree unnecessarily and especially
not during the merge window.  And be more careful about how you do
rebases if they are necessary.

--=20
Cheers,
Stephen Rothwell

--Sig_/lriMuSHaFGbuffbes_tc9eC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl43NA8ACgkQAVBC80lX
0GyvHQgAnskELwgAvripE6UZHfaFS9uA/PDWdSzOhEm+DYd4xV93EbMqRRDQ5uKI
lWoTs4vRJzM8IEqPE0/WzrvPuge42fqzEXzWAHWW0VDRk9OL7dJBZb3LM5LXVNIB
NrSNOQ5BvS7xuYXJo+7fk77L1OMF7irmXz22vM2oT5b0JNb15gJ6SpNA9NadhG+7
eIvY54MtulZqkq9a1l8Min2yt9rJNoOvrBgq6Nl1YCuPy8vqgIDiP6j9PGVkOrNJ
jh3EoAdTn2uLFQEaTjEY2DdpMiOAYfTkPTllQ9YM1KirUdFBt2l7Kqh3MkxQJ50H
WaFaSgESjeEe+u4PZLtFtxiBysNtog==
=sToY
-----END PGP SIGNATURE-----

--Sig_/lriMuSHaFGbuffbes_tc9eC--
