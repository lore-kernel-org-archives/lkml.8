Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41192C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8EC217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IwVG86sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgATN4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:56:50 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46962 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgATN4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:56:49 -0500
Received: by mail-qt1-f195.google.com with SMTP id e25so16353892qtr.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 05:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UDw9crDqR4wuzSt+UUQwG9e+dAgvTCVj+tj91bpFb5k=;
        b=IwVG86sx9Lal+wnkqP7aHYTH3k6lsQoaHMIqKhMY3rAY0lY1bwRPlKkRoI1PdR95rr
         hRAG85dHZS9ji9iStf/Ehxnyq2zzr4cGQNfh0KOrS2u0JOz+dU71AiFfpQBJkxtz5SMK
         ujwJypuJEhbXmwudqMWISSA2btDZ8ipgFut6ZMJ2/6akmiLirUsd8j4CJ7RagwCljgRc
         3zgO0yJ7qyruHjSyTq6roKQyC368Y6J3oATccJv5jxSSxnlDpWKFy0VObUlPnkGomM4x
         D6udpzNxzmA0UhAP7Mj1M4t/0QuxfcRT/MTq3IVCjA2Rmazj7jz6Z2L2h1cWg0mrhg6J
         czAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UDw9crDqR4wuzSt+UUQwG9e+dAgvTCVj+tj91bpFb5k=;
        b=PRaAS+tOTRf6UUGOxBd0dETUJ3qroJF8LNOyKgS1t5JJQLayaUR/AxAuYE4a7eNxu9
         CWRgS3YoKKfXJzdCELCLNgFri+pybpUUyf0R4/HRAl1pRnFBznC8Cy3JV3PeJPZHS0J8
         83dDYlifb031G8hWH715cJtS4q8M3BfWVLYTpgp4mQwbiOgutDg1rQAByWF+Bpw7E3Mc
         x3wmYUm5cj3C6ER4fTSqlY0mXg9hh7fBubmPx8RObO7tjH+gh0RdNZsDP56kGb2jtZfU
         FfDAys8dl7eGmWT+JPoCXzT1gREvLtvtQ2SfVgoppX+/pJCX6VY8Bngqcwr179UX1bfX
         KzRg==
X-Gm-Message-State: APjAAAUtIBeEijRP1EXRl6ODFOwU7nRjpCGxse2L31m/wvkLEfKAt/oM
        TbVPbiLn4ojM6HBxWzZ9rpoLzykYthISOQ==
X-Google-Smtp-Source: APXvYqwD8U+ozurfTwVFyCwlyCeLFxNMSxMeTnnCY7Eto/JANTFlyaPjX/ctFbQLYbh9UJyvxfLkug==
X-Received: by 2002:ac8:31f0:: with SMTP id i45mr20739412qte.327.1579528608282;
        Mon, 20 Jan 2020 05:56:48 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f19sm15659723qkk.69.2020.01.20.05.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 05:56:47 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -mm v2] mm/page_isolation: fix potential warning from user
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <ba3215a2-d616-c636-e70d-99bb8f504292@redhat.com>
Date:   Mon, 20 Jan 2020 08:56:46 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>, mhocko@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <96675869-3815-4E98-8492-1D84F5B42AED@lca.pw>
References: <20200120131909.813-1-cai@lca.pw>
 <8c56268d-9b8a-f62e-eca9-7707852a2aaf@redhat.com>
 <ba3215a2-d616-c636-e70d-99bb8f504292@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 20, 2020, at 8:38 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 20.01.20 14:30, David Hildenbrand wrote:
