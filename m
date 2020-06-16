Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66029C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CFF120A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzwKOgAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgFPLwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:52:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33108 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728344AbgFPLwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592308358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0u70X+6091ldYMfR0Lh17cf24icfwEIvRCnUc/IkzSM=;
        b=BzwKOgAx62D+S5ylRzZAHWN/iDbdyw+L9QFqhig4Mg2+v50sT3tZGVEh7T9EW8xZq6ix9Q
        j3E6VPpZR5abkJONO5WqeEMqR1qngW3bhFKQIVdeKyEs9GDfsJO7wWX9U7qF5lo5JwUVX4
        OH9xv3VxcDGWLXG0+LJyCaWK8vxyeyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-RkqmAsI4OhirDalbWuG3_Q-1; Tue, 16 Jun 2020 07:52:31 -0400
X-MC-Unique: RkqmAsI4OhirDalbWuG3_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 229D9803329;
        Tue, 16 Jun 2020 11:52:30 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-106.ams2.redhat.com [10.36.114.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1162707C6;
        Tue, 16 Jun 2020 11:52:27 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v1 3/3] mm/shuffle: remove dynamic reconfiguration
Date:   Tue, 16 Jun 2020 13:52:13 +0200
Message-Id: <20200616115213.13109-4-david@redhat.com>
In-Reply-To: <20200616115213.13109-1-david@redhat.com>
References: <20200616115213.13109-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e900a918b098 ("mm: shuffle initial free memory to improve
memory-side-cache utilization") promised "autodetection of a
memory-side-cache (to be added in a follow-on patch)" over a year ago.

The original series included patches [1], however, they were dropped
during review [2] to be followed-up later.

Let's simplify for now and re-add when really (ever?) needed.

[1] https://lkml.kernel.org/r/154510700291.1941238.817190985966612531.stgit@dwillia2-desk3.amr.corp.intel.com/
[2] https://lkml.kernel.org/r/154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/shuffle.c | 28 ++--------------------------
 mm/shuffle.h | 17 -----------------
 2 files changed, 2 insertions(+), 43 deletions(-)

diff --git a/mm/shuffle.c b/mm/shuffle.c
index 609c26aa57db0..702c0d5cf276c 100644
--- a/mm/shuffle.c
+++ b/mm/shuffle.c
@@ -10,33 +10,11 @@
 #include "shuffle.h"
 
 DEFINE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
-static unsigned long shuffle_state __ro_after_init;
-
-/*
- * Depending on the architecture, module parameter parsing may run
- * before, or after the cache detection. SHUFFLE_FORCE_DISABLE prevents,
- * or reverts the enabling of the shuffle implementation. SHUFFLE_ENABLE
- * attempts to turn on the implementation, but aborts if it finds
- * SHUFFLE_FORCE_DISABLE already set.
- */
-__meminit void page_alloc_shuffle(enum mm_shuffle_ctl ctl)
-{
-	if (ctl == SHUFFLE_FORCE_DISABLE)
-		set_bit(SHUFFLE_FORCE_DISABLE, &shuffle_state);
-
-	if (test_bit(SHUFFLE_FORCE_DISABLE, &shuffle_state)) {
-		if (test_and_clear_bit(SHUFFLE_ENABLE, &shuffle_state))
-			static_branch_disable(&page_alloc_shuffle_key);
-	} else if (ctl == SHUFFLE_ENABLE
-			&& !test_and_set_bit(SHUFFLE_ENABLE, &shuffle_state))
-		static_branch_enable(&page_alloc_shuffle_key);
-}
 
 static bool shuffle_param;
 static int shuffle_show(char *buffer, const struct kernel_param *kp)
 {
-	return sprintf(buffer, "%c\n", test_bit(SHUFFLE_ENABLE, &shuffle_state)
-			? 'Y' : 'N');
+	return sprintf(buffer, "%c\n", shuffle_param ? 'Y' : 'N');
 }
 
 static __meminit int shuffle_store(const char *val,
@@ -47,9 +25,7 @@ static __meminit int shuffle_store(const char *val,
 	if (rc < 0)
 		return rc;
 	if (shuffle_param)
-		page_alloc_shuffle(SHUFFLE_ENABLE);
-	else
-		page_alloc_shuffle(SHUFFLE_FORCE_DISABLE);
+		static_branch_enable(&page_alloc_shuffle_key);
 	return 0;
 }
 module_param_call(shuffle, shuffle_store, shuffle_show, &shuffle_param, 0400);
diff --git a/mm/shuffle.h b/mm/shuffle.h
index 657e2b9ec38dd..5574cbd4611e3 100644
--- a/mm/shuffle.h
+++ b/mm/shuffle.h
@@ -4,23 +4,10 @@
 #define _MM_SHUFFLE_H
 #include <linux/jump_label.h>
 
-/*
- * SHUFFLE_ENABLE is called from the command line enabling path, or by
- * platform-firmware enabling that indicates the presence of a
- * direct-mapped memory-side-cache. SHUFFLE_FORCE_DISABLE is called from
- * the command line path and overrides any previous or future
- * SHUFFLE_ENABLE.
- */
-enum mm_shuffle_ctl {
-	SHUFFLE_ENABLE,
-	SHUFFLE_FORCE_DISABLE,
-};
-
 #define SHUFFLE_ORDER (MAX_ORDER-1)
 
 #ifdef CONFIG_SHUFFLE_PAGE_ALLOCATOR
 DECLARE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
-extern void page_alloc_shuffle(enum mm_shuffle_ctl ctl);
 extern void __shuffle_free_memory(pg_data_t *pgdat);
 extern bool shuffle_pick_tail(void);
 static inline void shuffle_free_memory(pg_data_t *pgdat)
@@ -46,10 +33,6 @@ static inline void shuffle_free_memory(pg_data_t *pgdat)
 {
 }
 
-static inline void page_alloc_shuffle(enum mm_shuffle_ctl ctl)
-{
-}
-
 static inline bool is_shuffle_order(int order)
 {
 	return false;
-- 
2.26.2

