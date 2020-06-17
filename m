Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE38C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826A1214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgFQJzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:55:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:48066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgFQJzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:55:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DD7C2AC50;
        Wed, 17 Jun 2020 09:55:12 +0000 (UTC)
Subject: Re: [PATCH 2/2] mm, page_alloc: use unlikely() in task_capc()
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        liwang@redhat.com, mgorman@techsingularity.net
References: <b17acf5b-5e8a-3edf-5a64-603bf6177312@suse.cz>
 <20200616082649.27173-1-vbabka@suse.cz>
 <20200616082649.27173-2-vbabka@suse.cz>
 <alpine.LSU.2.11.2006161319030.1119@eggly.anvils>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4a24f7af-3aa5-6e80-4ae6-8f253b562039@suse.cz>
Date:   Wed, 17 Jun 2020 11:55:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2006161319030.1119@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/16/20 10:29 PM, Hugh Dickins wrote:
> On Tue, 16 Jun 2020, Vlastimil Babka wrote:
> 
>> Hugh noted that task_capc() could use unlikely(), as most of the time there is
>> no capture in progress and we are in page freeing hot path. Indeed adding
>> unlikely() redirects produces assembly that better matches the assumption and
>> moves all the tests away from the hot path.
>> 
>> I have also noticed that we don't need to test for cc->direct_compaction as the
>> only place we set current->task_capture is compact_zone_order() which also
>> always sets cc->direct_compaction true.
>> 
>> Suggested-by: Hugh Dickins <hughd@google.com>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Acked-by: Hugh Dickins <hughd@googlecom>

Thanks.

> Thanks for pursuing these, Vlastimil: I'm glad you were able
> to remove a test and branch instead of adding one as I had.
> 
> One little thing, you've probably gone into this yourself and know
> what you've written here is optimal: but I'd rather imagined it with
> "unlikely(capc) && ..." instead of "unlikely(capc && ...)" - no need
> to respond, please just give it a moment's consideration, Acked anyway.

It makes no difference, at least on my gcc10 which seems to be smart enough to
do the right thing. But yeah, your suggestion is more readable and precise and
maybe can work better with a less smart compiler. Thanks.

----8<----
From 615eea6f6abe288ffb708aa0d1bdfbeaf30a4cbd Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 16 Jun 2020 10:14:47 +0200
Subject: [PATCH] mm, page_alloc: use unlikely() in task_capc()

Hugh noted that task_capc() could use unlikely(), as most of the time there is
no capture in progress and we are in page freeing hot path. Indeed adding
unlikely() produces assembly that better matches the assumption and moves
all the tests away from the hot path.

I have also noticed that we don't need to test for cc->direct_compaction as the
only place we set current->task_capture is compact_zone_order() which also
always sets cc->direct_compaction true.

Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Hugh Dickins <hughd@googlecom>
---
 mm/page_alloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48eb0f1410d4..18d5aed3f97b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -813,11 +813,10 @@ static inline struct capture_control *task_capc(struct zone *zone)
 {
 	struct capture_control *capc = current->capture_control;
 
-	return capc &&
+	return unlikely(capc) &&
 		!(current->flags & PF_KTHREAD) &&
 		!capc->page &&
-		capc->cc->zone == zone &&
-		capc->cc->direct_compaction ? capc : NULL;
+		capc->cc->zone == zone ? capc : NULL;
 }
 
 static inline bool
-- 
2.27.0

