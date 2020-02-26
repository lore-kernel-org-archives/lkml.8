Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BD6C4BA0D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CA9222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rT6F5zYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBZD6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:58:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34568 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBZD6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 22:58:36 -0500
Received: by mail-qk1-f193.google.com with SMTP id 11so1434581qkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 19:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqQmLpDggmkX79HmGpvNiduhmKU3MFQ/yb6zXVa9mHE=;
        b=rT6F5zYEOmpDgUzrFDBCMZAaOJhoSxf4o8I4SGInJOOYeGvF761sKRyRCkPu2qxIYM
         eGIPJMS32c/dSXBGgxX/JnwJSkz59s0zlk3v4G5UjTN2IrOm9RKYv2tCS8fx7ShZ2PFe
         L6Dzyxqv4esV8AzjCiLSysQ0SM0vtS5CubXECAaSwcoQzrGKMtfgKNqG0t0YTHPFYJDe
         fjm0lKvXiZNnXN4svOOvoO/IBMc3adHjPaIoraXeIvsTIUVGM5nH8/Bxm2TOENPOzgpX
         7it3V/PlJ1yfTBJstjO3O0JbV8DD6Q7FoU20D0v2Lm4yGuk//WeX3mV5kVvNU6k9ozoZ
         ar7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqQmLpDggmkX79HmGpvNiduhmKU3MFQ/yb6zXVa9mHE=;
        b=lZ5LUmtQFfpuB0lWS1/joel22LijJP3AdjEs8D33LqnoYtddxva5iIeG3elTqtaIdS
         /+MoKRpS0GnuzClJN+fYPHrrBbr/ebIqu5b+Q89nyvvsjoUsMVbfs8J9+/dGpsw5Ts7W
         ncxPTopGpUBpJMJZpIwWe8fDK1liJz9ySQRp+b/62Nd/QM+/E+AwMfWXmrQsn1DapCL9
         oM1EiIyd+0vG4c1POI3sYNvX3sbLhA56ZxdjU/PTHertkETsnVXItloOHvjrDSOx9HOp
         yQ/FDFQ/w4GbDyX+TEmiDeu4MIM6Jaj82CovYk9ddZgIYcGa8dss5OlqfyGn56EuJ+E3
         ZQ4Q==
X-Gm-Message-State: APjAAAW6NJmsqaqLolH3Vas5Zn41+sOusnod5jPER4q1dj+AMlM0rGkA
        mS6M4/8HNw/Ay4jhJySIL86fCA==
X-Google-Smtp-Source: APXvYqz4lfngE1yhsz7pY6I/dmXhFqLwXsrOP2yR9CbfyvStim1JwfYW4Msvzmz+gRthOGA1jx1nCA==
X-Received: by 2002:a37:9b91:: with SMTP id d139mr2993478qke.366.1582689515562;
        Tue, 25 Feb 2020 19:58:35 -0800 (PST)
Received: from ovpn-121-122.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m17sm401595qki.128.2020.02.25.19.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 19:58:35 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] mm/vmscan: fix data races at kswapd_classzone_idx
Date:   Tue, 25 Feb 2020 22:58:27 -0500
Message-Id: <20200226035827.1285-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: use a temp variable and take care of kswapd_order per Matthew.
     take care of allow_direct_reclaim() as well.

 mm/vmscan.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 876370565455..e61cc71b8915 100644
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
 
@@ -3953,20 +3954,23 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
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
2.21.0 (Apple Git-122.2)

