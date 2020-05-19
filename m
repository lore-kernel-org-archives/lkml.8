Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6080C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6FC207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nchV7XJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgESSgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESSge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:36:34 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E001C08C5C0;
        Tue, 19 May 2020 11:36:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49RPjX0pyjz9sTH;
        Wed, 20 May 2020 04:36:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1589913393;
        bh=uHf/n/3lhq80d/20JbDIKvnFDtOjqWPxZBs/eern4Tc=;
        h=Date:From:To:Cc:Subject:From;
        b=nchV7XJFXHz/dOTOpSi/rBos5yGTV09NBskEw0f3KCv61/NCpPGVL0/OC6GRGPNta
         zcRGVBs/sq6LjR0LsLra8DmcqXOLawjInD6R7lMssWwUz5OKICVbOrgovVeEnYeuai
         AtZjFc3uhTaaVUoKPZLr4O1sLdPM5OK3VdsPxp3bFpubDPIAt6wg7jTQT8YgPSFOMK
         fb3fa25NpJrAM6fXIbuZG7ihcKDtU7F2/vmDPx+qHEbblINgx90K1P9Jv68SwvsIYU
         1bnTZivcJ+dwJLMsrvzWzlOu1XVmld6fnabFdVk2p95N9+uzoP9QVrtkwiz+6O8REM
         wAToACIaqONWA==
Date:   Wed, 20 May 2020 04:36:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: linux-next: Fixes tag needs some work in the iommu tree
Message-ID: <20200520043631.41a150d2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QZtWuWWQjElsZXikxlRXNfy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QZtWuWWQjElsZXikxlRXNfy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ef0865631ae3 ("iommu/vt-d: Fix pointer cast warnings on 32 bit")

Fixes tag

  Fixes: d64d47f4f5678 ("iommu/vt-d: Add nested translation helper function=
")

has these problem(s):

  - Target SHA1 does not exist

Fixes tag

  Fixes: a3bea1a35c083 ("iommu/vt-d: Add bind guest PASID support")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: b0d1f8741b81 ("iommu/vt-d: Add nested translation helper function")
Fixes: 56722a4398a3 ("iommu/vt-d: Add bind guest PASID support")

--=20
Cheers,
Stephen Rothwell

--Sig_/QZtWuWWQjElsZXikxlRXNfy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7EJy8ACgkQAVBC80lX
0GyfpAf8D2Cq6o0ggkCuC3xkUXuOF2h3mbMy0b72PY/Wvls23FJGiQVRjUQ2d0Xu
Xea683UQqLvpSwgOdmIWnUVQKzp4I28o6fO9vXmYuZv9BM1d24j5yonhm8MsDnQn
Uu1gYTI20Z1hy0qmYut1X3GBCKOdQtShVCEf0Tq//LIy0DJPRgYmHsiFN9nqCKZL
0FNskQZUMY9jAqtmyzP+qx5x3bhIajK+hcyBw+e+ePGqMGSoW13zhko1/yMm8Yze
WE1qHu8CQGb9fupZnKDLQs8/CmY8I0BLRjz7GFC3WJMwtx0c40aqUKGJzNbqk0jj
S1CPjc8Kb6JyzuvC18RNmePstVmShA==
=qyWc
-----END PGP SIGNATURE-----

--Sig_/QZtWuWWQjElsZXikxlRXNfy--
