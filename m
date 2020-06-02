Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D476C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B64B206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tykouUWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgFBFAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgFBFAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:00:42 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D52C061A0E;
        Mon,  1 Jun 2020 22:00:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49bfxh5c8Pz9sSc;
        Tue,  2 Jun 2020 15:00:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591074041;
        bh=kLo8D05nwjnkeeDgzqHh8FHUQMdvTn0azD2tCjFkAxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tykouUWwxeeeXmYSea5wtQPX4Zrdymi7sBY5ptulqrLH0IzO11ZUKx7Dxmj7buT7k
         HjkpOLr8XKhbvbbTxvKoZHAW6PzHnX1L1RT0CdCqpxWMf+YR6SlHXrfqxn+vnWGlx0
         1nqCWA2nK66vgW7B6kh1833hmOzbu9VNJos5TeEcrDGYe1rUyhtU8FQYClNofmonAT
         tmdVSJqoUh7p8DJhxu0jtwljqaNk70lgbdhrcDM1PKkqvyBZBqHVR7pXGx01BaZfeb
         6WifNbgMx9MsGKdQ/2RMNIchbMcBC9rj5djdl2gN7jcOJIkagrz/lmnwn9i/CrDEnp
         glNxF4o+Ui8Ag==
Date:   Tue, 2 Jun 2020 15:00:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rich Felker <dalias@libc.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: linux-sh for-next reactivation
Message-ID: <20200602150039.780a0ac0@canb.auug.org.au>
In-Reply-To: <20200602031123.GA1079@brightrain.aerifal.cx>
References: <20200602031123.GA1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gsE_2=m7QKGJH_vSBhfk+y.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gsE_2=m7QKGJH_vSBhfk+y.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rich,

On Mon, 1 Jun 2020 23:11:39 -0400 Rich Felker <dalias@libc.org> wrote:
>
> Could you reactivate linux-next pull from my arch/sh for-next branch?
> It's where it was before, at:
>=20
>     git://git.libc.org/linux-sh for-next
>=20
> and has newly accepted patches ready.

I already have an SH tree from
git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git#sh-next .  Should
I do anything with that one?

It currently contains:

$ git log --oneline origin/master..sh/sh-next=20
a193018e5290 (sh/sh-next) sh: add missing EXPORT_SYMBOL() for __delay
1d5fd6c33b04 sh: add missing DECLARE_EXPORT() for __ashiftrt_r4_xx
d70f1e3d5dbd Merge remote-tracking branch 'origin/master' into sh-next
baf58858e8b6 sh: prefer __section from compiler_attributes.h
8619b5a9035a sh: Drop -Werror from kernel Makefile
3a3a78124693 sh: kernel: disassemble: Mark expected switch fall-throughs
fb8f77490f55 sh: kernel: hw_breakpoint: Fix missing break in switch stateme=
nt
cd10afbc932d sh: remove unneeded uapi asm-generic wrappers
cbfc6edb6a4a sh: use __builtin_constant_p() directly instead of IS_IMMEDIAT=
E()

--=20
Cheers,
Stephen Rothwell

--Sig_/gsE_2=m7QKGJH_vSBhfk+y.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7V3PcACgkQAVBC80lX
0GyoGAf+PUHFAeyT0a8axcC/6t3R6JTTGr4Dx8bRfuVNwMviPCLt9STH6rNfTuCc
12si3wDrMOxdGC6PQ9CTkiHHYd6uGkRrepV859eZiXhr9da6iBfBtazjDgrbA73L
bPuYDvjbj4VppSTh7gBn2XBV0yTRkpdH4b4CBDe5CN1bLvDnmrwVen6gtPnZHJ+V
2ho2argum7J/j5XkvpQaZIpBXtfNwoQRpbJugfUtuUu3m4zmV9vJNFs/47AUJXEF
gVcl6YqhbKORbrEuAk7qS1TMndbCzJhEitnDFYHmyDaW6gWTuB+36bBFHqcpnStD
alFkOAFx1Ae2VkFfn3e+ImoL3vr8mQ==
=btR0
-----END PGP SIGNATURE-----

--Sig_/gsE_2=m7QKGJH_vSBhfk+y.--
