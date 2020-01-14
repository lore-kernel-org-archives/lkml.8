Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E722C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48AE24681
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0IWLYk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgANMa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:30:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42760 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725994AbgANMa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579005055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=9eRj52C1+peq4w50rV4YnC62uxPGAZpTYF2uUUGAMwg=;
        b=a0IWLYk+HvjKEAn9ZVQfaY5J3Wn78ZBG9OCSCy+7+48dYZmt91+3qPuNZkj9UUuabFtkhu
        Tm0tvlpCyigUNwAlCFV0HXtuUtOWOeH6TKMkPXS6BsdlkKAmra84Z9i6zHIHL/qfgk2+op
        FsYkV58td2lIqZbkD2T17gV9XUp5HDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-hpZSS4q-NFWksr77-uSBdQ-1; Tue, 14 Jan 2020 07:30:52 -0500
X-MC-Unique: hpZSS4q-NFWksr77-uSBdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F46E6A2A7;
        Tue, 14 Jan 2020 12:30:49 +0000 (UTC)
Received: from [10.36.118.60] (unknown [10.36.118.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CD5EA4B60;
        Tue, 14 Jan 2020 12:30:43 +0000 (UTC)
Subject: Re: [PATCH V11 1/5] mm/hotplug: Introduce arch callback validating
 the hot remove range
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <dhildenb@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        cai@lca.pw, logang@deltatee.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        mgorman@techsingularity.net, osalvador@suse.de,
        ard.biesheuvel@arm.com, steve.capper@arm.com, broonie@kernel.org,
        valentin.schneider@arm.com, robin.murphy@arm.com,
        steven.price@arm.com, suzuki.poulose@arm.com, ira.weiny@intel.com
References: <6f0efddc-f124-58ca-28b6-4632469cf992@arm.com>
 <3C3BE5FA-0CFC-4C90-8657-63EF5B680B0B@redhat.com>
 <6b8fb779-31e8-1b63-85a8-9f6c93a04494@arm.com>
 <19194427-1295-3596-2c2c-463c4adf4f35@redhat.com>
 <78f04711-2ca6-280c-d0c2-ab9eea866e59@arm.com>
 <2c4b04d6-6d86-e87a-9b09-b931133a0d9c@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <2570152d-47b4-c9c0-6a40-18952355069d@redhat.com>
Date:   Tue, 14 Jan 2020 13:30:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <2c4b04d6-6d86-e87a-9b09-b931133a0d9c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.20 12:09, Anshuman Khandual wrote:
>=20
>=20
> On 01/14/2020 07:43 AM, Anshuman Khandual wrote:
>>
>>
>> On 01/13/2020 04:07 PM, David Hildenbrand wrote:
>>> On 13.01.20 10:50, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 01/13/2020 02:44 PM, David Hildenbrand wrote:
>>>>>
>>>>>
>>>>>> Am 13.01.2020 um 10:10 schrieb Anshuman Khandual <anshuman.khandua=
l@arm.com>:
>>>>>>
>>>>>> =EF=BB=BF
>>>>>>
>>>>>>> On 01/10/2020 02:12 PM, David Hildenbrand wrote:
>>>>>>>> On 10.01.20 04:09, Anshuman Khandual wrote:
>>>>>>>> Currently there are two interfaces to initiate memory range hot =
removal i.e
>>>>>>>> remove_memory() and __remove_memory() which then calls try_remov=
e_memory().
>>>>>>>> Platform gets called with arch_remove_memory() to tear down requ=
ired kernel
>>>>>>>> page tables and other arch specific procedures. But there are pl=
atforms
>>>>>>>> like arm64 which might want to prevent removal of certain specif=
ic memory
>>>>>>>> ranges irrespective of their present usage or movability propert=
ies.
>>>>>>>
>>>>>>> Why? Is this only relevant for boot memory? I hope so, otherwise =
the
>>>>>>> arch code needs fixing IMHO.
>>>>>>
>>>>>> Right, it is relevant only for the boot memory on arm64 platform. =
But this
>>>>>> new arch callback makes it flexible to reject any given memory ran=
ge.
>>>>>>
>>>>>>>
>>>>>>> If it's only boot memory, we should disallow offlining instead vi=
a a
>>>>>>> memory notifier - much cleaner.
>>>>>>
>>>>>> Dont have much detail understanding of MMU notifier mechanism but =
from some
>>>>>> initial reading, it seems like we need to have a mm_struct for a n=
otifier
>>>>>> to monitor various events on the page table. Just wondering how a =
physical
>>>>>> memory range like boot memory can be monitored because it can be u=
sed both
>>>>>> for for kernel (init_mm) or user space process at same time. Is th=
ere some
>>>>>> mechanism we could do this ?
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Current arch call back arch_remove_memory() is too late in the p=
rocess to
>>>>>>>> abort memory hot removal as memory block devices and firmware me=
mory map
>>>>>>>> entries would have already been removed. Platforms should be abl=
e to abort
>>>>>>>> the process before taking the mem_hotplug_lock with mem_hotplug_=
begin().
>>>>>>>> This essentially requires a new arch callback for memory range v=
alidation.
>>>>>>>
>>>>>>> I somewhat dislike this very much. Memory removal should never fa=
il if
>>>>>>> used sanely. See e.g., __remove_memory(), it will BUG() whenever
>>>>>>> something like that would strike.
>>>>>>>
>>>>>>>>
>>>>>>>> This differentiates memory range validation between memory hot a=
dd and hot
>>>>>>>> remove paths before carving out a new helper check_hotremove_mem=
ory_range()
>>>>>>>> which incorporates a new arch callback. This call back provides =
platforms
>>>>>>>> an opportunity to refuse memory removal at the very onset. In fu=
ture the
>>>>>>>> same principle can be extended for memory hot add path if requir=
ed.
>>>>>>>>
>>>>>>>> Platforms can choose to override this callback in order to rejec=
t specific
>>>>>>>> memory ranges from removal or can just fallback to a default imp=
lementation
>>>>>>>> which allows removal of all memory ranges.
>>>>>>>
>>>>>>> I suspect we want really want to disallow offlining instead. E.g.=
, I
>>>>>>
>>>>>> If boot memory pages can be prevented from being offlined for sure=
, then it
>>>>>> would indirectly definitely prevent hot remove process as well.
>>>>>>
>>>>>>> remember s390x does that with certain areas needed for dumping/ke=
xec.
>>>>>>
>>>>>> Could not find any references to mmu_notifier in arch/s390 or any =
other arch
>>>>>> for that matter apart from KVM (which has an user space component)=
, could you
>>>>>> please give some pointers ?
>>>>>
>>>>> Memory (hotplug) notifier, not MMU notifier :)
>>>>
>>>> They are so similarly named :)
>>>>
>>>>>
>>>>> Not on my notebook right now, grep for MEM_GOING_OFFLINE, that shou=
ld be it.
>>>>>
>>>>
>>>> Got it, thanks ! But we will still need boot memory enumeration via =
MEMBLOCK_BOOT
>>>> to reject affected offline requests in the callback.
>>>
>>> Do you really need that?
>>>
>>> We have SECTION_IS_EARLY. You could iterate all involved sections (fo=
r
>>> which you are getting notified) and check if any one of these is mark=
ed
>>> SECTION_IS_EARLY. then, it was added during boot and not via add_memo=
ry().
>>
>> Seems to be a better approach than adding a new memblock flag.
>=20
> These additional changes do the trick and prevent boot memory removal.
> Hope this is in line with your earlier suggestion.
>=20
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 00f3e1836558..3b59e6a29dea 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -17,6 +17,7 @@
> +++ b/arch/arm64/mm/mmu.c
> @@ -17,6 +17,7 @@
>  #include <linux/mman.h>
>  #include <linux/nodemask.h>
>  #include <linux/memblock.h>
> +#include <linux/memory.h>
>  #include <linux/fs.h>
>  #include <linux/io.h>
>  #include <linux/mm.h>
> @@ -1365,4 +1366,37 @@ void arch_remove_memory(int nid, u64 start, u64 =
size,
>         __remove_pages(start_pfn, nr_pages, altmap);
>         __remove_pgd_mapping(swapper_pg_dir, __phys_to_virt(start), siz=
e);
>  }
> +
> +static int boot_mem_remove_notifier(struct notifier_block *nb,
> +                                   unsigned long action, void *data)
> +{
> +       unsigned long start_pfn, end_pfn, pfn, section_nr;
> +       struct mem_section *ms;
> +       struct memory_notify *arg =3D data;
> +
> +       start_pfn =3D=20
> +       end_pfn =3D start_pfn + arg->nr_pages;

You can initialize some of these directly

struct memory_notify *arg =3D data;
const unsigned long end_pfn =3D arg->start_pfn; + arg->nr_pages;
unsigned long pfn =3D arg->start_pfn;

and avoid start_pfn.

> +
> +       if (action !=3D MEM_GOING_OFFLINE)
> +               return NOTIFY_OK;
> +
> +       for (pfn =3D start_pfn; pfn < end_pfn; pfn +=3D PAGES_PER_SECTI=
ON) {
> +               section_nr =3D ;
> +               ms =3D __nr_to_section(section_nr);

Also, I think you can avoid section_nr.

		ms =3D __nr_to_section(pfn_to_section_nr(pfn));

> +
> +               if (early_section(ms))
> +                       return NOTIFY_BAD;
> +       }
> +       return NOTIFY_OK;
> +}
> +
> +static struct notifier_block boot_mem_remove_nb =3D {
> +       .notifier_call =3D boot_mem_remove_notifier,
> +};
> +
> +static int __init boot_mem_remove_init(void)
> +{
> +       return register_memory_notifier(&boot_mem_remove_nb);
> +}
> +device_initcall(boot_mem_remove_init);
>  #endif

Exactly what I was suggesting :)

If we ever need to offline+re-online boot memory (e.g., to a different
zone), we can think of something else.

--=20
Thanks,

David / dhildenb

