Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AC3C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 06:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0996E208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 06:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="ld67Urrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgIEGEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 02:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgIEGEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 02:04:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260A3C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 23:04:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so5387314pgm.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 23:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+N5fopK2fadGjRXyoImn8Tt1p4TzHbOsZlKc73Tq7SQ=;
        b=ld67UrrjZcLMg3MDR9GurkEbZDHAbxiOuFIi8QEKjwUmeoFFmf76XFQHbPK/xQHoBJ
         5qfzQq8YdJA3RavOltq+AcGDAJfJ4sJl739sDaAh+TyUZvZihPJPbB5tfjqN+CDMyegT
         n4hHTVaCnOyuUaPxCOLWy4ymjAjexH7pwSlmm7Vc+OlJGGr6q+jr+HxlnKT4IpwWFP/2
         Nm1TdcPuvjmPOoFXKcikIZp5rgNcSH9M3rjp6AYnN73dbmEaTHkvBnQVvXkp8zi36ch2
         cLAuSXZxpWqdxzvtPd35R4JXWe3JK9khiEqmtZaa0QpDqowBk2ZMSBB97s4zUO/waa/H
         r3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+N5fopK2fadGjRXyoImn8Tt1p4TzHbOsZlKc73Tq7SQ=;
        b=l18zpCVjB0vxsPsEHWtZkO5H00XiwF7EsuiLWajfm5ztxXzmO9G25t+4LuDWoFicjJ
         KLq+jLNYM/c7ernV+tUGvBXgD6DEWNtQbwsUaOH3+BT9zsvcgQZABXE+CaYXwzh2DRZM
         xualCPEHhFvD3BlXNoDPuCNA4odgRZYvS6KlkDZTkVMXPb5PhqUMX7NndMHYYTVljAZO
         aOjHTiumC+T+Id8ofObB+ZMk7U7DZ8pIdENxIo1rGN1OMXSsjRBfbjkpwIJLmnahDeH1
         1ocJDnGjanItVgvZdKtrfpcYA3ygQoSGkXJtfKIuzetY05zz9G14dpvPyOKSN/5AA76E
         W24g==
X-Gm-Message-State: AOAM531XSKZD4fdJYfahlgVKM9U+J/JXqA7s0w2EnehU3c8Oq44w5Rup
        XYgQhwOd5EDMH3SNYH3OhQTSXg==
X-Google-Smtp-Source: ABdhPJw+8Kxoak1cDEggyclA0c7eAfZuR8igs4Z76HOl2PcFFW8FbWLu0LVt81gMNvYh4wgsEow+wA==
X-Received: by 2002:a63:1323:: with SMTP id i35mr9483599pgl.41.1599285871728;
        Fri, 04 Sep 2020 23:04:31 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.68])
        by smtp.gmail.com with ESMTPSA id 190sm8781306pfy.22.2020.09.04.23.04.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 23:04:31 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     rostedt@goodmis.org, mingo@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, will@kernel.org, romain.perier@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] tasklet: Introduce tasklet tracepoints
Date:   Sat,  5 Sep 2020 14:04:12 +0800
Message-Id: <20200905060412.88560-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce tracepoints for tasklets just like softirq does. In this case,
we can calculate tasklet latency and know what tasklet run.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/trace/events/irq.h | 44 ++++++++++++++++++++++++++++++++++++++
 kernel/softirq.c           |  2 ++
 2 files changed, 46 insertions(+)

diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
index eeceafaaea4c..69a16f3a21c2 100644
--- a/include/trace/events/irq.h
+++ b/include/trace/events/irq.h
@@ -160,6 +160,50 @@ DEFINE_EVENT(softirq, softirq_raise,
 	TP_ARGS(vec_nr)
 );
 
+DECLARE_EVENT_CLASS(tasklet,
+
+	TP_PROTO(struct tasklet_struct *t),
+
+	TP_ARGS(t),
+
+	TP_STRUCT__entry(
+		__field(	void *,	callback	)
+	),
+
+	TP_fast_assign(
+		__entry->callback = t->callback;
+	),
+
+	TP_printk("callback=%ps", __entry->callback)
+);
+
+/**
+ * tasklet_entry - called immediately before the tasklet handler
+ * @t: pointer to struct tasklet_struct
+ *
+ * When used in combination with the tasklet_exit tracepoint
+ * we can determine the tasklet handler routine.
+ */
+DEFINE_EVENT(tasklet, tasklet_entry,
+
+	TP_PROTO(struct tasklet_struct *t),
+
+	TP_ARGS(t)
+);
+
+/**
+ * tasklet_exit - called immediately after the tasklet handler returns
+ * @t: pointer to struct tasklet_struct
+ *
+ * When used in combination with the tasklet_entry tracepoint
+ * we can determine the tasklet handler routine.
+ */
+DEFINE_EVENT(tasklet, tasklet_exit,
+
+	TP_PROTO(struct tasklet_struct *t),
+
+	TP_ARGS(t)
+);
 #endif /*  _TRACE_IRQ_H */
 
 /* This part must be outside protection */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index bf88d7f62433..0f9f5b2cc3d3 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -553,10 +553,12 @@ static void tasklet_action_common(struct softirq_action *a,
 				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
 							&t->state))
 					BUG();
+				trace_tasklet_entry(t);
 				if (t->use_callback)
 					t->callback(t);
 				else
 					t->func(t->data);
+				trace_tasklet_exit(t);
 				tasklet_unlock(t);
 				continue;
 			}
-- 
2.20.1

