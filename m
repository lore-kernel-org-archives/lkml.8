Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B869C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC70206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LRYP5s/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgELAcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 20:32:54 -0400
Received: from ozlabs.org ([203.11.71.1]:47289 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgELAcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:32:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Lf0N3XMjz9sPF;
        Tue, 12 May 2020 10:32:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1589243572;
        bh=CfIzPuOiXbybOvfSqceGWMDoLXl65+ov+p4Y8Cw6fJ0=;
        h=Date:From:To:Cc:Subject:From;
        b=LRYP5s/2oaJ6Khbqcgfc7zh8mE9iubbMH6Qa/q3NFIN6EdviAvZV9qnGE3qMZcDBz
         1Qd0mJWgLVu2+xoK7lrO1WrxTK3gxqdjMoxaza/9epQktlqGQJ7dQFUD3Lmr5nAHSQ
         sbnaua/xDlG5BfOubYWjo+SxZHECpISeiUoruLnj6PgIAIqQ7yS/AWqz+ZFkTs5bmL
         Yvm3D3Gi0NCcpHMMwZ6RK9qGME6VL8oklpr/GIFD3KbgAhgkrNgVC7XoD7IlzgO3w2
         6aaP/7ppoBw6QB/3kmnMuPL57rqMp6+YaVOnfNHZ6Geic43HGVcKzv/XjAld3PKBdo
         61LrXzQq1V+eA==
Date:   Tue, 12 May 2020 10:32:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the fsinfo tree
Message-ID: <20200512103245.4ae66dce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VZz.h2chlpVPZl3LgM/gF23";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VZz.h2chlpVPZl3LgM/gF23
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  ee8ad8190cb1 ("vfs, fsinfo: Add an RCU safe per-ns mount list")
  a627d57b0248 ("fsinfo: Add an attribute that lists all the visible mounts=
 in a namespace")

are missing a Signed-off-by from their author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/VZz.h2chlpVPZl3LgM/gF23
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl657q0ACgkQAVBC80lX
0GzlSAf7BEdVmK+UaDuQw/Ou/vQVPzmgNFiTOj/RpNlEMEVBEqklC8Jo+JQ9kMQI
v6KHKeXMPQdSqbPNAoxJW4ILNxw0qynrFwrGIV/I3WV+LCv27iYdb6klQsay6Oj5
bKFxjnof7gUuPwXWckp4WuYWt1402whpB3UMkp1twZq25Ln7ZhhyIAGW05jLk+sM
RjV5qhDDAINuSmA21wilTRU3ymdhABQoLSOOZUx+59JtQjLhV/lvJSm/MSWvB7Ih
Ud/lqw5KI12+8FqRzRRqpyf9uZoNYYNHkuGUQ02UX31IGfCi2fxxtcFDYfBvYFKK
uCZpInfY2WqdcrYM5l7WwUrFJ66kyQ==
=YzpU
-----END PGP SIGNATURE-----

--Sig_/VZz.h2chlpVPZl3LgM/gF23--
