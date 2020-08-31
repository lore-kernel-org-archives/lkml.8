Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50489C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF43206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgHaTuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 15:50:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:56222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbgHaTuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 15:50:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E676B7F1;
        Mon, 31 Aug 2020 19:50:06 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org
Cc:     oleg@redhat.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH -next] kdb: Use newer api for tasklist scanning
Date:   Mon, 31 Aug 2020 12:34:35 -0700
Message-Id: <20200831193435.22141-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This kills the custom kdb_do_each_thread/kdb_while_each_thread
calls used in kdb to iterate through all tasks. It is obsolete
and racy to use tsk->thread_group, although in this particular
case there is no concurrency so it doesn't matter. Still, lets
trivially replace it for the newer one, maintaining semantics,
of course.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/debug/kdb/kdb_bt.c      | 4 ++--
 kernel/debug/kdb/kdb_main.c    | 8 ++++----
 kernel/debug/kdb/kdb_private.h | 4 ----
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 18e03aba2cfc..1f9f0e47aeda 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -149,14 +149,14 @@ kdb_bt(int argc, const char **argv)
 				return 0;
 		}
 		/* Now the inactive tasks */
-		kdb_do_each_thread(g, p) {
+		for_each_process_thread(g, p) {
 			if (KDB_FLAG(CMD_INTERRUPT))
 				return 0;
 			if (task_curr(p))
 				continue;
 			if (kdb_bt1(p, mask, btaprompt))
 				return 0;
-		} kdb_while_each_thread(g, p);
+		}
 	} else if (strcmp(argv[0], "btp") == 0) {
 		struct task_struct *p;
 		unsigned long pid;
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 5c7949061671..930ac1b25ec7 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2299,10 +2299,10 @@ void kdb_ps_suppressed(void)
 		if (kdb_task_state(p, mask_I))
 			++idle;
 	}
-	kdb_do_each_thread(g, p) {
+	for_each_process_thread(g, p) {
 		if (kdb_task_state(p, mask_M))
 			++daemon;
-	} kdb_while_each_thread(g, p);
+	}
 	if (idle || daemon) {
 		if (idle)
 			kdb_printf("%d idle process%s (state I)%s\n",
@@ -2370,12 +2370,12 @@ static int kdb_ps(int argc, const char **argv)
 	}
 	kdb_printf("\n");
 	/* Now the real tasks */
-	kdb_do_each_thread(g, p) {
+	for_each_process_thread(g, p) {
 		if (KDB_FLAG(CMD_INTERRUPT))
 			return 0;
 		if (kdb_task_state(p, mask))
 			kdb_ps1(p);
-	} kdb_while_each_thread(g, p);
+	}
 
 	return 0;
 }
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 2e296e4a234c..a4281fb99299 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -230,10 +230,6 @@ extern struct task_struct *kdb_curr_task(int);
 
 #define kdb_task_has_cpu(p) (task_curr(p))
 
-/* Simplify coexistence with NPTL */
-#define	kdb_do_each_thread(g, p) do_each_thread(g, p)
-#define	kdb_while_each_thread(g, p) while_each_thread(g, p)
-
 #define GFP_KDB (in_interrupt() ? GFP_ATOMIC : GFP_KERNEL)
 
 extern void *debug_kmalloc(size_t size, gfp_t flags);
-- 
2.26.2

