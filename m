Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB2CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166C3221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qm6S/7Ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgHGRIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgHGRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:07:50 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E87DC061A30
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 10:07:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 2so2329838qkf.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gicPVw0CqSD8CviuYDeBK7XWa+PKPPBQRJgIkcRqYe8=;
        b=qm6S/7Ualllrfwl4E6yQMbWN6fgGnMafA5K5NBJHki4cmb0uDO3WczO8vny81N9oWS
         9A+3eh/htpTKUbYFJPCE7ttB/y93pt4ToNaOgdrGJ6zzikB/A+NQe2cSel06AwszJXBS
         51zGUVQm2TGuSV1a0hNqOWGsM1eHoaNWk5Ot0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gicPVw0CqSD8CviuYDeBK7XWa+PKPPBQRJgIkcRqYe8=;
        b=F5iQELHLlVyKr2ZxBIJ1+yfnrIux5hDU9qPAB3jPywZY7cuk9EjJUOnAoJTFowlkWe
         z84dsOSoTrlEItevuFZ02JwKdDCmAFBGhz5UwfO+jCaQeNrdyLU7QVP1zvdD1SiwsUGJ
         FTwJXj96pv/WAzqsacszp6gfeE2W2RyVHyDN65lY6A6DhwXWEMyE4YE8+ZBL0sXZOhPm
         7VAnO/RFAmG32WmRVVv+8yYUHA+eQU/m9mGBY/Fd+DJZWe8IC0o+2uE7+/tlWVllN8ds
         1wUc4G4LiDCScgEmQCP7DXsjjqonlcHwMYP3dkeLJ3hetAMGgAwZN69EMammsUL5bvSL
         JUOg==
X-Gm-Message-State: AOAM5315ulgiWZ9uA/zSLkxBLOIgW5NmDN9vHo8Z0Z2UcLQSerBx4HYy
        jJGX2dbbXxFYC8FYeQ+Hq9tzFCqY/RE=
X-Google-Smtp-Source: ABdhPJw1TveHH3mLRkLNzH1vXnB8MHJ/p9aeD3oJKbCSQm6jAoJ7ClFaNEpUt9rAe1IYxH7vPVmZ+Q==
X-Received: by 2002:a05:620a:10ab:: with SMTP id h11mr14132645qkk.219.1596820051354;
        Fri, 07 Aug 2020 10:07:31 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id w18sm8559905qtk.1.2020.08.07.10.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 10:07:30 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        neeraju@codeaurora.org, "Paul E. McKenney" <paulmck@kernel.org>,
        peterz@infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, vineethrp@gmail.com
Subject: [PATCH v4 3/5] rcu/tree: Make FQS complaining about offline CPU more aggressive
Date:   Fri,  7 Aug 2020 13:07:20 -0400
Message-Id: <20200807170722.2897328-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
In-Reply-To: <20200807170722.2897328-1-joel@joelfernandes.org>
References: <20200807170722.2897328-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FQS loop detecting that an offline CPU has not yet reported a
quiescent state, is a serious problem. The current interaction between
RCU quiescent-state reporting and CPU-hotplug operations means that the
FQS loop should never find that an offline CPU (by RCU's understanding
of what is offline or not) has not yet reported a quiescent state.

First, the outgoing CPU explicitly reports a quiescent state if needed
in rcu_report_dead().  Second, the race where the CPU is leaving just as
RCU is initializing a new grace period is handled by an explicit check
for this condition in rcu_gp_init().  Third, the CPU's leaf rcu_node
structure's ->lock serializes these modifications and checks.

At the moment, the FQS loop detections this anomaly but only reports it
after a second has elapsed.

This commit therefore makes the warning more aggressive such that we fail
immediately when the FQS loop scan happens and bring the problem to
everyone's attention.

Light testing with TREE03 and hotplug shows no warnings. Converted the
warning as well to WARN_ON_ONCE() to reduce log spam.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2fb66cdbfa25..850628aba813 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1208,13 +1208,27 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		return 1;
 	}
 
-	/* If waiting too long on an offline CPU, complain. */
-	if (!(rdp->grpmask & rcu_rnp_online_cpus(rnp)) &&
-	    time_after(jiffies, rcu_state.gp_start + HZ)) {
+	/*
+	 * Complain if an offline CPU by RCU's hotplug bookkeeping has not
+	 * reported a quiescent state yet.
+	 *
+	 * Either a quiescent state for the offline CPU should have been
+	 * reported during CPU offlining, or during rcu_gp_init() if it
+	 * detected a race with either CPU offlining or task unblocking on a
+	 * node with all of its CPUs previously offlined. If neither of these
+	 * happened, we have a problem.
+	 *
+	 * The node lock is held here, ensuring exclusion from the
+	 * modification/checking of RCU's hotplug books by RCU's hotplug
+	 * notifier hooks and grace period initialization code.
+	 *
+	 * Refer to RCU's Requirements documentation about hotplug requirements
+	 * as well.
+	 */
+	if (WARN_ON_ONCE(!(rdp->grpmask & rcu_rnp_online_cpus(rnp)))) {
 		bool onl;
 		struct rcu_node *rnp1;
 
-		WARN_ON(1);  /* Offline CPUs are supposed to report QS! */
 		pr_info("%s: grp: %d-%d level: %d ->gp_seq %ld ->completedqs %ld\n",
 			__func__, rnp->grplo, rnp->grphi, rnp->level,
 			(long)rnp->gp_seq, (long)rnp->completedqs);
-- 
2.28.0.236.gb10cc79966-goog

