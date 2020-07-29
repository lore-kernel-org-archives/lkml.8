Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4DFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CD92082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Djc/rBMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgG2Vze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Vzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:55:33 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2646BC061794;
        Wed, 29 Jul 2020 14:55:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BH6mL5mgbz9sRN;
        Thu, 30 Jul 2020 07:55:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596059731;
        bh=feb3M2Tk7QoN+CzEDFxCJPGadKxz1RoZ7BeKRMA8ws0=;
        h=Date:From:To:Cc:Subject:From;
        b=Djc/rBMjXX06vHBQ6rISKwYiBCTgzF7w6G7b7UcN8xfz2tv5rcu7JTBlTAoQNcTLm
         eUkTv3nFcSig2ivGJ7SNl7tefJzb8gOejqKTSHJyDKDj1jDM5aR/UfXfM7WDdcg2IV
         McLqLa/k7I7MKC9J61qh6jXDgm5Py92ivciH0R5zfoKkzCj11BsPYeT5YRSOEivRL6
         +9ZSHHly3y+yiwSWLrXatiipqjfLI8wyShqDCURY6xEWqA0LarSvyEQ48syImKK1GK
         Sq3u37Ba9ekKUU38k/RuUofMF0AHopRnx+eub1MX6Xo6oLsfdwfdqo8C7jGhwmDSJ0
         jtL4cVjjI/42A==
Date:   Thu, 30 Jul 2020 07:55:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: linux-next: Fixes tag needs some work in the powerpc tree
Message-ID: <20200730075530.02c7eb5f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ftLvL+EvRwAOYve/warG=5m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ftLvL+EvRwAOYve/warG=5m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  443359aebce0 ("powerpc/perf: Fix MMCRA_BHRB_DISABLE define for binutils <=
 2.28")

Fixes tag

  Fixes: 9908c826d5ed ("Add Power10 PMU feature to DT CPU features")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Just a hint for the future.

--=20
Cheers,
Stephen Rothwell

--Sig_/ftLvL+EvRwAOYve/warG=5m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8h8FIACgkQAVBC80lX
0Gykmgf8Dx0n7wa4xu6xO0gRMPjJuLp/+yab4jJ+BjqOQ/nY1RXB2jXEqOjon6Gw
3+C0L4ZwCnPlLmkoc5eGa2mauYfqqn9xvB5LwdtG9wt2weymCgNmPeRQ5zmNeupQ
9kuavgmrBK48SVxuMapq6goBse7azECS6LBAexuvKjye3FKS6njxIZh/Msb0cPLS
mQtH6FikGwkNRNeWOlMHWTSRJSk0DUKZD9H/AHhjolcXV0aGw2Qskx+5+FV4vrt2
9CUg1I4FprDueCDJUV0tBTZGDPaewDXUJ1sYDFvp/ZSjFBrgZvI/HfDDvOXaXVQH
QscrAe9TkG0mXDbnVUe9D3iSqAA9Hw==
=g8tK
-----END PGP SIGNATURE-----

--Sig_/ftLvL+EvRwAOYve/warG=5m--
