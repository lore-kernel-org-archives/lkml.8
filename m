Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B144C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09034206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iR57JTc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgGGCdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:33:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47809 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgGGCdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 22:33:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B16196QnSz9sRK;
        Tue,  7 Jul 2020 12:33:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594089182;
        bh=kBgI8HNkyEaoGhzJtSBMsGN3tKiNPD8PuFGOCpABeWc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iR57JTc9U4FwVTG2eqIigA1Cgv9WOVYZtBZwBzPhNtF77cPvGmYgiQqrxAVT4mvhq
         2lFD8FFCfUvTiG6CvARvepgPX9PtjW7cE+00z1wnzDBaFCWYp5XKkoy5/ELMlfCj0u
         WAmNOEfaQEb8wKWU83Lfi4mDdXv3yXvVAR11wf/Mmz+sPP0fV+ZBUhDxRRIBiMCiBx
         AEyh7ZXbhOrQd25pD321QcS5bNWFGmc7baJmgoavEPFaeORfiOHKZMxFAYf26xp+za
         jjFzUzIENGw5pvvr7Vdod+laK8D+ehqmQa9QErOvNr1OyjIUTBvFBi+ggxsWPi8rUt
         wznx/098njUlA==
Date:   Tue, 7 Jul 2020 12:33:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20200707123301.79ca8a94@canb.auug.org.au>
In-Reply-To: <20200630125459.0ca67c38@canb.auug.org.au>
References: <20200622113700.3dd74527@canb.auug.org.au>
        <20200630125459.0ca67c38@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S9BC0YV_=F5t9ofv3kONcI4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S9BC0YV_=F5t9ofv3kONcI4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 30 Jun 2020 12:54:59 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 22 Jun 2020 11:37:00 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > After merging the tip tree, today's linux-next build (x86_64 allmodconf=
ig)
> > failed like this:
> >=20
> > ERROR: modpost: "sched_setscheduler" [kernel/trace/ring_buffer_benchmar=
k.ko] undefined!
> >=20
> > Caused by commit
> >=20
> >   616d91b68cd5 ("sched: Remove sched_setscheduler*() EXPORTs")
> >=20
> > Missed one :-)
> >=20
> > I have reverted that commit for today. =20
>=20
> I am still reverting that commit.

Ditto ...

--=20
Cheers,
Stephen Rothwell

--Sig_/S9BC0YV_=F5t9ofv3kONcI4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8D3t0ACgkQAVBC80lX
0Gw0gAgAh6yoQOwX+Bs5XBBbTuUGJy7bN2esYVysFEbsKKXluWKM7a78sLdzAae2
57jQRDpghDg1EaA8ShYGFiAmWD4yq0BLZEx1+Cr4jEa13NehXP3+gmblmQ+bpOt1
nIOahh6FOwAX+NOt9Ijv+F0wDIV1zwLpNrUZuyCxDFqzA+8XhQ3iAzfctz/b8+KI
HPDvpfnnq90tfvERytlmAFuIGTmXu/RUeYo0WqTKGpLuW1g1m/KrMQ+JWIO6TUgx
tovMq90ZahXmWsMT18T1pgZT4BT7NrQcPwlu0qsShYsy6ccL6l5l3QVkA0B6t/GG
+2PB8Z+/6A7Cky7G5ouNAA46qQI1nw==
=+th2
-----END PGP SIGNATURE-----

--Sig_/S9BC0YV_=F5t9ofv3kONcI4--
