Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B5AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF772075B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rh1pVCPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgHRGL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:11:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44449 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgHRGL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:11:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BW0sm2f4Sz9sTH;
        Tue, 18 Aug 2020 16:11:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1597731084;
        bh=uA/giJ0TzTis8fgQXiophKkvkStCEFhq3/Fv5VyfCnU=;
        h=Date:From:To:Cc:Subject:From;
        b=rh1pVCPYZrQ5XQKNrDSZ/U2ZGU8jKU6X/PGdKy3GRhOHDP+yfoN5DjPQuTybp3QMJ
         uVeWDG5RUWGsCEGJNbuTFXw7p0AVzG+13WWN7pzqW3E2El6LeJl6jOTS21B6zL3mee
         h0Mozz4eOvvQbaZdNu4F80Pu11B+1bu1ZurwGcn2olYd8FcSJrfcGzmHUy1vKUB7Hu
         LcAbjGNWqyB87q3TZNmcKDEWgIoZGobmwEyk7Xz9fQqRmidHKfsnOHmqPeXrxPpAEV
         wGsx8Pn9AWh9YJHcbu3JDMz8WqDA9aLxERhUaWLJAXyVQwCE56I7WMK+TuoaPnJ8Xx
         ZYBrcClqwN9dg==
Date:   Tue, 18 Aug 2020 16:11:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Can Guo <cang@codeaurora.org>
Subject: linux-next: Fixes tag needs some work in the scsi-mkp tree
Message-ID: <20200818161121.77559bee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Xl6MU2KjIxU7XP9BQJULhYe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xl6MU2KjIxU7XP9BQJULhYe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  35afe60929ab ("scsi: ufs: Properly release resources if a task is aborted=
 successfully")

Fixes tag

  Fixes: 5a0b0cb9bee7 ("ufs: Add support for clock gating")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Did you mean

Fixes: 5a0b0cb9bee7 ("[SCSI] ufs: Add support for sending NOP OUT UPIU")

or

Fixes: 1ab27c9cf8b6 ("ufs: Add support for clock gating")

--=20
Cheers,
Stephen Rothwell

--Sig_/Xl6MU2KjIxU7XP9BQJULhYe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl87cQkACgkQAVBC80lX
0GynMAgAkSl6ASR3JRrkZO9rg03BodTPJ/k/jWAdIGaoD2Ljh6A0gHrEHjx2U5NA
/RoNFqWJ5hUnf5P0fayvcF+9SbJwplNo7U1NuyFfSDi1n0y7SvVutqOGQ3fMuDHw
ngz9QVGLeFjdg0vhh7iKNww47NTpbplMsi7bfZRJcNlKbj3qVwGOorA8ZHkjgNDl
lZxy1jR9agQwfZg2dm1yf5jrqQ9yvmzzr9ZM1C/21wTQk5xB2R23WVcuWYpMm3O7
21IpLCg2OMKRhZQUwqcUBmL2wE/vL0JBl1RVDidYJ80+9NCgsjNmHdRY6lJxZfzv
0flD3d9FpuZRCNGh6m29wixNx9S1Rg==
=qb+q
-----END PGP SIGNATURE-----

--Sig_/Xl6MU2KjIxU7XP9BQJULhYe--
