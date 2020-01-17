Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2252C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C9F2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="R4a7Kkhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgAQTmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:42:35 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35120 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQTmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 14:42:35 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so23861863qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 11:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ye5PEji8Lgk+2HK8XuoofHoKU/zw+6IcqrRfWMDcXsA=;
        b=R4a7KkhpxKG2u4gFSisO74w8LfwHYRat/WpvDdyj2oMT3EFfpLna9/LhRToKNfnOKO
         FOOGRvVdugmQZL8pTmrKw7C/kKY2TW6lQonQJ2Br1zQXv3OSUFM+FKgPpRRN80Epbmk1
         mLz6hI0t/d0YpzianpWAoyaxAFkomd935paPz2kLaXK3x8QEv8GmQ7C9r8cAwAkEVbGJ
         w1QhCdaR67LRaXAbvY9v8ZkQB0CGPWFWNLGYNl+Y+/ky1xbH84KpZq77nGBRKsoN3KmI
         MnrspkpYSmcq082/h8d9/o2A/PjYjduzPZVbD3aoB91scCnc3OYBrJ8Jwbt9idjnTkvF
         bt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ye5PEji8Lgk+2HK8XuoofHoKU/zw+6IcqrRfWMDcXsA=;
        b=EFUjg+eTdYhpjSCkfwwcMUuqG+EqQYzSvmFZFg6E4QuYtFgpaMlf7B1HpDd3gf0IC5
         IINWnEbceZb9VuzVIq8LVBm1FjJVSX5x8ANBtI7P3iKgCuDTWMS6W9y1LQ0gGmt/bJVq
         fBGlQrTeJ/IKhyIVNwHpl/HOvkshb9RiJluc9cDirqEy3e2OpVIkb/aM2gQ/Q11VV18I
         CXwgK4U8eAjB9k33SibCt+VY/DUIsbMin4M/414LR2LB/cBd/Ko/3JvsCpiWSzOouyeX
         9E0c3g9LF6LLf9spguuSJdrY8D3U20dFPPPlOVKJUuWm+VA7kLZAvMLf/eazoBIiSIc0
         3Jog==
X-Gm-Message-State: APjAAAVa5q0UI+m/GqCR9LhQUio+/QsAxOTRVge6jIpZVxU9bBFxCJyd
        Ef9Y224R09nT4YUui0BucMWcdg==
X-Google-Smtp-Source: APXvYqwSBcRUIb0XSF+TonuquGNqUOqr3lpe0eX2whLYDESj9Kjje059D4yf4ox2EQy7aqDnbLzkfA==
X-Received: by 2002:a37:ea09:: with SMTP id t9mr39996237qkj.151.1579290154109;
        Fri, 17 Jan 2020 11:42:34 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c6sm12009610qka.111.2020.01.17.11.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 11:42:33 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with
 printk()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <06AE045D-F167-406B-A78B-CAE246058C9D@redhat.com>
Date:   Fri, 17 Jan 2020 14:42:32 -0500
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E07384A-0C7F-4462-852F-B5A386AC10EB@lca.pw>
References: <00155F33-17C6-4051-A8F9-CCD9414F400D@lca.pw>
 <06AE045D-F167-406B-A78B-CAE246058C9D@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2020, at 2:15 PM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
>=20
>=20
>> Am 17.01.2020 um 19:49 schrieb Qian Cai <cai@lca.pw>:
>>=20
>> =EF=BB=BF
>>=20
>>> On Jan 17, 2020, at 10:46 AM, Michal Hocko <mhocko@kernel.org> =
wrote:
>>>=20
>>>> On Fri 17-01-20 10:05:12, Qian Cai wrote:
>>>>=20
>>>>=20
>>>>> On Jan 17, 2020, at 9:39 AM, Michal Hocko <mhocko@kernel.org> =
wrote:
>>>>>=20
>>>>> Thanks a lot. Having it in a separate patch would be great.
>>>>=20
>>>> I was thinking about removing that WARN together in this v5 patch,
>>>> so there is less churn to touch the same function again. However, I
>>>> am fine either way, so just shout out if you feel strongly towards =
a
>>>> separate patch.
>>>=20
>>> I hope you meant moving rather than removing ;). The warning is =
useful
>>> because we shouldn't see unmovable pages in the movable zone. And a
>>> separate patch makes more sense because the justification is =
slightly
>>> different. We do not want to have a way for userspace to trigger the
>>> warning from userspace - even though it shouldn't be possible, but
>>> still. Only the offlining path should complain.
>>=20
>> Something like this?
>>=20
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 621716a25639..32c854851e1f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8307,7 +8307,6 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>>       }
>>       return NULL;
>> unmovable:
>> -       WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>>       return pfn_to_page(pfn + iter);
>> }
>>=20
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index e70586523ca3..08571b515d9f 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -54,9 +54,11 @@ static int set_migratetype_isolate(struct page =
*page, int migratetype, int isol_
>>=20
>> out:
>>       spin_unlock_irqrestore(&zone->lock, flags);
>> +
>>       if (!ret)
>>               drain_all_pages(zone);
>>       else if ((isol_flags & REPORT_FAILURE) && unmovable)
>=20
> We have a dedicated flag for the offlining part.

This should do the trick then,

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 621716a25639..4bb3e503cb9e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8231,7 +8231,7 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
                if (is_migrate_cma(migratetype))
                        return NULL;
=20
-               goto unmovable;
+               return page;
        }
=20
        for (; iter < pageblock_nr_pages; iter++) {
@@ -8241,7 +8241,7 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
                page =3D pfn_to_page(pfn + iter);
=20
                if (PageReserved(page))
-                       goto unmovable;
+                       return page;
=20
                /*
                 * If the zone is movable and we have ruled out all =
reserved
@@ -8303,12 +8303,9 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
                 * is set to both of a memory hole page and a _used_ =
kernel
                 * page at boot.
                 */
-               goto unmovable;
+               return pfn_to_page(pfn + iter);
        }
        return NULL;
-unmovable:
-       WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
-       return pfn_to_page(pfn + iter);
 }
=20
 #ifdef CONFIG_CONTIG_ALLOC
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index e70586523ca3..e140eaa901b2 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -54,14 +54,20 @@ static int set_migratetype_isolate(struct page =
*page, int migratetype, int isol_
=20
 out:
        spin_unlock_irqrestore(&zone->lock, flags);
-       if (!ret)
+
+       if (!ret) {
                drain_all_pages(zone);
-       else if ((isol_flags & REPORT_FAILURE) && unmovable)
-               /*
-                * printk() with zone->lock held will guarantee to =
trigger a
-                * lockdep splat, so defer it here.
-                */
-               dump_page(unmovable, "unmovable page");
+       } else {
+               if (isol_flags & MEMORY_OFFLINE)
+                       WARN_ON_ONCE(zone_idx(zone) =3D=3D =
ZONE_MOVABLE);
+
+               if ((isol_flags & REPORT_FAILURE) && unmovable)
+                       /*
+                        * printk() with zone->lock held will likely =
trigger a
+                        * lockdep splat, so defer it here.
+                        */
+                       dump_page(unmovable, "unmovable page");
+       }
=20
        return ret;
 }

>=20
>> +               WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>>               /*
>>                * printk() with zone->lock held will guarantee to =
trigger a
>>                * lockdep splat, so defer it here.
>>=20
>=20
> So, are we fine with unmovable data ending up in ZONE_MOVABLE as long =
as we can offline it?=20
>=20
> This might make my life in virtio-mem a little easier (I can unplug =
chunks falling into ZONE_MOVABLE).

