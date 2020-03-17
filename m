Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF35C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EAC20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgCQI7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:59:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:42634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQI7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:59:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CABB1AEC7;
        Tue, 17 Mar 2020 08:59:05 +0000 (UTC)
Subject: Re: [v2 PATCH 1/2] mm: swap: make page_evictable() inline
To:     Yang Shi <yang.shi@linux.alibaba.com>, shakeelb@google.com,
        willy@infradead.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1584397455-28701-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <f8dd76b9-b7f7-340c-5778-9a6ab3408a07@suse.cz>
Date:   Tue, 17 Mar 2020 09:59:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584397455-28701-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/20 11:24 PM, Yang Shi wrote:
> When backporting commit 9c4e6b1a7027 ("mm, mlock, vmscan: no more
> skipping pagevecs") to our 4.9 kernel, our test bench noticed around 10%
> down with a couple of vm-scalability's test cases (lru-file-readonce,
> lru-file-readtwice and lru-file-mmap-read).  I didn't see that much down
> on my VM (32c-64g-2nodes).  It might be caused by the test configuration,
> which is 32c-256g with NUMA disabled and the tests were run in root memcg,
> so the tests actually stress only one inactive and active lru.  It
> sounds not very usual in mordern production environment.
> 
> That commit did two major changes:
> 1. Call page_evictable()
> 2. Use smp_mb to force the PG_lru set visible
> 
> It looks they contribute the most overhead.  The page_evictable() is a
> function which does function prologue and epilogue, and that was used by
> page reclaim path only.  However, lru add is a very hot path, so it
> sounds better to make it inline.  However, it calls page_mapping() which
> is not inlined either, but the disassemble shows it doesn't do push and
> pop operations and it sounds not very straightforward to inline it.
> 
> Other than this, it sounds smp_mb() is not necessary for x86 since
> SetPageLRU is atomic which enforces memory barrier already, replace it
> with smp_mb__after_atomic() in the following patch.
> 
> With the two fixes applied, the tests can get back around 5% on that
> test bench and get back normal on my VM.  Since the test bench
> configuration is not that usual and I also saw around 6% up on the
> latest upstream, so it sounds good enough IMHO.
> 
> The below is test data (lru-file-readtwice throughput) against the v5.6-rc4:
> 	mainline	w/ inline fix
>           150MB            154MB
> 
> With this patch the throughput gets 2.67% up.  The data with using
> smp_mb__after_atomic() is showed in the following patch.
> 
> Fixes: 9c4e6b1a7027 ("mm, mlock, vmscan: no more skipping pagevecs")
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.
