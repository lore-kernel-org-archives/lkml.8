Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E64C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C67D214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="euX0p0KD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390880AbgDCNgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:36:00 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45509 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390857AbgDCNf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:35:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id o18so5074966qko.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=t5mNk/pBsrx+7SZ7Dr7HuNaAm2sCHM+52woIf4SjdLE=;
        b=euX0p0KDOn8g3Gb1NEzcdIwRj0eFSMuMP0GNCXsR+rIq/KXzGri2F/Vs/jEf/Kb9Gl
         jTRNzJvFK8e53RNfBPpE6nkBqeOG15Zh3UG/MF+KKs/KfxM2OW77BXTAt+jQoN83/DEJ
         69UvFw+oK9bXxLJakw0CYE7rWtfkcssbI1ETSOF6HC9Wg3nHvwfkishfjJHoBKoppOHh
         NQhbPYrBrMbFcTB0JU4KCpCFN/vmWJ/xXsSCi5bU2EGJwZwiGfwBDPioObbkSLQl6rMY
         fLVHxnVbmbESLJSwWMyuqRRNJbcqcaf3RoN4qx0ptzn87eLlqcECUMZJTkXVJ9hZ2geR
         t+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=t5mNk/pBsrx+7SZ7Dr7HuNaAm2sCHM+52woIf4SjdLE=;
        b=jYiDMy3I2POBMJJLuPW5IdRzVgI6ga351asLZYbKwNn7GXySYYdKpvyrhj6OoXLOPp
         i8yvYOM248p/kDqY3Ztk5lPK1XPbQJvknDkkg4MI/OdqVafKSlkALAIPFiLcBsaqMamg
         nUXeKsPFpkMR14eA64uc+zgQeK3vJ2UcxiczLHeyJ/qmr8eRTBMhPP8gViqF3eH9ktZH
         ftSZredSnKX9/2p/hqHmb6OkETm3u8XLUpu8JtRv9ZM6D8W8gEwjn+bA5VPTumuJEA9o
         3ZK6yIxSHGoGRa7QaoVGDC8QG40qj/U1DMnnYHWqN7t+mF74AQxIGMoaQPL5qzky5lb0
         /PQg==
X-Gm-Message-State: AGi0PuYf/2nn+BneD389DPxRhuFxgbtYOG79V0h89Qec4b7ujBK93iy9
        5ZePe8eHttgL7aGOROu1Aio5OAX19Qo=
X-Google-Smtp-Source: APiQypIS+Ilc05wjUfNSDBZF6lQsnbsb8T/dby3KyfO+CIdtRbbr8ey0xj0xIdbJ3VAfjfs6tlhD2A==
X-Received: by 2002:a05:620a:cc6:: with SMTP id b6mr8775786qkj.74.1585920957072;
        Fri, 03 Apr 2020 06:35:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 17sm6210799qkm.105.2020.04.03.06.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 06:35:56 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@soleen.com, ktkhai@virtuozzo.com, david@redhat.com,
        jmorris@namei.org, sashal@kernel.org, vbabka@suse.cz
Subject: [PATCH v3 3/3] mm: call cond_resched() from deferred_init_memmap()
Date:   Fri,  3 Apr 2020 09:35:49 -0400
Message-Id: <20200403133549.14338-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200403133549.14338-1-pasha.tatashin@soleen.com>
References: <20200403133549.14338-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that deferred pages are initialized with interrupts enabled we can
replace touch_nmi_watchdog() with cond_resched(), as it was before
3a2d7fa8a3d5.

For now, we cannot do the same in deferred_grow_zone() as it is still
initializes pages with interrupts disabled.

This change fixes RCU problem described:
linux-mm/20200401104156.11564-2-david@redhat.com

[   60.474005] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[   60.475000] rcu:  1-...0: (0 ticks this GP) idle=02a/1/0x4000000000000000 softirq=1/1 fqs=15000
[   60.475000] rcu:  (detected by 0, t=60002 jiffies, g=-1199, q=1)
[   60.475000] Sending NMI from CPU 0 to CPUs 1:
[    1.760091] NMI backtrace for cpu 1
[    1.760091] CPU: 1 PID: 20 Comm: pgdatinit0 Not tainted 4.18.0-147.9.1.el8_1.x86_64 #1
[    1.760091] Hardware name: Red Hat KVM, BIOS 1.13.0-1.module+el8.2.0+5520+4e5817f3 04/01/2014
[    1.760091] RIP: 0010:__init_single_page.isra.65+0x10/0x4f
[    1.760091] Code: 48 83 cf 63 48 89 f8 0f 1f 40 00 48 89 c6 48 89 d7 e8 6b 18 80 ff 66 90 5b c3 31 c0 b9 10 00 00 00 49 89 f8 48 c1 e6 33 f3 ab <b8> 07 00 00 00 48 c1 e2 36 41 c7 40 34 01 00 00 00 48 c1 e0 33 41
[    1.760091] RSP: 0000:ffffba783123be40 EFLAGS: 00000006
[    1.760091] RAX: 0000000000000000 RBX: fffffad34405e300 RCX: 0000000000000000
[    1.760091] RDX: 0000000000000000 RSI: 0010000000000000 RDI: fffffad34405e340
[    1.760091] RBP: 0000000033f3177e R08: fffffad34405e300 R09: 0000000000000002
[    1.760091] R10: 000000000000002b R11: ffff98afb691a500 R12: 0000000000000002
[    1.760091] R13: 0000000000000000 R14: 000000003f03ea00 R15: 000000003e10178c
[    1.760091] FS:  0000000000000000(0000) GS:ffff9c9ebeb00000(0000) knlGS:0000000000000000
[    1.760091] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.760091] CR2: 00000000ffffffff CR3: 000000a1cf20a001 CR4: 00000000003606e0
[    1.760091] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.760091] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    1.760091] Call Trace:
[    1.760091]  deferred_init_pages+0x8f/0xbf
[    1.760091]  deferred_init_memmap+0x184/0x29d
[    1.760091]  ? deferred_free_pages.isra.97+0xba/0xba
[    1.760091]  kthread+0x112/0x130
[    1.760091]  ? kthread_flush_work_fn+0x10/0x10
[    1.760091]  ret_from_fork+0x35/0x40
[   89.123011] node 0 initialised, 1055935372 pages in 88650ms

Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
Cc: stable@vger.kernel.org # 4.17+

Reported-by: Yiqian Wei <yiwei@redhat.com>
Tested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4a60f2427eb0..445f74358997 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1816,7 +1816,7 @@ static int __init deferred_init_memmap(void *data)
 	 */
 	while (spfn < epfn) {
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
-		touch_nmi_watchdog();
+		sched_clock();
 	}
 zone_empty:
 	/* Sanity check that the next zone really is unpopulated */
-- 
2.17.1

