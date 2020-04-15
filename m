Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A660C38A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB0121744
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586970807;
	bh=dSo5spukq2o6ctjGLHd9O9QaqM7Pb24Hbyo2sHA/3bY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DGcOgJ0qVuz2hcmxngMydNopahR2Nnuqn/Bxfe9RwJZP45ltgDuc3PHt8BU3kLbAv
	 DpeHd8suh+VwP6spQnXt/y4/RjeWj45owE6MhWDkIp9LtRlxJN4Ic5mmjxBok6VzDM
	 1jCZMaAlD4i2qHMMVcR35rF4Q1hmKW2xRFmnEOo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416493AbgDORNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406325AbgDORK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:10:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F72D216FD;
        Wed, 15 Apr 2020 17:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970656;
        bh=dSo5spukq2o6ctjGLHd9O9QaqM7Pb24Hbyo2sHA/3bY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3wvq7ao8bEqM+39Kmdi9uYCNjmTtY6sG+tXlUyxv7vmzkX8DrihP6MkWCIkDTD+4
         rCTFPcvITWUrQjK13M4lR3XnRtG1WkCh6pbffrpRjATNlpmcINGkp1XVnUJZK9rL/Z
         LETH6GhDqxJZmNHi3AxvgXtuyMryXT6DLmcnaVkw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/19] rcu: Add KCSAN stubs
Date:   Wed, 15 Apr 2020 10:10:36 -0700
Message-Id: <20200415171054.9013-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds stubs for KCSAN's data_race(), ASSERT_EXCLUSIVE_WRITER(),
and ASSERT_EXCLUSIVE_ACCESS() macros to allow code using these macros to
move ahead.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 06548e2..f13130a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -67,6 +67,19 @@
 #endif
 #define MODULE_PARAM_PREFIX "rcutree."
 
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
 /* Data structures. */
 
 /*
-- 
2.9.5

