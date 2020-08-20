Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E577C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A1020885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgHTUyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:54:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:42190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgHTUyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:54:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 636AAACB5;
        Thu, 20 Aug 2020 20:55:15 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, oleg@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] mm/kmemleak: rely on rcu for task stack scanning
Date:   Thu, 20 Aug 2020 13:39:02 -0700
Message-Id: <20200820203902.11308-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak_scan() currently relies on the big tasklist_lock
hammer to stabilize iterating through the tasklist. Instead,
this patch proposes simply using rcu along with the rcu-safe
for_each_process_thread flavor (without changing scan semantics),
which doesn't make use of next_thread/p->thread_group and thus
cannot race with exit. Furthermore, any races with fork()
and not seeing the new child should be benign as it's not
running yet and can also be detected by the next scan.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 mm/kmemleak.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 5e252d91eb14..c0014d3b91c1 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1471,15 +1471,15 @@ static void kmemleak_scan(void)
 	if (kmemleak_stack_scan) {
 		struct task_struct *p, *g;
 
-		read_lock(&tasklist_lock);
-		do_each_thread(g, p) {
+		rcu_read_lock();
+		for_each_process_thread(g, p) {
 			void *stack = try_get_task_stack(p);
 			if (stack) {
 				scan_block(stack, stack + THREAD_SIZE, NULL);
 				put_task_stack(p);
 			}
-		} while_each_thread(g, p);
-		read_unlock(&tasklist_lock);
+		}
+		rcu_read_unlock();
 	}
 
 	/*
-- 
2.26.2

