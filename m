Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669D9C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 23:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3442080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 23:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQmfLnUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgAMXCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:02:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59887 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728829AbgAMXCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 18:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578956524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5fL1RUVxKn4V2Ga2cRKwS4hMy9dSfducYFMZLP5PZMc=;
        b=hQmfLnUhOdWb3tvUxjWdbyHFLaKnC/6OZ5NWemAoT1wES9QYOy0Vj6opj/0fo9lixSrWhU
        REMhT3gn4ELlgJ9qwVwWGtL7B2Sj3U36/49LxW57BYdRJ1KZEhR3ZQO7+iM9egRkkrYMq/
        946DSA0SAcL3UoPOPgfOI+sQjBCakqc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-9s7xs9egN2e-bt6h5FIsMA-1; Mon, 13 Jan 2020 18:02:03 -0500
X-MC-Unique: 9s7xs9egN2e-bt6h5FIsMA-1
Received: by mail-wr1-f70.google.com with SMTP id h30so5651770wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 15:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=5fL1RUVxKn4V2Ga2cRKwS4hMy9dSfducYFMZLP5PZMc=;
        b=ScNMvka/Z6YmcHf3m5vpp8pj/4XkSvpksH3A81wWptay+b/vdERKunLac35inYEP1/
         ZN/bfEj7YGONB0KdNYbx1OFXd4WBC9tFQk66lVC2UsieyBqgdfyu0G/bnz80P8/GQAGH
         U4y3vDv3CO+tqStuhPCkdao20ignPgMQdF6IenFjDhEg7q40KrfMRsqX1it7VlWkuHNU
         U3vVP5GzKefcN2x493dcw0C5rflntXowTAUvkTmWufPTLFQckHXA2LVKtlKeQvaNKmJz
         vIssiBEPwScDsi+VayrQoiF+iMamDTyqPuC+qeqCZfF4MI7Zd8ng18N3JcVThySf+9sS
         vUBw==
X-Gm-Message-State: APjAAAWJ+hXji6+lp6ETo8oJ7lJo/rDP2OrzRMuZkFSBQNyceydyQ4hl
        bJzA2n6ir89/QURLBP4QmFf07bh1IcTdXm8bj5rNmvi/J2le7mopiXvGtCqJ/YblUxWvcZiRosG
        qeGtl2tELpwoR69ITIznP1SDI
X-Received: by 2002:a05:600c:1003:: with SMTP id c3mr22551694wmc.120.1578956521978;
        Mon, 13 Jan 2020 15:02:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9SqrbRJ1amVPbv6RQ8+6k23HI2AviInNnXyBSjBFNCQ72/q/DmkvdohlkJoL+leSPqUNaAA==
X-Received: by 2002:a05:600c:1003:: with SMTP id c3mr22551679wmc.120.1578956521786;
        Mon, 13 Jan 2020 15:02:01 -0800 (PST)
Received: from [192.168.3.122] (p5B0C617C.dip0.t-ipconnect.de. [91.12.97.124])
        by smtp.gmail.com with ESMTPSA id s65sm16655673wmf.48.2020.01.13.15.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 15:02:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 2/2] mm: factor out next_present_section_nr()
Date:   Tue, 14 Jan 2020 00:02:00 +0100
Message-Id: <C40ACB72-F8C7-4F9B-B3F3-00FBC0C44406@redhat.com>
References: <0B77E39C-BD38-4A61-AB28-3578B519952F@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <0B77E39C-BD38-4A61-AB28-3578B519952F@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 13.01.2020 um 23:57 schrieb David Hildenbrand <dhildenb@redhat.com>:
>=20
> =EF=BB=BF
>=20
>>> Am 13.01.2020 um 23:41 schrieb Kirill A. Shutemov <kirill@shutemov.name>=
:
>>>=20
>>> =EF=BB=BFOn Mon, Jan 13, 2020 at 03:40:35PM +0100, David Hildenbrand wro=
te:
>>> Let's move it to the header and use the shorter variant from
>>> mm/page_alloc.c (the original one will also check
>>> "__highest_present_section_nr + 1", which is not necessary). While at it=
,
>>> make the section_nr in next_pfn() const.
>>>=20
>>> In next_pfn(), we now return section_nr_to_pfn(-1) instead of -1 once
>>> we exceed __highest_present_section_nr, which doesn't make a difference i=
n
>>> the caller as it is big enough (>=3D all sane end_pfn).
>>>=20
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Michal Hocko <mhocko@kernel.org>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>> include/linux/mmzone.h | 10 ++++++++++
>>> mm/page_alloc.c        | 11 ++---------
>>> mm/sparse.c            | 10 ----------
>>> 3 files changed, 12 insertions(+), 19 deletions(-)
>>>=20
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index c2bc309d1634..462f6873905a 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -1379,6 +1379,16 @@ static inline int pfn_present(unsigned long pfn)
>>>   return present_section(__nr_to_section(pfn_to_section_nr(pfn)));
>>> }
>>>=20
>>> +static inline unsigned long next_present_section_nr(unsigned long secti=
on_nr)
>>> +{
>>> +    while (++section_nr <=3D __highest_present_section_nr) {
>>> +        if (present_section_nr(section_nr))
>>> +            return section_nr;
>>> +    }
>>> +
>>> +    return -1;
>>> +}
>>> +
>>> /*
>>> * These are _only_ used during initialisation, therefore they
>>> * can use __initdata ...  They could have names to indicate
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index a92791512077..26e8044e9848 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -5852,18 +5852,11 @@ overlap_memmap_init(unsigned long zone, unsigned=
 long *pfn)
>>> /* Skip PFNs that belong to non-present sections */
>>> static inline __meminit unsigned long next_pfn(unsigned long pfn)
>>> {
>>> -    unsigned long section_nr;
>>> +    const unsigned long section_nr =3D pfn_to_section_nr(++pfn);
>>>=20
>>> -    section_nr =3D pfn_to_section_nr(++pfn);
>>>   if (present_section_nr(section_nr))
>>>       return pfn;
>>> -
>>> -    while (++section_nr <=3D __highest_present_section_nr) {
>>> -        if (present_section_nr(section_nr))
>>> -            return section_nr_to_pfn(section_nr);
>>> -    }
>>> -
>>> -    return -1;
>>> +    return section_nr_to_pfn(next_present_section_nr(section_nr));
>>=20
>> This changes behaviour in the corner case: if next_present_section_nr()
>> returns -1, we call section_nr_to_pfn() for it. It's unlikely would give
>> any valid pfn, but I can't say for sure for all archs. I guess the worst
>> case scenrio would be endless loop over the same secitons/pfns.
>>=20
>> Have you considered the case?
>=20
> Yes, see the patch description. We return -1 << PFN_SECTION_SHIFT, so a nu=
mber close to the end of the address space (0xfff...000). (Will double check=
 tomorrow if any 32bit arch could be problematic here)

... but thinking again, 0xfff... is certainly an invalid PFN, so this should=
 work just fine.

(biggest possible pfn is -1 >> PFN_SHIFT)

But it=E2=80=98s late in Germany, will double check tomorrow :)=

