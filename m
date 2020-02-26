Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6FEC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF0124653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KubLIMk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgBZUiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:38:06 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37712 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgBZUiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:38:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id j34so571994qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 12:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1+FF8laV1uW4uV4Gl7mC+45itLTemNWg5eIUO54Qcwc=;
        b=KubLIMk7flKHMhRJs1aAP6ESSh3y8tdMgMGwRGgENJT0Bvp8QKI59thi49+Rd1wqy2
         VOfEKMJZMuJYl9qHJOlBDvkNrr8l+rZaGaE/1T2F4Cqt2imi5HM0Ben1msJm50UYOECI
         DtmauHl25cCws3NOeLsayH1HQMnItxblak1KzSo/4L+uv6irc4vgFwN4K4ufam6AYxLt
         6V9bVA4ZZab6+znSX2MHrhxtRU9LD/SCyD0qKP0DHAEO2KgIjTVU3mNDBCclZoOzTFCG
         S8ioGfQIhI5PfxnRnl1aSDTeyw3haIam0Q/pE9KBkEJe5MEIrqkn77PKZT22hVMCorBE
         Dpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1+FF8laV1uW4uV4Gl7mC+45itLTemNWg5eIUO54Qcwc=;
        b=XBab+vdBzSS9gHYY9cvUaLft1J+o0Mf9AOI+r2Ufp7T/WsP4/qNX6oYvPtCp6LMCvU
         NT/RsDR2wgsHvvksB03eg3gCkAhan0ZSP7fN3iuAqnw0a2MwIWiFpNjPws1zrvoI9GRc
         xUuIqdHbLg4OuvPqpNd9c4rFowanxDbYO0h5K7ZamYMmfFaU2co53sU45PrAbbCc8lbC
         oao8EwqgviBPa2gsd24Egs6ENoma9e5VLt/1soBegtdOI8Yoyet1akQ6o6rv7eK1iuyU
         VCe3gRSIrbwTHsei039X3fZHnKFJGVGI4grgP6WFIZnbbT050NkmncIdo61yIoT/GB8S
         ZWiQ==
X-Gm-Message-State: APjAAAU5Nv9JKbn7y6ivrEoLbX8f1o7Vb/LNGGxAOh9+4YWfm3qZeO5O
        uYBS66sHFNXQ2JGNScsJP7fZbA==
X-Google-Smtp-Source: APXvYqz5cBzLht6gWlCeb5WqGQU8kNxijfOJJGhXXIZZEY/ICGKhh27FTpoJVAdyQHV3QyJ1D37eOw==
X-Received: by 2002:ac8:540f:: with SMTP id b15mr754546qtq.237.1582749485389;
        Wed, 26 Feb 2020 12:38:05 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t30sm1747373qtd.67.2020.02.26.12.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 12:38:04 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v3] mm/vmscan: fix data races at kswapd_classzone_idx
Date:   Wed, 26 Feb 2020 15:37:52 -0500
Message-Id: <1582749472-5171-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pgdat->kswapd_classzone_idx could be accessed concurrently in
wakeup_kswapd(). Plain writes and reads without any lock protection
result in data races. Fix them by adding a pair of READ|WRITE_ONCE() as
well as saving a branch (compilers might well optimize the original code
in an unintentional way anyway). While at it, also take care of
pgdat->kswapd_order and non-kswapd threads in allow_direct_reclaim().
The data races were reported by KCSAN,

 BUG: KCSAN: data-race in wakeup_kswapd / wakeup_kswapd

 write to 0xffff9f427ffff2dc of 4 bytes by task 7454 on cpu 13:
  wakeup_kswapd+0xf1/0x400
  wakeup_kswapd at mm/vmscan.c:3967
  wake_all_kswapds+0x59/0xc0
  wake_all_kswapds at mm/page_alloc.c:4241
  __alloc_pages_slowpath+0xdcc/0x1290
  __alloc_pages_slowpath at mm/page_alloc.c:4512
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_vma+0x8a/0x2c0
  do_anonymous_page+0x16e/0x6f0
  __handle_mm_fault+0xcd5/0xd40
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 1 lock held by mtest01/7454:
  #0: ffff9f425afe8808 (&mm->mmap_sem#2){++++}, at:
 do_page_fault+0x143/0x6f9
 do_user_addr_fault at arch/x86/mm/fault.c:1405
 (inlined by) do_page_fault at arch/x86/mm/fault.c:1539
 irq event stamp: 6944085
 count_memcg_event_mm+0x1a6/0x270
 count_memcg_event_mm+0x119/0x270
 __do_softirq+0x34c/0x57c
 irq_exit+0xa2/0xc0

 read to 0xffff9f427ffff2dc of 4 bytes by task 7472 on cpu 38:
  wakeup_kswapd+0xc8/0x400
  wake_all_kswapds+0x59/0xc0
  __alloc_pages_slowpath+0xdcc/0x1290
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_vma+0x8a/0x2c0
  do_anonymous_page+0x16e/0x6f0
  __handle_mm_fault+0xcd5/0xd40
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 1 lock held by mtest01/7472:
  #0: ffff9f425a9ac148 (&mm->mmap_sem#2){++++}, at:
 do_page_fault+0x143/0x6f9
 irq event stamp: 6793561
 count_memcg_event_mm+0x1a6/0x270
 count_memcg_event_mm+0x119/0x270
 __do_softirq+0x34c/0x57c
 irq_exit+0xa2/0xc0

 BUG: KCSAN: data-race in kswapd / wakeup_kswapd

 write to 0xffff90973ffff2dc of 4 bytes by task 820 on cpu 6:
  kswapd+0x27c/0x8d0
  kthread+0x1e0/0x200
  ret_from_fork+0x27/0x50

 read to 0xffff90973ffff2dc of 4 bytes by task 6299 on cpu 0:
  wakeup_kswapd+0xf3/0x450
  wake_all_kswapds+0x59/0xc0
  __alloc_pages_slowpath+0xdcc/0x1290
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_vma+0x8a/0x2c0
  do_anonymous_page+0x170/0x700
  __handle_mm_fault+0xc9f/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: Take care of kswapd() and kswapd_try_to_sleep() too.
