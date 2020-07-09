Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEB9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54842206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AkMK/z63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgGIH55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgGIH55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:57:57 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5B6C061A0B;
        Thu,  9 Jul 2020 00:57:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B2T741Vpfz9sRR;
        Thu,  9 Jul 2020 17:57:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594281473;
        bh=kOvYc2LeXb9BZAgB32ZKJVYF6rg6jt4+jFAyTi3BIQQ=;
        h=Date:From:To:Cc:Subject:From;
        b=AkMK/z633ans5oWh7KZzlTuK22qgvOduC6a/OPyOnVZAem1SY2LIgBn6cw5cN4ERB
         K7Xy2uNwd8pGw2Kln/owT1nUibeA0jsYCBRTUYEbmcu8bArLwfwYo2e/qOaiz0kyI6
         L+9FZqMwHigWbi0aYqnQAVMI05bHXMyIJnnsvyzDBq5JDGUxG4rA5OURn9fpaE6Aom
         1PMpKmY7vk6AAiMOqWMZ3G2ocsv7TxdFEoeRF7+UleRoBw+Sx7GSf/ULbHH/RPVd9E
         Z5myjEqwqzAKVmRNX3pmvJGe70NfJhFiLM9Kaw3ZRp4UPUWiZ6w4ZnMaSiV1tez4/j
         0iekmppakgEAg==
Date:   Thu, 9 Jul 2020 17:57:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: linux-next: manual merge of the akpm-current tree with the userns
 tree
Message-ID: <20200709175751.7adc70b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L//Og=ab1.FTuOJW8uku_PQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L//Og=ab1.FTuOJW8uku_PQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  fs/exec.c

between commit:

  25cf336de51b ("exec: Remove do_execve_file")

from the userns tree and commit:

  538d50d50815 ("umh: fix refcount underflow in fork_usermode_blob().")

from the akpm-current tree.

I fixed it up (I effectively dropped the akpm-current tree patch since
the former commit means that "file" is no longer passed the affected
function) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/L//Og=ab1.FTuOJW8uku_PQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8Gzf8ACgkQAVBC80lX
0Gz+/wf7BI1bJe53UmhesGd1EFMOxchvxcsjDU4Q8YcIhYlxJqWWcHSGZWKiTdIV
mDtk82SiyZtbjWXQQZcHVhL/PCsQsnOCb7WOEMxUNGEx1ZIconN/u29CLW0Udotk
DmZ0fAKFGJqkc+JEqX3eVLiBTJuvhsOl99aWm6fQYms/rGrAcuwa+lCc2/pRQvPY
YKkR2tcAGC6McQzKXJwf+ZEYElKxILHvhxFiiZRA61wNIqFbcK1r0P1JGAQWodxh
/AhBnuVAAAkvkiPEnp4SKzI5kTgLjG06vNIv0uvSYwY3GsgjDhFHn8VEHr1uqYu/
nCWH1q1c1lG1Yjmr5ZWu+KZWKbT27A==
=uPH8
-----END PGP SIGNATURE-----

--Sig_/L//Og=ab1.FTuOJW8uku_PQ--
