Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1390FC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0DB20727
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ph2wxm08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgCKOSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:18:17 -0400
Received: from ozlabs.org ([203.11.71.1]:53959 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729559AbgCKOSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:18:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48cvFG60Tbz9sPF;
        Thu, 12 Mar 2020 01:18:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1583936294;
        bh=7/Zpw+iQg6yYYoyvhDYNahBVanAKxjeXCSO/xB7KURM=;
        h=Date:From:To:Cc:Subject:From;
        b=ph2wxm08Vgrk1cRuxoio2XPs0veC+rrubQUK14mHY30HB4td3+9+MTjwMfTdJz8WM
         9zMTQ+dz9w0LIB3hUU3A8jsaSOLXAMdik+JkWxLUqUVsiW3fG6CdgeJxFwOdfHc/JY
         LaKgFbVSw4BUHRFyKZehG7nXBqfUNr7MlAT7Q2I7bhQkH0N7ZKGeFNdAnjVrFI2vCA
         s8LFm+42y+zm9fugHyaCt1uE/pENvERVNuZ7X1ldsec6YCAOOA5cI6DVwmXwtDE068
         0WaxAeGEwe4a6W4Q/YoC49CIres7OLz6aBzWutX4ycUIcAyzrDBZ3MGISgcjmJc6qA
         ntzz4kxwevlQg==
Date:   Thu, 12 Mar 2020 01:18:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Subject: linux-next: Signed-off-by missing for commit in the file-locks tree
Message-ID: <20200312011809.408fd045@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q8Qt0lCox7tKsfSN0bsFcmc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q8Qt0lCox7tKsfSN0bsFcmc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  e2de130a568c ("locks: reintroduce locks_delete_lock shortcut")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/q8Qt0lCox7tKsfSN0bsFcmc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5o8yEACgkQAVBC80lX
0Gx93Af9GDGS5lFo2SBj9y+p7l7uPx8fKx0o4iECB1GxWVGnY2wNXkXjiIJIO2ih
moMtlkqIiqk9260fxNlxLuf79zkf4yrLBIyJMCifH8mooJ0tm7UL5dGRnZ8jFHi8
1mkzSva/3W5kpu8r4E+RpWsxOnhvWoBPTRH2n2oGBA1IH/1vYHCNu+Q9y/OHKIMG
3pHBX68lIVxugpEouZ1PUDXPB84tnDIJihgfkzm3pSjD3tfV60zvEsYsbt25wYoe
x5XHxnocnZQ2FOvWGRnJCTNAXTy//NTqMkpX0XL3QS3uwzqyoLpkDxfDActa8+32
mS5SbKll+a2BTltmWhPlxOi4THmDlg==
=uqnI
-----END PGP SIGNATURE-----

--Sig_/q8Qt0lCox7tKsfSN0bsFcmc--
