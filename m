Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B397BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8708F2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXDXs3eU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbgEZIp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:45:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33485 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727948AbgEZIp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590482756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A2gPYZsvlCWG6qCp9z9PddRYT7m0NpQJX5STo5s8nf4=;
        b=NXDXs3eUMWZvhudl8+JJuE4nTb382mw664u9h5Z3XTzzhyEY7MN3AHPYEC0CssbahYttcT
        NK6uYvLLs4pm5xwR/SjpDsOV3Tt//xnVktsCV2GZ5Cl75Yc/Ldhzo8HDniirkxxzsbogar
        lzOFaliXnCMWDyw2IOE8ISP9kLCPIp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-KKlDxKSOPJKRxDJ2JJvfgQ-1; Tue, 26 May 2020 04:45:52 -0400
X-MC-Unique: KKlDxKSOPJKRxDJ2JJvfgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ADF9800688;
        Tue, 26 May 2020 08:45:50 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D46A78362;
        Tue, 26 May 2020 08:45:45 +0000 (UTC)
Date:   Tue, 26 May 2020 16:45:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>, mgorman@suse.de,
        david@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, cai@lca.pw, mhocko@kernel.org
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages()
Message-ID: <20200526084543.GG26955@MiWiFi-R3L-srv>
References: <20200521014407.29690-1-bhe@redhat.com>
 <20200521092612.GP1059226@linux.ibm.com>
 <20200521155225.GA20045@MiWiFi-R3L-srv>
 <20200521171836.GU1059226@linux.ibm.com>
 <20200522070114.GE26955@MiWiFi-R3L-srv>
 <20200522072524.GF26955@MiWiFi-R3L-srv>
 <20200522142053.GW1059226@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522142053.GW1059226@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/20 at 05:20pm, Mike Rapoport wrote:
> Hello Baoquan,
> 
> On Fri, May 22, 2020 at 03:25:24PM +0800, Baoquan He wrote:
> > On 05/22/20 at 03:01pm, Baoquan He wrote:
> > > 
> > > So let's add these unavailable ranges into memblock and reserve them
> > > in init_unavailable_range() instead. With this change, they will be added
> > > into appropriate node and zone in memmap_init(), and initialized in
> > > reserve_bootmem_region() just like any other memblock reserved regions.
> > 
> > Seems this is not right. They can't get nid in init_unavailable_range().
> > Adding e820 ranges may let them get nid. But the hole range won't be
> > added to memblock, and still has the issue.
> > 
> > Nack this one for now, still considering.
> 
> Why won't we add  the e820 reserved ranges to memblock.memory during
> early boot as I suggested?
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index c5399e80c59c..b0940c618ed9 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1301,8 +1301,11 @@ void __init e820__memblock_setup(void)
>  		if (end != (resource_size_t)end)
>  			continue;
>  
> -		if (entry->type == E820_TYPE_SOFT_RESERVED)
> +		if (entry->type == E820_TYPE_SOFT_RESERVED ||
> +		    entry->type == E820_TYPE_RESERVED) {
> +			memblock_add(entry->addr, entry->size);
>  			memblock_reserve(entry->addr, entry->size);
> +		}
>  
>  		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
>  			continue;
> 
> The setting of node later  in numa_init() will assign the proper node
> for these regions as it does for the usable memory.

Yes, if it's only related to e820 reserved region, this truly works.

However, it also has ACPI table regions. That's why I changed to call
the problematic area as firmware reserved ranges later.

Bisides, you can see below line, there's another reserved region which only
occupies one page in one memory seciton. If adding to memblock.memory, we also
will build struct mem_section and the relevant struct pages for the whole
section. And then the holes around that page will be added and initialized in
init_unavailable_mem(). numa_init() will assign proper node for memblock.memory
and memblock.reserved, but won't assign proper node for the holes.

~~~
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
~~~

So I still think we should not add firmware reserved range into
memblock for fixing this issue.

And, the fix in the original patch seems necessary. You can see in
compaction code, the migration source is chosen from LRU pages or
movable pages, the migration target has to be got from Buddy. However,
only the min_pfn in fast_isolate_freepages(), it's calculated by
distance between cc->free_pfn - cc->migrate_pfn, we can't guarantee it's
safe, then use it as the target to handle.

Hi David,

Meanwhile, I checked the history of init_unavailable_mem(). Till below
commit From David, the unavailable ranges began to be added to zone 0
and node 0. Before that, we only zero the struct page of unavailable
ranges and mark it as Reserved. Am wondering if we have to add it to
node 0 and zone 0. From below commit, I don't get why. Could you help
clarify so that I get what I missed?

commit 4b094b7851bf4bf551ad456195d3f26e1c03bd74
Author: David Hildenbrand <david@redhat.com>
Date:   Mon Feb 3 17:33:55 2020 -0800

    mm/page_alloc.c: initialize memmap of unavailable memory directly

I have sent mail to Naoya trying to make clear question I have,
see if we can do something to clean up the mess here.


[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008c000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000028328fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000028329000-0x0000000028568fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000028569000-0x0000000028d85fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000028d86000-0x0000000028ee5fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000028ee6000-0x0000000029a04fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000029a05000-0x0000000029a08fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000029a09000-0x0000000029ee4fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000029ee5000-0x0000000029ef2fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000029ef3000-0x0000000029f22fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000029f23000-0x0000000029f23fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000029f24000-0x0000000029f24fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000029f25000-0x0000000029f28fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000029f29000-0x0000000029f29fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000029f2a000-0x0000000029f2bfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000029f2c000-0x0000000029f2cfff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000029f2d000-0x0000000029f2ffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000029f30000-0x0000000029ffdfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000029ffe000-0x000000002a80afff] reserved
[    0.000000] BIOS-e820: [mem 0x000000002a80b000-0x000000002a80efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000002a80f000-0x000000002a81ffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000002a820000-0x000000002a822fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000002a823000-0x0000000033a22fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000033a23000-0x0000000033a32fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000033a33000-0x0000000033a42fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000033a43000-0x0000000033a52fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000033a53000-0x0000000077ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000078000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087effffff] usable
[    0.000000] BIOS-e820: [mem 0x000000087f000000-0x000000087fffffff] reserved

