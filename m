Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EE7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F4C20757
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Xw1O5YFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgEDMFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728733AbgEDMFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:05:20 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B7AC061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 05:05:20 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g185so2655765qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AkV9Ms3hREYQxDI7vbI/vre83zHV+UkAnE8bMyGSE40=;
        b=Xw1O5YFAMOdNkTA0GRsuZN/EHqty3MLT15ZROyM4ee26FXm7poVBfNDJKGF8+6vHWK
         iV/+oczWlxYvSad7X7Mr1ieD1IuwZjsAknyhUW8MMOaG5ecGxUGDrq9/uPI2x0/jHM/K
         ED0UJwOcWTJ23fB2jd3sOb1pSC3Ml8k2YfE/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkV9Ms3hREYQxDI7vbI/vre83zHV+UkAnE8bMyGSE40=;
        b=KAw/yAS8e5Ov3tTS5BDkyi+gVHn9u+RPPkD5AvZ+FWYPfTjh3fGHSqS8jda77pSAo0
         SI68/kQBrZIifB8XsNrJ48x3q9GBMHQQjlehtI0NAUgy5apLiGQSBPj3ernnZWUmOpbV
         mSNwzvvthBN06TMhemu0u6cWFpIZdWjHDzzFYAyrWF/mgmNpseyXI6SclTCarlFyy9Un
         7V++/nWYl+wMcjyJHceL/AIviL154enJRbiU1grcGcOe2JTHOisdetAgYYoQH2M0QXGc
         VpjewMRzIBR3dQAfpKwsJNFxmzW2+fj9B5fcrOdeb5+A543GXz9zAQop94v9O4LfUsOh
         rHhA==
X-Gm-Message-State: AGi0PuZ2WnfUlW+R3nHuLFN3lrExgjoKeCgEMFhpSE69DLkCGSrM0VEy
        YRFXoPwOLGKVi/rYoBqDy63Kud4jumo=
X-Google-Smtp-Source: APiQypJYQMsgW1be3aeepNkiH8+m/0+inCleC9mF3XGU/Ou4Ft52TSrGTSg+934E6/sgZnJZaApt3g==
X-Received: by 2002:a37:804:: with SMTP id 4mr7969049qki.405.1588593918568;
        Mon, 04 May 2020 05:05:18 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y50sm6194534qta.56.2020.05.04.05.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:05:17 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
        Petr Mladek <pmladek@suse.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, tglx@linutronix.de, vpillai@digitalocean.com
Subject: [PATCH v3 2/5] rcu/tree: Add better tracing for dyntick-idle
Date:   Mon,  4 May 2020 08:05:02 -0400
Message-Id: <20200504120505.89351-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200504120505.89351-1-joel@joelfernandes.org>
References: <20200504120505.89351-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dyntick-idle traces are a bit confusing. This patch makes it simpler
and adds some missing cases such as EQS-enter due to user vs idle mode.

Following are the changes:
(1) Add a new context field to trace_rcu_dyntick tracepoint. This
    context field can be "USER", "IDLE" or "IRQ".

