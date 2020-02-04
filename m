Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E4FC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EFA20674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgBDLIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:08:11 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34956 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726741AbgBDLIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:08:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Tp7nyiq_1580814485;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tp7nyiq_1580814485)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Feb 2020 19:08:06 +0800
Subject: Re: [PATCH] OCFS2: remove unused macros
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ChenGang <cg.chen@huawei.com>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <1579577827-251796-1-git-send-email-alex.shi@linux.alibaba.com>
 <a12fc48c-3165-3519-c2b2-399b06c8b5c6@linux.alibaba.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <580ee0d1-edce-3161-dbd9-91c763412681@linux.alibaba.com>
Date:   Tue, 4 Feb 2020 19:08:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a12fc48c-3165-3519-c2b2-399b06c8b5c6@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/1/26 上午9:43, Joseph Qi 写道:
> 
> 
> On 20/1/21 11:37, Alex Shi wrote:
>> O2HB_DEFAULT_BLOCK_BITS/DLM_THREAD_MAX_ASTS/DLM_MIGRATION_RETRY_MS and
>> OCFS2_MAX_RESV_WINDOW_BITS/OCFS2_MIN_RESV_WINDOW_BITS are
>> never used from they were introduced to kernel. so better to remove
>> them.
>>
>>  
>> -#define DLM_MIGRATION_RETRY_MS  100
>> -
> It is no longer used since commit 66effd3c6812 ("ocfs2/dlm: Do not
> migrate resource to a node that is leaving the domain").

Thanks for point out. how about the following revised patch?

Since a trival patch don't need much reviewer, I removed some Ccs.

Thanks
Alex

---

From 3bf7bf5a82a6a2275db49ba029d48fdd5c09332c Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Tue, 21 Jan 2020 11:14:29 +0800
Subject: [PATCH v2] OCFS2: remove unused macros

DLM_MIGRATION_RETRY_MS is no longer used since commit 66effd3c6812
("ocfs2/dlm: Do not migrate resource to a node that is leaving the domain").

And the others are never used since they were introduced. Let's remove
them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
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

