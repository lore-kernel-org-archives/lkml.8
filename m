Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF75C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 23:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A92782063A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 23:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pXYU5SOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgEHXpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 19:45:21 -0400
Received: from ozlabs.org ([203.11.71.1]:58347 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgEHXpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 19:45:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Jn4s4LCzz9sRf;
        Sat,  9 May 2020 09:45:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588981518;
        bh=2WQDracut3zz1bq++kSErjF7oN+Ntk+RcYSiiBCiIQ4=;
        h=Date:From:To:Cc:Subject:From;
        b=pXYU5SOf5gKaD8OtwYkGI5tOken/Qkc7ZyCTKN77YNff8cQNoQXNpXLf4F2+7FGCN
         NdbH216oSRBWWnx+EhSgElJxZKBN3rnla37oOuvTGHXumvlqKjvKQu7wO6aFB8cBRu
         8l/BvLU2YTkUQ/FIrkukPH2wVEDTbYu9O3+BgWlkjWJfrvuLiFfn/9Enay7FhRMzZN
         xn/M9fFPIbOQKUKKCJHgPTw6QZ8LYuUpmH7wZ1sH19ZgcwpXz3tKZssDodiNhCKSme
         LstdRB2rzDoDOj/tFDX4DvJ2AcKDrGBjV8XYauE71uJquQXgbfDoLQqFoZnvpwItj8
         +XSkEG/lrl35g==
Date:   Sat, 9 May 2020 09:45:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sage Weil <sage@newdream.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: linux-next: new contact(s) for the ceph tree?
Message-ID: <20200509094515.7082eb92@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QrGhtZScms+ql_amXLes32e";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QrGhtZScms+ql_amXLes32e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

I noticed commit

  3a5ccecd9af7 ("MAINTAINERS: remove myself as ceph co-maintainer")

appear recently.  So who should I now list as the contact(s) for the
ceph tree?

--=20
Cheers,
Stephen Rothwell

--Sig_/QrGhtZScms+ql_amXLes32e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl617wsACgkQAVBC80lX
0GwE0QgAifvK+HJPBq+Eb3B63fj8y7MRZYxKw9Rc5I23M8/Yf4QhWbei2WMOqB/L
e2i/IQvqRnGcjO0Ibbiem9qzT/KSLhtQC1S+FcOCrqWTz+yS3mrzlf0zzCKhOaWh
IeN1UOfJ+qQ4PvtXPBwnPeroag54o61Z9BEBX7ASeUdl4ddvE7u9V79VqDPUEvXe
phKdwcBANp53UicKR7nv8lTMRnn/b1c+o5MvjuiTIwtydxDAVvadf0iXkkh4fvaj
62dPCG9DL7B4Tvz9MJsmuJVyZhiXz6KfTdA/d9AXqSL3cPeFZMEKxVOo4mbsVwgU
ohBY/h72mb9ozZZ8OtFBMMRf++2uHw==
=TNFg
-----END PGP SIGNATURE-----

--Sig_/QrGhtZScms+ql_amXLes32e--
