Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A48C33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A896D214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBYeuidB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgAMI5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:57:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45997 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727325AbgAMI5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578905834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/8jjd0naK5yUfMwY72nPxcwXV/oe8/+GoHM6O1vObkI=;
        b=PBYeuidBoLr1BbFJXdNrqoM3UtKB+8vEAHxyAtnIgKDzLdI0ZG5T4FRGgDKiVwe6umE2F0
        PpMy0kwzvon5xmoD1P5w92dqBeimAbKo04ABjtublE/6PrnPlMyz8Bb+XSaSo+899Qk5NA
        590/K/V04R9JGXbzOLFP60XMKbeWTsU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-LNDL1G75NsCN5XlaS-uVfA-1; Mon, 13 Jan 2020 03:57:13 -0500
X-MC-Unique: LNDL1G75NsCN5XlaS-uVfA-1
Received: by mail-wr1-f71.google.com with SMTP id c17so4663616wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 00:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=/8jjd0naK5yUfMwY72nPxcwXV/oe8/+GoHM6O1vObkI=;
        b=lK7VguusL9zyd/Lo6uDwUSg4kh2xjkIsbcCk8Hnf2cXaBFrW3vGeS7dNuLGYm9V+qr
         vAKYl7Du0u3kpzug0Go59zjTe6sBarwL2e7u44a6okOvbln5cKk0WZgQffUlYwwnlc21
         3CtqNoi2o+AsL2fgBTU/1CwTdUBmbvSPOgqyAqFRpVJS8ASJyPsLOGDj9aN1FRQCVVNb
         QUnQfnLLeKdFGPcFYMwJFDaLve1lDdyl8RqT5noY/N9KQNRZqY7af+KXOsnImx47KuyL
         XaOPAjP4FNPrugDcg4jjfnv1y0Y3zYq3ih72zKiCZ9rN6Pi4ABNI7x8FlUOmf2Hw5Fz0
         Qnhw==
X-Gm-Message-State: APjAAAVIwY9WRZZw6dzio0zy3O8etLnYrlO5V1lkh0EpiKiaA9oCK8ah
        OHI2RmsQBP7hspnlvDoDu44Nh3+FB2fMG3tAwOeksiuTBXOF1yRilqvb5sHcZe9cbfPD0qMSk5N
        Xn/qaLdPf2Be30FAsclpK1HKA
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr17811297wrm.262.1578905831872;
        Mon, 13 Jan 2020 00:57:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqwF0kUnrNLDD5EzuOc11BAoE/EIsGFlPEyEanuIV9dNnJKSOmjB0O8bGGRRL5aTmJgHXY6KaQ==
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr17811261wrm.262.1578905831571;
        Mon, 13 Jan 2020 00:57:11 -0800 (PST)
Received: from ?IPv6:2a01:598:a803:c918:91cf:ba30:dbb0:f19? ([2a01:598:a803:c918:91cf:ba30:dbb0:f19])
        by smtp.gmail.com with ESMTPSA id b18sm14133777wru.50.2020.01.13.00.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 00:57:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V11 2/5] mm/memblock: Introduce MEMBLOCK_BOOT flag
Date:   Mon, 13 Jan 2020 09:57:09 +0100
Message-Id: <12BCAD36-D99C-4AC0-B466-06E1A02DDD72@redhat.com>
References: <08a2f82a-3201-055a-316a-a2f11c7ff7a5@arm.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, mark.rutland@arm.com,
        david@redhat.com, catalin.marinas@arm.com, linux-mm@kvack.org,
        arunks@codeaurora.org, cpandya@codeaurora.org, will@kernel.org,
        ira.weiny@intel.com, steven.price@arm.com,
        valentin.schneider@arm.com, suzuki.poulose@arm.com,
        robin.murphy@arm.com, broonie@kernel.org, cai@lca.pw,
        ard.biesheuvel@arm.com, dan.j.williams@intel.com,
        linux-arm-kernel@lists.infradead.org, osalvador@suse.de,
        steve.capper@arm.com, logang@deltatee.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net
