Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF19C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9AE21734
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkfgRwnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAVSkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:40:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46085 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVSkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:40:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so134931wrl.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 10:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uODYef6V5UQuTuRXVEyhhndNaJhy4VEZKyLovoUQA5I=;
        b=YkfgRwnFUtPcEYb4Hq14+OPacMGFeE1gaEgkVrHQ6lXqK+Ha8la/J9S1ey7Re6N13M
         L6985+Y2kRJC4LJvEeBJyocbjeqVxN+H4K1p84E7XIOYHxu6t3eK+HHoRiwC05MU+JgB
         dezUXNsD3ngerN4GP1CTE8yIizPYLd0vqju2QZufT6tnLcw3frm8rVq6SwK154jv7of0
         TVgu8/vuT6PqE2KuRYO6ycvTdHxK503ZwBdhkzW0M4U+yiIdjfVS+lCxzfuPUg+nV9Jq
         FODQhMHaZLlQ8c6TvJhnud2artrFQePP2CFHnhd55oARVZ8RrP2OhCpnJQn8U5OJW3cF
         fytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uODYef6V5UQuTuRXVEyhhndNaJhy4VEZKyLovoUQA5I=;
        b=T+846Oat4PULuVN1aj+DRMqRJydCg+se7iL6XHB5Siin4IGgbxluZa5F8mc/yhk2in
         WplfAgrvKuhKO+rcXOCOIbeRksqr8A02pMsb9Si6p18x//CzmL6gQIxDRMm0EUNm9Vir
         NRyoCedSoIs3QClE0E7w7FveoxDvmfiDYMXS2xdwfmJ2NKXq7ir4xKdWKifdaaH+ygbK
         1bLnuisCoM4jix7YCXBZAvvY6yhUVk/qdm1s1Y3a8AQ3JUZQRxSdGdcDQc6mJsfmsQV0
         tBwg/vHpv2nNxuilrQNNpE+6ySOfRGtg35XmfoHPF4CZ7PjTp2YhENQsdz1yDN/jsxNK
         G5KA==
X-Gm-Message-State: APjAAAUQm0TinCP2bvzEzn7iIysYaOOw8LhKadS6GPgzkbk787N0QMJb
        Gn3GVgjdsDGiRnXLh8+5wUl9v1f0XTlUug==
X-Google-Smtp-Source: APXvYqy+NoLvxAGFEnuS1+2R4WwB1OaS47Cg3KPOzWmELoeZsdZOyY1y8oQilH7sbYmW5EF+Nv0vMA==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr12485767wrj.349.1579718418450;
        Wed, 22 Jan 2020 10:40:18 -0800 (PST)
Received: from andrea.corp.microsoft.com (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id m21sm5181367wmi.27.2020.01.22.10.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 10:40:17 -0800 (PST)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v2] workqueue: Document (some) memory-ordering properties of {queue,schedule}_work()
Date:   Wed, 22 Jan 2020 19:39:52 +0100
Message-Id: <20200122183952.30083-1-parri.andrea@gmail.com>
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
Changes since v1 [1]:
  - fix typo (Randy Dunlap)
  - add Acked-by: tag (Paul E. McKenney)

[1] https://lkml.kernel.org/r/20200118215820.7646-1-parri.andrea@gmail.com

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

