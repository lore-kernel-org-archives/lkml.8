Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65885C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A0F206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgEETtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:49:01 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60594 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgEETtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:49:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3Yn-0008OI-Ha; Tue, 05 May 2020 13:48:57 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3Ym-0008CU-IP; Tue, 05 May 2020 13:48:57 -0600
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
Date:   Tue, 05 May 2020 14:45:33 -0500
In-Reply-To: <87h7wujhmz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 05 May 2020 14:39:32 -0500")
Message-ID: <87ftcei2si.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jW3Ym-0008CU-IP;;;mid=<87ftcei2si.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+0vxq8buPMPNgPKrDcyd7EIeeeXCYCozY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 6/7] exec: Move most of setup_new_exec into flush_old_exec
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The current idiom for the callers is:

flush_old_exec(bprm);
set_personality(...);
setup_new_exec(bprm);

In 2010 Linus split flush_old_exec into flush_old_exec and
setup_new_exec.  With the intention that setup_new_exec be what is
called after the processes new personality is set.

Move the code that doesn't depend upon the personality from
setup_new_exec into flush_old_exec.  This is to facilitate future
changes by having as much code together in one function as possible.

Ref: 221af7f87b97 ("Split 'flush_old_exec' into two functions")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 85 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 8c3abafb9bb1..0eff20558735 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1359,39 +1359,7 @@ int flush_old_exec(struct linux_binprm * bprm)
 	 * undergoing exec(2).
 	 */
 	do_close_on_exec(me->files);
-	return 0;
-
-out_unlock:
-	mutex_unlock(&me->signal->exec_update_mutex);
-out:
-	return retval;
-}
-EXPORT_SYMBOL(flush_old_exec);
-
-void would_dump(struct linux_binprm *bprm, struct file *file)
-{
-	struct inode *inode = file_inode(file);
-	if (inode_permission(inode, MAY_READ) < 0) {
-		struct user_namespace *old, *user_ns;
-		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
-
-		/* Ensure mm->user_ns contains the executable */
-		user_ns = old = bprm->mm->user_ns;
-		while ((user_ns != &init_user_ns) &&
-		       !privileged_wrt_inode_uidgid(user_ns, inode))
-			user_ns = user_ns->parent;
 
-		if (old != user_ns) {
-			bprm->mm->user_ns = get_user_ns(user_ns);
-			put_user_ns(old);
-		}
-	}
-}
-EXPORT_SYMBOL(would_dump);
-
-void setup_new_exec(struct linux_binprm * bprm)
-{
-	struct task_struct *me = current;
 	/*
 	 * Once here, prepare_binrpm() will not be called any more, so
 	 * the final state of setuid/setgid/fscaps can be merged into the
@@ -1414,8 +1382,6 @@ void setup_new_exec(struct linux_binprm * bprm)
 			bprm->rlim_stack.rlim_cur = _STK_LIM;
 	}
 
-	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
-
 	me->sas_ss_sp = me->sas_ss_size = 0;
 
 	/*
@@ -1430,16 +1396,9 @@ void setup_new_exec(struct linux_binprm * bprm)
 	else
 		set_dumpable(current->mm, SUID_DUMP_USER);
 
-	arch_setup_new_exec();
 	perf_event_exec();
 	__set_task_comm(me, kbasename(bprm->filename), true);
 
-	/* Set the new mm task size. We have to do that late because it may
-	 * depend on TIF_32BIT which is only updated in flush_thread() on
-	 * some architectures like powerpc
-	 */
-	me->mm->task_size = TASK_SIZE;
-
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
 	WRITE_ONCE(me->self_exec_id, me->self_exec_id + 1);
@@ -1467,6 +1426,50 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 * credentials; any time after this it may be unlocked.
 	 */
 	security_bprm_committed_creds(bprm);
+	return 0;
+
+out_unlock:
+	mutex_unlock(&me->signal->exec_update_mutex);
+out:
+	return retval;
+}
+EXPORT_SYMBOL(flush_old_exec);
+
+void would_dump(struct linux_binprm *bprm, struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	if (inode_permission(inode, MAY_READ) < 0) {
+		struct user_namespace *old, *user_ns;
+		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
+
+		/* Ensure mm->user_ns contains the executable */
+		user_ns = old = bprm->mm->user_ns;
+		while ((user_ns != &init_user_ns) &&
+		       !privileged_wrt_inode_uidgid(user_ns, inode))
+			user_ns = user_ns->parent;
+
+		if (old != user_ns) {
+			bprm->mm->user_ns = get_user_ns(user_ns);
+			put_user_ns(old);
+		}
+	}
+}
+EXPORT_SYMBOL(would_dump);
+
+void setup_new_exec(struct linux_binprm * bprm)
+{
+	/* Setup things that can depend upon the personality */
+	struct task_struct *me = current;
+
+	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
+
+	arch_setup_new_exec();
+
+	/* Set the new mm task size. We have to do that late because it may
+	 * depend on TIF_32BIT which is only updated in flush_thread() on
+	 * some architectures like powerpc
+	 */
+	me->mm->task_size = TASK_SIZE;
 	mutex_unlock(&me->signal->exec_update_mutex);
 	mutex_unlock(&me->signal->cred_guard_mutex);
 }
-- 
2.20.1