In-Reply-To: <08a2f82a-3201-055a-316a-a2f11c7ff7a5@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 13.01.2020 um 09:41 schrieb Anshuman Khandual <anshuman.khandual@arm.co=
m>:
>=20
> =EF=BB=BF
>=20
>> On 01/13/2020 01:07 PM, Mike Rapoport wrote:
>>> On Fri, Jan 10, 2020 at 08:39:12AM +0530, Anshuman Khandual wrote:
>>> On arm64 platform boot memory should never be hot removed due to certain=

>>> platform specific constraints. Hence the platform would like to override=

>>> earlier added arch call back arch_memory_removable() for this purpose. I=
n
>>> order to reject boot memory hot removal request, it needs to first track=

>>> them at runtime. In the future, there might be other platforms requiring=

>>> runtime boot memory enumeration. Hence lets expand the existing generic
>>> memblock framework for this purpose rather then creating one just for
>>> arm64 platforms.
>>>=20
>>> This introduces a new memblock flag MEMBLOCK_BOOT along with helpers whi=
ch
>>> can be marked by given platform on all memory regions discovered during
>>> boot.
>>=20
>> We already have MEMBLOCK_HOTPLUG to mark hotpluggable region. Can't we us=
e
>> it for your use-case?
>=20
> At present MEMBLOCK_HOTPLUG flag helps in identifying parts of boot memory=

> as hotpluggable as indicated by the firmware. This information is then use=
d
> to avoid those regions during standard memblock_alloc_*() API requests and=

> later marking them as ZONE_MOVABLE when buddy gets initialized.
>=20
> Memory hot remove does not check for MEMBLOCK_HOTPLUG flag as a requiremen=
t
> before initiating the process. We could probably use this flag if generic
> hot remove can be changed to check for MEMBLOCK_HOTPLUG as a prerequisite
> which will require changes to memblock handling (boot and runtime) on all
> existing platforms currently supporting hot remove. But what about handlin=
g
> the movable boot memory created with movablecore/kernelcore command line,
> should generic MM update their memblock regions with MEMBLOCK_HOTPLUG ?

As I said in my other mail, just disallow offlining of the affected (boot) m=
emory blocks using a memory notifier and you should be good to go. No change=
s in memory unplug code required.

