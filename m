Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D28FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C02920786
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JKKUjIko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHSSPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:15:07 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5218 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHSSPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:15:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3d6bec0002>; Wed, 19 Aug 2020 11:14:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 19 Aug 2020 11:15:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 19 Aug 2020 11:15:03 -0700
Received: from [10.2.49.218] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Aug
 2020 18:14:56 +0000
Subject: Re: [PATCH] mm/gup: don't permit users to call get_user_pages with
 FOLL_LONGTERM
To:     Barry Song <song.bao.hua@hisilicon.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Christoph Hellwig" <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Dave Chinner" <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Jonathan Corbet" <corbet@lwn.net>, Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
References: <20200819110100.23504-1-song.bao.hua@hisilicon.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e4265ac0-793d-053b-81b1-15e57c04b830@nvidia.com>
Date:   Wed, 19 Aug 2020 11:14:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819110100.23504-1-song.bao.hua@hisilicon.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597860845; bh=gNdAT/etTZwZteED0BIN2T3CZYf5c64GDyXgROoUS1o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JKKUjIkoVN9iC4WXRB5nrYw218IysKH7+JRf9wi0cjxJrbhYBwzeU5CV+QVHgt1tF
         XW03l6xc9F9fGw7Wr3N0EWXpC83URUk9jPN5SyYmRdGkht8QLZValtcSwUZ05bIwL0
         fUC73aIfquDBW7xe298badhDUMs+2OuBVtpSYI+k1RAbSncdUuRLDISrRucv7RXUpW
         1VOFlOxO7UptMfR0ahtUoUvreYKH4JmeZQnvZqvY3tplSsA/7E2U655uBLII6aOkjU
         SoMDfOrkPqlsJII+J7QyGDd2OJy2w/tESfrhtPctzDjWobfW0RC4iZdsxhx0NayF8k
         AH42Yl+2/kodg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/20 4:01 AM, Barry Song wrote:
> gug prohibits users from calling get_user_pages() with FOLL_PIN. But it

Maybe Andrew can fix the typo above: gug --> gup.


> allows users to call get_user_pages() with FOLL_LONGTERM only. It seems
> insensible.
>=20
> since FOLL_LONGTERM is a stricter case of FOLL_PIN, we should prohibit
> users from calling get_user_pages() with FOLL_LONGTERM while not with
> FOLL_PIN.
>=20
> mm/gup_benchmark.c used to be the only user who did this improperly.
> But it has been fixed by moving to use pin_user_pages().

For future patches, you don't have to write everything in the
commit log. Some things are better placed in a cover letter or after
the "---" line, because they don't need to be recorded forever.

Anyway, the diffs seem fine, assuming that you've audited the call sites.

thanks,
--=20
John Hubbard
NVIDIA

>=20
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   mm/gup.c | 37 ++++++++++++++++++++++---------------
>   1 file changed, 22 insertions(+), 15 deletions(-)
>=20
> diff --git a/mm/gup.c b/mm/gup.c
> index ae096ea7583f..4da669f79566 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1789,6 +1789,25 @@ static long __get_user_pages_remote(struct mm_stru=
ct *mm,
>   				       gup_flags | FOLL_TOUCH | FOLL_REMOTE);
>   }
>  =20
> +static bool is_valid_gup_flags(unsigned int gup_flags)
> +{
> +	/*
> +	 * FOLL_PIN must only be set internally by the pin_user_pages*() APIs,
> +	 * never directly by the caller, so enforce that with an assertion:
> +	 */
> +	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> +		return false;
> +	/*
> +	 * FOLL_PIN is a prerequisite to FOLL_LONGTERM. Another way of saying
> +	 * that is, FOLL_LONGTERM is a specific case, more restrictive case of
> +	 * FOLL_PIN.
> +	 */
> +	if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
> +		return false;
> +
> +	return true;
> +}
> +
>   /**
>    * get_user_pages_remote() - pin user pages in memory
>    * @mm:		mm_struct of target mm
> @@ -1854,11 +1873,7 @@ long get_user_pages_remote(struct mm_struct *mm,
>   		unsigned int gup_flags, struct page **pages,
>   		struct vm_area_struct **vmas, int *locked)
>   {
> -	/*
> -	 * FOLL_PIN must only be set internally by the pin_user_pages*() APIs,
> -	 * never directly by the caller, so enforce that with an assertion:
> -	 */
> -	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> +	if (!is_valid_gup_flags(gup_flags))
>   		return -EINVAL;
>  =20
>   	return __get_user_pages_remote(mm, start, nr_pages, gup_flags,
> @@ -1904,11 +1919,7 @@ long get_user_pages(unsigned long start, unsigned =
long nr_pages,
>   		unsigned int gup_flags, struct page **pages,
>   		struct vm_area_struct **vmas)
>   {
> -	/*
> -	 * FOLL_PIN must only be set internally by the pin_user_pages*() APIs,
> -	 * never directly by the caller, so enforce that with an assertion:
> -	 */
> -	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> +	if (!is_valid_gup_flags(gup_flags))
>   		return -EINVAL;
>  =20
>   	return __gup_longterm_locked(current->mm, start, nr_pages,
> @@ -2810,11 +2821,7 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast_only);
>   int get_user_pages_fast(unsigned long start, int nr_pages,
>   			unsigned int gup_flags, struct page **pages)
>   {
> -	/*
> -	 * FOLL_PIN must only be set internally by the pin_user_pages*() APIs,
> -	 * never directly by the caller, so enforce that:
> -	 */
> -	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> +	if (!is_valid_gup_flags(gup_flags))
>   		return -EINVAL;
>  =20
>   	/*
>=20

