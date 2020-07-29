Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A7BC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5282076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdkIpYLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgG2Ion (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:44:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39718 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgG2Ion (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596012280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=5y6sLodwxeVWldEuLL7e40j+rSSieWkQYEctvruINb4=;
        b=DdkIpYLKcu3yzmuwY8+Ms6y4lv9/RNxSn4b+NZzxrV8iaQD3HxdulPQm3QATh+q6tOvQyO
        0QsnC9MovDRa+7BGvvoNZxCI2Z7bMbA8xg0wMu/e8FSd8NcmZgmuR28NmA/mRBH7HBStr6
        qZvdWkIeH1u+jL+tFcMVe51YXfD4Rg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-zesZOHQjPKmULJPKd38RQw-1; Wed, 29 Jul 2020 04:44:34 -0400
X-MC-Unique: zesZOHQjPKmULJPKd38RQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8656B59;
        Wed, 29 Jul 2020 08:44:31 +0000 (UTC)
Received: from [10.36.114.111] (ovpn-114-111.ams2.redhat.com [10.36.114.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C10175C1BD;
        Wed, 29 Jul 2020 08:44:21 +0000 (UTC)
Subject: Re: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem
 alignment
To:     Justin He <Justin.He@arm.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Capper <Steve.Capper@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, Kaly Xin <Kaly.Xin@arm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
 <D1981D47-61F1-42E9-A426-6FEF0EC310C8@redhat.com>
 <AM6PR08MB40690714A2E77A7128B2B2ADF7700@AM6PR08MB4069.eurprd08.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <a6c56f12-9978-88b2-3cc5-2947356b3294@redhat.com>
Date:   Wed, 29 Jul 2020 10:44:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <AM6PR08MB40690714A2E77A7128B2B2ADF7700@AM6PR08MB4069.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.07.20 10:27, Justin He wrote:
> Hi David
> 
>> -----Original Message-----
>> From: David Hildenbrand <david@redhat.com>
>> Sent: Wednesday, July 29, 2020 2:37 PM
>> To: Justin He <Justin.He@arm.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>; Vishal Verma
>> <vishal.l.verma@intel.com>; Mike Rapoport <rppt@linux.ibm.com>; David
>> Hildenbrand <david@redhat.com>; Catalin Marinas <Catalin.Marinas@arm.com>;
>> Will Deacon <will@kernel.org>; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>; Rafael J. Wysocki <rafael@kernel.org>; Dave
>> Jiang <dave.jiang@intel.com>; Andrew Morton <akpm@linux-foundation.org>;
>> Steve Capper <Steve.Capper@arm.com>; Mark Rutland <Mark.Rutland@arm.com>;
>> Logan Gunthorpe <logang@deltatee.com>; Anshuman Khandual
>> <Anshuman.Khandual@arm.com>; Hsin-Yi Wang <hsinyi@chromium.org>; Jason
>> Gunthorpe <jgg@ziepe.ca>; Dave Hansen <dave.hansen@linux.intel.com>; Kees
>> Cook <keescook@chromium.org>; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; linux-nvdimm@lists.01.org; linux-mm@kvack.org; Wei
>> Yang <richardw.yang@linux.intel.com>; Pankaj Gupta
>> <pankaj.gupta.linux@gmail.com>; Ira Weiny <ira.weiny@intel.com>; Kaly Xin
>> <Kaly.Xin@arm.com>
>> Subject: Re: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem
>> alignment
>>
>>
>>
>>> Am 29.07.2020 um 05:35 schrieb Jia He <justin.he@arm.com>:
>>>
>>> ﻿When enabling dax pmem as RAM device on arm64, I noticed that kmem_start
>>> addr in dev_dax_kmem_probe() should be aligned w/
>> SECTION_SIZE_BITS(30),i.e.
>>> 1G memblock size. Even Dan Williams' sub-section patch series [1] had
>> been
>>> upstream merged, it was not helpful due to hard limitation of kmem_start:
>>> $ndctl create-namespace -e namespace0.0 --mode=devdax --map=dev -s 2g -f
>> -a 2M
>>> $echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
>>> $echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
>>> $cat /proc/iomem
>>> ...
>>> 23c000000-23fffffff : System RAM
>>>  23dd40000-23fecffff : reserved
>>>  23fed0000-23fffffff : reserved
>>> 240000000-33fdfffff : Persistent Memory
>>>  240000000-2403fffff : namespace0.0
>>>  280000000-2bfffffff : dax0.0          <- aligned with 1G boundary
>>>    280000000-2bfffffff : System RAM
>>> Hence there is a big gap between 0x2403fffff and 0x280000000 due to the
>> 1G
>>> alignment.
>>>
>>> Without this series, if qemu creates a 4G bytes nvdimm device, we can
>> only
>>> use 2G bytes for dax pmem(kmem) in the worst case.
>>> e.g.
>>> 240000000-33fdfffff : Persistent Memory
>>> We can only use the memblock between [240000000, 2ffffffff] due to the
>> hard
>>> limitation. It wastes too much memory space.
>>>
>>> Decreasing the SECTION_SIZE_BITS on arm64 might be an alternative, but
>> there
>>> are too many concerns from other constraints, e.g. PAGE_SIZE, hugetlb,
>>> SPARSEMEM_VMEMMAP, page bits in struct page ...
>>>
>>> Beside decreasing the SECTION_SIZE_BITS, we can also relax the kmem
>> alignment
>>> with memory_block_size_bytes().
>>>
>>> Tested on arm64 guest and x86 guest, qemu creates a 4G pmem device. dax
>> pmem
>>> can be used as ram with smaller gap. Also the kmem hotplug add/remove
>> are both
>>> tested on arm64/x86 guest.
>>>
>>
>> Hi,
>>
>> I am not convinced this use case is worth such hacks (that’s what it is)
>> for now. On real machines pmem is big - your example (losing 50% is
>> extreme).
>>
>> I would much rather want to see the section size on arm64 reduced. I
>> remember there were patches and that at least with a base page size of 4k
>> it can be reduced drastically (64k base pages are more problematic due to
>> the ridiculous THP size of 512M). But could be a section size of 512 is
>> possible on all configs right now.
> 
> Yes, I once investigated how to reduce section size on arm64 thoughtfully:
> There are many constraints for reducing SECTION_SIZE_BITS
> 1. Given page->flags bits is limited, SECTION_SIZE_BITS can't be reduced too
>    much.
> 2. Once CONFIG_SPARSEMEM_VMEMMAP is enabled, section id will not be counted
>    into page->flags.

Yep.

> 3. MAX_ORDER depends on SECTION_SIZE_BITS 
>  - 3.1 mmzone.h
> #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
> #error Allocator MAX_ORDER exceeds SECTION_SIZE
> #endif

Yep, with 4k base pages it's 4 MB. However, with 64k base pages its
512MB ( :( ).

>  - 3.2 hugepage_init()
> MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER >= MAX_ORDER);
> 
> Hence when ARM64_4K_PAGES && CONFIG_SPARSEMEM_VMEMMAP are enabled,
> SECTION_SIZE_BITS can be reduced to 27.
> But when ARM64_64K_PAGES, given 3.2, MAX_ORDER > 29-16 = 13.
> Given 3.1 SECTION_SIZE_BITS >= MAX_ORDER+15 > 28. So SECTION_SIZE_BITS can not
> be reduced to 27.

I think there were plans to eventually switch to 2MB THP with 64k base
pages as well (which can be emulated using some sort of consecutive PTE
entries under arm64, don't ask me how this feature is called),
theoretically also allowing smaller section sizes (when also reducing
MAX_ORDER properly) I would highly appreciate that switch. Having max
allocation/THP in the size of gigantic pages sounds very weird to me
(and creates issues e.g., to support hot(un)plug of small memory blocks
for virtio-mem). But I guess this is not under our control :)

> 
> In one word, if we considered to reduce SECTION_SIZE_BITS on arm64, the Kconfig
> might be very complicated,e.g. we still need to consider the case for
> ARM64_16K_PAGES.

Haven't looked into 16k base pages yet. But I remember it's in general
more similar to 4k than to 64k (speaking about sane THP sizes and
similar ...).

> 
>>
>> In the long term we might want to rework the memory block device model
>> (eventually supporting old/new as discussed with Michal some time ago
>> using a kernel parameter), dropping the fixed sizes
> 
> Has this been posted to Linux mm maillist? Sorry, searched and didn't find it.

Yeah, but I might not be able to dig it out anymore ...

Anyhow, the idea would be to have some magic switch that converts
between old and new world, to not break userspace that relies on that.

With old, everything would continue to work as it is. With *new* we
would have the reduced number of memory blocks for boot memory and
decoupled it from a strict, static memory block size.


There would be another option in corner cases right now. If you would
*know* that the metadata memory has no memmap/idendity mapping and have
1G alignment for your pmem device (including the metadata part)

1. add_memory_device_managed() the whole memory, including the metadata part
2. use generic_online_pages() to not expose metadata pages to the buddy
3. Mark metdata pages in a special way, such that you can e.g., allow to
offline memory again, including the metdata pages (e.g., PG_offline +
memory notifier like virtio-mem does)

3. would only be relevant to support offlining of memory again.

If the metadata part is, however, already ZONE_DEVICE with a memmap,
then that's not an option. (I have no idea how that metadata part is
used, sorry)


-- 
Thanks,

David / dhildenb

