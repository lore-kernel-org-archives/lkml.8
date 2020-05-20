Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3E2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9820F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SJdjEkS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgETV7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:59:54 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43567 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbgETV7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:59:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49S69f0563z9sTN;
        Thu, 21 May 2020 07:59:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590011991;
        bh=9C6FrJ77beTpNxWh+pD6MyfUV83fIBDXa4d8Y0TzOSM=;
        h=Date:From:To:Cc:Subject:From;
        b=SJdjEkS8jmUSJNvTL2/OgiIK1vFpPkNTyafthYft2xoB9en3dZURUoXdwLpzoYXtz
         h8AuZykvsQQRYh9l2SILQhUmjmi5jt+dJTi7GUUJPaylmPA2orAFhM8yw6/RoVMGQ6
         7eO5S1fQzrAG06c10NdCjySS0KCa7sTG73hZHOHdPprnMegcKZMoo3+SCKwzW00dMN
         2vgxs5fexrQ0x+WaCGxi0sS0ek/LKkzdFqcEZsz2gwRwpAJCJuCcO+rnUtGWHyTDMM
         YeXrm1fJ60Bdb9eOOa25t+1gjNW7TvwSk6ibuG0KK/e1wdTWZyjpEhvF6vHltW9pwi
         KYmmIHrPyjMQw==
Date:   Thu, 21 May 2020 07:59:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: linux-next: Fixes tags needs some work in the tip tree
Message-ID: <20200521075949.6db68c4a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/brJGB.HyXKGJi3d5CyS7j6P";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/brJGB.HyXKGJi3d5CyS7j6P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  39f23ce07b93 ("sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list")

Fixes tag

  Fixes: fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

In commit

  b34cb07dde7c ("sched/fair: Fix enqueue_task_fair() warning some more")

Fixes tag

  Fixes: fe61468b2cb ("sched/fair: Fix enqueue_task_fair warning")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/brJGB.HyXKGJi3d5CyS7j6P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7FqFUACgkQAVBC80lX
0GzARQf/SI6L16TURENQFR2YyrVsoAzQhqRQENLRo7GxNnQ6jku/l/i1LI83tIc+
UNACByZhdFoWxDO4ili44MDzWCbphEgnoYhUpXFQn7Q4ZQxemHAFBCcZs4LkPShV
lFFpILeYMe+B4EaF3a+qUDMRui7FD3ptdLslmGNPgSyKC8pAJJpm1cEMvlVVkiH9
wkLWFbgzjO+cHtj9net6dtcNPcQD2nDZju5LUwPDutt4HzglWobyY4Vr6qfA0Ir+
vUSrq2Z94r6BbKfZq0+1eMPIr+saP0/xBpTSC5sNHTLRwQzDMGAM2aFQaHbQ9daa
hia8MHohaU/3KfOuANTKowjL5mR9UQ==
=E8PV
-----END PGP SIGNATURE-----

--Sig_/brJGB.HyXKGJi3d5CyS7j6P--
