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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C9BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 03:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C495207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 03:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBtizuJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgHYDGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 23:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgHYDGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 23:06:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 20:06:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o5so5798505pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 20:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zo+pPFHoHkxCyL6a3EGynd+Cu4nkkxbIIog9PhSmGyI=;
        b=DBtizuJD0INQLu7O/ykdLAWQtfDzGUhvHKw9Iiu2EnNAbViRVDfTSp3tE5lDAWmJKr
         FJ8fkgM3gk8jRyuKBgHTnqkO1EVxZBUoVKzTOm1S7sFeUgDWUYE3f5br5Yz/NpwYr292
         3DOhUb8+hPQJ03CkyjcviHOyEL53OtWLHU5/J3t3phdWsVKw0v+deen+6PsNxU29c6GU
         gxUpMVMAPZEoB2G0XV2CGpKj6nWpA3QDdgoqTr4IKIm5IUjpZsOs/grtSoYoMMCo95mP
         gcHWOo/oXLA0QdZGzs+s0O918Rcw1KQIvGBpQvRKxwu71mLJDI8Z1oL/7A4AL/qdb0Lx
         mv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zo+pPFHoHkxCyL6a3EGynd+Cu4nkkxbIIog9PhSmGyI=;
        b=XhDW7vZaGI7YYkR0XxDgI9dwZjPzwd+UngPz77amCExR/YI+lOdd+BnRSG5sPzF1Yw
         Jct9p5i/UsEC2Kx8SxJr7l9PT+veIMmArwQv0RT3SlZZOCqjkhJezOAgKc+qOh8WXM2j
         XAophSZ3QUoNhR81aNyUmggQLbKu6cwcV1otDVxSaw8rT05EH2+tTdfMwRPeW6SoPM4R
         I2gx0z4K/r8R5NQ/FTNpD+m0O/uwo0iLJLYiBrXAuhLkhokpvuQlr2TZG3Wy77PL/tgJ
         YuJjW6ccPuTqsF+vTf/1Q1zB7oCOkWS86Lz8GdsQUtz8M3Ab0QXxzNX+t7xMw+yVzlJO
         3KBA==
X-Gm-Message-State: AOAM531nxenO97pi3pwRbh2I8TJGYPzg+0+qXnuDoqAD47IHLZrbobg3
        S/Ac6vxujUWj9oCRzp7mhCw=
X-Google-Smtp-Source: ABdhPJzbj7EPczfCdJfWxzTlsdpF5Eoa50zYraJojeAAE2dKm3Rbr4YR5oh7nLYBEb0LskJbnAQ3kw==
X-Received: by 2002:a62:86ca:: with SMTP id x193mr1652702pfd.114.1598324809078;
        Mon, 24 Aug 2020 20:06:49 -0700 (PDT)
Received: from builder-PowerEdge-R730xd.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id e2sm13049691pfm.37.2020.08.24.20.06.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 20:06:48 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, Markus.Elfring@web.de
Cc:     linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH v2] workqueue: Warn when work flush own workqueue
Date:   Tue, 25 Aug 2020 11:06:42 +0800
Message-Id: <74f570e0aab48b86f7a157d87c16715289d457f4.1598323824.git.zhaoqianli@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qianli Zhao <zhaoqianli@xiaomi.com>

Flushing own workqueue or work self in work context will lead to
a deadlock.
Catch this incorrect usage and issue a warning when issue happened

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
Changes in V2:
- update changelog
- update comment
---
 kernel/workqueue.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3f5d4bf..9798d77 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2585,6 +2585,7 @@ static int rescuer_thread(void *__rescuer)
  * @target_work: work item being flushed (NULL for workqueue flushes)
  *
  * %current is trying to flush the whole @target_wq or @target_work on it.
+ * If a work flushing own workqueue or itself will lead to a deadlock.
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

