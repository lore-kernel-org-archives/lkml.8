Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51764C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2951A2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1m+8znh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgHXLUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHXLT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:19:58 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB88C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:19:58 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so4073082plr.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2g3JRsf/PKzig8v/7OjH4THY5xjYwC1a2FsdQmpvMQ8=;
        b=G1m+8znhMcg31IaZZwCkHg9c/a9YCnCWU0t9gKHOeVu2+2cqBfkhEoLIxSqOsnHBzg
         GATzFuVnfjjmMcO4NOezcDypI1urXfjzM8HgYwp39103gTtUHynFPlv+FPZwboQqAORD
         LbgwAVr/IbQE75LCeEqK1IMmFC0f5ofpt3wbpBQB/p37pOWusMepDK4fH3E4vqWEGPlp
         1+w05tCICJh81N6zJya73aEIGfnrQuABDkL+9O/UyPg2Jk31Td2W0aHKkn3c1Z49kRzV
         X7e9IJgvu47kJ6LmG3rNDobSbR1acWAIFjxDMsY9w46u7ClSB9LBE+OBeG0DWe2oCQYK
         QhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2g3JRsf/PKzig8v/7OjH4THY5xjYwC1a2FsdQmpvMQ8=;
        b=oa8gTc1DBWKamuc8YQIbfHa2wkOl4um45GRAtIeBWLddNy1et6jcSwkxrokCDxkrQh
         CcOz+0cnwa1dc/RZnwDDO7XBRWUyribw/yRlJ6Rc6O+bZoaG9mp2dBeXH1+tjXD4WEhf
         G1BB96y+qAp0CaHNbYtN7/3QHhezGDfrbFSBjhvdC6cnSbQV5sASSZZWpCSSQUDGjIRS
         yx1lcSxdf2agKpEtdqlHohs1P7k0ShRvPD6qLmzMoR1XqazA/KiTxgx82HhLJmyeF4d3
         FYEQVXEoh4M6A1z1MxI/BSOECHgY6c0MuLQCOnpP8RXKmhSQEYA3yMt5NJw9zjhJwFt2
         fFrQ==
X-Gm-Message-State: AOAM531QZCZsFu5V1EyU6KwqD02NXLCQRAnoxuMWjPmPXv+WKmInWG/i
        k8Rz3SBffsLBDpKvp89eMco=
X-Google-Smtp-Source: ABdhPJwk8e6D4k/zcB9i/bzBJbjcIEvQVgR9nSFgoOFEd+TvsZ6Mi+gUyyNyG2o8w67VUE5logb4tA==
X-Received: by 2002:a17:902:8a93:: with SMTP id p19mr3500563plo.320.1598267997884;
        Mon, 24 Aug 2020 04:19:57 -0700 (PDT)
Received: from builder-PowerEdge-R730xd.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 193sm11447084pfu.169.2020.08.24.04.19.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 04:19:57 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH] workqueue: Warning when work try to flush own workqueue
Date:   Mon, 24 Aug 2020 19:19:50 +0800
Message-Id: <fd24b0a495da7658481925548183eaa22a57351f.1598266402.git.zhaoqianli@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qianli Zhao <zhaoqianli@xiaomi.com>

In a work process context,flush own workqueue or work self
will cause process blocked(enter state D),leading to a
deadlock,catch this wrong use,warn when the issue happened

crash> ps 10856
PID    PPID  CPU       TASK       ST   COMM
10856    2   2  ffffffc873428080  UN  [kworker/u16:15]
crash> bt 10856
PID: 10856  TASK: ffffffc873428080  CPU: 2   COMMAND: "kworker/u16:15"
 #0 [ffffff80270cb9a0] __switch_to at ffffff99bba8533c
 #1 [ffffff80270cba30] __schedule at ffffff99bcda18dc
 #2 [ffffff80270cba50] schedule at ffffff99bcda1cdc
 #3 [ffffff80270cbaf0] schedule_timeout at ffffff99bcda6674
 #4 [ffffff80270cbb70] wait_for_common at ffffff99bcda2c68
 #5 [ffffff80270cbb80] wait_for_completion at ffffff99bcda2b60
 #6 [ffffff80270cbc30] flush_workqueue at ffffff99bbad7a60
 #7 [ffffff80270cbc90] drain_workqueue at ffffff99bbad80fc
 #8 [ffffff80270cbcb0] destroy_workqueue at ffffff99bbad92f8
 #9 [ffffff80270cbda0] dfc_svc_init at ffffff99bbfbfb6c
 #10 [ffffff80270cbdf0] process_one_work at ffffff99bbadc478
 #11 [ffffff80270cbe50] worker_thread at ffffff99bbadc9dc
 #12 [ffffff80270cbeb0] kthread at ffffff99bbae1f84

Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
---
 kernel/workqueue.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3f5d4bf..759280d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2585,6 +2585,8 @@ static int rescuer_thread(void *__rescuer)
  * @target_work: work item being flushed (NULL for workqueue flushes)
  *
  * %current is trying to flush the whole @target_wq or @target_work on it.
+ * If a work try to flush own workqueue or itself will cause process blocked,
+ * leading to a dealock.
  * If @target_wq doesn't have %WQ_MEM_RECLAIM, verify that %current is not
  * reclaiming memory or running on a workqueue which doesn't have
  * %WQ_MEM_RECLAIM as that can break forward-progress guarantee leading to
@@ -2594,13 +2596,16 @@ static void check_flush_dependency(struct workqueue_struct *target_wq,
 				   struct work_struct *target_work)
 {
 	work_func_t target_func = target_work ? target_work->func : NULL;
-	struct worker *worker;
+	struct worker *worker = current_wq_worker();
+
+	WARN_ONCE(worker && worker->current_pwq->wq == target_wq &&
+		  worker->task == current,
+		  "workqueue: current work function:%ps is flushing own workqueue:%s",
+		  worker->current_func, target_wq->name);
 
 	if (target_wq->flags & WQ_MEM_RECLAIM)
 		return;
 
-	worker = current_wq_worker();
-
 	WARN_ONCE(current->flags & PF_MEMALLOC,
 		  "workqueue: PF_MEMALLOC task %d(%s) is flushing !WQ_MEM_RECLAIM %s:%ps",
 		  current->pid, current->comm, target_wq->name, target_func);
-- 
2.7.4

