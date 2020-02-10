Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E13AC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028FC20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpSasX8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgBJVpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:45:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40645 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJVpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:45:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so965535wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 13:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EKAPXBv9g0SuZQIOWAJHUtATkRZbCU3wSnu3b/TqWkA=;
        b=MpSasX8fFn9n6tnK60+DnQm5uN9dRfUyDUuvElVUDvijG9Z9A2vG+ooi/7qOF8gFpa
         s+LyIPsfKaQADXwFs01C2c/1KX7zkl52VV0IK1lAcNYUQEOiFjVaGwzHJUkntW0nyElz
         eFqGqKIWovWExXMBFbmehK7VOQ2besNXPD9C5GHsm4Fs2L2H9HrL+AeVGAZJfyfF3G6t
         GNSQUtrNzd+pNyuIp60pJTOdRBtAw5avHNWpJBnCkajcKURVZqI+4L1oOmIm0Yuituo9
         J0aLeyCmP73cUVk6AViWywnIB/kcjMd8MvtISO8nsnEgABcfKII7LphNJjc7RLufnA+N
         hOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EKAPXBv9g0SuZQIOWAJHUtATkRZbCU3wSnu3b/TqWkA=;
        b=XUGOb1I9qzPOItFs30a1ashw+MhISJ3ToeM+Nrcb7H49I9XW9cUx8g5D50wKFWtqMI
         95ngEAPwLGGjnrKE2Bq7Npl6OyMVH9phuQs9/wzhEUc5qew4LQ6jd3UXZR6gw0JGPYQW
         KqPBJgP/DTIrDGoKSl1qDVdbFs979gZ0W5Gq/DaFJCOOZEhZhDZrRNlzkofZI7UY5dJ3
         96w0lIB/fJham9hl69GvrfnE8AKny9WEefoCOzuN827gMQnNHnBCKbEvq4tkuKVn34nC
         E1/V3S9OfJl/ay8HpvFiB4cGrYi5fBEVQ5tHBon32x2/dIgKIZbW1M7afo33VU0nmsm+
         ICIw==
X-Gm-Message-State: APjAAAXh7NvRQR8C2p2D/4lm1TDS1YzjWmdrLutFq3za+ZjnFRMfFHI0
        dvQJ7IVREr+QOO7icvOTTQ4ulv/YJYT1ZA==
X-Google-Smtp-Source: APXvYqySE0ClGSP8YJgp/fiVNVmDUVVtfUyTropNOxpwQDUP2r/qBohJjXKab/enm6C5rLwbYBNuAQ==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr994353wml.107.1581371108243;
        Mon, 10 Feb 2020 13:45:08 -0800 (PST)
Received: from localhost.localdomain (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id m3sm2225983wrs.53.2020.02.10.13.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 13:45:07 -0800 (PST)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [RESEND PATCH v2] workqueue: Document (some) memory-ordering properties of {queue,schedule}_work()
Date:   Mon, 10 Feb 2020 22:44:47 +0100
Message-Id: <20200210214447.14685-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's desirable to be able to rely on the following property:  All stores
preceding (in program order) a call to a successful queue_work() will be
visible from the CPU which will execute the queued work by the time such
work executes, e.g.,

  { x is initially 0 }

    CPU0                              CPU1

    WRITE_ONCE(x, 1);                 [ "work" is being executed ]
    r0 = queue_work(wq, work);          r1 = READ_ONCE(x);

  Forbids: r0 == true && r1 == 0

The current implementation of queue_work() provides such memory-ordering
property:

  - In __queue_work(), the ->lock spinlock is acquired.

  - On the other side, in worker_thread(), this same ->lock is held
    when dequeueing work.

So the locking ordering makes things work out.

Add this property to the DocBook headers of {queue,schedule}_work().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
Unchanged since v2:

  https://lkml.kernel.org/r/20200122183952.30083-1-parri.andrea@gmail.com

 include/linux/workqueue.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 4261d1c6e87b1..e48554e6526c0 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -487,6 +487,19 @@ extern void wq_worker_comm(char *buf, size_t size, struct task_struct *task);
  *
  * We queue the work to the CPU on which it was submitted, but if the CPU dies
  * it can be processed by another CPU.
+ *
+ * Memory-ordering properties:  If it returns %true, guarantees that all stores
+ * preceding the call to queue_work() in the program order will be visible from
+ * the CPU which will execute @work by the time such work executes, e.g.,
+ *
+ * { x is initially 0 }
+ *
+ *   CPU0				CPU1
+ *
+ *   WRITE_ONCE(x, 1);			[ @work is being executed ]
+ *   r0 = queue_work(wq, work);		  r1 = READ_ONCE(x);
+ *
+ * Forbids: r0 == true && r1 == 0
  */
 static inline bool queue_work(struct workqueue_struct *wq,
 			      struct work_struct *work)
@@ -546,6 +559,9 @@ static inline bool schedule_work_on(int cpu, struct work_struct *work)
  * This puts a job in the kernel-global workqueue if it was not already
  * queued and leaves it in the same position on the kernel-global
  * workqueue otherwise.
+ *
+ * Shares the same memory-ordering properties of queue_work(), cf. the
+ * DocBook header of queue_work().
  */
 static inline bool schedule_work(struct work_struct *work)
 {
-- 
2.24.0

