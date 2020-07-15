Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD70C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB10720657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qL45cPbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgGOVwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:52:36 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492ADC061755;
        Wed, 15 Jul 2020 14:52:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B6WML60npz9sRf;
        Thu, 16 Jul 2020 07:52:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594849951;
        bh=DWOB7BDM/uY0gB+Y02UWYOGVO58T9skDdstd4FZMYgo=;
        h=Date:From:To:Cc:Subject:From;
        b=qL45cPbB+HR0yQ2F3X0JXEG/GKcENc/z++1Wx+syKwDmwTLIv1o+N83jIFBdo6zoB
         qBFQRmB+lrcqvgrAqI3mQVRA2oSCyLzSILMTUCZ0TsRk6rfsfWWnn/N5WRLhIv2WSX
         Pa8xXFYYQkujhAsiCedfulox3q2XduWGQhHNOlwCSH7/C7Nds1a0zz6zjI8t4xh5wM
         F+NGW2mO7YraVXWdf8jaP+MALwsDOrPtrN4K07dSgV0YLY9mH8NXTCnVr/fWtjI9qw
         WMS62LT2/hsUigARt+v6fhj/wnkYFvVrUEa56szdUs2qDnElFkYFIU2dGJ2yFFPley
         HetseklUmn3JQ==
Date:   Thu, 16 Jul 2020 07:52:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        youngjun <her0gyugyu@gmail.com>
Subject: linux-next: Fixes tags need some work in the overlayfs tree
Message-ID: <20200716075229.1a31def6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/34/IiJZa8UfH7n11R367u6p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/34/IiJZa8UfH7n11R367u6p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c70cc896be1c ("ovl: fix oops in ovl_indexdir_cleanup() with nfs_export=3D=
on")

Fixes tag

  Fixes: commit c21c839b8448 ("ovl: whiteout inode sharing")

has these problem(s):

  - leading word 'commit' unexpected

In commit

  6083ba4ed54a ("ovl: inode reference leak in ovl_is_inuse true case.")

Fixes tag

  Fixes: 0be0bfd2de9d ("ovl: fix regression caused by overlapping layers..")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

There is no need to truncate the subject of the fixed commit.

Neither of these warrants rebasing the tree, just remember for next time.

--=20
Cheers,
Stephen Rothwell

--Sig_/34/IiJZa8UfH7n11R367u6p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8Pep0ACgkQAVBC80lX
0GyOPwf/fk8hT+aLTeAyyjj32BWQJ6QbZdiIQAdAlNfpjnv3dmpTQ65JgxPuS61V
rhk5ZhK+OzbRsd6Ev7FMT/LaKAKSgFctKqPGvIda+88HYFjlzZ4oSArTn3zhRmaN
nYh4N34Yewa1sqDzXsRpoDl25jN0BUYjd4/sof94Djm5BB7JfV4SffZ37ofnVzua
euYAutocyz7nnL3N+0+5wSiPTqmNhivp8MIn027qhMwB87MiO103gRNM+fBW7WGd
47bLa7vdzu4x9JsFiFCY184QjDtVwg6niqTX13PX3LSuIbkATU0ZfAjG0FFmq81a
SnNjMPclcSs99xas3R4lqFS6KC/GbQ==
=S6RE
-----END PGP SIGNATURE-----

--Sig_/34/IiJZa8UfH7n11R367u6p--
