Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957F3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 00:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7327920656
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 00:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="m3roDEvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbgGaAkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730980AbgGaAk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 20:40:28 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02F2C061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 17:40:27 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id dd12so8396330qvb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 17:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bbCcJZmt6eGN4Co8J2+ytDC8kXUiakoxhSvDXw3GNYk=;
        b=m3roDEvLZDluWMv4Jf0eK6iWRB7TE4WjwUmvl+Ztv1l8tlV3g5pqoewEx1NRGudSME
         bWnThrRj4f8XlOdkMX/Exib4j0mVJFa2bljwKeGs7+0toMNQeYwrepJ71djn7uHgLt2P
         u8cQ277PfKk6UV6kHQ3nSxlf+tB6jNBkysGHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bbCcJZmt6eGN4Co8J2+ytDC8kXUiakoxhSvDXw3GNYk=;
        b=Ew1FRevfqpePQxQEBLEgXxoF2Bh5oGGbOrmEXUIUTFdj7jHtcjG9TN5+k+yVjYNoYN
         nhkwt8pv173S5R6MWYSw1vZCmBstAQ5kLhExmNI2j7v33qbfviN+K+vRDRQjXMbOr3bi
         VEwsh093pA9O2sYsICZczly1qZ7hoYLdKmkpcHZMurooqsQf+8po865QjnvtcZ1MNLGg
         zgkHPeNgZClSZP53j6Vltw0pvIvCf3se5ffgJG1xILWm4ip26fUgV+KizVbqzGk09VZz
         HSLAV6eyymsxdeb/0Lh5A3jFaY8Yi8Z9o7T732pAqRtEZAnwIAAgUVP6O4jFlb5zX75s
         D85A==
X-Gm-Message-State: AOAM532YTWYjXgJ73/1C3+9KzaqGlDkvs9EASDHpk5FRf+B4vwX2aP1J
        H63oCYlbKzkMdbCRZ4TXvZxGosk8Ndw=
X-Google-Smtp-Source: ABdhPJx3+bhAG64u/N4H2NWZ+LadDA8xgtXti0oQIPdXAYDiaLpEVTsgkhft7YGIxruNnyBYfG6Asg==
X-Received: by 2002:a0c:c781:: with SMTP id k1mr1720225qvj.223.1596156026599;
        Thu, 30 Jul 2020 17:40:26 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id c5sm3077320qtp.62.2020.07.30.17.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 17:40:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 3/3] rcu/tree: Make FQS complaining about offline CPU more aggressive
Date:   Thu, 30 Jul 2020 20:40:12 -0400
Message-Id: <20200731004012.2324147-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731004012.2324147-1-joel@joelfernandes.org>
References: <20200731004012.2324147-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make FQS loop consider it an immediate failure if the case of an offline CPU
reporting QS is detected, instead of a full second.

This is because rcu_report_dead() already reports quiescent states and
updates ->qsmaskinitnext under node lock.

Light testing with TREE03 and hotplug shows no warnings.

Convert the warning as well to WARN_ON_ONCE() to reduce log spam.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a621932cc385..39bdd744ba97 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1208,13 +1208,15 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		return 1;
 	}
 
-	/* If waiting too long on an offline CPU, complain. */
-	if (!(rdp->grpmask & rcu_rnp_online_cpus(rnp)) &&
-	    time_after(jiffies, rcu_state.gp_start + HZ)) {
+	/*
+	 * Complain if an offline CPU by RCU's books has not reported QS. Node
+	 * lock is held ensuring offlining does not race here.
+	 */
+	if (!(rdp->grpmask & rcu_rnp_online_cpus(rnp))) {
 		bool onl;
 		struct rcu_node *rnp1;
 
-		WARN_ON(1);  /* Offline CPUs are supposed to report QS! */
+		WARN_ON_ONCE(1);  /* Offline CPUs are supposed to report QS! */
 		pr_info("%s: grp: %d-%d level: %d ->gp_seq %ld ->completedqs %ld\n",
 			__func__, rnp->grplo, rnp->grphi, rnp->level,
 			(long)rnp->gp_seq, (long)rnp->completedqs);
-- 
2.28.0.163.g6104cc2f0b6-goog

