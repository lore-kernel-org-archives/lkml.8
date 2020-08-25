Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07889C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50112071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOIK5NAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgHYMGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgHYMG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:06:26 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87D2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:06:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nv17so1149876pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f7Xw87w/h5UvoabA+YlP6Bsn9RajGgFTR3KFrppXRRY=;
        b=OOIK5NAH8qBlZl61Na9QU2GYwVCduBlfi2NZol0VFYNhC3F2qUyXztDdWQK/g1yN08
         81F7NABVeNAk2Zv+idhvRPOrkNa/IWlc5hqmkGmJsWCqOKNF2MJE9zZjJ9FGoyeYaobx
         xPUNZvP8ndqqqDiIinuDS6qdn9zfkSOiJz2l1wTva4Fw1C/Kq6cLIlNFSaJO8KLNMaV2
         p/ygEjIvOkHzHuPZ1OpGNkvd70FMbrQffjcjL/vSj3NymiH02XMtHc9Y/4M7prQjXavB
         UbUIJ3oiZsRfB0hj4ax9FKNdjwJHuAJLZkxCOndmCHbOPyBY8JMx12iclZVrINMxGxyC
         m8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f7Xw87w/h5UvoabA+YlP6Bsn9RajGgFTR3KFrppXRRY=;
        b=FNQBE+wDgGybhroj4GI4I0RMlCdEml1qEqbltOo/h8bBM+WQ8D3OltY0yCBMM6DdAs
         k/XQ8LUGTRyB29lNugKwI+wle8dSWshvoppOfeeS9mu2f3XujP6vcy1y+lfObGpFADcc
         t/DSVgZoS2mx0MylM3/mKNdvWs2vRdT6wN3Z+5+EeIFOXt3t76HwcXRIXiB3HeV7CraY
         qKi0t72unQNndj0LH4OdeuK4cd1b2TbjfWw7oihmMroPMNt0RZ+cfDAl/OYCnzenKo5L
         dVN9Jeh2ztrv8HnXTRdJe7tkiUZc7KCKGtJXaXlrkx0CvmVQ6w8u4cbZBJVPkJ684qaW
         nhlg==
X-Gm-Message-State: AOAM530c2Gq2wB/XWvJgAZXYm+fVEB/T4dBMmhJtZis+q+av94NKdcHr
        LQTcdO7ceso32JHVRPUeI02hkTH1iQmueg==
X-Google-Smtp-Source: ABdhPJwIDIbapC/r5dkd4XzqXqUzr+kB4BTKDK4Ng/k0FEJ4aXkmFo48suBkWgwXJ/OwYQiagcVTBA==
X-Received: by 2002:a17:90a:cf8a:: with SMTP id i10mr1342047pju.140.1598357186344;
        Tue, 25 Aug 2020 05:06:26 -0700 (PDT)
Received: from builder-PowerEdge-R730xd.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id a20sm5546597pfi.11.2020.08.25.05.06.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 05:06:25 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, dan.carpenter@oracle.com,
        Markus.Elfring@web.de
Cc:     linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH v3] workqueue: Warn when work flush own workqueue
Date:   Tue, 25 Aug 2020 20:06:19 +0800
Message-Id: <e253c86e5f43cdaf5de696c7e2beca4d7edd1ea0.1598355934.git.zhaoqianli@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qianli Zhao <zhaoqianli@xiaomi.com>

If a workqueue flushes itself then that will lead to
a deadlock. Print a warning and a stack trace when
this happens.

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
Changes in V3:
- update changelog
- update comment

Changes in V2:
- update changelog
- update comment

 kernel/workqueue.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c41c3c1..a46d289 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2585,6 +2585,7 @@ static int rescuer_thread(void *__rescuer)
  * @target_work: work item being flushed (NULL for workqueue flushes)
  *
  * %current is trying to flush the whole @target_wq or @target_work on it.
+ * If a work queue flushes itself, that will lead to a deadlock.
  * If @target_wq doesn't have %WQ_MEM_RECLAIM, verify that %current is not
  * reclaiming memory or running on a workqueue which doesn't have
  * %WQ_MEM_RECLAIM as that can break forward-progress guarantee leading to
@@ -2594,13 +2595,16 @@ static void check_flush_dependency(struct workqueue_struct *target_wq,
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

