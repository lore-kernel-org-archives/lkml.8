Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB929C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AC224125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAUDhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 22:37:23 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:19187 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728827AbgAUDhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 22:37:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0ToGalXN_1579577829;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToGalXN_1579577829)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 11:37:09 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        ChenGang <cg.chen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] OCFS2: remove unused macros
Date:   Tue, 21 Jan 2020 11:37:07 +0800
Message-Id: <1579577827-251796-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O2HB_DEFAULT_BLOCK_BITS/DLM_THREAD_MAX_ASTS/DLM_MIGRATION_RETRY_MS and
OCFS2_MAX_RESV_WINDOW_BITS/OCFS2_MIN_RESV_WINDOW_BITS are
never used from they were introduced to kernel. so better to remove
them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com> 
Cc: Joel Becker <jlbec@evilplan.org> 
Cc: Joseph Qi <joseph.qi@linux.alibaba.com> 
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
Cc: Kate Stewart <kstewart@linuxfoundation.org> 
Cc: ChenGang <cg.chen@huawei.com> 
Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: Richard Fontana <rfontana@redhat.com> 
Cc: ocfs2-devel@oss.oracle.com 
Cc: linux-kernel@vger.kernel.org 
---
 fs/ocfs2/cluster/heartbeat.c | 2 --
 fs/ocfs2/dlm/dlmmaster.c     | 2 --
 fs/ocfs2/dlm/dlmthread.c     | 1 -
 fs/ocfs2/reservations.c      | 3 ---
 4 files changed, 8 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index a368350d4c27..78cb48d6a596 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -101,8 +101,6 @@ struct o2hb_debug_buf {
 
 static struct o2hb_callback *hbcall_from_type(enum o2hb_callback_type type);
 
-#define O2HB_DEFAULT_BLOCK_BITS       9
-
 enum o2hb_heartbeat_modes {
 	O2HB_HEARTBEAT_LOCAL		= 0,
 	O2HB_HEARTBEAT_GLOBAL,
diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 74b768ca1cd8..123b6873d9fa 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -2751,8 +2751,6 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
 	return ret;
 }
 
-#define DLM_MIGRATION_RETRY_MS  100
-
 /*
  * Should be called only after beginning the domain leave process.
  * There should not be any remaining locks on nonlocal lock resources,
diff --git a/fs/ocfs2/dlm/dlmthread.c b/fs/ocfs2/dlm/dlmthread.c
index 61c51c268460..2dd9727537fe 100644
--- a/fs/ocfs2/dlm/dlmthread.c
+++ b/fs/ocfs2/dlm/dlmthread.c
@@ -680,7 +680,6 @@ static void dlm_flush_asts(struct dlm_ctxt *dlm)
 
 #define DLM_THREAD_TIMEOUT_MS (4 * 1000)
 #define DLM_THREAD_MAX_DIRTY  100
-#define DLM_THREAD_MAX_ASTS   10
 
 static int dlm_thread(void *data)
 {
diff --git a/fs/ocfs2/reservations.c b/fs/ocfs2/reservations.c
index 0249e8ca1028..bf3842e34fb9 100644
--- a/fs/ocfs2/reservations.c
+++ b/fs/ocfs2/reservations.c
@@ -33,9 +33,6 @@
 
 static DEFINE_SPINLOCK(resv_lock);
 
-#define	OCFS2_MIN_RESV_WINDOW_BITS	8
-#define	OCFS2_MAX_RESV_WINDOW_BITS	1024
-
 int ocfs2_dir_resv_allowed(struct ocfs2_super *osb)
 {
 	return (osb->osb_resv_level && osb->osb_dir_resv_level);
-- 
1.8.3.1

