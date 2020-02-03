Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989E0C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6932C2084E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBLVJVXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgBCVox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:44:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33403 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725372AbgBCVox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580766291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=APvzKJbOVU63A3dxA5kI8kBeWOZPD++mpXTHMc1xuKc=;
        b=HBLVJVXvxYCtQQDhR+yiD09/k73GjU5RfywgtxhxQt8PZAXsIJ3cr9lxbei67z85ObqTjw
        kEUBIjloQ4ufv7gTzXbmPJYKEN+eN+2kb6yHbbzgt1Sr1/cwfcuyvEH0mEeDQcJ7+3TjT/
        TgSSyR+9lbWm3bG1PZlIkxLCjO/4Bf0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-7FiP-X_DMzO-5Zu12XEdAQ-1; Mon, 03 Feb 2020 16:44:48 -0500
X-MC-Unique: 7FiP-X_DMzO-5Zu12XEdAQ-1
Received: by mail-wr1-f72.google.com with SMTP id d15so5589644wru.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 13:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=APvzKJbOVU63A3dxA5kI8kBeWOZPD++mpXTHMc1xuKc=;
        b=ZLN+gCwN2qiDhuuNxyX207h2hbv5gVWIKjRqpEI6wiIrt4BvJ+e16XQURuhn9yzVZE
         ZrPbZ383G1nZWo9Vw8oS+gRR4rVudyBEUhY92zjOP8YdBfZ8dYM5s8lCAjfBq3t3l1TS
         X3q2hRnbv1zJKNaNKL9JYIhofwr+OpWB42TM1xeg0l2xsM74/hfLjEZ2kloeArU7vf78
         oUqnKoHIHuVFye3tr6Vk+JEMS2ZPCB6/DdnAbDPMFH8pGdH6Yw4gZJqYwteUTrqAAzvI
         U4+BLSrzwDPKD1wWCwFLHmyYICxSasS3IGykSESXIVXhXn2ZsvIGeVuhSHH3f000glL0
         uCSg==
X-Gm-Message-State: APjAAAVcmoy5mR843aposjNI+QWTu997FKZmQ2g+lgGCu+Ggn4zrZ9x3
        /UXE9AJR1OsQCigPXHG47EXquILSF10yJ8LZ797u7Ss45S2mxo33KrZyg9sJdsCoPSyQxtSkEMw
        w2YjRHAaCuK8Ind48l0q4PwQr
X-Received: by 2002:adf:ec83:: with SMTP id z3mr16898620wrn.133.1580766286883;
        Mon, 03 Feb 2020 13:44:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyrsyYng4IR6o6G/LYaVafSTJOiC/W7rP+gXYQ+Gl4WeTH94Pt4DFpOc0g+rN+cc4LgnOQtXQ==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr16898607wrn.133.1580766286715;
        Mon, 03 Feb 2020 13:44:46 -0800 (PST)
Received: from [192.168.3.122] (p5B0C6AA7.dip0.t-ipconnect.de. [91.12.106.167])
        by smtp.gmail.com with ESMTPSA id e17sm14180838wrn.62.2020.02.03.13.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 13:44:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 1/2] mm/page_alloc: fix and rework pfn handling in memmap_init_zone()
Date:   Mon, 3 Feb 2020 22:44:45 +0100
Message-Id: <1583F4CF-6CD8-4AB6-A2F6-60E6AEE5D5B2@redhat.com>
References: <CAKgT0UdFphMbS04NMRYU=VUmbnVi_purz4UA0cqA3dd7YW-pJA@mail.gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
In-Reply-To: <CAKgT0UdFphMbS04NMRYU=VUmbnVi_purz4UA0cqA3dd7YW-pJA@mail.gmail.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 03.02.2020 um 22:35 schrieb Alexander Duyck <alexander.duyck@gmail.com>=
:
>=20
> =EF=BB=BFOn Mon, Jan 13, 2020 at 6:40 AM David Hildenbrand <david@redhat.c=
om> wrote:
>>=20
>> Let's update the pfn manually whenever we continue the loop. This makes
>> the code easier to read but also less error prone (and we can directly
>> fix one issue).
>>=20
>> When overlap_memmap_init() returns true, pfn is updated to
>> "memblock_region_memory_end_pfn(r)". So it already points at the *next*
>> pfn to process. Incrementing the pfn another time is wrong, we might
>> leave one uninitialized. I spotted this by inspecting the code, so I have=

>> no idea if this is relevant in practise (with kernelcore=3Dmirror).
>>=20
>> Fixes: a9a9e77fbf27 ("mm: move mirrored memory specific code outside of m=
emmap_init_zone")
>> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> mm/page_alloc.c | 9 ++++++---
>> 1 file changed, 6 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index a41bd7341de1..a92791512077 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5905,18 +5905,20 @@ void __meminit memmap_init_zone(unsigned long siz=
e, int nid, unsigned long zone,
>>        }
>> #endif
>>=20
>> -       for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
>> +       for (pfn =3D start_pfn; pfn < end_pfn; ) {
>>                /*
>>                 * There can be holes in boot-time mem_map[]s handed to th=
is
>>                 * function.  They do not exist on hotplugged memory.
>>                 */
>>                if (context =3D=3D MEMMAP_EARLY) {
>>                        if (!early_pfn_valid(pfn)) {
>> -                               pfn =3D next_pfn(pfn) - 1;
>> +                               pfn =3D next_pfn(pfn);
>>                                continue;
>>                        }
>> -                       if (!early_pfn_in_nid(pfn, nid))
>> +                       if (!early_pfn_in_nid(pfn, nid)) {
>> +                               pfn++;
>>                                continue;
>> +                       }
>>                        if (overlap_memmap_init(zone, &pfn))
>>                                continue;
>>                        if (defer_init(nid, pfn, end_pfn))
>=20
> I'm pretty sure this is a bit broken. The overlap_memmap_init is going
> to return memblock_region_memory_end_pfn instead of the start of the
> next region. I think that is going to stick you in a mirrored region
> without advancing in that case. You would also need to have that case
> do a pfn++ before the continue;

Thanks for having a look.

Did you read the description regarding this change?=

