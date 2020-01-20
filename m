Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563E8C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D44022464
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Yc8FBZqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgATNiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:38:15 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41157 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATNiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:38:15 -0500
Received: by mail-qv1-f65.google.com with SMTP id x1so13964104qvr.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 05:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VsoGp109ufXvJlVZJZ7+0lYM452uESSHevplYutSYdo=;
        b=Yc8FBZqTZ49PR5XXHmSJg+sa0E2yA2SnM6T59xCyidB4uZeLSzVy3UCVN/qMge68b1
         fjqdT3489T5Z9hCB68ih4OOwJ7kCdrHvSclJqdiHN0Y/83q6BhWQUHxOOR2JZQKib/ol
         IVT97/PKh0h37qHZrTsQV6nsAf4i2OqGL+rlxPdD/ODZU2JSFurICYGDHrm0NPhB4qo0
         XOmN1zU5d3ygI6eneSowmjWlfPkWWHuEdhIc/aOG/ldQrdJZwuJ1zRX+h7e+jW3Bcb4I
         szkVtjbdL6RtZQ/rzLdjS30XlWuEzg99yvFOAs9wPiGEQMnL+ioVC2Korl/zK2n8Pkdu
         OyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VsoGp109ufXvJlVZJZ7+0lYM452uESSHevplYutSYdo=;
        b=KAZwjkZPn3tfRS102yX39n2bFXQho4zuskUeu9eIrZ1J48NzBef8sE+oUyIOl+iRuh
         o/5IiwuuV7WOToddxUPlrkTpz1idW2hjBEgcsQONRgQ8Xc6YPUtkvFhUtg3MMSfFQv9Z
         9Sl2jOxXig5DhKv089oi2Iie//aI5RI+69rNDLxZ0KsiIos+NLeXwSbCLesUMomv6SCF
         u5iis7Vo1Vfj6mbQauCNkF3H2B5SCDFY62Sw5HkFKLv6tZqTbSHpuJbzR3KWAv24gg79
         HHboFLQya/tK8/uRmIAme+VmI+8UL2TGDjY47jIWxCuXofF+XDOTCYjcscBhHcZazhI5
         GXPg==
X-Gm-Message-State: APjAAAUBbCkMJQSAJW57NM6Ycl793BZ3kYkRbLb07S1EHGmjrR8RI32R
        Dj3hY+ZENWHzb/Nvfr2wVujPrA==
X-Google-Smtp-Source: APXvYqzJWHkLYwbnfPaTEh8dSNBmbk2tJ+IQclnyI2T+yocRWe19nO7fmcyCO3qWekozAS8DWPvdzQ==
X-Received: by 2002:a0c:a145:: with SMTP id d63mr21206033qva.120.1579527493658;
        Mon, 20 Jan 2020 05:38:13 -0800 (PST)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i90sm17560198qtd.49.2020.01.20.05.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 05:38:13 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -mm v2] mm/page_isolation: fix potential warning from user
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <8c56268d-9b8a-f62e-eca9-7707852a2aaf@redhat.com>
Date:   Mon, 20 Jan 2020 08:38:12 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <28542D23-FCB7-4342-B77C-65C7B1F162FC@lca.pw>
References: <20200120131909.813-1-cai@lca.pw>
 <8c56268d-9b8a-f62e-eca9-7707852a2aaf@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 20, 2020, at 8:30 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 20.01.20 14:19, Qian Cai wrote:
