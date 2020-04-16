Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6391DC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42328206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l66/kW4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404471AbgDPAe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404403AbgDPAey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:34:54 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44961C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:34:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 492gGc6G4wz9s71;
        Thu, 16 Apr 2020 10:34:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1586997290;
        bh=JVY3AHGDOL32GRFuO3WUuBbkNWwIarfZ1wi32M7mkCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l66/kW4Fq07FEsSoh3Wz8lH7WJ8UMusOho5fqEmJZ9MDUZjjcZXOL9PG1+rprYFE2
         BOnlN9XksfZkjVaquGLDE5mfJoUZDAIQxxtuwlQjjSbZIVA+ZC5t+Pn6ieef43/oWO
         hv28qZJtDOxOEAAvbJ5ibW9vDXLi+YusXYlSZx1XhW68Ja+gGtid2Et/2pvqWY9tt+
         nXpixmEmmVNCYjSrP3Igj1ie9wA0dG0kcQJ+ltlEfCNPOYLBdbGzirCcXZxxPPMfO/
         zF2HemH3+IodDHaoNw3mPx7MF6HLuf2UwLIsbRh+uRduCmjS2YO2gX3L0+Czt3IlNN
         aC66TpdHqiZFw==
Date:   Thu, 16 Apr 2020 10:34:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Rue <dan.rue@linaro.org>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Message-ID: <20200416103446.09cb27e1@canb.auug.org.au>
In-Reply-To: <CACT4Y+ZE1XhYpTsjP1J1PyUsEHYKvchww71aHb7UnSk5=4xUrw@mail.gmail.com>
References: <20200408014010.80428-1-peterx@redhat.com>
        <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
        <CACT4Y+bhQVcpSkSh_OZ5ZanfFZUqn2iypLhG_Z-nWKTkaYr1jw@mail.gmail.com>
        <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
        <20200410092951.6db32bfe@canb.auug.org.au>
        <7325374A-6072-44E4-85EE-F97FC7E8565F@lca.pw>
        <CACT4Y+ZE1XhYpTsjP1J1PyUsEHYKvchww71aHb7UnSk5=4xUrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6aYWaJ2XREg19MXPDjfGwaQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6aYWaJ2XREg19MXPDjfGwaQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Tue, 14 Apr 2020 13:12:50 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:
>
> AI: we need to CC linux-next@ on linux-next build/boot failures. I
> will work on this.
> We have functionality to CC given emails on _all_ bugs on the given
> tree, but we don't have this for build/boot bugs only. I will try to
> add this soon.
> Stephen, do you want to be CCed as well? Or just linux-next@?

Please cc me as well, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/6aYWaJ2XREg19MXPDjfGwaQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6XqCYACgkQAVBC80lX
0Gwv/wf+KssL/Lva4DpwdIXzEHw0cImI2G7COGBTaYnC0GZ19e2ygv4DlCWBCzDd
9yCyUhzPftDca+xAcCiyRkMPdS6B45RIWt2z0tKSyJO1tnlbuU2g1OproZRz4t1Q
eQCtHGB+HVPXUfmvpMND4pwzaKBRo5vzLlZ04vEeNpTMgVHBfLa9D/l9EWBcXXbx
zbCmFyq24O4Y9kbwfcQr1l/szrjKLS1TeGOsAa2mR0K2tm8ERdNehavvjRtHJ/C2
bCdVrbTxcJVHYczbU3DGS91XE0eQ5m655hzkWcrPAAx6rSww2r+523Gv1q7Y95XO
4rNIKrUTTq7TVj6TgdyzfL/I7hLPvA==
=OQKM
-----END PGP SIGNATURE-----

--Sig_/6aYWaJ2XREg19MXPDjfGwaQ--