v2: Use a temp variable and take care of kswapd_order per Matthew.
    Take care of allow_direct_reclaim() as well.

 mm/vmscan.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f14c8c6069a6..4c8a1cdccbba 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3136,8 +3136,9 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
 
 	/* kswapd must be awake if processes are being throttled */
 	if (!wmark_ok && waitqueue_active(&pgdat->kswapd_wait)) {
-		pgdat->kswapd_classzone_idx = min(pgdat->kswapd_classzone_idx,
-						(enum zone_type)ZONE_NORMAL);
+		if (READ_ONCE(pgdat->kswapd_classzone_idx) > ZONE_NORMAL)
+			WRITE_ONCE(pgdat->kswapd_classzone_idx, ZONE_NORMAL);
+
 		wake_up_interruptible(&pgdat->kswapd_wait);
 	}
 
@@ -3769,9 +3770,9 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 static enum zone_type kswapd_classzone_idx(pg_data_t *pgdat,
 					   enum zone_type prev_classzone_idx)
 {
-	if (pgdat->kswapd_classzone_idx == MAX_NR_ZONES)
-		return prev_classzone_idx;
-	return pgdat->kswapd_classzone_idx;
+	enum zone_type curr_idx = READ_ONCE(pgdat->kswapd_classzone_idx);
+
+	return curr_idx == MAX_NR_ZONES ? prev_classzone_idx : curr_idx;
 }
 
 static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
@@ -3815,8 +3816,11 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 		 * the previous request that slept prematurely.
 		 */
 		if (remaining) {
-			pgdat->kswapd_classzone_idx = kswapd_classzone_idx(pgdat, classzone_idx);
-			pgdat->kswapd_order = max(pgdat->kswapd_order, reclaim_order);
+			WRITE_ONCE(pgdat->kswapd_classzone_idx,
+				   kswapd_classzone_idx(pgdat, classzone_idx));
+
+			if (READ_ONCE(pgdat->kswapd_order) < reclaim_order)
+				WRITE_ONCE(pgdat->kswapd_order, reclaim_order);
 		}
 
 		finish_wait(&pgdat->kswapd_wait, &wait);
@@ -3893,12 +3897,12 @@ static int kswapd(void *p)
 	tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
 	set_freezable();
 
-	pgdat->kswapd_order = 0;
-	pgdat->kswapd_classzone_idx = MAX_NR_ZONES;
+	WRITE_ONCE(pgdat->kswapd_order, 0);
+	WRITE_ONCE(pgdat->kswapd_classzone_idx, MAX_NR_ZONES);
 	for ( ; ; ) {
 		bool ret;
 
-		alloc_order = reclaim_order = pgdat->kswapd_order;
+		alloc_order = reclaim_order = READ_ONCE(pgdat->kswapd_order);
 		classzone_idx = kswapd_classzone_idx(pgdat, classzone_idx);
 
 kswapd_try_sleep:
@@ -3906,10 +3910,10 @@ static int kswapd(void *p)
 					classzone_idx);
 
 		/* Read the new order and classzone_idx */
-		alloc_order = reclaim_order = pgdat->kswapd_order;
+		alloc_order = reclaim_order = READ_ONCE(pgdat->kswapd_order);
 		classzone_idx = kswapd_classzone_idx(pgdat, classzone_idx);
-		pgdat->kswapd_order = 0;
-		pgdat->kswapd_classzone_idx = MAX_NR_ZONES;
+		WRITE_ONCE(pgdat->kswapd_order, 0);
+		WRITE_ONCE(pgdat->kswapd_classzone_idx, MAX_NR_ZONES);
 
 		ret = try_to_freeze();
 		if (kthread_should_stop())
@@ -3953,20 +3957,23 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 		   enum zone_type classzone_idx)
 {
 	pg_data_t *pgdat;
+	enum zone_type curr_idx;
 
 	if (!managed_zone(zone))
 		return;
 
 	if (!cpuset_zone_allowed(zone, gfp_flags))
 		return;
+
 	pgdat = zone->zone_pgdat;
+	curr_idx = READ_ONCE(pgdat->kswapd_classzone_idx);
+
+	if (curr_idx == MAX_NR_ZONES || curr_idx < classzone_idx)
+		WRITE_ONCE(pgdat->kswapd_classzone_idx, classzone_idx);
+
+	if (READ_ONCE(pgdat->kswapd_order) < order)
+		WRITE_ONCE(pgdat->kswapd_order, order);
 
-	if (pgdat->kswapd_classzone_idx == MAX_NR_ZONES)
-		pgdat->kswapd_classzone_idx = classzone_idx;
-	else
-		pgdat->kswapd_classzone_idx = max(pgdat->kswapd_classzone_idx,
-						  classzone_idx);
-	pgdat->kswapd_order = max(pgdat->kswapd_order, order);
 	if (!waitqueue_active(&pgdat->kswapd_wait))
 		return;
 
-- 
1.8.3.1

