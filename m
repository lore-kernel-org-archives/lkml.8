Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA92CC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C174120714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341577;
	bh=akmx110CRng1Q+duUrYkwbF/YuF/T+XgC+YIRummkg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xj25Ec3B1s/BcUhlJoRH7HkZuLzQ8fCHGrAHVUQfRU4N+2XkTDANE+8Fkg727Hl+N
	 EF6b5P2qINCNLj74xzsVEYQ5CXSYZaP0K96AEyMOf3sv7k2s0rukyopap/eWhcmF4I
	 l9dQX0G/rMz3r9r0q8RHq6GTgOniwzmKP8cLShSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgBJNc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:32:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbgBJMfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:41 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B9B92085B;
        Mon, 10 Feb 2020 12:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338140;
        bh=akmx110CRng1Q+duUrYkwbF/YuF/T+XgC+YIRummkg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/l9v+VTjTAtUDZWGWPoTrYSt3lADnS2UZpexdTx/AwMe/0s108VQuyAh/mkikTlc
         LWndM5r2gTOyJyDvqfJ5/BqE87BEhgkKBvM8Rg5CGE7xfuVRfj7kRP3dtI+L+cdC2J
         GFiOj67MdISmCuk0D6Rsgod5ggOVOBN20WHpOa30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 095/195] ftrace: Protect ftrace_graph_hash with ftrace_sync
Date:   Mon, 10 Feb 2020 04:32:33 -0800
Message-Id: <20200210122314.533421943@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

[ Upstream commit 54a16ff6f2e50775145b210bcd94d62c3c2af117 ]

As function_graph tracer can run when RCU is not "watching", it can not be
protected by synchronize_rcu() it requires running a task on each CPU before
it can be freed. Calling schedule_on_each_cpu(ftrace_sync) needs to be used.

Link: https://lore.kernel.org/r/20200205131110.GT2935@paulmck-ThinkPad-P72

Cc: stable@vger.kernel.org
Fixes: b9b0c831bed26 ("ftrace: Convert graph filter to use hash tables")
Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ftrace.c | 11 +++++++++--
 kernel/trace/trace.h  |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 09c69ad8439ef..53795237e9751 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5344,8 +5344,15 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 
 		mutex_unlock(&graph_lock);
 
-		/* Wait till all users are no longer using the old hash */
-		synchronize_sched();
+		/*
+		 * We need to do a hard force of sched synchronization.
+		 * This is because we use preempt_disable() to do RCU, but
+		 * the function tracers can be called where RCU is not watching
+		 * (like before user_exit()). We can not rely on the RCU
+		 * infrastructure to do the synchronization, thus we must do it
+		 * ourselves.
+		 */
+		schedule_on_each_cpu(ftrace_sync);
 
 		free_ftrace_hash(old_hash);
 	}
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1721b95ba9b7d..ee0c6a313ed1a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -887,6 +887,7 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 	 * Have to open code "rcu_dereference_sched()" because the
 	 * function graph tracer can be called when RCU is not
 	 * "watching".
+	 * Protected with schedule_on_each_cpu(ftrace_sync)
 	 */
 	hash = rcu_dereference_protected(ftrace_graph_hash, !preemptible());
 
@@ -939,6 +940,7 @@ static inline int ftrace_graph_notrace_addr(unsigned long addr)
 	 * Have to open code "rcu_dereference_sched()" because the
 	 * function graph tracer can be called when RCU is not
 	 * "watching".
+	 * Protected with schedule_on_each_cpu(ftrace_sync)
 	 */
 	notrace_hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
 						 !preemptible());
-- 
2.20.1



