Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CA8C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04173214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052537;
	bh=d3rPK+o6s1i/11GAyOvWBa5KXsljWQQoaILIlXSnfXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EvguLsdiXhhP0z9Yj6O7DfQkB8drY+agIIyqFyKX0qHR/G1sj8ta7oHI+AxRFB2IG
	 edsKzJFZdn8Y0st9rXzOdKoFrv0NfEnqyQ8i7/Dte3g6Z/CmDS6xuUXoZvpPfiqKSv
	 bMrhB1RuXy4K/lOMzEPHtkJLtI6mfy5JIGb9Sfk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896043AbgDPPze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896010AbgDPN3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:29:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29F8021D79;
        Thu, 16 Apr 2020 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043773;
        bh=d3rPK+o6s1i/11GAyOvWBa5KXsljWQQoaILIlXSnfXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZWrLRK1GVvsdlDlxa7lbkIqigu9/hFxgfo6hcuX2dEyD+YvAUPdWM8ALn9R+6UHJ
         6iP8R0Q4QpCxIOrFxSkqYJMcNasf4udQJor2YK8lkUj76HShaFqCd5sGdKeQFc/v4B
         vO9ceUwqCkb8OSG01j0gjb3nJAOD83Dii6fESlIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.19 077/146] signal: Extend exec_id to 64bits
Date:   Thu, 16 Apr 2020 15:23:38 +0200
Message-Id: <20200416131253.455184977@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com>

commit d1e7fd6462ca9fc76650fbe6ca800e35b24267da upstream.

Replace the 32bit exec_id with a 64bit exec_id to make it impossible
to wrap the exec_id counter.  With care an attacker can cause exec_id
wrap and send arbitrary signals to a newly exec'd parent.  This
bypasses the signal sending checks if the parent changes their
credentials during exec.

The severity of this problem can been seen that in my limited testing
of a 32bit exec_id it can take as little as 19s to exec 65536 times.
Which means that it can take as little as 14 days to wrap a 32bit
exec_id.  Adam Zabrocki has succeeded wrapping the self_exe_id in 7
days.  Even my slower timing is in the uptime of a typical server.
Which means self_exec_id is simply a speed bump today, and if exec
gets noticably faster self_exec_id won't even be a speed bump.

Extending self_exec_id to 64bits introduces a problem on 32bit
architectures where reading self_exec_id is no longer atomic and can
take two read instructions.  Which means that is is possible to hit
a window where the read value of exec_id does not match the written
value.  So with very lucky timing after this change this still
remains expoiltable.

I have updated the update of exec_id on exec to use WRITE_ONCE
and the read of exec_id in do_notify_parent to use READ_ONCE
to make it clear that there is no locking between these two
locations.

Link: https://lore.kernel.org/kernel-hardening/20200324215049.GA3710@pi3.com.pl
Fixes: 2.3.23pre2
Cc: stable@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/exec.c             |    2 +-
 include/linux/sched.h |    4 ++--
 kernel/signal.c       |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1378,7 +1378,7 @@ void setup_new_exec(struct linux_binprm
 
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
-	current->self_exec_id++;
+	WRITE_ONCE(current->self_exec_id, current->self_exec_id + 1);
 	flush_signal_handlers(current, 0);
 }
 EXPORT_SYMBOL(setup_new_exec);
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -887,8 +887,8 @@ struct task_struct {
 	struct seccomp			seccomp;
 
 	/* Thread group tracking: */
-	u32				parent_exec_id;
-	u32				self_exec_id;
+	u64				parent_exec_id;
+	u64				self_exec_id;
 
 	/* Protection against (de-)allocation: mm, files, fs, tty, keyrings, mems_allowed, mempolicy: */
 	spinlock_t			alloc_lock;
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1837,7 +1837,7 @@ bool do_notify_parent(struct task_struct
 		 * This is only possible if parent == real_parent.
 		 * Check if it has changed security domain.
 		 */
-		if (tsk->parent_exec_id != tsk->parent->self_exec_id)
+		if (tsk->parent_exec_id != READ_ONCE(tsk->parent->self_exec_id))
 			sig = SIGCHLD;
 	}
 


