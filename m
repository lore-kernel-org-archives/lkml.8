Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8819C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2932206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DqxdiboI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389985AbgE1Mxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:53:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38181 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389899AbgE1Mxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:53:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Xngk1GHNz9sSF;
        Thu, 28 May 2020 22:53:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590670420;
        bh=if7jQmZfG6lRcbOj6WB0TjZbqpX42ichS7+r4E0q2xY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DqxdiboIX52vd97+6EWS/vyv8TKyyXlXZPWj5X5qnIZyVM9tTT57M1RvOF+jEa8lF
         3hiJilNIBE4cfDtLRGIFQ0/6dDxWHUL/2Wy2B1AaZXwhYIgBHsv7K671iaveDpp0+E
         Q9oOcErGQR4g2LD8yhd97sWHkMFfQLoV4H9woytdX/revyNjP1k4q50QPnGCELsaRJ
         6CXgfeDxC6Jj5TtOArxrtF02i+d/pk/CihuQdxQ6YXxC/VnSE9jSVhThVDZjiCosIB
         QPmpSiM9A0gXvPugJOjbt8G/WzMd5TQnOnYtd4i8GLHVZON4yJDQ7d3UfkWqkOFoOu
         GOtrbhAVc/9HQ==
Date:   Thu, 28 May 2020 22:53:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH -tip v3 09/11] data_race: Avoid nested statement
 expression
Message-ID: <20200528225336.2defab20@canb.auug.org.au>
In-Reply-To: <CAK8P3a1BH5nXDK2VS7jWc_u2B1kztr4u9JMXhWF9-iZdrsb-7Q@mail.gmail.com>
References: <20200521142047.169334-1-elver@google.com>
        <20200521142047.169334-10-elver@google.com>
        <CAKwvOdnR7BXw_jYS5PFTuUamcwprEnZ358qhOxSu6wSSSJhxOA@mail.gmail.com>
        <CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com>
        <20200526120245.GB27166@willie-the-truck>
        <CAK8P3a29BNwvdN1YNzoN966BF4z1QiSxdRXTP+BzhM9H07LoYQ@mail.gmail.com>
        <CANpmjNOUdr2UG3F45=JaDa0zLwJ5ukPc1MMKujQtmYSmQnjcXg@mail.gmail.com>
        <20200526173312.GA30240@google.com>
        <CAK8P3a3ZawPnzmzx4q58--M1h=v4X-1GtQLiwL1=G6rDK8=Wpg@mail.gmail.com>
        <CAK8P3a3UYQeXhiufUevz=rwe09WM_vSTCd9W+KvJHJcOeQyWVA@mail.gmail.com>
        <20200527072248.GA9887@willie-the-truck>
        <CANpmjNO2A39XRQ9OstwKGKpZ6wQ4ebVcBNfH_ZhCTi8RG6WqYw@mail.gmail.com>
        <CAK8P3a1BH5nXDK2VS7jWc_u2B1kztr4u9JMXhWF9-iZdrsb-7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=gXnD5Mwv9r7w5Lq6vJ+mEE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=gXnD5Mwv9r7w5Lq6vJ+mEE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, 27 May 2020 11:26:51 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> Right. I think there is still room for optimization around here, but
> for v5.8 I'm happy enough with Marco's__unqual_scalar_typeof()
> change. Stephen Rothwell is probably the one who's most affected
> by compile speed, so it would be good to get an Ack/Nak from him
> on whether this brings speed and memory usage back to normal
> for him as well.

Assuming you meant "[PATCH -tip] compiler_types.h: Optimize
__unqual_scalar_typeof  compilation time"
https://lore.kernel.org/lkml/20200527103236.148700-1-elver@google.com/

I did some x86_64 allmodconfig builds (as I do all day):

Linus' tree:

36884.15user 1439.31system 9:05.46elapsed 7025%CPU (0avgtext+0avgdata 50041=
6maxresident)k
0inputs+128outputs (0major+64821256minor)pagefaults 0swaps
36878.19user 1436.60system 9:05.37elapsed 7025%CPU (0avgtext+0avgdata 49465=
6maxresident)k
0inputs+128outputs (0major+64771097minor)pagefaults 0swaps

linux-next:

42378.58user 1513.34system 9:59.33elapsed 7323%CPU (0avgtext+0avgdata 53792=
0maxresident)k
0inputs+384outputs (0major+65102976minor)pagefaults 0swaps
42378.38user 1509.52system 9:59.12elapsed 7325%CPU (0avgtext+0avgdata 53536=
0maxresident)k
0inputs+384outputs (0major+65102513minor)pagefaults 0swaps

linux-next+patch:

39090.54user 1464.71system 9:17.36elapsed 7276%CPU (0avgtext+0avgdata 52057=
6maxresident)k
0inputs+384outputs (0major+62226026minor)pagefaults 0swaps
39101.66user 1471.55system 9:18.13elapsed 7269%CPU (0avgtext+0avgdata 51385=
6maxresident)k
0inputs+384outputs (0major+62243972minor)pagefaults 0swaps

So, it is a bit better than current linux-next, but not quita back to
Linus' tree (but that is not unexpected as there are over 12000 new
commits in -next).

$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 9.3.0-8) 9.3.0

80 thread Power8 using -j100

--=20
Cheers,
Stephen Rothwell

--Sig_/=gXnD5Mwv9r7w5Lq6vJ+mEE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7PtFAACgkQAVBC80lX
0GwShgf/WE8dBTWi5LGlN07/ZZepqF0bEYhRDibb43csv7ZTlkh/o57GpSMNFz5P
WTFPsP/oiD6mNhZVkuu5vZfNTocZo/r4f5n4CsIF5Tn9PSHVXw8nSYmC9GmLV/+K
LCSNsc6d/TQQRBPY7fSMlSh12NxhQ2nE1LbbxRZpnZT852NnCncBfFsKMGEb1ue0
AVzcq4+iModfjf2dqRJKUgBwpD8VxfBPgV9zjmH3U4BW9NgYVTndW5E/ceXCM6Yd
cOQCADKJP4qWLETMrC4oTiXMwRP5pHjZ7oXOccD7XsKnPWrHLFET8G5KAySIiA9e
Xz7rs85KHwGG5zkogSTDHVkNUkg0vA==
=YOpz
-----END PGP SIGNATURE-----

--Sig_/=gXnD5Mwv9r7w5Lq6vJ+mEE--
