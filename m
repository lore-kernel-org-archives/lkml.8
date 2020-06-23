Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5C2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD88220720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871769;
	bh=s3Q7WdoimhZ9FOtIeYRsMhnpVsrytMjrx1czpUaeO4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YmAydt7hV1hGosgelWwRU+h7iJKDhdrxfrMuGlJ1TthkCocSh6ZcsJG02gBtXzs3Z
	 iLDtflAL0NmWgdhBg0+8A3WQ1gPDjFhZ53K9uc6zfNIc7gZwGd0xfz0M7C53SRLpJ4
	 4+4FtdDB57+L0UkBBDxi0FxwWPGS1cZWb2wU1Gew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbgFWAWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731544AbgFWAVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:52 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04575208A7;
        Tue, 23 Jun 2020 00:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871712;
        bh=s3Q7WdoimhZ9FOtIeYRsMhnpVsrytMjrx1czpUaeO4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1+CYeDtz+PmHP2OWySCkcXJJT8UvLZ6Tkxx25Y47YqC0PTOOThI60BmIB9EOwj/Y5
         qc/O99T/lrD9VX1lx5uy0G0egNfaSL/hzoZMFsX/g0/W6lcfjjUOIHo97L31v7YdpV
         z17xHgEadKBEK3EVfNYHL4gZDG4d5PTJOKHr++lk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/26] rcu: fix some kernel-doc warnings
Date:   Mon, 22 Jun 2020 17:21:35 -0700
Message-Id: <20200623002147.25750-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There are some kernel-doc warnings:

	./kernel/rcu/tree.c:2915: warning: Function parameter or member 'count' not described in 'kfree_rcu_cpu'

This commit therefore moves the comment for "count" to the kernel-doc
markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 48ae673..08e3648 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2987,6 +2987,7 @@ struct kfree_rcu_cpu_work {
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
  * @initialized: The @lock and @rcu_work fields have been initialized
+ * @count: Number of objects for which GP not started
  *
  * This is a per-CPU structure.  The reason that it is not included in
  * the rcu_data structure is to permit this code to be extracted from
@@ -3002,7 +3003,6 @@ struct kfree_rcu_cpu {
 	struct delayed_work monitor_work;
 	bool monitor_todo;
 	bool initialized;
-	// Number of objects for which GP not started
 	int count;
 };
 
-- 
2.9.5

