Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3078BC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CD22051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CRCojlnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgCPCov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:44:51 -0400
Received: from ozlabs.org ([203.11.71.1]:45863 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbgCPCou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:44:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48ggcv3gWSz9sQt;
        Mon, 16 Mar 2020 13:44:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1584326688;
        bh=r2yy0AcpeEUNNS7rHmuG3ftnuWMz+KvixUCl+V0bheM=;
        h=Date:From:To:Cc:Subject:From;
        b=CRCojlnqV/BvW/eP2xJDepvU7K+22BqRB0mIGcRba2nhcWcSx/eaL4DC1xL6CnRC2
         dveoklX++0AcCZ1EQ6BPmrRHXyeB/I8UnFamDCHLUoCd/dZrLL6JtslK7BfP5WC9I4
         udTahwzrAHzt/P5+VLixkYoIuF6WBQR+GDIeM1ARNjkUjBmzrUD77h0/+DFRKSaNiQ
         mfmKRjGiIFuUqkMFzxSCcWXQQjg9yl2o+xHPkYY8m9XY9rRTmMaKljNTJy97zSLTda
         TEKtf22Ydb4sB6SZIIw4Pxr1QNs7l7hpTuGWex4ZpNdJBPa0XHjGsOBnsm/4d285ne
         /+3xgqKuZLEIg==
Date:   Mon, 16 Mar 2020 13:44:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Colin Cross <ccross@android.com>,
        Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: linux-next: manual merge of the usb tree with the tegra tree
Message-ID: <20200316134445.343e7c97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rf7oPnAFWl+rnUKbWd7sNpx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rf7oPnAFWl+rnUKbWd7sNpx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got conflicts in:

  drivers/usb/gadget/udc/tegra-xudc.c

between commit:

  041960cf6937 ("usb: gadget: tegra-xudc: Remove usb-role-switch support")

from the tegra tree and commit:

  bce3052f0c16 ("usb: roles: Provide the switch drivers handle to the switc=
h in the API")

from the usb tree.

I fixed it up (I basically used the tegra tree version) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/rf7oPnAFWl+rnUKbWd7sNpx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5u6B0ACgkQAVBC80lX
0Gzz7wf/cT6VWvdwPoY2k6IemoYPNQGEnzWhgT65BtXUVG4s5LTVAT+cAHH8aRTk
F7Tn3hHSxds9jtLjbIhL5Fuv5qlSeVT1KXi+sWGVzrAuL/XNy8Xou5ue10qPU+Qt
CZfc7arq3b+1kpSVVHVKqcYQQxzLXYtHvcETHfQej1S1zUrE83Hr9Ut7YnA52dAs
qn1bmdoeRX4q9sgvhbMUxCllgi8F8JjgIKyA+laCcr61/UeXBRNl/43d2Q7mKMF1
JeTu2wCMVzXaZFEqcqhI7CkCS3gkbdOORV64r9P5ro1l1HKGQyN1cPQy5/npbZu1
mDERkaRH3dIpIqp4Drbx3oq46BcvFQ==
=Qu3/
-----END PGP SIGNATURE-----

--Sig_/rf7oPnAFWl+rnUKbWd7sNpx--
