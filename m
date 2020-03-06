Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0DAC3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66772073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Yq09FMJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCFBQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:16:37 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38344 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgCFBQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:16:36 -0500
Received: by mail-qv1-f68.google.com with SMTP id g16so242115qvz.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 17:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KyceYHjNR0+tJKq4afNPN4A8qP/UwCCjKjkz+4QibW8=;
        b=Yq09FMJudZsU2wl6tqLW7YPTPzlmCsgcQ94F6rTlSV7AhzAtvJVN6INygjUpWMKIl3
         LQ4+5lcIZ3/sTYhcxdEKllPSDsc60CbvBpBfBKXdSz2NmPPSz711vuD88stHvNdEprOf
         Vb92Mjr9QSB44uvWZwgNoTfcj6txSpRbj+K14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KyceYHjNR0+tJKq4afNPN4A8qP/UwCCjKjkz+4QibW8=;
        b=UgZvRQfsWcZJVf9BS3J6oWzWRLJ8RnIrjvCByQ7CIJSL8bawadNtVkzaPFr+5AV5AS
         Z5FzfTx0bRq3ZcAjIH20OV6RYwBGvDtbfVFcKGR5DhV9hCqg3rtbKfnMr/OBcGaHlFHa
         ueTPG7q0l98wnIqJByAClLi1LdXzAPv+ZXICbTXe4y3TQARA974E863xD27iVj7EqkZL
         pZoBltj4ZxqmjXWnB9qf3WguoybPcR6gispyoqsY+nX8MkNgYIKaJ27CsWZyFWHLlpWb
         gRjnZvWi0PC0ZvKkuMMAwK/5jKdZZmOFAIo/Z8Q6cxgpCUyx+dEtVr/CBSZMzyHonnB+
         qLIA==
X-Gm-Message-State: ANhLgQ0y4Kt0BbTxhmi3tTpo62KTjZgux9fHd2IdjvluDizhYaZ30vLj
        1qoFS5OiZm6PfDkLF/8nWI7yyTCIBXk=
X-Google-Smtp-Source: ADFU+vse+j4JxbZ36ptTWD7X3OZUzYLKNeaixExTTbPIU4RLB99Y3mYHCXb8aN6oekb8zoBfxvl1qQ==
X-Received: by 2002:a0c:d603:: with SMTP id c3mr952502qvj.45.1583457395488;
        Thu, 05 Mar 2020 17:16:35 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 65sm16934009qtf.95.2020.03.05.17.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 17:16:35 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH rcu-dev 2/2] rcu/tree: Add a shrinker to prevent OOM due to kfree_rcu() batching
Date:   Thu,  5 Mar 2020 20:16:26 -0500
Message-Id: <20200306011626.97616-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200306011626.97616-1-joel@joelfernandes.org>
References: <20200306011626.97616-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce grace periods and improve kfree() performance, we have done
batching recently dramatically bringing down the number of grace periods
while giving us the ability to use kfree_bulk() for efficient kfree'ing.

However, this has increased the likelihood of OOM condition under heavy
kfree_rcu() flood on small memory systems. This patch introduces a
shrinker which starts grace periods right away if the system is under
memory pressure due to existence of objects that have still not started
a grace period.

With this patch, I do not observe an OOM anymore on a system with 512MB
RAM and 8 CPUs, with the following rcuperf options:

rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000
rcuperf.kfree_rcu_test=1 rcuperf.kfree_mult=2

Otherwise it easily OOMs with the above parameters.

NOTE:
1. On systems with no memory pressure, the patch has no effect as intended.
2. In the future, we can use this same mechanism to prevent grace periods
   from happening even more, by relying on shrinkers carefully.

Cc: urezki@gmail.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d3f52c30efb0c..2e0f66f04360e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2823,6 +2823,8 @@ struct kfree_rcu_cpu {
 	struct delayed_work monitor_work;
 	bool monitor_todo;
 	bool initialized;
+	// Number of objects for which GP not started
+	int count;
 };
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
@@ -2936,6 +2938,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 				krcp->head = NULL;
 			}
 
+			krcp->count = 0;
+
 			/*
 			 * One work is per one batch, so there are two "free channels",
 			 * "bhead_free" and "head_free" the batch can handle. It can be
@@ -3072,6 +3076,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		krcp->head = head;
 	}
 
+	krcp->count++;
+
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 	    !krcp->monitor_todo) {
@@ -3086,6 +3092,58 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
+static unsigned long
+kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu;
+	unsigned long flags, count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_online_cpu(cpu) {
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		spin_lock_irqsave(&krcp->lock, flags);
+		count += krcp->count;
+		spin_unlock_irqrestore(&krcp->lock, flags);
+	}
+
+	return count;
+}
+
+static unsigned long
+kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu, freed = 0;
+	unsigned long flags;
+
+	for_each_online_cpu(cpu) {
+		int count;
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		count = krcp->count;
+		spin_lock_irqsave(&krcp->lock, flags);
+		if (krcp->monitor_todo)
+			kfree_rcu_drain_unlock(krcp, flags);
+		else
+			spin_unlock_irqrestore(&krcp->lock, flags);
+
+		sc->nr_to_scan -= count;
+		freed += count;
+
+		if (sc->nr_to_scan <= 0)
+			break;
+	}
+
+	return freed;
+}
+
+static struct shrinker kfree_rcu_shrinker = {
+	.count_objects = kfree_rcu_shrink_count,
+	.scan_objects = kfree_rcu_shrink_scan,
+	.batch = 0,
+	.seeks = DEFAULT_SEEKS,
+};
+
 void __init kfree_rcu_scheduler_running(void)
 {
 	int cpu;
@@ -4007,6 +4065,8 @@ static void __init kfree_rcu_batch_init(void)
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		krcp->initialized = true;
 	}
+	if (register_shrinker(&kfree_rcu_shrinker))
+		pr_err("Failed to register kfree_rcu() shrinker!\n");
 }
 
 void __init rcu_init(void)
-- 
2.25.0.265.gbab2e86ba0-goog

