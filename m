Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE095C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA942215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgIGUsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 16:48:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:36380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726850AbgIGUsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:48:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AAACFAC95;
        Mon,  7 Sep 2020 20:48:39 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     daniel.thompson@linaro.org
Cc:     dianders@chromium.org, jason.wessel@windriver.com, oleg@redhat.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v2] kdb: Use newer api for tasklist scanning
Date:   Mon,  7 Sep 2020 13:32:06 -0700
Message-Id: <20200907203206.21293-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907134614.guc4tzj3knnihbe4@holly.lan>
References: <20200907134614.guc4tzj3knnihbe4@holly.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This kills using the do_each_thread/while_each_thread combo to
iterate all threads and uses for_each_process_thread() instead,
maintaining semantics. while_each_thread() is ultimately racy
and deprecated;  although in this particular case there is no
concurrency so it doesn't matter. Still lets trivially get rid
of two more users.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/debug/gdbstub.c         | 4 ++--
 kernel/debug/kdb/kdb_bt.c      | 4 ++--
 kernel/debug/kdb/kdb_main.c    | 8 ++++----
 kernel/debug/kdb/kdb_private.h | 4 ----
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index cc3c43dfec44..b52ebff09ac8 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -725,7 +725,7 @@ static void gdb_cmd_query(struct kgdb_state *ks)
 			}
 		}
 
-		do_each_thread(g, p) {
+		for_each_process_thread(g, p) {
 			if (i >= ks->thr_query && !finished) {
 				int_to_threadref(thref, p->pid);
 				ptr = pack_threadid(ptr, thref);
@@ -735,7 +735,7 @@ static void gdb_cmd_query(struct kgdb_state *ks)
 					finished = 1;
 			}
 			i++;
-		} while_each_thread(g, p);
+		}
 
 		*(--ptr) = '\0';
 		break;
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

