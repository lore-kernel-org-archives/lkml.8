Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D28C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7074121927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="t+yok5JZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgBZECd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:02:33 -0500
Received: from ozlabs.org ([203.11.71.1]:52477 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgBZECc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:02:32 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48S2FL0j9kz9sPK;
        Wed, 26 Feb 2020 15:02:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1582689751;
        bh=5RT30J7tQ+Hw5KnOScWGVk38RmRkj0hsVmq+y1pbK/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t+yok5JZtsf2HQmV2d14oVgoZa7dyl6LI50HjYQdj/gI5OCWulbPJAUMRrX9iHpyE
         AqpqBDGPpkk46HXutEJrdk2BPt2SXTQbdPRq6DZCzR43evGs38/CB/YWvC31mGVNkM
         eSLykVqdMBAKHBOBdS0/M81EKjknB3JP9xX/nmWflDEjjxyeqA/qTbL0mACLsxHzaP
         C93HIc2yJs9ORCwE5wwuUcu4bxU0kwpp9ZBBrb32WWdY3ViA8a2s5QJuO/1rkL6JaV
         IGdtdFNCoE/sEnQ0/sX3iIedAc2nBZtoJQM3OPXXqmfLu2VsMkFS4KPXeDcz6M+r/A
         Y0JRlXYhw0MzA==
Date:   Wed, 26 Feb 2020 15:02:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arjun Roy <arjunroy@google.com>,
        David Miller <davem@davemloft.net>
Subject: Re: linux-next: build failure after merge of the akpm tree
Message-ID: <20200226150229.138122d2@canb.auug.org.au>
In-Reply-To: <20200217145711.4af495a3@canb.auug.org.au>
References: <20200217145711.4af495a3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NVuV3qDcMu_0F4KS9.vL6PC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NVuV3qDcMu_0F4KS9.vL6PC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 17 Feb 2020 14:57:11 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the akpm tree, today's linux-next build (sparc64 defconfig)
> failed like this:
>=20
> mm/memory.c: In function 'insert_pages':
> mm/memory.c:1523:56: error: macro "pte_index" requires 2 arguments, but o=
nly 1 given
>    remaining_pages_total, PTRS_PER_PTE - pte_index(addr));
>                                                         ^
>=20
> Caused by commit
>=20
>   366142f0b000 ("mm/memory.c: add vm_insert_pages()")
>=20
> This is the first use of pte_index() outside arch specific code and the
> sparc64 version of pte_index() nas an extra argument.
>=20
> I have reverted these commits for today:
>=20
>   219ae14a9686 ("net-zerocopy-use-vm_insert_pages-for-tcp-rcv-zerocopy-fi=
x")
>   cb912fdf96bf ("net-zerocopy: use vm_insert_pages() for tcp rcv zerocopy=
")
>   72c684430b94 ("add missing page_count() check to vm_insert_pages().")
>   dbd9553775f3 ("mm-add-vm_insert_pages-fix")
>   366142f0b000 ("mm/memory.c: add vm_insert_pages()")

This failure is now in the akpm tree (it was previously in the
skpm-current tree) but I am still reverting the same patches (though
they are now slightly different).

--=20
Cheers,
Stephen Rothwell

--Sig_/NVuV3qDcMu_0F4KS9.vL6PC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5V7dUACgkQAVBC80lX
0Gwv1Qf/S6Ym7LPZSqA9CS6CG+40egEofcLlpIcTaNkcoFh0hMzk72qbtDb/3mnE
wkRAo5j9Vx6aGQyo+sBVlZ2N29mINSihmUHW0UcBLRYgt7H+fxp3CTs2QKPUC202
26nUEs98ZB9RthdhDSeH1ojlsIbgnw/cX9SL4pww0L6k6LHf/NQncsaVlEuEr/fI
liA073R0T+GHeVNQ29dpeMY3gBSZp0FTIjT2rSbqZa5UwaoGDds3wl0ktxM0svxx
BbNt7iMnJd3/5ztgNPC7wZ5Cg8MJ8AP1ViDU9VYNVh7wnAJGhg5NK6g9NOmfHlji
zTUMMnjzhye6ydHWvulBNQBASbFvcA==
=t09f
-----END PGP SIGNATURE-----

--Sig_/NVuV3qDcMu_0F4KS9.vL6PC--
