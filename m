Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE245C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC930206ED
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="s+FRY8H+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbgBKSjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:39:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42755 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbgBKSjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:39:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id r5so7391416qtt.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 10:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wUX84XimYmGL58y+DzX6h0BesHs7o3oJk7cCJ/rePag=;
        b=s+FRY8H+L2o0LYjVYAMze9JUB1QpIvbbm9dd8JTtRTfz6pUYsbH+UoKl9adNfmjLZo
         lk+4kTrNVUb9QtohaEMoEpRvhtn2LOA9CMScsc+gJuxHkSE8bPltZyuQcO3txz1nfIIL
         n9ZcieAfupktiGsDlWJvNDAyaSfem//wVjMzC3IPOKj9PrdG2c305wVAzHA7Ly5pOpCN
         CxAfnnkFwmc72vMMyyxLHZgFL9lPsKxZkMT6s0xiVA80vuTgyX0vATtUAEWduuZyg0ov
         kHokO9WwQwVWtBz91FOgypXyL8Yq2mm6aJWLUlzgpRNLZyV7+NDo28fLBLOEFRMdRK3X
         wa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wUX84XimYmGL58y+DzX6h0BesHs7o3oJk7cCJ/rePag=;
        b=T8xiImaweoxMzCXDDnApAPjBDi+E7XRHaVR7GIumebKQOBc9A+7tdTDmXN8flgIuov
         iNiNyYINCa+P1ArpkQQ4AlVglVL+UbA9Gs6K92wbp0i5/mUniNyaGzfzQXrJjze7dE5U
         XaEYys2pVLBMrwGEOUF5JUEKxLaSPk12U+sdut6N377AnZ7pw8eYPzNdzLQPze5VkGci
         3ZRc1aGYXWBUDcEBA8lsLnu2fMunU6vgNg5WXgHU/dEQeFUJXsiQyCmSswOOTA3bO409
         t3YoPHXlx1DU0tK+tkUEsofBSsJ/U5YiInLv/c1sGvmoyZLF3c7ksuuP3pe8XaMQXzOb
         1ibA==
X-Gm-Message-State: APjAAAXugSwv2vIuAtjeaEQkHZoJbUssWE4ODMjHzUlNPPagt6iWGG/+
        ZvfckxdlCoPQjgwWnX0soHmAMA==
X-Google-Smtp-Source: APXvYqzOwN8G547ApDB+/AxLeAtsW7EosMSlxcEgkj0nUCP29m2bN1xxdRjHlKpJGx2zZ8+GU2IkWg==
X-Received: by 2002:ac8:2af4:: with SMTP id c49mr3754111qta.367.1581446393834;
        Tue, 11 Feb 2020 10:39:53 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o10sm2520877qtp.38.2020.02.11.10.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 10:39:53 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, tj@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/mempool: fix a data race in mempool_free()
Date:   Tue, 11 Feb 2020 13:39:44 -0500
Message-Id: <1581446384-2131-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mempool_t pool.curr_nr could be accessed concurrently as noticed by
KCSAN,

 BUG: KCSAN: data-race in mempool_free / remove_element

 write to 0xffffffffa937638c of 4 bytes by task 6359 on cpu 113:
  remove_element+0x4a/0x1c0
  remove_element at mm/mempool.c:132
  mempool_alloc+0x102/0x210
  (inlined by) mempool_alloc at mm/mempool.c:399
  bio_alloc_bioset+0x106/0x2c0
  get_swap_bio+0x49/0x230
  __swap_writepage+0x680/0xc30
  swap_writepage+0x9c/0xf0
  pageout+0x33e/0xae0
  shrink_page_list+0x1f57/0x2870
  shrink_inactive_list+0x316/0x880
  shrink_lruvec+0x8dc/0x1380
  shrink_node+0x317/0xd80
  do_try_to_free_pages+0x1f7/0xa10
  try_to_free_pages+0x26c/0x5e0
  __alloc_pages_slowpath+0x458/0x1290
  <snip>

 read to 0xffffffffa937638c of 4 bytes by interrupt on cpu 64:
  mempool_free+0x3e/0x150
  mempool_free at mm/mempool.c:492
  bio_free+0x192/0x280
  bio_put+0x91/0xd0
  end_swap_bio_write+0x1d8/0x280
  bio_endio+0x2c2/0x5b0
  dec_pending+0x22b/0x440 [dm_mod]
  clone_endio+0xe4/0x2c0 [dm_mod]
  bio_endio+0x2c2/0x5b0
  blk_update_request+0x217/0x940
  scsi_end_request+0x6b/0x4d0
  scsi_io_completion+0xb7/0x7e0
  scsi_finish_command+0x223/0x310
  scsi_softirq_done+0x1d5/0x210
  blk_mq_complete_request+0x224/0x250
  scsi_mq_done+0xc2/0x250
  pqi_raid_io_complete+0x5a/0x70 [smartpqi]
  pqi_irq_handler+0x150/0x1410 [smartpqi]
  __handle_irq_event_percpu+0x90/0x540
  handle_irq_event_percpu+0x49/0xd0
  handle_irq_event+0x85/0xca
  handle_edge_irq+0x13f/0x3e0
  do_IRQ+0x86/0x190
  <snip>

Since the write is under pool->lock but the read is done as lockless.
Even though the commit 5b990546e334 ("mempool: fix and document
synchronization and memory barrier usage") introduced the smp_wmb() and
smp_rmb() pair to improve the situation, it is adequate to protect it
from data races which could lead to a logic bug, so fix it by adding
READ_ONCE() for the read.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/mempool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 85efab3da720..79bff63ecf27 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -489,7 +489,7 @@ void mempool_free(void *element, mempool_t *pool)
 	 * ensures that there will be frees which return elements to the
 	 * pool waking up the waiters.
 	 */
-	if (unlikely(pool->curr_nr < pool->min_nr)) {
+	if (unlikely(READ_ONCE(pool->curr_nr) < pool->min_nr)) {
 		spin_lock_irqsave(&pool->lock, flags);
 		if (likely(pool->curr_nr < pool->min_nr)) {
 			add_element(pool, element);
-- 
1.8.3.1