(2) Remove the "++=" and "--=" strings and replace them with
   "StillNonIdle". This is much easier on the eyes, and the -- and ++
   are easily apparent in the dynticks_nesting counters we are printing
   anyway.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 29 ++++++++++++++++-------------
 kernel/rcu/tree.c          | 20 +++++++++++++-------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index f9a7811148e2a..164c43b72ca29 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -435,26 +435,28 @@ TRACE_EVENT_RCU(rcu_fqs,
 #endif /* #if defined(CONFIG_TREE_RCU) */
 
 /*
- * Tracepoint for dyntick-idle entry/exit events.  These take a string
- * as argument: "Start" for entering dyntick-idle mode, "Startirq" for
- * entering it from irq/NMI, "End" for leaving it, "Endirq" for leaving it
- * to irq/NMI, "--=" for events moving towards idle, and "++=" for events
- * moving away from idle.
+ * Tracepoint for dyntick-idle entry/exit events.  These take 2 strings
+ * as argument:
+ * polarilty: "Start", "End", "StillIdle" for entering, exiting or still being
+ * in dyntick-idle mode.
+ * context: "USER" or "KERNEL" or "IRQ".
+ * NMIs nested in IRQs are inferred with dynticks_nesting > 1 in IRQ context.
  *
  * These events also take a pair of numbers, which indicate the nesting
  * depth before and after the event of interest, and a third number that is
- * the ->dynticks counter.  Note that task-related and interrupt-related
- * events use two separate counters, and that the "++=" and "--=" events
- * for irq/NMI will change the counter by two, otherwise by one.
+ * the ->dynticks counter. During NMI nesting within IRQs, the dynticks_nesting
+ * counter changes by two, otherwise one.
  */
 TRACE_EVENT_RCU(rcu_dyntick,
 
-	TP_PROTO(const char *polarity, long oldnesting, long newnesting, int dynticks),
+	TP_PROTO(const char *polarity, const char *context, long oldnesting,
+		 long newnesting, int dynticks),
 
-	TP_ARGS(polarity, oldnesting, newnesting, dynticks),
+	TP_ARGS(polarity, context, oldnesting, newnesting, dynticks),
 
 	TP_STRUCT__entry(
 		__field(const char *, polarity)
+		__field(const char *, context)
 		__field(long, oldnesting)
 		__field(long, newnesting)
 		__field(int, dynticks)
@@ -462,14 +464,15 @@ TRACE_EVENT_RCU(rcu_dyntick,
 
 	TP_fast_assign(
 		__entry->polarity = polarity;
+		__entry->context = context;
 		__entry->oldnesting = oldnesting;
 		__entry->newnesting = newnesting;
 		__entry->dynticks = dynticks;
 	),
 
-	TP_printk("%s %lx %lx %#3x", __entry->polarity,
-		  __entry->oldnesting, __entry->newnesting,
-		  __entry->dynticks & 0xfff)
+	TP_printk("%s %s %lx %lx %#3x", __entry->polarity,
+		__entry->context, __entry->oldnesting, __entry->newnesting,
+		__entry->dynticks & 0xfff)
 );
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1ec7b1d4a03c4..eb7a4d90b3b91 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -573,7 +573,8 @@ static void rcu_eqs_enter(bool user)
 	}
 
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("Start"), (user ? TPS("USER") : TPS("IDLE")),
+			  rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rdp = this_cpu_ptr(&rcu_data);
 	do_nocb_deferred_wakeup(rdp);
@@ -648,15 +649,17 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	 * leave it in non-RCU-idle state.
 	 */
 	if (rdp->dynticks_nmi_nesting != 1) {
-		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
-				  atomic_read(&rdp->dynticks));
+		trace_rcu_dyntick(TPS("StillNonIdle"), TPS("IRQ"),
+				  rdp->dynticks_nmi_nesting,
+				  rdp->dynticks_nmi_nesting - 2, atomic_read(&rdp->dynticks));
 		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
 			   rdp->dynticks_nmi_nesting - 2);
 		return;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("Start"), TPS("IRQ"), rdp->dynticks_nmi_nesting,
+			  0, atomic_read(&rdp->dynticks));
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
 	if (irq)
@@ -748,7 +751,8 @@ static void rcu_eqs_exit(bool user)
 	rcu_dynticks_eqs_exit();
 	// ... but is watching here.
 	rcu_cleanup_after_idle();
-	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("End"), (user ? TPS("USER") : TPS("IDLE")),
+			  rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
@@ -850,9 +854,11 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		}
 		raw_spin_unlock_rcu_node(rdp->mynode);
 	}
-	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
-			  rdp->dynticks_nmi_nesting,
+
+	trace_rcu_dyntick(incby == 1 ? TPS("End") : TPS("StillNonIdle"),
+			  TPS("IRQ"), rdp->dynticks_nmi_nesting,
 			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
+
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
 		   rdp->dynticks_nmi_nesting + incby);
 	barrier();
-- 
2.26.2.526.g744177e7f7-goog

