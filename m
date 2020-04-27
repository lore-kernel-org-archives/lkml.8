Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E993C81CFF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E07D206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IDd6i+8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgD0WbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:31:06 -0400
Received: from ozlabs.org ([203.11.71.1]:40529 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgD0WbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:31:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 499zyH209Zz9sSJ;
        Tue, 28 Apr 2020 08:31:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588026664;
        bh=Fmq+8t9RaqoJ3RMhYnZhT/UZrui38TFUaHdcDwHmSXM=;
        h=Date:From:To:Cc:Subject:From;
        b=IDd6i+8xv6sUQVUZB7/PZgG30RrejdZIUhOlVe7N/rvsb44gbbP5eQEPGNT4rV8GK
         N3qb930qW4xbJMru2+tH+qUHpnI/5Ios9s37t8ujEsR5SvvbeK/NBXNd2ACng1gkgj
         LvmN3TxT+lQLvMg/krdgrIfqze3bXH6WO8VZzoypRInFWsXbgPSmmOI8pOr9HLJJ7c
         7CVoHtT5XpvhqVnjdG5eG+6jh7sAHzJMaRzG7arkulMdqt8k1bn+Q3JLDL+uzcU2Kb
         XYlkdtzpH5yi8v3AUEYKmbKvmVmkF3HAOxInycbUCkzDq8iRJQVULRYrzY2TMv6OMS
         M2X9kUiajp9/Q==
Date:   Tue, 28 Apr 2020 08:31:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: linux-next: Signed-off-by missing for commit in the net-next tree
Message-ID: <20200428083101.5b9868a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L.aB7SFndVmGJmjjAwEBrOL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L.aB7SFndVmGJmjjAwEBrOL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  26893e7e928e ("batman-adv: Utilize prandom_u32_max for random [0, max) va=
lues")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/L.aB7SFndVmGJmjjAwEBrOL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6nXSUACgkQAVBC80lX
0Gx6gQf/WwwbJl7R+0Ioil7+8DiVO0tSe4xC3ZT83di0ATNyyu9LPTgBbacOBmV+
q8Ve5qIupUj/CwSOCjP54Xs+6DmrjQ3eVvYGchOiUy1cL0Ulk14Et9dOZAwayf0p
aOHT/+On8xnFQY1Si+kF+NmGkDQyNQyaiLqeymwcScfxxFEODB6/j/0e2h9O/+bU
h0ldcwVKfTOXvsgqIhIWctRxzbO5AWr/I8T614kGTxvuBKY6oUckfKfq3eFFm7l0
NYfzzBhTXKMYoY0eshqofnqy8XQExP9jUGZJxMHni7QTOEAYUzZZwlvaPRYOMLow
As5vCeANhBQJtjoxBiKLvU7SzbwzMQ==
=UzbV
-----END PGP SIGNATURE-----

--Sig_/L.aB7SFndVmGJmjjAwEBrOL--
