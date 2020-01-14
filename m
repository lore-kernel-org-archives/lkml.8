Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818E9C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1E72072B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaO7Bgy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgANIac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:30:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57815 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725820AbgANIab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578990629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=anFLJs72TKHU5JfVk1MfiSh3J5J5mkNkxtuJX7w+loc=;
        b=GaO7Bgy0ynN8wOdZzL3W5+KYr2qpZGcSN4sMRrjT8ZOjqjvKGq/yxEsp6MsZJlHlTrKhD1
        x3/nxMSn0F4zLFftwsmyuqENGkGC1+OoI1fUBk9JROPQu7uNckVt55aV5NRJPZSgf3pMW+
        kNT30mXBXV26/qa9mQLB5AdFLbydFWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-0HduMfy1NAadjriOad3Llw-1; Tue, 14 Jan 2020 03:30:26 -0500
X-MC-Unique: 0HduMfy1NAadjriOad3Llw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C42FE8024D4;
        Tue, 14 Jan 2020 08:30:23 +0000 (UTC)
Received: from [10.36.117.154] (ovpn-117-154.ams2.redhat.com [10.36.117.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7586C5DA70;
        Tue, 14 Jan 2020 08:30:20 +0000 (UTC)
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
References: <49fa7dea-00ac-155f-e7b7-eeca206556b5@arm.com>
 <6A58E80B-7A5F-4CAD-ACF1-89BCCBE4D3B1@lca.pw>
 <a0bfcebe-a0f4-95ef-0973-8edd3780d013@redhat.com>
 <f6487dc1-c962-67aa-131e-2eec4f6ca686@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <85c5a146-0014-16cc-0c31-9b99fc02e847@redhat.com>
Date:   Tue, 14 Jan 2020 09:30:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <f6487dc1-c962-67aa-131e-2eec4f6ca686@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.20 09:19, Anshuman Khandual wrote:
> 
> 
> On 10/04/2019 01:55 PM, David Hildenbrand wrote:
>> On 03.10.19 14:14, Qian Cai wrote:
>>>
>>>
>>>> On Oct 3, 2019, at 8:01 AM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>>>
>>>> Will something like this be better ?
>>>
>>> Not really. dump_page() will dump PageCompound information anyway, so it is trivial to figure out if went in that path.
>>>
>>
>> I agree, I use the dump_page() output frequently to identify PG_reserved
>> pages. No need to duplicate that.
> 
> Here in this path there is a reserved page which is preventing
> offlining a memory section but unfortunately dump_page() does
> not print page->flags for a reserved page pinned there possibly
> through memblock_reserve() during boot.
> 
> __offline_pages()
> 	start_isolate_page_range()
> 		set_migratetype_isolate()
> 			has_unmovable_pages()
> 				dump_page() 
> 
> [   64.920970] ------------[ cut here ]------------
> [   64.921718] WARNING: CPU: 16 PID: 1116 at mm/page_alloc.c:8298 has_unmovable_pages+0x274/0x2a8
> [   64.923110] Modules linked in:
> [   64.923634] CPU: 16 PID: 1116 Comm: bash Not tainted 5.5.0-rc6-00006-gca544f2a11ae-dirty #281
> [   64.925102] Hardware name: linux,dummy-virt (DT)
> [   64.925905] pstate: 60400085 (nZCv daIf +PAN -UAO)
> [   64.926742] pc : has_unmovable_pages+0x274/0x2a8
> [   64.927554] lr : has_unmovable_pages+0x298/0x2a8
> [   64.928359] sp : ffff800014fd3a00
> [   64.928944] x29: ffff800014fd3a00 x28: fffffe0017640000 
> [   64.929875] x27: 0000000000000000 x26: ffff0005fcfcda00 
> [   64.930810] x25: 0000000000640000 x24: 0000000000000003 
> [   64.931736] x23: 0000000019840000 x22: 0000000000001380 
> [   64.932667] x21: ffff800011259000 x20: ffff0005fcfcda00 
> [   64.933588] x19: 0000000000661000 x18: 0000000000000010 
> [   64.934514] x17: 0000000000000000 x16: 0000000000000000 
> [   64.935454] x15: ffffffffffffffff x14: ffff8000118498c8 
> [   64.936377] x13: ffff800094fd3797 x12: ffff800014fd379f 
> [   64.937304] x11: ffff800011861000 x10: ffff800014fd3720 
> [   64.938226] x9 : 00000000ffffffd0 x8 : ffff8000106a60d0 
> [   64.939156] x7 : 0000000000000000 x6 : ffff0005fc6261b0 
> [   64.940078] x5 : ffff0005fc6261b0 x4 : 0000000000000000 
> [   64.941003] x3 : ffff0005fc62cf80 x2 : ffffffffffffec80 
> [   64.941927] x1 : ffff800011141b58 x0 : ffff0005fcfcda00 
> [   64.942857] Call trace:
> [   64.943298]  has_unmovable_pages+0x274/0x2a8
> [   64.944056]  start_isolate_page_range+0x258/0x360
> [   64.944879]  __offline_pages+0xf4/0x9e8
> [   64.945554]  offline_pages+0x10/0x18
> [   64.946189]  memory_block_action+0x40/0x1a0
> [   64.946929]  memory_subsys_offline+0x4c/0x78
> [   64.947679]  device_offline+0x98/0xc8
> [   64.948328]  unprobe_store+0xa8/0x158
> [   64.948976]  dev_attr_store+0x14/0x28
> [   64.949628]  sysfs_kf_write+0x40/0x50
> [   64.950273]  kernfs_fop_write+0x108/0x218
> [   64.950983]  __vfs_write+0x18/0x40
> [   64.951592]  vfs_write+0xb0/0x1d0
> [   64.952175]  ksys_write+0x64/0xe8
> [   64.952761]  __arm64_sys_write+0x18/0x20
> [   64.953451]  el0_svc_common.constprop.2+0x88/0x150
> [   64.954293]  el0_svc_handler+0x20/0x80
> [   64.954963]  el0_sync_handler+0x118/0x188
> [   64.955669]  el0_sync+0x140/0x180
> [   64.956256] ---[ end trace b162b4d1cbea304d ]---
> [   64.957063] page:fffffe0017640000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
> [   64.958489] raw: 1ffff80000001000 fffffe0017640008 fffffe0017640008 0000000000000000
> [   64.959839] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> [   64.961174] page dumped because: unmovable page
> 
> The reason is dump_page() does not print page->flags universally
> and only does so for KSM, Anon and File pages while excluding
> reserved pages at boot. Wondering should not we make printing
> page->flags universal ?

The thing is that "PageReserved" on a random page tells us that the
values in the memmap cannot be trusted (in some scenarios).

However, we also expose flags for reserved pages via stable_page_flags()
- /proc/kpageflags. As this is just a debugging mechanism, I think it
makes sense to also print them.


-- 
Thanks,

David / dhildenb

