Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDDBC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F776208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586973452;
	bh=1R7gXM8eRxN4PT3jYnhPCVqSze7aESde1MRtGmvXYuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wl072qNBrWGjcTKGEe9IIaUL3fT/G46pCDjPAIeyck4yBFvZDy0d09+BJixhs62U/
	 ckPCfjrgq1f31kdGSGVAmzhqKN8R1u6iVhUup+zqqx4NzkuhKa4QmmNFAHq479JeZf
	 fFb4JHaHsPdSPqp0KwY5uxxuQwNBOTNUITA/yHtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411538AbgDOR5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416562AbgDOR4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:56:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B592084D;
        Wed, 15 Apr 2020 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586973376;
        bh=1R7gXM8eRxN4PT3jYnhPCVqSze7aESde1MRtGmvXYuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vk3ibdNqjpc4+xBWezbd9gGnG57y0EVDjOuOSLajFOG0a8UaE2DMdhMGKEjVKNMbn
         4BLS/Mf0eJPg4wYAWm62ANZZolr7BaAKFNkhouvtyJr0rWpSorSpWWvkmZKOujPpzQ
         /mTN6bbmMIuP4mS78Yf/Y8wlTu9Q6pcUTvv1+Crs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/6] rcu: Add KCSAN stubs to update.c
Date:   Wed, 15 Apr 2020 10:56:09 -0700
Message-Id: <20200415175614.10837-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415175543.GA10416@paulmck-ThinkPad-P72>
References: <20200415175543.GA10416@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds stubs for KCSAN's data_race(), ASSERT_EXCLUSIVE_WRITER(),
and ASSERT_EXCLUSIVE_ACCESS() macros to allow code using these macros
to move ahead.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 28a8bdc..74a698a 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -51,6 +51,19 @@
 #endif
 #define MODULE_PARAM_PREFIX "rcupdate."
 
+#ifndef data_race
+#define data_race(expr)							\
+	({								\
+		expr;							\
+	})
+#endif
+#ifndef ASSERT_EXCLUSIVE_WRITER
+#define ASSERT_EXCLUSIVE_WRITER(var) do { } while (0)
+#endif
+#ifndef ASSERT_EXCLUSIVE_ACCESS
+#define ASSERT_EXCLUSIVE_ACCESS(var) do { } while (0)
+#endif
+
 #ifndef CONFIG_TINY_RCU
 module_param(rcu_expedited, int, 0);
 module_param(rcu_normal, int, 0);
-- 
2.9.5

