Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818E9C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 03:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F55208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 03:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="n0/oe4aL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgEADpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 23:45:46 -0400
Received: from ozlabs.org ([203.11.71.1]:47965 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgEADpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 23:45:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Cynx66VLz9sTP;
        Fri,  1 May 2020 13:45:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588304743;
        bh=IIPHFxBcj85QE/JOewCEDMMpIUUBvRoR4Qgg9tLU9ys=;
        h=Date:From:To:Cc:Subject:From;
        b=n0/oe4aLBYnd0kU17bBSG/shak8TUpLVzsim9vQzP+Gx6ztXNam/bKTtuzxrV2HKK
         6FA3u1j+IakNj6a12gt+Mg+FxHtVQS4R+E2T1jxmBQekSIxjjlDzgGqA+j0/V8HSBH
         oojpNbn3pBGkCEdKE7/Nvnsz4on5WkFq9tc7gLtN52be19NfkQo2Wi4/nHLOAwuomM
         timJod54omTDV+/j3fwqTGyz4pZH/JhymbHHakAwGuOi1WN1U6UMVZ/1I7scs/9ILe
         XlHr1A4hVMaWf664Xia/8BTt5BSV0WoTxBGeLi7thqKVGpZ5jWgLVqRzQy45/HFCdG
         X0IxSalQRXIsA==
Date:   Fri, 1 May 2020 13:45:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes
 tree
Message-ID: <20200501134536.12468fa1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rd9/1PLkDNX6mHZWGfNHp2o";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rd9/1PLkDNX6mHZWGfNHp2o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  include/linux/dma-buf.h

between commit:

  6f49c2515e22 ("dma-buf: fix documentation build warnings")

from the drm-misc-fixes tree and commit:

  09606b5446c2 ("dma-buf: add peer2peer flag")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/dma-buf.h
index 57bcef6f988a,82e0a4a64601..000000000000
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@@ -333,8 -334,16 +333,16 @@@ struct dma_buf=20
   * Attachment operations implemented by the importer.
   */
  struct dma_buf_attach_ops {
+ 	/**
+ 	 * @allow_peer2peer:
+ 	 *
+ 	 * If this is set to true the importer must be able to handle peer
+ 	 * resources without struct pages.
+ 	 */
+ 	bool allow_peer2peer;
+=20
  	/**
 -	 * @move_notify
 +	 * @move_notify: [optional] notification that the DMA-buf is moving
  	 *
  	 * If this callback is provided the framework can avoid pinning the
  	 * backing store while mappings exists.

--Sig_/rd9/1PLkDNX6mHZWGfNHp2o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6rm2AACgkQAVBC80lX
0GxJBwf/coOFFEbY8Z/MwYFICaThvtaMgyS97f1WpYa3Pnj8wCQ7CGfTVQVwKa77
CNkg/096iwIc/eJVgNbODY+XKh28Q92IA4jVwkJ+rTiFkhcb/JI7A4m4Nvhkrx9X
RihPQ0BTkoT+oJBUWvzpOoi8lmrHQaxCPmRspjPqk7/7DPFZbRftHGATzziZXHDG
4Jx+MaFlZj+tygXiJMQoSESiuxRvpPNkG1bBrufr3/4dZ5U/ZcSQPrCfmN288oCV
pYo3IvWoJLHB4Xd7NTrxgNJYjnCe4Pz+XXSZUji9g0p+jqQU27firEzT2Ot4XDif
xYpWwAaOARGTWWEUv9uTctLrWv3/cA==
=84tC
-----END PGP SIGNATURE-----

--Sig_/rd9/1PLkDNX6mHZWGfNHp2o--
