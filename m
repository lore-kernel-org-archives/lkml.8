Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E6CC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2083E20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgICOsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:48:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:38054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729184AbgICOXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:23:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9843DAB91;
        Thu,  3 Sep 2020 13:50:21 +0000 (UTC)
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org
References: <20200901124615.137200-1-pasha.tatashin@soleen.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <49d977ed-549a-8810-fb71-cf47b9f81f27@suse.cz>
Date:   Thu, 3 Sep 2020 15:50:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901124615.137200-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 2:46 PM, Pavel Tatashin wrote:
> There is a race during page offline that can lead to infinite loop:
> a page never ends up on a buddy list and __offline_pages() keeps
> retrying infinitely or until a termination signal is received.
> 
> Thread#1 - a new process:
> 
> load_elf_binary
>  begin_new_exec
>   exec_mmap
>    mmput
>     exit_mmap
>      tlb_finish_mmu
>       tlb_flush_mmu
>        release_pages
>         free_unref_page_list
>          free_unref_page_prepare
>           set_pcppage_migratetype(page, migratetype);
>              // Set page->index migration type below  MIGRATE_PCPTYPES
> 
> Thread#2 - hot-removes memory
> __offline_pages
>   start_isolate_page_range
>     set_migratetype_isolate
>       set_pageblock_migratetype(page, MIGRATE_ISOLATE);
>         Set migration type to MIGRATE_ISOLATE-> set
>         drain_all_pages(zone);
>              // drain per-cpu page lists to buddy allocator.
> 
> Thread#1 - continue
>          free_unref_page_commit
>            migratetype = get_pcppage_migratetype(page);
>               // get old migration type
>            list_add(&page->lru, &pcp->lists[migratetype]);
>               // add new page to already drained pcp list
> 
> Thread#2
> Never drains pcp again, and therefore gets stuck in the loop.
> 
> The fix is to try to drain per-cpu lists again after
> check_pages_isolated_cb() fails.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: stable@vger.kernel.org

Fixes: ?
Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.
