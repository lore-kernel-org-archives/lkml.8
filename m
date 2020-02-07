Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E66C35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EE0217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ku1eaJ8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBGRW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:22:27 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42964 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGRW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:22:26 -0500
Received: by mail-qt1-f193.google.com with SMTP id j5so2399684qtq.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 09:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vQB77v92IwZwqEzds5lYvt972FWysZSlX36ikp3H76A=;
        b=ku1eaJ8NHCTWizII24U5UbU0csBtEmjMxQvt7dpGLUa8/W+XjzGZd/NFKogIsGZhUW
         tjhf4CR1FJHrzjD/EWNc1tk8poFJ3nZIy6kGGJIIlLYdBGWjEhJYaW1eQjfitjHv3joe
         KzJHUzfS5CyCWZUsphRKJpaLtuy0L9yErzUxM67g/QlmywjJHV3gK7cPj1Fh0oMxPGEG
         31OTjs0wW+rLs4kw96NtfPgAO1JXPQFStKBAdUIavloHPE+DBN35FPZb2sFKkxxeoldC
         seB6ahNNJoji0z3RlTKkXXOcYbXPoG0W39FL4OLgJCO4T1HvN5zibh2NFWiq8CFbgSso
         ppAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vQB77v92IwZwqEzds5lYvt972FWysZSlX36ikp3H76A=;
        b=l9R/3wUhmrtBL4X/cgJL7DF/xHjKUzZ3j5i5aHTQD0k5FjQi4dHZ/Lg2Y/Iyvjv7yR
         pKuB57MpbLBXCc3ZfMzBVKUf10EPIibt6VOPyH6RAU95eSXn2PQjqXexC6cnjupjBKfF
         QVCqFjJ0E3U+/5PxDFrrLvGmlf9wzq/4zfuIndfGEDsCe91ecD7kuram7ziekDFMAhng
         eruj3oChOf8hc/016HiMdVAZwsRLojieQXTaiRp3vO+WeFgbGJFaJ/5GP1FeajA2zc5r
         ABjGvY8EWPZxAJDaqf7+wsUhxwc5YNE1ZpyEcKYLRCzgT2QK86Cb6Ji2Gl6IOtqCIfj8
         iGkw==
X-Gm-Message-State: APjAAAXc4AKVFOSj9H6f5UDza+EszKkWLfEswNrzTPibymU2csQldnAS
        9OTQdHy5w7chLxHzb0Royun4XQ==
X-Google-Smtp-Source: APXvYqwYzX+5Y/qFVobmc9Tc5YUyGFVZoUD0dW9jpbXeaWdgbBPas6sppQz4atm4xMNhogkqpMrmvA==
X-Received: by 2002:ac8:5208:: with SMTP id r8mr8375434qtn.131.1581096145499;
        Fri, 07 Feb 2020 09:22:25 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y194sm1600745qkb.113.2020.02.07.09.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 09:22:24 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        elver@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] mm/memcontrol: fix a data race in scan count
Date:   Fri,  7 Feb 2020 12:21:59 -0500
Message-Id: <1581096119-13593-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct mem_cgroup_per_node mz.lru_zone_size[zone_idx][lru] could be
accessed concurrently as noticed by KCSAN,

 BUG: KCSAN: data-race in lruvec_lru_size / mem_cgroup_update_lru_size

 write to 0xffff9c804ca285f8 of 8 bytes by task 50951 on cpu 12:
  mem_cgroup_update_lru_size+0x11c/0x1d0
  mem_cgroup_update_lru_size at mm/memcontrol.c:1266
  isolate_lru_pages+0x6a9/0xf30
  shrink_active_list+0x123/0xcc0
  shrink_lruvec+0x8fd/0x1380
  shrink_node+0x317/0xd80
  do_try_to_free_pages+0x1f7/0xa10
  try_to_free_pages+0x26c/0x5e0
  __alloc_pages_slowpath+0x458/0x1290
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_vma+0x8a/0x2c0
  do_anonymous_page+0x170/0x700
  __handle_mm_fault+0xc9f/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 read to 0xffff9c804ca285f8 of 8 bytes by task 50964 on cpu 95:
  lruvec_lru_size+0xbb/0x270
  mem_cgroup_get_zone_lru_size at include/linux/memcontrol.h:536
  (inlined by) lruvec_lru_size at mm/vmscan.c:326
  shrink_lruvec+0x1d0/0x1380
  shrink_node+0x317/0xd80
  do_try_to_free_pages+0x1f7/0xa10
  try_to_free_pages+0x26c/0x5e0
  __alloc_pages_slowpath+0x458/0x1290
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_current+0xa6/0x120
  alloc_slab_page+0x3b1/0x540
  allocate_slab+0x70/0x660
  new_slab+0x46/0x70
  ___slab_alloc+0x4ad/0x7d0
  __slab_alloc+0x43/0x70
  kmem_cache_alloc+0x2c3/0x420
  getname_flags+0x4c/0x230
  getname+0x22/0x30
  do_sys_openat2+0x205/0x3b0
  do_sys_open+0x9a/0xf0
  __x64_sys_openat+0x62/0x80
  do_syscall_64+0x91/0xb47
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 95 PID: 50964 Comm: cc1 Tainted: G        W  O L    5.5.0-next-20200204+ #6
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

The write is under lru_lock, but the read is done as lockless. The scan
count is used to determine how aggressively the anon and file LRU lists
should be scanned. Load tearing could generate an inefficient heuristic,
so fix it by adding READ_ONCE() for the read and WRITE_ONCE() for the
writes.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: also have WRITE_ONCE() in the writer which is necessary.

 include/linux/memcontrol.h | 2 +-
 mm/memcontrol.c            | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a7a0a1a5c8d5..e8734dabbc61 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -533,7 +533,7 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 	struct mem_cgroup_per_node *mz;
 
 	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	return mz->lru_zone_size[zone_idx][lru];
+	return READ_ONCE(mz->lru_zone_size[zone_idx][lru]);
 }
 
 void mem_cgroup_handle_over_high(void);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6f6dc8712e39..daf375cc312c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1263,7 +1263,7 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 	lru_size = &mz->lru_zone_size[zid][lru];
 
 	if (nr_pages < 0)
-		*lru_size += nr_pages;
+		WRITE_ONCE(*lru_size, *lru_size + nr_pages);
 
 	size = *lru_size;
 	if (WARN_ONCE(size < 0,
@@ -1274,7 +1274,7 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 	}
 
 	if (nr_pages > 0)
-		*lru_size += nr_pages;
+		WRITE_ONCE(*lru_size, *lru_size + nr_pages);
 }
 
 /**
-- 
1.8.3.1

