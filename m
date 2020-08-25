Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E6BC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C662204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PqkZ7o3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgHYCtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgHYCsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:48:53 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2223C0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:48:52 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d139so4697787qke.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0080KZgusFAuq7G8ZJQI5GUSGutjLoBrn+hD/TwbzQ=;
        b=PqkZ7o3MHwAjjeTTptmK86Xd2Q14MbEIoxrhAmW5T7VSL7ZuKA2xpoyfAVJ1SPFaWc
         b2IhxEyCktC3iTbOO2xrf5YtOhUSnQmJtVWkhBSNr8eLS92VQ+BVu+qxOevNFkYwBZPK
         r5h9JhNmzpGu9UJMS9hO51ya3Fq+NEJQSDEy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0080KZgusFAuq7G8ZJQI5GUSGutjLoBrn+hD/TwbzQ=;
        b=QHrYEHWECKYfOQ/fXAHrSyGvFUVpPMxScoP8nH07Suo4jvM1rA7ICgf7cTxSAkmQlg
         D8CtxNPEogOySI8rKdPhKVU6OIp1awT0ZqsEA/Z70KHESv833w6K4uARYIy5KYmcaqAp
         csxfykeTFpJt8E5u8OcUx2KktA8s2i4H4AfRB0Idu/HPmW0aneQ/zkz0gOfzrXZ0Pwil
         KqXATyANY7+fTYQUMctwSnNkGPTHqn/6M6SzhSUNXUwV1cGUjElyEjYH1tgEGvQfxe5V
         +5gt+xeiXokHHyAXSwSic7Dd3q4zQoI2XFGSNhyiCGeVAMm7bPOSWRUudXBmKJJEdbQs
         xbNw==
X-Gm-Message-State: AOAM533KOn4pXNCPqflV+4uajO7NF5PYhrXCxmZu9X4CGRDbOrv3O1Fg
        ND+lg0WpZIqkImFLEErBWAhAA9bGuUPGbA==
X-Google-Smtp-Source: ABdhPJyomXaaCQ0lDWf8KzkN1e6Yp67V22lZ37ypf3J/F4C4YJBIVbpXIAzS4wsvTFNRnQ6r2IzK9Q==
X-Received: by 2002:a05:620a:102c:: with SMTP id a12mr7480019qkk.47.1598323731542;
        Mon, 24 Aug 2020 19:48:51 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n14sm2159188qtk.50.2020.08.24.19.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:48:51 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        boqun.feng@gmail.com, dave@stgolabs.net,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, vineethrp@gmail.com
Subject: [PATCH v4 -rcu 2/4] rcu/tree: Make rcu_do_batch count how many callbacks were executed
Date:   Mon, 24 Aug 2020 22:48:40 -0400
Message-Id: <20200825024842.3408659-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200825024842.3408659-1-joel@joelfernandes.org>
References: <20200825024842.3408659-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, rcu_do_batch() depends on the unsegmented callback list's len field
to know how many CBs are executed. This fields counts down from 0 as CBs are
dequeued.  It is possible that all CBs could not be run because of reaching
limits in which case the remaining unexecuted callbacks are requeued in the
CPU's segcblist.

The number of callbacks that were not requeued are then the negative count (how
many CBs were run) stored in the rcl->len which has been counting down on every
dequeue. This negative count is then added to the per-cpu segmented callback
list's to correct its count.

Such a design works against future efforts to track the length of each segment
of the segmented callback list. The reason is because
rcu_segcblist_extract_done_cbs() will have to store the length of the callback
list in rcl->len to make rcu_segcblist_merge() work.

Also, the design of counting down from 0 is confusing and error-prone IMHO.

This commit therefore explicitly counts have many callbacks were executed in
rcu_do_batch() itself, and uses that to update the per-CPU segcb list's len
field, without relying on the negativity of rcl->len.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.c | 2 +-
 kernel/rcu/rcu_segcblist.h | 1 +
 kernel/rcu/tree.c          | 9 ++++-----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index b70d4154433c..076337ae2e50 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -95,7 +95,7 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
  * This increase is fully ordered with respect to the callers accesses
  * both before and after.
  */
-static void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
+void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
 	smp_mb__before_atomic(); /* Up to the caller! */
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 5c293afc07b8..b90725f81d77 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -76,6 +76,7 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
 }
 
 void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
+void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v);
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
 void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 548404489c04..51348144a4ea 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2419,7 +2419,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			       rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
-	long bl, count;
+	long bl, count = 0;
 	long pending, tlimit = 0;
 
 	/* If no callbacks are ready, just return. */
@@ -2464,6 +2464,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
+		count++;
 		debug_rcu_head_unqueue(rhp);
 
 		rcu_lock_acquire(&rcu_callback_map);
@@ -2477,9 +2478,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 		/*
 		 * Stop only if limit reached and CPU has something to do.
-		 * Note: The rcl structure counts down from zero.
 		 */
-		if (-rcl.len >= bl && !offloaded &&
+		if (count >= bl && !offloaded &&
 		    (need_resched() ||
 		     (!is_idle_task(current) && !rcu_is_callbacks_kthread())))
 			break;
@@ -2502,7 +2502,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	local_irq_save(flags);
 	rcu_nocb_lock(rdp);
-	count = -rcl.len;
 	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
 			    is_idle_task(current), rcu_is_callbacks_kthread());
@@ -2510,7 +2509,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
 	smp_mb(); /* List handling before counting for rcu_barrier(). */
-	rcu_segcblist_insert_count(&rdp->cblist, &rcl);
+	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
 	count = rcu_segcblist_n_cbs(&rdp->cblist);
-- 
2.28.0.297.g1956fa8f8d-goog