>> It makes sense to call the WARN_ON_ONCE(zone_idx(zone) =3D=3D =
ZONE_MOVABLE)
>> from start_isolate_page_range(), but should avoid triggering it from
>> userspace, i.e, from is_mem_section_removable() because it could be a
>> DoS if warn_on_panic is set.
>>=20
>> While at it, simplify the code a bit by removing an unnecessary jump
>> label and a local variable, so set_migratetype_isolate() could really
>> return a bool.
>>=20
>> Suggested-by: Michal Hocko <mhocko@kernel.org>
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>>=20
>> v2: Improve the commit log.
>>    Warn for all start_isolate_page_range() users not just offlining.
>>=20
>> mm/page_alloc.c     | 11 ++++-------
>> mm/page_isolation.c | 30 +++++++++++++++++-------------
>> 2 files changed, 21 insertions(+), 20 deletions(-)
>>=20
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 621716a25639..3c4eb750a199 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8231,7 +8231,7 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>> 		if (is_migrate_cma(migratetype))
>> 			return NULL;
>>=20
>> -		goto unmovable;
>> +		return page;
>> 	}
>>=20
>> 	for (; iter < pageblock_nr_pages; iter++) {
>> @@ -8241,7 +8241,7 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>> 		page =3D pfn_to_page(pfn + iter);
>>=20
>> 		if (PageReserved(page))
>> -			goto unmovable;
>> +			return page;
>>=20
>> 		/*
>> 		 * If the zone is movable and we have ruled out all =
reserved
>> @@ -8261,7 +8261,7 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>> 			unsigned int skip_pages;
>>=20
>> 			if =
(!hugepage_migration_supported(page_hstate(head)))
>> -				goto unmovable;
>> +				return page;
>>=20
>> 			skip_pages =3D compound_nr(head) - (page - =
head);
>> 			iter +=3D skip_pages - 1;
>> @@ -8303,12 +8303,9 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>> 		 * is set to both of a memory hole page and a _used_ =
kernel
>> 		 * page at boot.
>> 		 */
>> -		goto unmovable;
>> +		return page;
>> 	}
>> 	return NULL;
>> -unmovable:
>> -	WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>> -	return pfn_to_page(pfn + iter);
>> }
>>=20
>> #ifdef CONFIG_CONTIG_ALLOC
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index e70586523ca3..31f5516f5d54 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -15,12 +15,12 @@
>> #define CREATE_TRACE_POINTS
>> #include <trace/events/page_isolation.h>
>>=20
>> -static int set_migratetype_isolate(struct page *page, int =
migratetype, int isol_flags)
>> +static bool set_migratetype_isolate(struct page *page, int =
migratetype,
>> +				    int isol_flags)
>=20
> Why this change?
>=20
>> {
>> -	struct page *unmovable =3D NULL;
>> +	struct page *unmovable =3D ERR_PTR(-EBUSY);
>=20
> Also, why this change?
>=20
>> 	struct zone *zone;
>> 	unsigned long flags;
>> -	int ret =3D -EBUSY;
>>=20
>> 	zone =3D page_zone(page);
>>=20
>> @@ -49,21 +49,25 @@ static int set_migratetype_isolate(struct page =
*page, int migratetype, int isol_
>> 									=
NULL);
>>=20
>> 		__mod_zone_freepage_state(zone, -nr_pages, mt);
>> -		ret =3D 0;
>> 	}
>>=20
>> out:
>> 	spin_unlock_irqrestore(&zone->lock, flags);
>> -	if (!ret)
>> +
>> +	if (!unmovable) {
>> 		drain_all_pages(zone);
>> -	else if ((isol_flags & REPORT_FAILURE) && unmovable)
>> -		/*
>> -		 * printk() with zone->lock held will guarantee to =
trigger a
>> -		 * lockdep splat, so defer it here.
>> -		 */
>> -		dump_page(unmovable, "unmovable page");
>> -
>> -	return ret;
>> +	} else {
>> +		WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>> +
>> +		if ((isol_flags & REPORT_FAILURE) && !IS_ERR(unmovable))
>> +			/*
>=20
> Why this change? (!IS_ERR)
>=20
>=20
> Some things here look unrelated - or I am missing something :)

The original =E2=80=9Cret=E2=80=9D variable looks ugly to me, so I just =
removed that and consolidated with
the =E2=80=9Cunmovable=E2=80=9D pointer to always be able to report an =
error. Since this cleanup is really
small, I did not bother send a separate patch for it.=
