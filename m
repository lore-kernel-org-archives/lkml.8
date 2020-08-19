Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E50C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5A720866
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKqpsTCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgHSMyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbgHSMyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:54:10 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE2EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 05:54:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a79so11626785pfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 05:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PnRFKRAedDIcgPdVOrDHp5lHsOtzTanDbhe4IRPxP8c=;
        b=LKqpsTCNNWud5otkV6T5Gl5AekemUr7F96//2IxrvX3NNPAtJz+npMbpX0qHnVBj12
         BLP4+aWV3uG5rd2DL2h3EqsGuU2twiLFLuvfMrSVouQWdeMyCNgtTAjpTfwjFrjOEcYK
         XeACCj6r08YWcckRGHcVbisWLNWaxwLPCXCSvr0v2j3iYN5odNu6b9JcF7hJX48YWVqW
         FuBe/SPHmuc5CekDaeMdgKedJg9Y7bWMDRu/L54pQJYw2bGhroUJZyrpu2bhpANLA+Kt
         ycgJ8n9UwqBh88t0JZXiBKKBrpHc85DXXL69fTsBGrFTMkE1eaRFssxBtdx+LWWfvprz
         pMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PnRFKRAedDIcgPdVOrDHp5lHsOtzTanDbhe4IRPxP8c=;
        b=G4RyI1x0jlHoIrxZLFqbylNcktf1QSFsmV6IhqrKwTzb6dKVZqO2WgZzBhgr1him3M
         DHOP6AdiPJcIfjjo7uFyXE5d4mx35e+iq39L4IJc/spi1rY+hv1uP+N8yBNa0IPFIi6o
         DlHgkWKIk6VUAxv/yf6DNQfpn6rM+h4eVScMrOZrsl6P2XFxdwRLlTQMOHYmAoY4WOYE
         LO2nQpxZnEc3aoFeSfm+nKJPglAE3TlCoRESqPfitWoGbZabHCaKYVs4ng8/NKD3+1yP
         ef4ph7ZP74RSuIeYz/o8+DMg3mgQCBb7D859/ek+gjAWAdD3kyqqgwZrHpjQSDbrivTV
         hCeA==
X-Gm-Message-State: AOAM533TOrRUW3fGqFLIqMk1A30tEwqMxsUdzoyMn4Kaq8nlHpD0FerU
        syLRDYds1CAI3tN8xkszs9g=
X-Google-Smtp-Source: ABdhPJynmTgB9JqM7CUZrJw0aqDD1TaenZHzXqIb7z6sRPvOrLwgGp4XYR87l38q2708D4T+VhlkCg==
X-Received: by 2002:a05:6a00:22c9:: with SMTP id f9mr19142584pfj.212.1597841650118;
        Wed, 19 Aug 2020 05:54:10 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-193-175.tpgi.com.au. [193.116.193.175])
        by smtp.gmail.com with ESMTPSA id o16sm30903203pfu.188.2020.08.19.05.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 05:54:09 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH RFC] mm: increase page waitqueue hash size
Date:   Wed, 19 Aug 2020 22:53:49 +1000
Message-Id: <20200819125349.558249-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page waitqueue hash is a bit small (256 entries) on very big systems. A
16 socket 1536 thread POWER9 system was found to encounter hash collisions
and excessive time in waitqueue locking at times. This was intermittent and
hard to reproduce easily with the setup we had (very little real IO
capacity). The thought is some important pages happened to collide in the
hash, slowing down page locking, causing the problem to snowball.

An small test case was made where threads would write and fsync different
pages, generating just a small amount of contention across many pages.

Increasing page waitqueue hash size to 262144 entries increased throughput
by 182% while also reducing standard deviation 3x. perf before the increase:

  36.23%  [k] _raw_spin_lock_irqsave                -      -
              |
              |--34.60%--wake_up_page_bit
              |          0
              |          iomap_write_end.isra.38
              |          iomap_write_actor
              |          iomap_apply
              |          iomap_file_buffered_write
              |          xfs_file_buffered_aio_write
              |          new_sync_write

  17.93%  [k] native_queued_spin_lock_slowpath      -      -
              |
              |--16.74%--_raw_spin_lock_irqsave
              |          |
              |           --16.44%--wake_up_page_bit
              |                     iomap_write_end.isra.38
              |                     iomap_write_actor
              |                     iomap_apply
              |                     iomap_file_buffered_write
              |                     xfs_file_buffered_aio_write

This patch uses alloc_large_system_hash to allocate a bigger system hash
that scales somewhat with memory size.

This hash could be made per-node, which should help reduce remote accesses
on well localised workloads, but that adds some complexity with hotplug,
so until we get a less artificial workload to test with, let's keep it
simple.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

 mm/filemap.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1aaea26556cc..d3cd158f0c3f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -34,6 +34,7 @@
 #include <linux/security.h>
 #include <linux/cpuset.h>
 #include <linux/hugetlb.h>
+#include <linux/memblock.h>
 #include <linux/memcontrol.h>
 #include <linux/cleancache.h>
 #include <linux/shmem_fs.h>
@@ -969,19 +970,36 @@ EXPORT_SYMBOL(__page_cache_alloc);
  * at a cost of "thundering herd" phenomena during rare hash
  * collisions.
  */
-#define PAGE_WAIT_TABLE_BITS 8
-#define PAGE_WAIT_TABLE_SIZE (1 << PAGE_WAIT_TABLE_BITS)
+#define PAGE_WAIT_TABLE_SIZE (1 << page_wait_table_bits)
+#if CONFIG_BASE_SMALL
+static const unsigned int page_wait_table_bits = 4;
 static wait_queue_head_t page_wait_table[PAGE_WAIT_TABLE_SIZE] __cacheline_aligned;
+#else
+static unsigned int page_wait_table_bits __ro_after_init;
+static wait_queue_head_t *page_wait_table __ro_after_init;
+#endif
 
 static wait_queue_head_t *page_waitqueue(struct page *page)
 {
-	return &page_wait_table[hash_ptr(page, PAGE_WAIT_TABLE_BITS)];
+	return &page_wait_table[hash_ptr(page, page_wait_table_bits)];
 }
 
 void __init pagecache_init(void)
 {
 	int i;
 
+	if (!CONFIG_BASE_SMALL) {
+		page_wait_table = alloc_large_system_hash("Page waitqueue hash",
+							sizeof(wait_queue_head_t),
+							0,
+							21,
+							0,
+							&page_wait_table_bits,
+							NULL,
+							0,
+							0);
+	}
+
 	for (i = 0; i < PAGE_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(&page_wait_table[i]);
 
-- 
2.23.0