>> On 20.01.20 14:19, Qian Cai wrote:
>>> It makes sense to call the WARN_ON_ONCE(zone_idx(zone) =3D=3D =
ZONE_MOVABLE)
>>> from start_isolate_page_range(), but should avoid triggering it from
>>> userspace, i.e, from is_mem_section_removable() because it could be =
a
>>> DoS if warn_on_panic is set.
>>>=20
>>> While at it, simplify the code a bit by removing an unnecessary jump
>>> label and a local variable, so set_migratetype_isolate() could =
really
>>> return a bool.
>>>=20
>>> Suggested-by: Michal Hocko <mhocko@kernel.org>
>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>> ---
>>>=20
>>> v2: Improve the commit log.
>>>    Warn for all start_isolate_page_range() users not just offlining.
>>>=20
>>> mm/page_alloc.c     | 11 ++++-------
>>> mm/page_isolation.c | 30 +++++++++++++++++-------------
>>> 2 files changed, 21 insertions(+), 20 deletions(-)
>>>=20
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 621716a25639..3c4eb750a199 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -8231,7 +8231,7 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>>> 		if (is_migrate_cma(migratetype))
>>> 			return NULL;
>>>=20
>>> -		goto unmovable;
>>> +		return page;
>>> 	}
>>>=20
>>> 	for (; iter < pageblock_nr_pages; iter++) {
>>> @@ -8241,7 +8241,7 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>>> 		page =3D pfn_to_page(pfn + iter);
>>>=20
>>> 		if (PageReserved(page))
>>> -			goto unmovable;
>>> +			return page;
>>>=20
>>> 		/*
>>> 		 * If the zone is movable and we have ruled out all =
reserved
>>> @@ -8261,7 +8261,7 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>>> 			unsigned int skip_pages;
>>>=20
>>> 			if =
(!hugepage_migration_supported(page_hstate(head)))
>>> -				goto unmovable;
>>> +				return page;
>>>=20
>>> 			skip_pages =3D compound_nr(head) - (page - =
head);
>>> 			iter +=3D skip_pages - 1;
>>> @@ -8303,12 +8303,9 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>>> 		 * is set to both of a memory hole page and a _used_ =
kernel
>>> 		 * page at boot.
>>> 		 */
>>> -		goto unmovable;
>>> +		return page;
>>> 	}
>>> 	return NULL;
>>> -unmovable:
>>> -	WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>>> -	return pfn_to_page(pfn + iter);
>>> }
>>>=20
>>> #ifdef CONFIG_CONTIG_ALLOC
>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>> index e70586523ca3..31f5516f5d54 100644
>>> --- a/mm/page_isolation.c
>>> +++ b/mm/page_isolation.c
>>> @@ -15,12 +15,12 @@
>>> #define CREATE_TRACE_POINTS
>>> #include <trace/events/page_isolation.h>
>>>=20
>>> -static int set_migratetype_isolate(struct page *page, int =
migratetype, int isol_flags)
>>> +static bool set_migratetype_isolate(struct page *page, int =
migratetype,
>>> +				    int isol_flags)
>>=20
>> Why this change?
>>=20
>>> {
>>> -	struct page *unmovable =3D NULL;
>>> +	struct page *unmovable =3D ERR_PTR(-EBUSY);
>>=20
>> Also, why this change?
>>=20
>>> 	struct zone *zone;
>>> 	unsigned long flags;
>>> -	int ret =3D -EBUSY;
>>>=20
>>> 	zone =3D page_zone(page);
>>>=20
>>> @@ -49,21 +49,25 @@ static int set_migratetype_isolate(struct page =
*page, int migratetype, int isol_
>>> 									=
NULL);
>>>=20
>>> 		__mod_zone_freepage_state(zone, -nr_pages, mt);
>>> -		ret =3D 0;
>>> 	}
>>>=20
>>> out:
>>> 	spin_unlock_irqrestore(&zone->lock, flags);
>>> -	if (!ret)
>>> +
>>> +	if (!unmovable) {
>>> 		drain_all_pages(zone);
>>> -	else if ((isol_flags & REPORT_FAILURE) && unmovable)
>>> -		/*
>>> -		 * printk() with zone->lock held will guarantee to =
trigger a
>>> -		 * lockdep splat, so defer it here.
>>> -		 */
>>> -		dump_page(unmovable, "unmovable page");
>>> -
>>> -	return ret;
>>> +	} else {
>>> +		WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>>> +
>>> +		if ((isol_flags & REPORT_FAILURE) && !IS_ERR(unmovable))
>>> +			/*
>>=20
>> Why this change? (!IS_ERR)
>>=20
>>=20
>> Some things here look unrelated - or I am missing something :)
>>=20
>=20
> FWIW, I'd prefer this change without any such cleanups (e.g., I don't
> like returning a bool from this function and the IS_ERR handling, =
makes
> the function harder to read than before)

What is Michal or Andrew=E2=80=99s opinion? BTW, a bonus point to return =
a bool
is that it helps the code robustness in general, as UBSAN will be able =
to
catch any abuse.

