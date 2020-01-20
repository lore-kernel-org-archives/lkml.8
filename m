Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC25CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D95221835
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Fyx8XxKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgATOL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:11:59 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41217 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgATOL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:11:59 -0500
Received: by mail-qt1-f195.google.com with SMTP id k40so27713029qtk.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 06:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jGThDTnuhXaKd8DUWOBQzCaaD/3GsSO5W0D8Fuquqn0=;
        b=Fyx8XxKTcB983BEZFuMKhi0v0oJEKtHTRfaSigJ+fwp7PGmQ++wUXsjZdf+nCKqCcn
         dHWFBaYViWbhwgjjxbHD1UaRCcHU9ibSPb94wiCAwpUkYdb2fkJdyrvI9lDZxEP5cvLE
         EF3Y5aGybIxQ2K5xY166/G1u97pWIgPUiocb7YdosKnGsaZSiVEXzislnebp+lTv0UxW
         SCNhTHI+wbc4d1THfcQcZ/JM4pmgVoTdDmBg8i7jwQNWsp82G9lEKyIer7ww9sz7nI57
         YAyhiTRIWo7TYPl4Z22Ced0DxxvCHHn/jjgqm+TKXDIRtJZSReOasohKg1oRvIzUijtZ
         UqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jGThDTnuhXaKd8DUWOBQzCaaD/3GsSO5W0D8Fuquqn0=;
        b=U3P5QndFjf87gXr4RM2hVBMTNXEnBg/XNXMTH9ljwnXk/mz0jsxQZ3vQtJtGCTzsra
         0gdPEMU+7DZXpzEhLaVF6oWN1XYi2sBVgw2vOsWynSdFKVuRRFTUuCyvWOXhKRJObIvg
         ib3vQHUSKUYl5DQrSQ/be6IcgyuAgxIjiyYWESTZe3QiNV7KGDTaxyhYR2T2EHmVV4/C
         y5uXUNdaiexAz3CNqZ/clrh7ieBNgAJR1H1UP7rReZ+J/RdzBAzIInhrms4xS0tolBUQ
         eVw7aOwNsb96htvvP4LVPFIFnSBNRRJigjYRTJqeZlymfV6MJB8ho751o/ttXciwEzP+
         xC0A==
X-Gm-Message-State: APjAAAWU9mDSlfaKjiVHdUvbPsbE0450F8Jd8DgZ5G03iowyA5dvY63B
        /z5gd3v+5Xj0PyHYrHXN5Xzw8A==
X-Google-Smtp-Source: APXvYqwEfQwhex2/D/3RnAvsEIatvig33icdQFY0W8PcUteW/YXKF+TjYilF7ScjCcpAed2cmkBrqw==
X-Received: by 2002:ac8:4306:: with SMTP id z6mr20382763qtm.178.1579529518484;
        Mon, 20 Jan 2020 06:11:58 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t15sm15639623qkg.49.2020.01.20.06.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:11:57 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -mm v2] mm/page_isolation: fix potential warning from user
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <74aebdfe-e727-acd6-e664-6e63948a68ae@redhat.com>
Date:   Mon, 20 Jan 2020 09:11:55 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8997A77-7F52-4C0C-8045-F39C57B4CC74@lca.pw>
References: <20200120131909.813-1-cai@lca.pw>
 <8c56268d-9b8a-f62e-eca9-7707852a2aaf@redhat.com>
 <ba3215a2-d616-c636-e70d-99bb8f504292@redhat.com>
 <96675869-3815-4E98-8492-1D84F5B42AED@lca.pw>
 <74aebdfe-e727-acd6-e664-6e63948a68ae@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 20, 2020, at 9:01 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 20.01.20 14:56, Qian Cai wrote:
