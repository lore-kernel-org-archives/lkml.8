Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D84C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9005320801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgFLKa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:30:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:34372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgFLKa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:30:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 27B6CAEFA;
        Fri, 12 Jun 2020 10:30:59 +0000 (UTC)
Subject: Re: [PATCH] mm, page_alloc: capture page in task context only
To:     Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Li Wang <liwang@redhat.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <alpine.LSU.2.11.2006101342250.4607@eggly.anvils>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <01287865-153d-42e7-afd8-1178ec6bc5b9@suse.cz>
Date:   Fri, 12 Jun 2020 12:30:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2006101342250.4607@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/20 10:48 PM, Hugh Dickins wrote:
> While stressing compaction, one run oopsed on NULL capc->cc in
> __free_one_page()'s task_capc(zone): compact_zone_order() had been
> interrupted, and a page was being freed in the return from interrupt.
> 
> Though you would not expect it from the source, both gccs I was using
> (a 4.8.1 and a 7.5.0) had chosen to compile compact_zone_order() with
> the ".cc = &cc" implemented by mov %rbx,-0xb0(%rbp) immediately before
> callq compact_zone - long after the "current->capture_control = &capc".
> An interrupt in between those finds capc->cc NULL (zeroed by an earlier
> rep stos).

Ugh, nasty. Same here with gcc 10.

> This could presumably be fixed by a barrier() before setting
> current->capture_control in compact_zone_order(); but would also need
> more care on return from compact_zone(), in order not to risk leaking
> a page captured by interrupt just before capture_control is reset.

I was hoping a WRITE_ONCE(current->capture_control) would be enough,
but apparently it's not (I tried).

> Maybe that is the preferable fix, but I felt safer for task_capc() to
> exclude the rather surprising possibility of capture at interrupt time.

> Fixes: 5e1f0f098b46 ("mm, compaction: capture a page under direct compaction")
> Cc: stable@vger.kernel.org # 5.1+
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

But perhaps I would also make sure that we don't expose the half initialized
capture_control and run into this problem again later. It's not like this is a
fast path where barriers hurt. Something like this then? (with added comments)

diff --git a/mm/compaction.c b/mm/compaction.c
index fd988b7e5f2b..c89e26817278 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2316,15 +2316,17 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
 		.page = NULL,
 	};
 
-	current->capture_control = &capc;
+	barrier();
+
+	WRITE_ONCE(current->capture_control, &capc);
 
 	ret = compact_zone(&cc, &capc);
 
 	VM_BUG_ON(!list_empty(&cc.freepages));
 	VM_BUG_ON(!list_empty(&cc.migratepages));
 
-	*capture = capc.page;
-	current->capture_control = NULL;
+	WRITE_ONCE(current->capture_control, NULL);
+	*capture = READ_ONCE(capc.page);
 
 	return ret;
 }
