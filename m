Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E2DC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4EB20721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgEETry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:47:54 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42784 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgEETrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:47:53 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3Xk-0001UF-HF; Tue, 05 May 2020 13:47:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3Xj-0007vt-LV; Tue, 05 May 2020 13:47:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
Date:   Tue, 05 May 2020 14:44:28 -0500
In-Reply-To: <87h7wujhmz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 05 May 2020 14:39:32 -0500")
Message-ID: <87o8r2i2ub.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jW3Xj-0007vt-LV;;;mid=<87o8r2i2ub.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+MM8noAZIW3+gtzC3/VW1oflU0z+e62Ns=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 5/7] exec: In setup_new_exec cache current in the local variable me
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


At least gcc 8.3 when generating code for x86_64 has a hard time
consolidating multiple calls to current aka get_current(), and winds
up unnecessarily rereading %gs:current_task several times in
setup_new_exec.

Caching the value of current in the local variable of me generates
slightly better and shorter assembly.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 93e40f865523..8c3abafb9bb1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1391,6 +1391,7 @@ EXPORT_SYMBOL(would_dump);
 
 void setup_new_exec(struct linux_binprm * bprm)
 {
+	struct task_struct *me = current;
 	/*
 	 * Once here, prepare_binrpm() will not be called any more, so
 	 * the final state of setuid/setgid/fscaps can be merged into the
@@ -1400,7 +1401,7 @@ void setup_new_exec(struct linux_binprm * bprm)
 
 	if (bprm->secureexec) {
 		/* Make sure parent cannot signal privileged process. */
-		current->pdeath_signal = 0;
+		me->pdeath_signal = 0;
 
 		/*
 		 * For secureexec, reset the stack limit to sane default to
@@ -1413,9 +1414,9 @@ void setup_new_exec(struct linux_binprm * bprm)
 			bprm->rlim_stack.rlim_cur = _STK_LIM;
 	}
 
-	arch_pick_mmap_layout(current->mm, &bprm->rlim_stack);
+	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
 
-	current->sas_ss_sp = current->sas_ss_size = 0;
+	me->sas_ss_sp = me->sas_ss_size = 0;
 
 	/*
 	 * Figure out dumpability. Note that this checking only of current
@@ -1431,18 +1432,18 @@ void setup_new_exec(struct linux_binprm * bprm)
 
 	arch_setup_new_exec();
 	perf_event_exec();
-	__set_task_comm(current, kbasename(bprm->filename), true);
+	__set_task_comm(me, kbasename(bprm->filename), true);
 
 	/* Set the new mm task size. We have to do that late because it may
 	 * depend on TIF_32BIT which is only updated in flush_thread() on
 	 * some architectures like powerpc
 	 */
-	current->mm->task_size = TASK_SIZE;
+	me->mm->task_size = TASK_SIZE;
 
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
-	WRITE_ONCE(current->self_exec_id, current->self_exec_id + 1);
-	flush_signal_handlers(current, 0);
+	WRITE_ONCE(me->self_exec_id, me->self_exec_id + 1);
+	flush_signal_handlers(me, 0);
 
 	/*
 	 * install the new credentials for this executable
@@ -1458,16 +1459,16 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 * wait until new credentials are committed
 	 * by commit_creds() above
 	 */
-	if (get_dumpable(current->mm) != SUID_DUMP_USER)
-		perf_event_exit_task(current);
+	if (get_dumpable(me->mm) != SUID_DUMP_USER)
+		perf_event_exit_task(me);
 	/*
 	 * cred_guard_mutex must be held at least to this point to prevent
 	 * ptrace_attach() from altering our determination of the task's
 	 * credentials; any time after this it may be unlocked.
 	 */
 	security_bprm_committed_creds(bprm);
-	mutex_unlock(&current->signal->exec_update_mutex);
-	mutex_unlock(&current->signal->cred_guard_mutex);
+	mutex_unlock(&me->signal->exec_update_mutex);
+	mutex_unlock(&me->signal->cred_guard_mutex);
 }
 EXPORT_SYMBOL(setup_new_exec);
 
-- 
2.20.1

