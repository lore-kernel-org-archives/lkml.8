Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C49FC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FAC620857
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPy7wj2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDXUsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgDXUsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:48:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A26C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:48:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z1so3689588pfn.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=PDTf+FwCag54Gix+XkZ+brAEDzVD747g0MZvcGy7XE0=;
        b=KPy7wj2MyP0KtwiHu32IxKWS9Qes02e9yin3KAala4NLgMm1VYdrAdwr8R5QkeoAax
         AV6XDCiajWl6bZojse0RsWdjHKVDx/QTxgsCtwI3f9jEAAE3qq2pzTryQ9Fu54fb2eWZ
         sAelmXTpQT+moDBXTrFrFjpIeNnGkF2gnhsexFwJufG4FMRsjy4aoBIMZfzgB4RTYRN6
         uggAlfgC8WxPk5l1ZYSZdq40lfLyB+I+UsQ5FkIdcokI4sPvMZrrsovt90fmPTN5K2UV
         xQkKBLGA4zKXHilVWKPH14a6fAvJEM+hZhklmeX8y3qiqakYNpmE97QZFLPYgiy889vo
         iInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=PDTf+FwCag54Gix+XkZ+brAEDzVD747g0MZvcGy7XE0=;
        b=M23h2AGi8RHjlUdlnOKVl8mKfzx7foNC0EwOWJQOdvFwS2+f68CL74xQVuD9b5prTW
         ZPV4PNSq+YIo0SURjAxcnDtgOEJd7rzty679g8dd77pZaDTLZ5ecrwe8yOYlyEZd6+5J
         9925RZp3w/NwIepSd70UTmRHwjN7qf68tmyjpff2RedxqqUn9kFavKoSylV0geyXuO0e
         Ln2yaoSYThEIAGPRMr7GX18sLpztcu2rpdvMAKQDvgQCYrZUz8M3NT7G5UMMO7Fed6+A
         3o9BK2kGhURpB7SbWj2N7Bjgrb4/GRJpQOwPNU/BYI5JFHnwDJo9KrK5ZLU04eZEYXkL
         /GTA==
X-Gm-Message-State: AGi0PuaAWh0LIrAfWFGmm0zDV5qje3LiHOSNB5nPxcbvSeuk5BZOvqGf
        aGZQRGrtckRqobCD9L6HRJLh0CuR2aI=
X-Google-Smtp-Source: APiQypLbr3SMUctOMl8jKy4C36Pwrcoy0esZlXUBcjNAytAVSV5T3V1sQHTQBWvGQsaOgghOVd6afA==
X-Received: by 2002:a63:ed50:: with SMTP id m16mr3271084pgk.271.1587761287198;
        Fri, 24 Apr 2020 13:48:07 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 139sm2494798pfc.170.2020.04.24.13.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:48:06 -0700 (PDT)
Date:   Fri, 24 Apr 2020 13:48:06 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start failing
 soon
Message-ID: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If GFP_ATOMIC allocations will start failing soon because the amount of
free memory is substantially under per-zone min watermarks, it is better
to oom kill a process rather than continue to reclaim.

This intends to significantly reduce the number of page allocation
failures that are encountered when the demands of user and atomic
allocations overwhelm the ability of reclaim to keep up.  We can see this
with a high ingress of networking traffic where memory allocated in irq
context can overwhelm the ability to reclaim fast enough such that user
memory consistently loops.  In that case, we have reclaimable memory, and
reclaiming is successful, but we've fully depleted memory reserves that
are allowed for non-blockable allocations.

Commit 400e22499dd9 ("mm: don't warn about allocations which stall for
too long") removed evidence of user allocations stalling because of this,
but the situation can apply anytime we get "page allocation failures"
where reclaim is happening but per-zone min watermarks are starved:

Node 0 Normal free:87356kB min:221984kB low:416984kB high:611984kB active_anon:123009936kB inactive_anon:67647652kB active_file:429612kB inactive_file:209980kB unevictable:112348kB writepending:260kB present:198180864kB managed:195027624kB mlocked:81756kB kernel_stack:24040kB pagetables:11460kB bounce:0kB free_pcp:940kB local_pcp:96kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 1 Normal free:105616kB min:225568kB low:423716kB high:621864kB active_anon:122124196kB inactive_anon:74112696kB active_file:39172kB inactive_file:103696kB unevictable:204480kB writepending:180kB present:201326592kB managed:198174372kB mlocked:204480kB kernel_stack:11328kB pagetables:3680kB bounce:0kB free_pcp:1140kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0

Without this patch, there is no guarantee that user memory allocations
will ever be successful when non-blockable allocations overwhelm the
ability to get above per-zone min watermarks.

This doesn't solve page allocation failures entirely since it's a
preemptive measure based on watermarks that requires concurrent blockable
allocations to trigger the oom kill.  To complete solve page allocation
failures, it would be possible to do the same watermark check for non-
blockable allocations and then queue a worker to asynchronously oom kill
if it finds watermarks to be sufficiently low as well.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/page_alloc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4372,11 +4372,21 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 					ac->nodemask) {
 		unsigned long available;
 		unsigned long reclaimable;
+		unsigned long free;
 		unsigned long min_wmark = min_wmark_pages(zone);
 		bool wmark;
 
+		free = zone_page_state_snapshot(zone, NR_FREE_PAGES);
+		/*
+		 * If this zone is approaching the point where even order-0
+		 * GFP_ATOMIC allocations will fail, stop considering reclaim.
+		 */
+		if (!__zone_watermark_ok(zone, 0, min_wmark, ac_classzone_idx(ac),
+					 alloc_flags | ALLOC_HIGH, free))
+			continue;
+
 		available = reclaimable = zone_reclaimable_pages(zone);
-		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
+		available += free;
 
 		/*
 		 * Would the allocation succeed if we reclaimed all
