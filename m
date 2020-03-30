Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30800C2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057AE20675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uKub5kxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgC3Crx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:47:53 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60025 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgC3Crx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:47:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48rH1w57kRz9sP7;
        Mon, 30 Mar 2020 13:47:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585536471;
        bh=TpOtppbvh+jJ2NBvS6oKrocdp2Nf+tIqBhNtWvXHShk=;
        h=Date:From:To:Cc:Subject:From;
        b=uKub5kxICoX7nJM5GS/o+6ko+VIoGaIjknT1Dyo8qxMhayvg8z5itOjoIKfixxqIy
         HtQJRKDJcq98x/AmuFmHrIvpy+zq1rKH+RWuvwfSU4NHQanv9gckgaxzO5+ntPzYwm
         CZ4UrqYKLBeOEe0MeXWAgdiZajZCm/D+VUjHAzk/Wi/4PHQXrW2lGSW7yqGtt9qG4t
         qjJUoLQyCWmdK+ohZ6VclXX5xvFSy6kAaHibjca1/g9sJtK2GqclVMIuNwpug2q0JW
         nOWZHeojOX3JsWNmCdDm0i3fRa/07/kOLo7PVoy8wM2hO7XM/pXPZ+joYL1q1RPFTE
         vh6skdQblrRYw==
Date:   Mon, 30 Mar 2020 13:47:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: linux-next: build warning after merge of the tip tree
Message-ID: <20200330134746.627dcd93@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sIw9aPF8nvbDOH+4m/ixmWo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sIw9aPF8nvbDOH+4m/ixmWo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

kernel/futex.c: In function 'do_futex':
kernel/futex.c:1676:17: warning: 'oldval' may be used uninitialized in this=
 function [-Wmaybe-uninitialized]
 1676 |   return oldval =3D=3D cmparg;
      |          ~~~~~~~^~~~~~~~~
kernel/futex.c:1652:6: note: 'oldval' was declared here
 1652 |  int oldval, ret;
      |      ^~~~~~

Introduced by commit

  a08971e9488d ("futex: arch_futex_atomic_op_inuser() calling conventions c=
hange")

but I don't see how it makes this difference :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/sIw9aPF8nvbDOH+4m/ixmWo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6BXdIACgkQAVBC80lX
0Gze+Qf9F3jIksLj9UXDmiG0zldeWFHHplCXapObvVeul2IgnB6/xpaqMxWti6Bv
l+to6I0eKop0gNJ2PiNxIC1v6rXElOWreh4xmmxMx1VUTunr7weqaWqBvQx7ytDq
l3nIrnq4BE4tTYLdch6UsCRmzo2damqh3W4XBJJkosN6ZTsKHW1l6Qz32P4ihfuB
Dwvg65srVGN4b8wuTocqoRWn6ebkuU0E8Az1A7F5HAPtjaMTbRLQaHL+6zIHXi6L
aPbb5QF9px7VpJan3AHYOcnCQPtGaDCk4U0ml1Rl2eigRhiU5HjrUYSgTCl+MNvN
dyvk4lWnwuo0DSAbEpP2VWn6iT9msQ==
=n4Yi
-----END PGP SIGNATURE-----

--Sig_/sIw9aPF8nvbDOH+4m/ixmWo--
