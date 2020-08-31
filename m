Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87364C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530022083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598896973;
	bh=C+98zjjfkaugcV9frLXvjdO675Odo5v+44/WJvSgH2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NGTv4G3Ts7w4r5NuzOg4AANop0YCmvRKO0RD0bY8wB5TId6NkPlrSesajpBI10bx4
	 ntJeN7QRLjoEfrJfjr1YNLGuMARDApdfn+/0qZfG6L3bIZqfMGERcMWyj0YfL6Yyu9
	 9wds2tvtHvOVbFgQLHIBoOu3BOICCMUINU745xaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgHaSBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728333AbgHaSBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:20 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9965A20EDD;
        Mon, 31 Aug 2020 18:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896879;
        bh=C+98zjjfkaugcV9frLXvjdO675Odo5v+44/WJvSgH2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSLeycb6u6V+X2t3gP/7N8XVUR15Y+QKLRL1o8RliA32hfRvQT2NOUZ+QfKPe6A/O
         m0mFlP/r181XklBrWgvCezAgfsfABDXC0nQZhjIdbRPTdkeSbGIKqVLOHSlNkoRg8r
         VDoK0lxu5R70oPbZed0ZSRBYzb+qv7Q5CUb2eoVo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/24] rcu: Remove KCSAN stubs from update.c
Date:   Mon, 31 Aug 2020 11:00:54 -0700
Message-Id: <20200831180116.32690-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

KCSAN is now in mainline, so this commit removes the stubs for the
data_race(), ASSERT_EXCLUSIVE_WRITER(), and ASSERT_EXCLUSIVE_ACCESS()
macros.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 2de49b5..5f7713a 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -53,19 +53,6 @@
 #endif
 #define MODULE_PARAM_PREFIX "rcupdate."
 
-#ifndef data_race
-#define data_race(expr)							\
-	({								\
-		expr;							\
-	})
-#endif
-#ifndef ASSERT_EXCLUSIVE_WRITER
-#define ASSERT_EXCLUSIVE_WRITER(var) do { } while (0)
-#endif
-#ifndef ASSERT_EXCLUSIVE_ACCESS
-#define ASSERT_EXCLUSIVE_ACCESS(var) do { } while (0)
-#endif
-
 #ifndef CONFIG_TINY_RCU
 module_param(rcu_expedited, int, 0);
 module_param(rcu_normal, int, 0);
-- 
2.9.5

