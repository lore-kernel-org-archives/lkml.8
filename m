Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79886C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 01:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 571522070A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 01:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="r3wAAoWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgFZBne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:43:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38199 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgFZBne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 21:43:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49tKR64GvLz9sQx;
        Fri, 26 Jun 2020 11:43:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1593135812;
        bh=eQESNewGabImUpWknhGtlDqUX7u13gKZdpajK88V8Oc=;
        h=Date:From:To:Cc:Subject:From;
        b=r3wAAoWynW5ofY6RB24a7e7af76CCzxYSz/3hdzPSfdS+Q5jCfAFiBFGjsJlgihHz
         vtXiF4a8VZdVSynnc5fWgRkrpvAUQbF6xer84Uc3a5p3a2KVn8Vpv89H3jDBcqI4pp
         rl2xlVl4wHlRoEtSD1SVJ/4rhryOyBOTJKPk+RYxC06lkgYa5dBUX/64mOiPchwy3X
         qqnJPtFGkqmJ+O69ih0d5Bcu21MPl+TV9MVaal3apLrZT0r24WwkpxHKZGbQhEV+mu
         zIzVAM19iZjes9p9YijPWrb8I2q1P4r4fPCjjHawZJrbbLimnNKmNUiXzxTkxrttM7
         z6hPbmOhSb0DQ==
Date:   Fri, 26 Jun 2020 11:43:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nirmoy Das <nirmoy.aiemd@gmail.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20200626114328.71ae6193@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SQrTN=RMELoppdikG/Zdzo0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SQrTN=RMELoppdikG/Zdzo0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c

between commit:

  eaad0c3aa978 ("drm/amdgpu: rename direct to immediate for VM updates")

from the Linus' and commit:

  b1a8ef952a25 ("drm/amdgpu: move ttm bo->offset to amdgpu_bo")

from the drm-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 28bdfb3ac33d,2a7a6f62d627..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@@ -144,8 -141,8 +144,8 @@@ static void amdgpu_vm_sdma_copy_ptes(st
 =20
  	src +=3D p->num_dw_left * 4;
 =20
- 	pe +=3D amdgpu_gmc_sign_extend(bo->tbo.offset);
+ 	pe +=3D amdgpu_bo_gpu_offset_no_check(bo);
 -	trace_amdgpu_vm_copy_ptes(pe, src, count, p->direct);
 +	trace_amdgpu_vm_copy_ptes(pe, src, count, p->immediate);
 =20
  	amdgpu_vm_copy_pte(p->adev, ib, pe, src, count);
  }
@@@ -171,8 -168,8 +171,8 @@@ static void amdgpu_vm_sdma_set_ptes(str
  {
  	struct amdgpu_ib *ib =3D p->job->ibs;
 =20
- 	pe +=3D amdgpu_gmc_sign_extend(bo->tbo.offset);
+ 	pe +=3D amdgpu_bo_gpu_offset_no_check(bo);
 -	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->direct);
 +	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->immediate);
  	if (count < 3) {
  		amdgpu_vm_write_pte(p->adev, ib, pe, addr | flags,
  				    count, incr);

--Sig_/SQrTN=RMELoppdikG/Zdzo0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl71UsAACgkQAVBC80lX
0GyshQf/UnKvDsr4a32M1T4MZmRytJslGTYMmhzZWQbg6MPDHbbBQ2kgA9vE8ngN
ICbfjJLPISBHaPhUkB7M5s/vCIDfYokSkL7SSoZzTlSBxq34e6WBF38T8Z4IjOIQ
C7TmliGkh51hE1Pk4D0ylTjURIO04r0OzGFNK9Pp/W5ZLp/l1Bi3asmg5zebRFHi
eaz0ONQjJcku5m1boIATljAB6xIY0NZxm77qWDlSykZ5CwvRyK+33ETDUBbb8V/7
TgoGxfN41FObP2qKLqE3LR9PV673OGttXTtuqb6aYBF6VHIFm+U6AmZJPMGSczKT
RTpdOzrCezHI9uIMRypvP2/apR1/Ng==
=UgZP
-----END PGP SIGNATURE-----

--Sig_/SQrTN=RMELoppdikG/Zdzo0--
