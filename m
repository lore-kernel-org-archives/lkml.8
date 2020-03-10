Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4447C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E97E2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="udOKNhXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgCJJ6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:58:13 -0400
Received: from ozlabs.org ([203.11.71.1]:55609 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgCJJ6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:58:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48c9Wk4XJFz9s3x;
        Tue, 10 Mar 2020 20:58:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1583834290;
        bh=8X7d3J1ukIh3vjbI9RrtgL16s47wvAmjl1ql+quGmXQ=;
        h=Date:From:To:Cc:Subject:From;
        b=udOKNhXxjba/VMBfXdICI537rBt9htUba1FYZHAxxIwI6tNHy+eCyAFj2c0vPREQ7
         69VkNGcOM/W899cTShCEvo+rZA8d8L5sIxM5OEYhkEURfhtZLbWPAcvSfAYvvjeyt4
         0cEV14dQqkyeq7uyX8qALfkx4DGq/t/avt2RroqVM1FASwGco5ruT8xMIS+FknbkjF
         alu+ZSL7EOKsRRkNmIWyhlmk/VBFTKDeC2lc2cZuhZ1UQ//HkQyjFCUg+YU+O18v7j
         R932V0D4VlCu9+4EnUUwelFS0/CmgDNJXP5l5OUPR+Fs/IewYv1tR1BNK+jeyE+SXs
         F8Oy2+Wz38Uag==
Date:   Tue, 10 Mar 2020 20:58:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the f2fs tree
Message-ID: <20200310205809.415bd0a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/spKnK_0b=BebA+q5dFcymG_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/spKnK_0b=BebA+q5dFcymG_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  11150f0f3096 ("f2fs: fix reboot timeout crash observed with Andorid R")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/spKnK_0b=BebA+q5dFcymG_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5nZLEACgkQAVBC80lX
0GylYQf+MQYYRNIq4pr6yCg3eMU9hGNsR18R/OWuiQoKgXYUYs6zN91Q7h9aK6Qu
N1XQcL41/xOKpFi37u8A5ngEdr7FzrUYzGr8EAHMQL3Vq/6WHX77/wloolpAkSXQ
yeG001fiAc/ILlwlp0TUR9oB6wd001zs53040aUxE/LulaXT32Q9SlI+VK5B2HGn
dWL3aD26KhpAzmuWEflFgvvGRh10SuEVGTK3PHQuCs/Ww1+v+H5t80LadTc3sQ2/
K/gHlbiE/VxGwXoboZndnPcR1JjPs7SYjg2sqEYvovgr+nrtEVqZ4nAnXOQSzG5S
GbGO/IOhJYTp/mbD6+Y7/4Skq1vvoQ==
=wL76
-----END PGP SIGNATURE-----

--Sig_/spKnK_0b=BebA+q5dFcymG_--
