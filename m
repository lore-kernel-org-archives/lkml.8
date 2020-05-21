Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A81FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7043820829
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/Z8bKjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgEUPwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:52:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41177 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbgEUPwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590076353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Gvj/7T2IDb/JdSH5QRe4c+ocoKQtvVWgDX790pAa5o=;
        b=T/Z8bKjgab+pfiT/ikamrih3AuWyNgDZ9NS7V8F1AwbQLuesF60OcfkrIiKsAhRNcCKQAV
        LLZcXFDdORX7bYFLcBc+doVLzBuxZ3iE6eUToJl80Ye1ZB+87it/HoJpsgnuSG90IYkdYk
        xbcKB8sypxJlUXuXQPcUPc9Scyobk8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-AGZBepPoPp2ADqs6fDvXOA-1; Thu, 21 May 2020 11:52:30 -0400
X-MC-Unique: AGZBepPoPp2ADqs6fDvXOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1601EC1A7;
        Thu, 21 May 2020 15:52:28 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 164CB6AD16;
        Thu, 21 May 2020 15:52:27 +0000 (UTC)
Date:   Thu, 21 May 2020 23:52:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, cai@lca.pw, mgorman@suse.de,
        mhocko@kernel.org
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages()
Message-ID: <20200521155225.GA20045@MiWiFi-R3L-srv>
References: <20200521014407.29690-1-bhe@redhat.com>
 <20200521092612.GP1059226@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521092612.GP1059226@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/20 at 12:26pm, Mike Rapoport wrote:
> > For this kind of e820 reserved range, it won't be added to memblock allocator.
> > However, init_unavailable_mem() will initialize to add them into node 0,
> > zone 0. Before that commit, later, memmap_init() will add e820 reserved
> > ranges into the zone where they are contained, because it can pass
> > the checking of early_pfn_valid() and early_pfn_in_nid(). In this case,
> > the e820 reserved range where fault page 0x2a800000 is located is added
> > into DMA32 zone. After that commit, the e820 reserved rgions are kept
> > in node 0, zone 0, since we iterate over memblock regions to iniatialize
> > in memmap_init() instead, their node and zone won't be changed.
> 
> I wonder why woudn't we add the reserved memory to memblock from the
> very beginning...
> I've tried to undestand why this was not done, but I couldn't find the
> reasoning behind that.

I have added some explanation when reply to Mel. Please check that in
that thread.

As I said, the unavailable range includes firmware reserved ranges, and
holes inside one boot memory section, if that boot memory section haves
useable memory range, and firmware reserved ranges, and holes. Adding
them all into memblock seems a little unreasonable, since they are never
used by system in memblock, buddy or high level memory allocator. But I
can see that adding them into memblock may have the same effect as the
old code which is beofre your your patchset applied. Let's see if Mel or
other people have some saying. I pesonally would not suggest doing it
like this though.

> 
> Can you please try the below patch and see if it helps or, on the
> contrary, breaks anything else :)
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
> > Now, fast_isolate_freepages() will use min mark directly as the migration
> > target if no page is found from buddy. However, the min mark is not checked
> > carefully, it could be in e820 reserved range, and trigger the
> > VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn)) when try to mark it
> > as skip.
> > 
> > Here, let's call pageblock_pfn_to_page() to get page of min_pfn, since it
> > will do careful checks and return NULL if the pfn is not qualified.
> > 
> > [    0.000000] BIOS-provided physical RAM map:
> > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008bfff] usable
> > [    0.000000] BIOS-e820: [mem 0x000000000008c000-0x000000000009ffff] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000028328fff] usable
> > [    0.000000] BIOS-e820: [mem 0x0000000028329000-0x0000000028568fff] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000028569000-0x0000000028d85fff] usable
> > [    0.000000] BIOS-e820: [mem 0x0000000028d86000-0x0000000028ee5fff] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000028ee6000-0x0000000029a04fff] usable
> > [    0.000000] BIOS-e820: [mem 0x0000000029a05000-0x0000000029a08fff] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000029a09000-0x0000000029ee4fff] usable
> > [    0.000000] BIOS-e820: [mem 0x0000000029ee5000-0x0000000029ef2fff] ACPI data
> > [    0.000000] BIOS-e820: [mem 0x0000000029ef3000-0x0000000029f22fff] usable
> > [    0.000000] BIOS-e820: [mem 0x0000000029f23000-0x0000000029f23fff] ACPI data
> > [    0.000000] BIOS-e820: [mem 0x0000000029f24000-0x0000000029f24fff] usable
> > [    0.000000] BIOS-e820: [mem 0x0000000029f25000-0x0000000029f28fff] ACPI data
> > [    0.000000] BIOS-e820: [mem 0x0000000029f29000-0x0000000029f29fff] ACPI NVS
> > [    0.000000] BIOS-e820: [mem 0x0000000029f2a000-0x0000000029f2bfff] ACPI data
> > [    0.000000] BIOS-e820: [mem 0x0000000029f2c000-0x0000000029f2cfff] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000029f2d000-0x0000000029f2ffff] ACPI data
> > [    0.000000] BIOS-e820: [mem 0x0000000029f30000-0x0000000029ffdfff] usable
> > [    0.000000] BIOS-e820: [mem 0x0000000029ffe000-0x000000002a80afff] reserved
> > [    0.000000] BIOS-e820: [mem 0x000000002a80b000-0x000000002a80efff] ACPI NVS
> > [    0.000000] BIOS-e820: [mem 0x000000002a80f000-0x000000002a81ffff] reserved
> > [    0.000000] BIOS-e820: [mem 0x000000002a820000-0x000000002a822fff] ACPI NVS
> > [    0.000000] BIOS-e820: [mem 0x000000002a823000-0x0000000033a22fff] usable
> > [    0.000000] BIOS-e820: [mem 0x0000000033a23000-0x0000000033a32fff] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000033a33000-0x0000000033a42fff] ACPI NVS
> > [    0.000000] BIOS-e820: [mem 0x0000000033a43000-0x0000000033a52fff] ACPI data
> > [    0.000000] BIOS-e820: [mem 0x0000000033a53000-0x0000000077ffffff] usable
> > [    0.000000] BIOS-e820: [mem 0x0000000078000000-0x000000008fffffff] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087effffff] usable
> > [    0.000000] BIOS-e820: [mem 0x000000087f000000-0x000000087fffffff] reserved
> > 
> > Reported-by: Qian Cai <cai@lca.pw>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/compaction.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 67fd317f78db..9ce4cff4d407 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -1418,7 +1418,9 @@ fast_isolate_freepages(struct compact_control *cc)
> >  				cc->free_pfn = highest;
> >  			} else {
> >  				if (cc->direct_compaction && pfn_valid(min_pfn)) {
> > -					page = pfn_to_page(min_pfn);
> > +					page = pageblock_pfn_to_page(min_pfn,
> > +						pageblock_end_pfn(min_pfn),
> > +						cc->zone);
> >  					cc->free_pfn = min_pfn;
> >  				}
> >  			}
> > -- 
> > 2.17.2
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 

