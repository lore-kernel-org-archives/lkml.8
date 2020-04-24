Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F544C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F012071C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BiMwVvkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgDXBlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725888AbgDXBlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 21:41:20 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970B1C09B042;
        Thu, 23 Apr 2020 18:41:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 497cMc3fmBz9sP7;
        Fri, 24 Apr 2020 11:41:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587692476;
        bh=8/JeDTE0FdkiHAdnZiUnJb/qjEG0rVOWIdfq4r5Dwc0=;
        h=Date:From:To:Cc:Subject:From;
        b=BiMwVvkI8LBcM3w1iimHE2FKhlnWupThzD2vvj9E2H7lV/JYabr2j9zuPhDuS6Inp
         xC5E9QJAxK1kjBN6dXSIKwjHtVsx0WdLWpfrg1BKtEsvDzkYzmykyuBrfPVXQbd2aZ
         +F8xVBSxbmBw0VPRS6ke5+milJkThSdRwC1hDD/Io4Tf/7sb88QawFOQOtyRzccSpb
         FOJej/0/VExFnhe0TM/KEeuVWYakG/LzyA1ElLkzv+Hqe4ZGzAmDMKNfHdDlB5H+eg
         ghx9wZ2wWXrJmuWeQ7DGYu5OBW5i9o8Q+PJhNROTx03x/DMnRI9kAam/b1o7kCX+fk
         ZPFlhkSUfAMBw==
Date:   Fri, 24 Apr 2020 11:41:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the exfat tree with Linus' tree
Message-ID: <20200424114109.365a9ae5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TchrO31fZWjeSqqcfhbL+BP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TchrO31fZWjeSqqcfhbL+BP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the exfat tree got conflicts in:

  fs/exfat/super.c
  fs/exfat/misc.c
  fs/exfat/exfat_fs.h

Various patches in the exfat tree have been added to Linus' tree overnight
as different commits (an in some cases slightly different patches.
Please rebase the exfat tree on top of commit

  81df1ad40644 ("exfat: truncate atimes to 2s granularity")

from Linus' tree (or do a backmerge of that commit).

--=20
Cheers,
Stephen Rothwell

--Sig_/TchrO31fZWjeSqqcfhbL+BP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6iQ7UACgkQAVBC80lX
0GzB6gf/UTuGY4aMYaWeBIyrsMnB+JjyVQwac/+Q1kmhE/UqbIcNmfVg8FxT3GQ7
m20OJwYZpVTth1y7VMdvcT0HGrIoPFBMDAkp68Pj3LjpKayQ4+vsgazXQ35NszdI
ft/GcmUXK4QfrCZII+3kl/qkxD6Z1/VZvWhLVNCvpJLgolPtBT4GJHRTswXutyov
sPJSm4Z7xn1fyEvwnmibg9UuFw1rWwvNVaJKvQdH2z3oZxZDJDyLFE9lsXpEjUlh
MPki6uMyYzO9lxyTjmhlbUUUaSX7r0hUnmzfFhCbr+dFkbQhb5jWEHXEp1BmePtO
BPnqG8yF7d5AKqWQc6trmmxE5IraiA==
=D+ns
-----END PGP SIGNATURE-----

--Sig_/TchrO31fZWjeSqqcfhbL+BP--