>=20
>>=20
>>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> include/linux/memblock.h | 10 ++++++++++
>>> mm/memblock.c            | 37 +++++++++++++++++++++++++++++++++++++
>>> 2 files changed, 47 insertions(+)
>>>=20
>>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>> index b38bbef..fb04c87 100644
>>> --- a/include/linux/memblock.h
>>> +++ b/include/linux/memblock.h
>>> @@ -31,12 +31,14 @@ extern unsigned long long max_possible_pfn;
>>>  * @MEMBLOCK_HOTPLUG: hotpluggable region
>>>  * @MEMBLOCK_MIRROR: mirrored region
>>>  * @MEMBLOCK_NOMAP: don't add to kernel direct mapping
>>> + * @MEMBLOCK_BOOT: memory received from firmware during boot
>>>  */
>>> enum memblock_flags {
>>>    MEMBLOCK_NONE        =3D 0x0,    /* No special request */
>>>    MEMBLOCK_HOTPLUG    =3D 0x1,    /* hotpluggable region */
>>>    MEMBLOCK_MIRROR        =3D 0x2,    /* mirrored region */
>>>    MEMBLOCK_NOMAP        =3D 0x4,    /* don't add to kernel direct mappi=
ng */
>>> +    MEMBLOCK_BOOT        =3D 0x8,    /* memory received from firmware d=
uring boot */
>>> };
>>>=20
>>> /**
>>> @@ -116,6 +118,8 @@ int memblock_reserve(phys_addr_t base, phys_addr_t s=
ize);
>>> void memblock_trim_memory(phys_addr_t align);
>>> bool memblock_overlaps_region(struct memblock_type *type,
>>>                  phys_addr_t base, phys_addr_t size);
>>> +int memblock_mark_boot(phys_addr_t base, phys_addr_t size);
>>> +int memblock_clear_boot(phys_addr_t base, phys_addr_t size);
>>> int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
>>> int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>>> int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
>>> @@ -216,6 +220,11 @@ static inline bool memblock_is_nomap(struct membloc=
k_region *m)
>>>    return m->flags & MEMBLOCK_NOMAP;
>>> }
>>>=20
>>> +static inline bool memblock_is_boot(struct memblock_region *m)
>>> +{
>>> +    return m->flags & MEMBLOCK_BOOT;
>>> +}
>>> +
>>> #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
>>> int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,=

>>>                unsigned long  *end_pfn);
>>> @@ -449,6 +458,7 @@ void memblock_cap_memory_range(phys_addr_t base, phy=
s_addr_t size);
>>> void memblock_mem_limit_remove_map(phys_addr_t limit);
>>> bool memblock_is_memory(phys_addr_t addr);
>>> bool memblock_is_map_memory(phys_addr_t addr);
>>> +bool memblock_is_boot_memory(phys_addr_t addr);
>>> bool memblock_is_region_memory(phys_addr_t base, phys_addr_t size);
>>> bool memblock_is_reserved(phys_addr_t addr);
>>> bool memblock_is_region_reserved(phys_addr_t base, phys_addr_t size);
>>> diff --git a/mm/memblock.c b/mm/memblock.c
>>> index 4bc2c7d..e10207f 100644
>>> --- a/mm/memblock.c
>>> +++ b/mm/memblock.c
>>> @@ -865,6 +865,30 @@ static int __init_memblock memblock_setclr_flag(phy=
s_addr_t base,
>>> }
>>>=20
>>> /**
>>> + * memblock_mark_bootmem - Mark boot memory with flag MEMBLOCK_BOOT.
>>> + * @base: the base phys addr of the region
>>> + * @size: the size of the region
>>> + *
>>> + * Return: 0 on success, -errno on failure.
>>> + */
>>> +int __init_memblock memblock_mark_boot(phys_addr_t base, phys_addr_t si=
ze)
>>> +{
>>> +    return memblock_setclr_flag(base, size, 1, MEMBLOCK_BOOT);
>>> +}
>>> +
>>> +/**
>>> + * memblock_clear_bootmem - Clear flag MEMBLOCK_BOOT for a specified re=
gion.
>>> + * @base: the base phys addr of the region
>>> + * @size: the size of the region
>>> + *
>>> + * Return: 0 on success, -errno on failure.
>>> + */
>>> +int __init_memblock memblock_clear_boot(phys_addr_t base, phys_addr_t s=
ize)
>>> +{
>>> +    return memblock_setclr_flag(base, size, 0, MEMBLOCK_BOOT);
>>> +}
>>> +
>>> +/**
>>>  * memblock_mark_hotplug - Mark hotpluggable memory with flag MEMBLOCK_H=
OTPLUG.
>>>  * @base: the base phys addr of the region
>>>  * @size: the size of the region
>>> @@ -974,6 +998,10 @@ static bool should_skip_region(struct memblock_regi=
on *m, int nid, int flags)
>>>    if ((flags & MEMBLOCK_MIRROR) && !memblock_is_mirror(m))
>>>        return true;
>>>=20
>>> +    /* if we want boot memory skip non-boot memory regions */
>>> +    if ((flags & MEMBLOCK_BOOT) && !memblock_is_boot(m))
>>> +        return true;
>>> +
>>>    /* skip nomap memory unless we were asked for it explicitly */
>>>    if (!(flags & MEMBLOCK_NOMAP) && memblock_is_nomap(m))
>>>        return true;
>>> @@ -1785,6 +1813,15 @@ bool __init_memblock memblock_is_map_memory(phys_=
addr_t addr)
>>>    return !memblock_is_nomap(&memblock.memory.regions[i]);
>>> }
>>>=20
>>> +bool __init_memblock memblock_is_boot_memory(phys_addr_t addr)
>>> +{
>>> +    int i =3D memblock_search(&memblock.memory, addr);
>>> +
>>> +    if (i =3D=3D -1)
>>> +        return false;
>>> +    return memblock_is_boot(&memblock.memory.regions[i]);
>>> +}
>>> +
>>> #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
>>> int __init_memblock memblock_search_pfn_nid(unsigned long pfn,
>>>             unsigned long *start_pfn, unsigned long *end_pfn)
>>> --=20
>>> 2.7.4
>>>=20
>>=20
>=20