>>=20
>>=20
>>> On Jan 20, 2020, at 8:38 AM, David Hildenbrand <david@redhat.com> =
wrote:
>>>=20
>>> On 20.01.20 14:30, David Hildenbrand wrote:
>>>> On 20.01.20 14:19, Qian Cai wrote:
>>>>> It makes sense to call the WARN_ON_ONCE(zone_idx(zone) =3D=3D =
ZONE_MOVABLE)
>>>>> from start_isolate_page_range(), but should avoid triggering it =
from
>>>>> userspace, i.e, from is_mem_section_removable() because it could =
be a
>>>>> DoS if warn_on_panic is set.
>>>>>=20
>>>>> While at it, simplify the code a bit by removing an unnecessary =
jump
>>>>> label and a local variable, so set_migratetype_isolate() could =
really
>>>>> return a bool.
>>>>>=20
>>>>> Suggested-by: Michal Hocko <mhocko@kernel.org>
>>>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>>>> ---
>>>>>=20
>>>>> v2: Improve the commit log.
>>>>>   Warn for all start_isolate_page_range() users not just =
offlining.
>>>>>=20
>>>>> mm/page_alloc.c     | 11 ++++-------
>>>>> mm/page_isolation.c | 30 +++++++++++++++++-------------
>>>>> 2 files changed, 21 insertions(+), 20 deletions(-)
>>>>>=20
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index 621716a25639..3c4eb750a199 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -8231,7 +8231,7 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>>>>> 		if (is_migrate_cma(migratetype))
>>>>> 			return NULL;
>>>>>=20
>>>>> -		goto unmovable;
>>>>> +		return page;
>>>>> 	}
>>>>>=20
>>>>> 	for (; iter < pageblock_nr_pages; iter++) {
>>>>> @@ -8241,7 +8241,7 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>>>>> 		page =3D pfn_to_page(pfn + iter);
>>>>>=20
>>>>> 		if (PageReserved(page))
>>>>> -			goto unmovable;
>>>>> +			return page;
>>>>>=20
>>>>> 		/*
>>>>> 		 * If the zone is movable and we have ruled out all =
reserved
>>>>> @@ -8261,7 +8261,7 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>>>>> 			unsigned int skip_pages;
>>>>>=20
>>>>> 			if =
(!hugepage_migration_supported(page_hstate(head)))
>>>>> -				goto unmovable;
>>>>> +				return page;
>>>>>=20
>>>>> 			skip_pages =3D compound_nr(head) - (page - =
head);
>>>>> 			iter +=3D skip_pages - 1;
>>>>> @@ -8303,12 +8303,9 @@ struct page *has_unmovable_pages(struct =
zone *zone, struct page *page,
>>>>> 		 * is set to both of a memory hole page and a _used_ =
kernel
>>>>> 		 * page at boot.
>>>>> 		 */
>>>>> -		goto unmovable;
>>>>> +		return page;
>>>>> 	}
>>>>> 	return NULL;
>>>>> -unmovable:
>>>>> -	WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>>>>> -	return pfn_to_page(pfn + iter);
>>>>> }
>>>>>=20
>>>>> #ifdef CONFIG_CONTIG_ALLOC
>>>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>>>> index e70586523ca3..31f5516f5d54 100644
>>>>> --- a/mm/page_isolation.c
>>>>> +++ b/mm/page_isolation.c
>>>>> @@ -15,12 +15,12 @@
>>>>> #define CREATE_TRACE_POINTS
>>>>> #include <trace/events/page_isolation.h>
>>>>>=20
>>>>> -static int set_migratetype_isolate(struct page *page, int =
migratetype, int isol_flags)
>>>>> +static bool set_migratetype_isolate(struct page *page, int =
migratetype,
>>>>> +				    int isol_flags)
>>>>=20
>>>> Why this change?
>>>>=20
>>>>> {
>>>>> -	struct page *unmovable =3D NULL;
>>>>> +	struct page *unmovable =3D ERR_PTR(-EBUSY);
>>>>=20
>>>> Also, why this change?
>>>>=20
>>>>> 	struct zone *zone;
>>>>> 	unsigned long flags;
>>>>> -	int ret =3D -EBUSY;
>>>>>=20
>>>>> 	zone =3D page_zone(page);
>>>>>=20
>>>>> @@ -49,21 +49,25 @@ static int set_migratetype_isolate(struct page =
*page, int migratetype, int isol_
>>>>> 									=
NULL);
>>>>>=20
>>>>> 		__mod_zone_freepage_state(zone, -nr_pages, mt);
>>>>> -		ret =3D 0;
>>>>> 	}
>>>>>=20
>>>>> out:
>>>>> 	spin_unlock_irqrestore(&zone->lock, flags);
>>>>> -	if (!ret)
>>>>> +
>>>>> +	if (!unmovable) {
>>>>> 		drain_all_pages(zone);
>>>>> -	else if ((isol_flags & REPORT_FAILURE) && unmovable)
>>>>> -		/*
>>>>> -		 * printk() with zone->lock held will guarantee to =
trigger a
>>>>> -		 * lockdep splat, so defer it here.
>>>>> -		 */
>>>>> -		dump_page(unmovable, "unmovable page");
>>>>> -
>>>>> -	return ret;
>>>>> +	} else {
>>>>> +		WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>>>>> +
>>>>> +		if ((isol_flags & REPORT_FAILURE) && !IS_ERR(unmovable))
>>>>> +			/*
>>>>=20
>>>> Why this change? (!IS_ERR)
>>>>=20
>>>>=20
>>>> Some things here look unrelated - or I am missing something :)
>>>>=20
>>>=20
>>> FWIW, I'd prefer this change without any such cleanups (e.g., I =
don't
>>> like returning a bool from this function and the IS_ERR handling, =
makes
>>> the function harder to read than before)
>>=20
>> What is Michal or Andrew=E2=80=99s opinion? BTW, a bonus point to =
return a bool
>> is that it helps the code robustness in general, as UBSAN will be =
able to
>> catch any abuse.
>>=20
>=20
> A return type of bool on a function that does not test a property
> ("has_...", "is"...") is IMHO confusing.

That is fine. It could be renamed to set_migratetype_is_isolate() or
is_set_migratetype_isolate() which seems pretty minor because we
have no consistency in the naming of this in linux kernel at all, i.e.,
many existing bool function names without those test of properties.=20

>=20
> If we have an int, it is clear that "0" means "success". With a bool
> (true/false), it is not clear.
>=20
> --=20
> Thanks,
>=20
> David / dhildenb
>=20

