Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D414C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AD0207BC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871774;
	bh=tB9HlMkw5XLtFIN045BqGF8hHu7w98oiNEdIGZt8lnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wIM488phjE35ZejQDDfCd7FBxY/2vxTChp/2PJCmxNVyD+YGGiph83lPJ4bQnAaz7
	 UoJ0CicFn9grah+LJuHX1/j1k/qcxbkkPzXLwO1lS8d+jBfNUWCgeB89njhAT4OxD2
	 ZCqnyAS0WHFqsjQISwutYzNrrsg+nn7YIHE6xwTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbgFWAWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731551AbgFWAVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:52 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 446D020C56;
        Tue, 23 Jun 2020 00:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871712;
        bh=tB9HlMkw5XLtFIN045BqGF8hHu7w98oiNEdIGZt8lnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UReNzSQhTH9EAYT5o6V25xHX+tJIxsjVKXbwzFxb7Rrq6GSu21qRj88xnAjKyvHkD
         CgeA4kAcp+FVsQnR6zziVSPOKAYKOaWmQ88TLkGdjfCUi/HTk5zlGPTDXIES385Prd
         xqj46Mzk5x3PFPkA9Xj1fjjK/MoOkzh+S5c5fGhE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/26] rcu: Remove initialized but unused rnp from check_slow_task()
Date:   Mon, 22 Jun 2020 17:21:36 -0700
Message-Id: <20200623002147.25750-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit removes the variable rnp from check_slow_task(), which
is defined, assigned to, but not otherwise used.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 2768ce6..d203f82 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -237,14 +237,12 @@ struct rcu_stall_chk_rdr {
  */
 static bool check_slow_task(struct task_struct *t, void *arg)
 {
-	struct rcu_node *rnp;
 	struct rcu_stall_chk_rdr *rscrp = arg;
 
 	if (task_curr(t))
 		return false; // It is running, so decline to inspect it.
 	rscrp->nesting = t->rcu_read_lock_nesting;
 	rscrp->rs = t->rcu_read_unlock_special;
-	rnp = t->rcu_blocked_node;
 	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
 	return true;
 }
-- 
2.9.5

