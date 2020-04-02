Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A5CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4512063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585813458;
	bh=q08hBGADzcgr9PuyQype6pUwKbbd2ytaSXgg1Fn6PLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ASB/8bg5IJV0LCojRPGyfZwvDttI2bdp4a/uMRFyCrnFr7GjEHxN6KR9AkOTfv1xf
	 Y/o0FMe1k6tnICba2lfzGrriMbeuCjEe0XuWDexI68mWdWQMKuL1oSU5qc8cfL/z1D
	 V0ededYt/pJ1Zb/9HuZqTSN3An7yO6Chgm1RE6wA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbgDBHoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:44:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33720 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:44:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so2998287wrd.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UBE7VI9FnbtBHIdXLo3J25c1IHbGbjYoWi7ozq8GSkw=;
        b=ApGDE3OYM6E5igBx/hnbEBtdARdtNhcW/goX4e3tkKK1RsrQ9hiTXGK/6dj4/CS7dU
         efWrSq+htbilFm/Vwnvd0Q8rCmOMVpPEKWuma03dId7qlJb5IeDOE4wLiXjH6CEdz/4r
         lea15IYQJHu07LF9fcg08rSemd3CJJILhJwBMAJEGOHFwUI8IBge2+tyVlMPX6auEM2H
         jDB3ZZuwZj8AI7KhCCrp+m+5LowBQJBECaLP5CxGpHcMOJuMp8Xvy5hQhLuZhiR4XZa5
         7/OZwwljski8IEH0z3LRDGlktwDZa/eHxPVDrTn2ffoVtdxLD9+JW1MXo+/a4Fchp7kt
         u6fw==
X-Gm-Message-State: AGi0PuY3ItdQsDUBOmHVDr80IjKWn7BKExsNO2s7r0Rx6skHIpDFIY/O
        ItsZQmpKv7gMspbXQ4jOfEI=
X-Google-Smtp-Source: APiQypJOKL1DlYFdbEbI7pmv8zN7vXNpYVXMFImDay+xICRSRWkSegzmOrEqJY4ZmITPMktXMxiZCQ==
X-Received: by 2002:adf:97c8:: with SMTP id t8mr2054345wrb.319.1585813453828;
        Thu, 02 Apr 2020 00:44:13 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id b82sm5518287wme.25.2020.04.02.00.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:44:12 -0700 (PDT)
Date:   Thu, 2 Apr 2020 09:44:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        =?utf-8?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH -V2] /proc/PID/smaps: Add PMD migration entry parsing
Message-ID: <20200402074411.GH22681@dhcp22.suse.cz>
References: <20200402020031.1611223-1-ying.huang@intel.com>
 <20200402064437.GC22681@dhcp22.suse.cz>
 <87zhbufjyc.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhbufjyc.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-04-20 15:03:23, Huang, Ying wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Thu 02-04-20 10:00:31, Huang, Ying wrote:
> >> From: Huang Ying <ying.huang@intel.com>
> >> 
> >> Now, when read /proc/PID/smaps, the PMD migration entry in page table is simply
> >> ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and processing
> >> is added.
> >> 
> >> Before the patch, for a fully populated 400 MB anonymous VMA, sometimes some THP
> >> pages under migration may be lost as follows.
> >
> > Interesting. How did you reproduce this?
> > [...]
> 
> I run the pmbench in background to eat memory, then run
> `/usr/bin/migratepages` and `cat /proc/PID/smaps` every second.  The
> issue can be reproduced within 60 seconds.

Please add that information to the changelog. I was probably too
optimistic about the migration duration because I found it highly
unlikely to be visible. I was clearly wrong here.

> >> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >> index 8d382d4ec067..9c72f9ce2dd8 100644
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
> >> @@ -546,10 +546,19 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
> >>  	struct mem_size_stats *mss = walk->private;
> >>  	struct vm_area_struct *vma = walk->vma;
> >>  	bool locked = !!(vma->vm_flags & VM_LOCKED);
> >> -	struct page *page;
> >> +	struct page *page = NULL;
> >>  
> >> -	/* FOLL_DUMP will return -EFAULT on huge zero page */
> >> -	page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> >> +	if (pmd_present(*pmd)) {
> >> +		/* FOLL_DUMP will return -EFAULT on huge zero page */
> >> +		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> >> +	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
> >> +		swp_entry_t entry = pmd_to_swp_entry(*pmd);
> >> +
> >> +		if (is_migration_entry(entry))
> >> +			page = migration_entry_to_page(entry);
> >> +		else
> >> +			VM_WARN_ON_ONCE(1);
> >
> > Could you explain why do we need this WARN_ON? I haven't really checked
> > the swap support for THP but cannot we have normal swap pmd entries?
> 
> I have some patches to add the swap pmd entry support, but they haven't
> been merged yet.
> 
> Similar checks are for all THP migration code paths, so I follow the
> same style.

I haven't checked other migration code paths but what is the reason to
add the warning here? Even if this shouldn't happen, smaps is perfectly
fine to ignore that situation, no?
-- 
Michal Hocko
SUSE Labs
