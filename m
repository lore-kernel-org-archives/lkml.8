Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A851C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F81A2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgCDPVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:21:46 -0500
Received: from shelob.surriel.com ([96.67.55.147]:56722 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgCDPVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:21:46 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1j9Vpx-00068C-VJ; Wed, 04 Mar 2020 10:21:29 -0500
Message-ID: <221dab45ed46405b707825455086855665ead7cc.camel@surriel.com>
Subject: Re: [RFC v4 2/7] mm/damon: Account age of target regions
From:   Rik van Riel <riel@surriel.com>
To:     SeongJae Park <sjpark@amazon.com>, akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, aarcange@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, dwmw@amazon.com, jolsa@redhat.com,
        kirill@shutemov.name, mark.rutland@arm.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, rdunlap@infradead.org, rientjes@google.com,
        rostedt@goodmis.org, shuah@kernel.org, sj38.park@gmail.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Mar 2020 10:21:29 -0500
In-Reply-To: <20200303121406.20954-3-sjpark@amazon.com>
References: <20200303121406.20954-1-sjpark@amazon.com>
         <20200303121406.20954-3-sjpark@amazon.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-eGmSQoRR+kwATEvB5H6o"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eGmSQoRR+kwATEvB5H6o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-03 at 13:14 +0100, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>

> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -87,6 +87,10 @@ static struct damon_region
> *damon_new_region(struct damon_ctx *ctx,
>  	ret->sampling_addr =3D damon_rand(ctx, vm_start, vm_end);
>  	INIT_LIST_HEAD(&ret->list);
> =20
> +	ret->age =3D 0;
> +	ret->last_vm_start =3D vm_start;
> +	ret->last_vm_end =3D vm_end;

Wait, what tree is this supposed to apply against?

I see no mm/damon.c file in current Linus upstream.

--=20
All Rights Reversed.

--=-eGmSQoRR+kwATEvB5H6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl5fx3kACgkQznnekoTE
3oNdIQf+Jf9rcxWzut0/wdOMrnEpQsvag0DtVQ/TWi1ncSthQUXiwIX3WPPLGbsr
FR1OInV5p9OHU1pNZVCXy2PWRiXOEDwiYrBoaGkl5u2hThi8jqGaqJH39yX29JLR
OC+UAJ1WqPhhk4AenjZoHH3E7Vxd4K1m2z8VBETeU/TP1le1hl3CxPbNmyOMBxTU
3TE8vmJ+vRJGqVZFZictlSs4K0jKL+Px8cUxbK8qk7DdI1ulpq/i+CxzMHzMYVki
plb+kn3zVjLpJshoSH6qaNimk2XO02/0zzm7nNjiM5jm7IXomQRNQ/4PuIWyudgp
L++pTRBaHsq2fJoxo+vMGWAnwAhNVw==
=LokE
-----END PGP SIGNATURE-----

--=-eGmSQoRR+kwATEvB5H6o--

