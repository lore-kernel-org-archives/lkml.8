Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2EFC5ACBF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AC6206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="spKZul4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbgCPQcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:32:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40959 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732157AbgCPQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:32:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id n5so14738732qtv.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MS9t2iNEb4PB+lJw794GmMD2vsMG+E5GyTEPZil/bNo=;
        b=spKZul4E9ghWYJLYXGAXmc5aUIfKjBxesU7eG6/OrD8I3Ea6yP+POQQizAT5DR9TmS
         vN3QpCb2r0BbXbLTeuU7i+04biHMIE5d+GDzGkAJYffAS2qO60Dye0fGnLtBLYDI1+3v
         5PpmYKt4nUAQ/xvC5wSDEbmL+Z4IZ5aZ8oYy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MS9t2iNEb4PB+lJw794GmMD2vsMG+E5GyTEPZil/bNo=;
        b=MwWyF+dqZtCgGWltICUGU6hwZzN4mPyNraztbNZOtKg5dC1sMaLgfJkJ1nzptprN0e
         NCwWnpZDgBaEJ8l8v3RBNBRgcvkRUKWmlWBldl734GWu16U6QNAMYl8LjWAiS6wVAFzK
         J+IZ2EiQHrAXCnJady77640iqSnw/vK/jpbeXzP1oJcQJnerdwBu7PVBzW0BAPWTQ6Kt
         LzPV9BwTZYugfLjF4ZBMSuCUyQJwJR1wzTaLErYYSwClF4wPOs/W5bryR+31rO7xWWJ/
         v1RbDsFzVKJiCrmrIxq32adXxEOvVuqnwpWbnJaX3uPc57ewt4kduoqJ3w46RkZWWW4Q
         ySbA==
X-Gm-Message-State: ANhLgQ3g5HHbVNYVBs8dQ4zzWJvSq/m64CCUb6VySYp7a+EHW523w+Wa
        D3gZJc99FxwJkG6BvuLCdPVj01fi/RM=
X-Google-Smtp-Source: ADFU+vt7bNr8SiK9bno7vp1EaeHQg9Cz/e4b46LVAFks6Bap41A9ThJRP3j8Gke2/RMbnATTb4gwtw==
X-Received: by 2002:ac8:7319:: with SMTP id x25mr906277qto.96.1584376355937;
        Mon, 16 Mar 2020 09:32:35 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y127sm84139qkb.76.2020.03.16.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 09:32:35 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, urezki@gmail.com
Subject: [PATCH v2 rcu-dev 3/3] rcu/tree: Count number of batched kfree_rcu() locklessly
Date:   Mon, 16 Mar 2020 12:32:28 -0400
Message-Id: <20200316163228.62068-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200316163228.62068-1-joel@joelfernandes.org>
References: <20200316163228.62068-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can relax the correctness of counting of number of queued objects in
favor of not hurting performance, by locklessly sampling per-cpu
counters. This should be Ok since under high memory pressure, it should not
matter if we are off by a few objects while counting. The shrinker will
still do the reclaim.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/rcu/tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index dc570dff68d7b..875e7162ddcce 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2916,7 +2916,7 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 				krcp->head = NULL;
 			}
 
-			krcp->count = 0;
+			WRITE_ONCE(krcp->count, 0);
 
 			/*
 			 * One work is per one batch, so there are two "free channels",
@@ -3054,7 +3054,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		krcp->head = head;
 	}
 
-	krcp->count++;
+	WRITE_ONCE(krcp->count, krcp->count + 1);
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
@@ -3080,9 +3080,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	for_each_online_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		spin_lock_irqsave(&krcp->lock, flags);
-		count += krcp->count;
-		spin_unlock_irqrestore(&krcp->lock, flags);
+		count += READ_ONCE(krcp->count);
 	}
 
 	return count;
-- 
2.25.1.481.gfbce0eb801-goog

