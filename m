Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FADC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 10:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A522074B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 10:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Nw8HPU51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbgGaKCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 06:02:55 -0400
Received: from ozlabs.org ([203.11.71.1]:45941 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732371AbgGaKCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 06:02:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BJ2s72nvnz9sRK;
        Fri, 31 Jul 2020 20:02:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596189773;
        bh=cJ7Fx+1T8KQngnkpW8UTqNH1iSl1SEwAI6erXiCWh2c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nw8HPU51CUksknfbpdLzbKZNzH1MN9mTw50gnRr/hIEoW06RAbtAyD1ykkCv5bieL
         9G9EdkoJNaYQxEHdD+YprkX2v/hLyPyGxtnuF1RJM83YyfzoNkkUhOAk+vGklFrnRK
         +Ft1yEvm+90rPCDwDzhxUEA6YOKl9fGayN32c+MOXcGTrYwPJvBvDbNkDmr/8YS4O+
         OTFt/RA1SyA+X0pStTI5tuqbs3ssZwJ0lPImyBgAr58/wlOG+SRdHhOOdl709k4fA2
         ugB6uReezf+xPpyDED+9w4EKY73qA+nneGXV1gIdHh6VqkFQuPIAJJtGOIX1Qm3cjR
         ujtTrNLT+FY4Q==
Date:   Fri, 31 Jul 2020 20:02:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20200731200250.10150100@canb.auug.org.au>
In-Reply-To: <20200731095735.GB15126@gmail.com>
References: <20200731155304.06c67b0c@canb.auug.org.au>
        <20200731095735.GB15126@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gj8XUanrCFZDAmq6x=kGhVz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gj8XUanrCFZDAmq6x=kGhVz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Fri, 31 Jul 2020 11:57:35 +0200 Ingo Molnar <mingo@kernel.org> wrote:
>
> I've merged Linus's latest into tip:locking/core, keeping the simpler=20
> solution of a6342915881a and reducing the dependency hell.
>=20
> Will push it all out hopefully later today (unrelated changes need=20
> more testing), from that point on there should be no conflict in=20
> -next.
>=20
> My plan would be to send that resolution to Linus, under the=20
> assumption that a6342915881a is superior to the upstream aa54ea903abb=20
> solution.

Sounds good to me, thanks.

(though, no rush on my account as I won't do another linux-next until
Monday)
--=20
Cheers,
Stephen Rothwell

--Sig_/gj8XUanrCFZDAmq6x=kGhVz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8j7EoACgkQAVBC80lX
0GzogwgAn/L0BwVfEWiCcOfzsDzk/bvcjPWvKo7EfK2hMb1lqUSaVXgW0DluqS2r
+5/5OrGdGXW/bXoQUSEUsQiIXsmiKDWy5OFS3H0PQ/sqxm0iPLQAvKjTImndJFRo
mAezo00EfKLgJ/G1RZuaKe2/MayXJasU7HV7+I9nOJ4Y7N7+kxcBKgSFhQiaisHr
G5XmxYGYtk6HU1uWcUh77Aw8KyFXduZcJA+x1VGGfCXp6ArY2hDkUn4wo3RZdlfM
nsH8pqIvCsho00tMNJLEO+P+fK4e+DSFiDvBjgxRtKIYOIyGPIUPtcCOZCFCjVe5
Ebsbn1nPovzNKIB2wBTXT0WlEt+kvQ==
=tepQ
-----END PGP SIGNATURE-----

--Sig_/gj8XUanrCFZDAmq6x=kGhVz--
