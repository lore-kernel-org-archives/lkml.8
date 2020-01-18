Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B348EC32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860A92469D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Payn8D+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgARV6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 16:58:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41373 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgARV6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:58:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so25915788wrw.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 13:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaeYX/Ff/wQaMg6DYHILaGZDP7ER1icKxMDfq0TG0SI=;
        b=Payn8D+YqNMfkeO9DcSIuSyDncQC1hM2updNTA6l0CYGWvp9Dr5WjIH/mhBQFtU9iC
         ZJOw3RNITzEv8F2+lGVYKnsBCL1akhilV0x3qIIzfXY1L9VkamZkevNL5lrHs72PP7Yx
         firrtV8bCmQSmW81/BLHtMoBRqfMn+eC6i0qlfpiaOdUMeqS7Wkjfbpcu2v2wo4qSHyv
         1kKOILEslyGbaQtic/myMt8moK0+GQEplz/SvwjxG8QvjM5ZZs0vh6Ju3OfN65jY5Kbm
         EEBnbwVdmNqKNlcK7k534qqNa8eeUIRMJKiAQeJh+SFo/HYw0O3WdaCP4/d1mP3dX2Wx
         bMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaeYX/Ff/wQaMg6DYHILaGZDP7ER1icKxMDfq0TG0SI=;
        b=qx00GUdLTc2ihwOStycXKOpRgFYOh40hMwDxmjDxFg+0bS6oUHoQPzen5r+vl5tP5x
         yFL3r929SlQuO1OOVoBIEdTNKJwNbvd6WAnzsZeF6FDaFWfSSOHp2EDut4AezL8mauV2
         b3YWxD84JTEFTrGDVM7FyilhCvMOWYcSO6m4wtAhFqzdcVyikKonlj1qWkVs3wNycr9Z
         yZGFxB4KE+DrnBOlJmv3rMOMyEzBE9orS6p04ant4eENzGHKxc1vIiwXUmE5aB6U7TsS
         ruZvnqsEvxB8jqZoouvNXAR+200MlYKCM75Dm6bbKehHCQXLGtYsPyEH79JU3/S3Rwv7
         fVdg==
X-Gm-Message-State: APjAAAV894AeCs2FKCgi+gS7vEkjO2HcXh+zN+KpbKy23/aQv9SgbaRu
        we3Zily8J1eHSahqaEd8826ScJ35kNwP9Q==
X-Google-Smtp-Source: APXvYqzYQJ4sX823Ax3W4uleInvrwTF9nfvn7+Zy4bKN5H1yMR44iRaLer6iCruNAywTII38vzNanA==
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr9800867wrm.278.1579384717335;
        Sat, 18 Jan 2020 13:58:37 -0800 (PST)
Received: from localhost.localdomain (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id z8sm39789567wrq.22.2020.01.18.13.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 13:58:36 -0800 (PST)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH] workqueue: Document (some) memory-ordering properties of {queue,schedule}_work()
Date:   Sat, 18 Jan 2020 22:58:20 +0100
Message-Id: <20200118215820.7646-1-parri.andrea@gmail.com>
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
---
 include/linux/workqueue.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 4261d1c6e87b1..4fef6c38b0536 100644
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
+ * Shares the same memory-ordering properties of queue_work(), c.f., the
+ * DocBook header of queue_work().
  */
 static inline bool schedule_work(struct work_struct *work)
 {
-- 
2.24.0

