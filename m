Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0466DC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E5120739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="FzW0eLkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCTUYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:24:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45681 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTUYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:24:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so4374584wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 13:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=euYkKIzSn3Hde8M82x4MmzJpd9Ci08IFXigeVjLBfXI=;
        b=FzW0eLkXrnkafLzxHp1TVU9mlmHIR3g8W8SjwOlW4nHO0fpciko/JWioTp3R6n0Dz3
         VR+AJytLDbE/a7ALWCRUUcyK19SEcnNmhxxCxvuJtCKx5+5pBJ/YXnUZgRXkL0bb8DIA
         5YL/lkfhzvPnj6CO2ryJoUVU08yiQsU703NOqw9gB80RvkKluI8JUS10vJ0bzWOGfbOS
         m+EzWbjq8qX5LPai1eKGmosWV/ur2BAppFnBkNet6PRAIM3j/qc2YBOMQKhsh/1uFi/A
         akaNVhR05w/65IIimuuo20vWnjZqbUl4ItvFHjXmerB6hvDTcA0IwxqrolE8JmcKBALV
         3ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=euYkKIzSn3Hde8M82x4MmzJpd9Ci08IFXigeVjLBfXI=;
        b=ik5Aro0tgv1oXX+6hViiYMOaxpETRTASS703kQXLUo6JKW8BRZjbFXYglxX5O3UdRl
         VGr9+l03OGK5xEqQECbNN2Rwp4fk6enSAb0WPULZro8ZSGGpDxjFiqiypyKfFohs8uE7
         1jfWbveqJerOL4vjff70o2pk1kbpOLQc2jSCazZQPRujPB6w2Q70/kgEcggzOI76tiwH
         C9lHxl5FLfhhz+JgqlTfwEpURmCKJRcDJO8V2iqVVRRIf7U/HdXpvqcnPNImJvCCCXhk
         9aHQpEg+LZKMTohtwM0bWQxjAiFKKFtXm1bIC8442Qkrzx2O9ykRAq1aTBP9vnjOsBRs
         Ee8A==
X-Gm-Message-State: ANhLgQ0dzcS8FuSwLBkNmekY1ne1BfbqlhmuQHkeZAzgfnPSoqgKgv+/
        o1LoEbpDQr+TYsk2f+nNpzsL5w==
X-Google-Smtp-Source: ADFU+vtz4Qn5Yirjf7ZtBzNVBIt8n4Nj7r6Fj5G6SDeStBUf+kgiAfTl6t/orql7fAZ5Rs2zNl/jcQ==
X-Received: by 2002:adf:f3c8:: with SMTP id g8mr11357354wrp.351.1584735854835;
        Fri, 20 Mar 2020 13:24:14 -0700 (PDT)
Received: from nb01257.fkb.profitbricks.net ([2001:16b8:48c3:f900:5028:8a37:4a0d:15bd])
        by smtp.gmail.com with ESMTPSA id q4sm9437267wro.56.2020.03.20.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:24:14 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] wait: remove wait_event_interruptible_lock_irq_cmd
Date:   Fri, 20 Mar 2020 21:23:55 +0100
Message-Id: <20200320202355.27157-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove this function since it is not used.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 include/linux/wait.h | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3283c8d02137..e7fee8d1ac60 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1003,40 +1003,6 @@ do {										\
 		      schedule();						\
 		      spin_lock_irq(&lock))
 
-/**
- * wait_event_interruptible_lock_irq_cmd - sleep until a condition gets true.
- *		The condition is checked under the lock. This is expected to
- *		be called with the lock taken.
- * @wq_head: the waitqueue to wait on
- * @condition: a C expression for the event to wait for
- * @lock: a locked spinlock_t, which will be released before cmd and
- *	  schedule() and reacquired afterwards.
- * @cmd: a command which is invoked outside the critical section before
- *	 sleep
- *
- * The process is put to sleep (TASK_INTERRUPTIBLE) until the
- * @condition evaluates to true or a signal is received. The @condition is
- * checked each time the waitqueue @wq_head is woken up.
- *
- * wake_up() has to be called after changing any variable that could
- * change the result of the wait condition.
- *
- * This is supposed to be called while holding the lock. The lock is
- * dropped before invoking the cmd and going to sleep and is reacquired
- * afterwards.
- *
- * The macro will return -ERESTARTSYS if it was interrupted by a signal
- * and 0 if @condition evaluated to true.
- */
-#define wait_event_interruptible_lock_irq_cmd(wq_head, condition, lock, cmd)	\
-({										\
-	int __ret = 0;								\
-	if (!(condition))							\
-		__ret = __wait_event_interruptible_lock_irq(wq_head,		\
-						condition, lock, cmd);		\
-	__ret;									\
-})
-
 /**
  * wait_event_interruptible_lock_irq - sleep until a condition gets true.
  *		The condition is checked under the lock. This is expected
-- 
2.17.1

