Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C3BC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 06:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A174E20708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 06:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHNG7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:59:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:58872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgHNG7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 02:59:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38B1CAC46;
        Fri, 14 Aug 2020 06:59:30 +0000 (UTC)
Date:   Fri, 14 Aug 2020 08:59:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: include CMA pages in lowmem_reserve at boot
Message-ID: <20200814065836.GY9477@dhcp22.suse.cz>
References: <1597290698-24266-1-git-send-email-opendmb@gmail.com>
 <20200813111730.GH9477@dhcp22.suse.cz>
 <a6a23d81-d24e-e425-e1cb-d7ef3ef69a38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6a23d81-d24e-e425-e1cb-d7ef3ef69a38@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-08-20 10:55:17, Doug Berger wrote:
[...]
> One example might be a 1GB arm platform that defines a 256MB default CMA
> region. The default zones might map as follows:
> [    0.000000] cma: Reserved 256 MiB at 0x0000000030000000
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
> [    0.000000]   Normal   empty
> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]
[...]
> 
> Here you can see that the lowmem_reserve array for the DMA zone is all
> 0's. This is because the HighMem zone is consumed by the CMA region
> whose pages haven't been activated to increase the zone managed count
> when init_per_zone_wmark_min() is invoked at boot.
> 
> If we access the /proc/sys/vm/lowmem_reserve_ratio sysctl with:
> # cat /proc/sys/vm/lowmem_reserve_ratio
> 256     32      0       0

Yes, this is really an unexpected behavior.
[...]
 
> Here the lowmem_reserve back pressure for the DMA zone for allocations
> that target the HighMem zone is now 256 pages. Now 1MB is still not a
> lot of additional back pressure, but the watermarks on the HighMem zone
> aren't very large either so User space allocations can easily start
> consuming the DMA zone while kswapd starts trying to reclaim space in
> HighMem. This excess pressure on DMA zone memory can potentially lead to
> earlier triggers of OOM Killer and/or kernel fallback allocations into
> CMA Movable pages which can interfere with the ability of CMA to obtain
> larger size contiguous allocations.
> 
> All of that said, my main concern is that I don't like the inconsistency
> between the boot time and run time results.

Thanks for the clarification. I would suggest extending your changlog by
the following.

"
In many cases the difference is not significant, but for example an ARM
platform with 1GB of memory and the following memory layout
[    0.000000] cma: Reserved 256 MiB at 0x0000000030000000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]

would result in 0 lowmem_reserve for the DMA zone. This would allow
userspace the deplete the DMA zone easily. Funnily enough 
$ cat /proc/sys/vm/lowmem_reserve_ratio
would fix up the situation because it forces setup_per_zone_lowmem_reserve
as a side effect.
"

With that feel free to add
Acked-by: Michal Hocko <mhocko@suse.com.

Thanks!
-- 
Michal Hocko
SUSE Labs
