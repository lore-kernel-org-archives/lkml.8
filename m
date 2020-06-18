Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5356C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB08208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BhqrUg2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgFRQV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:21:59 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11892 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgFRQV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:21:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eeb94410000>; Thu, 18 Jun 2020 09:20:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 18 Jun 2020 09:21:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 18 Jun 2020 09:21:57 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun
 2020 16:21:57 +0000
Subject: Re: [PATCH -next] lib: fix test_hmm.c reference after free
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
CC:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <c845c158-9c65-9665-0d0b-00342846dd07@infradead.org>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <fae8934b-7300-27ff-e18e-6db413b9ea53@nvidia.com>
Date:   Thu, 18 Jun 2020 09:21:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c845c158-9c65-9665-0d0b-00342846dd07@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592497217; bh=0hMi0xIwkUC9/TCs8lWLufXqXDXyWYEohg3QmmYj+og=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BhqrUg2yERdAPawT5Qw+t1rBqdhQpLqbOV17quzsC/9rjv6aMSq/08gIKFAIfnzC8
         fLNVgJUxCYmt4ODHApjKeW8X41saLfBstZnr4Mrt4ew6jwqzwgaN+FrEX5vZU0f+uv
         ytpvt9Al4dInIlHv1IrCulb0wIIf8W43P5VnQDmijbE5NBUfUi4pX+jx4V//Jqzs7y
         LGrHBOEfbwED/NLPnPRG4aBFm8CdNTDEp6VJ+/7FV+k7wYEj4a4KG+Ct+5I0nejD8N
         xl3wDHJIDbbszYz4XG3tQ+uYRCN98O8xMG3f23aTRMb/uWKphvTYTYNCuv7EHEikVx
         A+Ogz+qbUsoNA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/17/20 10:31 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> Coccinelle scripts report the following errors:
>=20
> lib/test_hmm.c:523:20-26: ERROR: reference preceded by free on line 521
> lib/test_hmm.c:524:21-27: ERROR: reference preceded by free on line 521
> lib/test_hmm.c:523:28-35: ERROR: devmem is NULL but dereferenced.
> lib/test_hmm.c:524:29-36: ERROR: devmem is NULL but dereferenced.
>=20
> Fix these by using the local variable 'res' instead of devmem.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> ---
>   lib/test_hmm.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> --- linux-next-20200617.orig/lib/test_hmm.c
> +++ linux-next-20200617/lib/test_hmm.c
> @@ -520,8 +520,7 @@ static bool dmirror_allocate_chunk(struc
>   err_free:
>   	kfree(devmem);
>   err_release:
> -	release_mem_region(devmem->pagemap.res.start,
> -			   resource_size(&devmem->pagemap.res));
> +	release_mem_region(res->start, resource_size(res));
>   err:
>   	mutex_unlock(&mdevice->devmem_lock);
>   	return false;
>=20

Thanks for fixing this!
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
