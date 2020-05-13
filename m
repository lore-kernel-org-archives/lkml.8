Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D882FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B480207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589388457;
	bh=DpqSfsq1NEtjbPTH3BFadiNAreRXsV2vPnKorvlK8ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rPzoY6FaYJh8MoI9abVhiYJFI2Yn6Y1jbMz68Bt8vzsjhPv2ZvtpFaCJuMWP++4mY
	 VFnkFCau3xPYdicM4zgELErMFOSQMBSgG2Ji4X4mLrihi1K30v5DlIe9jTOp6QVOst
	 tGprcdizcYDAvkv56KGIoWsaEVup0tGiKwbcKZKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389769AbgEMQrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389749AbgEMQrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:47:31 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E1F420794;
        Wed, 13 May 2020 16:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589388451;
        bh=DpqSfsq1NEtjbPTH3BFadiNAreRXsV2vPnKorvlK8ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhDTh4QdCOE7/RLfFy+shT69iXAxT+qpry12C0XA+kijbcpB1sm+W8KtRYnvU4z8l
         nW2Opkh8g6IPYxxMTSdpOQwqVNGSEMhDhytKIwwIC89yiiEf+eBeUv1wtSXNFxm8G3
         xYyVlTlaQRA0+KbfZH1mB3koT2vLwBZL5yNmOZ+0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 06/10] rcu: Make nocb_cb kthread parkable
Date:   Wed, 13 May 2020 18:47:10 +0200
Message-Id: <20200513164714.22557-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200513164714.22557-1-frederic@kernel.org>
References: <20200513164714.22557-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be necessary to correctly implement rdp de-offloading. We
don't want rcu_do_batch() in nocb_cb kthread to race with local
rcu_do_batch().

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_plugin.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1dd3fdd675a1..43ecc047af26 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2104,7 +2104,9 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	if (needwake_gp)
 		rcu_gp_kthread_wake();
 	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
-				 !READ_ONCE(rdp->nocb_cb_sleep));
+				    !READ_ONCE(rdp->nocb_cb_sleep) ||
+				    kthread_should_park());
+
 	if (!smp_load_acquire(&rdp->nocb_cb_sleep)) { /* VVV */
 		/* ^^^ Ensure CB invocation follows _sleep test. */
 		return;
@@ -2125,6 +2127,8 @@ static int rcu_nocb_cb_kthread(void *arg)
 	// if there are no more ready callbacks, waits for them.
 	for (;;) {
 		nocb_cb_wait(rdp);
+		if (kthread_should_park())
+			kthread_parkme();
 		cond_resched_tasks_rcu_qs();
 	}
 	return 0;
-- 
2.25.0

