Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F731C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795BB20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="falzX6nK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgH0GJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgH0GJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:09:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A76C061249
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 23:09:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q1so2052631pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 23:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I7U/5qhA694RjZM2OW+xmuQjQNA+7fdpq4xzOUjoUlE=;
        b=falzX6nK15X4RByLUDfyCCnor91K34PriQeHLBm4zJE4VFeW4GTx3T4VPHN3CCe7Ot
         X+Qd8CvKb1/YLOCF/xazj8c/qwC89URldGi7L8BSwugFpb27ERJgsIfSpF9zedepvrnO
         INwAi5pQrjYQxapJUAEG76ZvIzxTzdNZenJAK+3+eBADzpVZXkYcq7Zq27np3W89v3BG
         LjTIric4FJiJfOI864SmAQiIIzTfRR7W33dBY0hSxhFefH1uiSC6xKoGExa3tAgOm8XX
         hot/PokUBUKeuPDbSzzTT/iTpia+Sq4+J8C/xh12YeW8yomDhF5monVzP7uDj9Sqg8kO
         aeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I7U/5qhA694RjZM2OW+xmuQjQNA+7fdpq4xzOUjoUlE=;
        b=ehv/TpvXt/16OK4roONGhh9SiGWdmQATnHzY9ZMH54wlGAdCFBDgGhU07uAzfsIoKr
         RBTk+iCHZ01sTB0fn9lzIWzoWnlH0vUiGFiNa0BeDPt63ditFIwSml+Hz2+wSac0GePp
         8I7CjG0EteMUwXwW/L4hvgsit2d1hQXb6bS1ZsSZl29xIuJsoE5t8ClmVEQNvRHrZTNz
         EbQgfoO4/jMbsdlMGvnhivhRBFe6J1qHyDxmeAwpipOzr8BU5LehcGyFV1RUZSfo63Jp
         ZvCNUT8ZocNcEGTjm0ioY9eVtM21qv2fBkLXfL7HTcCPmQhqnBmQ0Ap+0iC5qmc6QT1L
         AZBw==
X-Gm-Message-State: AOAM533jmLXep/l1ljlFunyauCXcRyQlLYjc5xOcljfo/d34tlLMuMbp
        ua3QqZ8oAB8686aeb1PWZ8I=
X-Google-Smtp-Source: ABdhPJyqkLsGntJbEmVYvjc0Azvxsk4+lXu7Gg6qwfhty1Wb26dnAA3ZzZTKx/EcGJBh9L6I5COb9w==
X-Received: by 2002:a17:90b:1b47:: with SMTP id nv7mr9010403pjb.128.1598508558805;
        Wed, 26 Aug 2020 23:09:18 -0700 (PDT)
Received: from builder-PowerEdge-R730xd.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id u123sm1219581pfb.209.2020.08.26.23.09.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 23:09:18 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, dan.carpenter@oracle.com,
        Markus.Elfring@web.de
Cc:     linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH v4] workqueue: Warn when work flush own workqueue
Date:   Thu, 27 Aug 2020 14:09:11 +0800
Message-Id: <4c1287b0881e780368623314348f704bd43e9bd2.1598507105.git.zhaoqianli@xiaomi.com>
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
---
Changes in V4:
- Fix an error that when different work item used same workqueue in flush_work, patch will trigger WARNING incorrectly, reported-by "kernel test robot <lkp@intel.com>"

Changes in V3:
- update changelog
- update comment

Changes in V2:
- update changelog
- update comment

 kernel/workqueue.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c41c3c1..6a8a4e0 100644
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
@@ -2594,13 +2595,17 @@ static void check_flush_dependency(struct workqueue_struct *target_wq,
 				   struct work_struct *target_work)
 {
 	work_func_t target_func = target_work ? target_work->func : NULL;
-	struct worker *worker;
+	struct worker *worker = current_wq_worker();
+
+	WARN_ONCE(worker && worker->current_pwq->wq == target_wq &&
+		  worker->task == current &&
+		  (target_work ? worker->current_work == target_work : true),
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

