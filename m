Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7758C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8985E206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgEETpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:45:13 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55146 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgEETpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:45:13 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3V9-00083B-LQ; Tue, 05 May 2020 13:45:12 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3V8-0003od-Jr; Tue, 05 May 2020 13:45:11 -0600
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
Date:   Tue, 05 May 2020 14:41:47 -0500
In-Reply-To: <87h7wujhmz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 05 May 2020 14:39:32 -0500")
Message-ID: <875zdajhj8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jW3V8-0003od-Jr;;;mid=<875zdajhj8.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/P9NxwY411o2elzyVOSNgU/+cN+kgzRws=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 2/7] exec: Make unlocking exec_update_mutex explict
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


With install_exec_creds updated to follow immediately after
setup_new_exec, the failure of unshare_sighand is the only
code path where exec_update_mutex is held but not explicitly
unlocked.

Update that code path to explicitly unlock exec_update_mutex.

Remove the unlocking of exec_update_mutex from free_bprm.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c               | 6 +++---
 include/linux/binfmts.h | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d..6bd82a007bfc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1344,7 +1344,7 @@ int flush_old_exec(struct linux_binprm * bprm)
 	 */
 	retval = unshare_sighand(me);
 	if (retval)
-		goto out;
+		goto out_unlock;
 
 	set_fs(USER_DS);
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
@@ -1361,6 +1361,8 @@ int flush_old_exec(struct linux_binprm * bprm)
 	do_close_on_exec(me->files);
 	return 0;
 
+out_unlock:
+	mutex_unlock(&me->signal->exec_update_mutex);
 out:
 	return retval;
 }
@@ -1477,8 +1479,6 @@ static void free_bprm(struct linux_binprm *bprm)
 {
 	free_arg_pages(bprm);
 	if (bprm->cred) {
-		if (bprm->called_exec_mmap)
-			mutex_unlock(&current->signal->exec_update_mutex);
 		mutex_unlock(&current->signal->cred_guard_mutex);
 		abort_creds(bprm->cred);
 	}
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index a345d9fed3d8..6f564b9ad882 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -47,8 +47,7 @@ struct linux_binprm {
 		secureexec:1,
 		/*
 		 * Set by flush_old_exec, when exec_mmap has been called.
-		 * This is past the point of no return, when the
-		 * exec_update_mutex has been taken.
+		 * This is past the point of no return.
 		 */
 		called_exec_mmap:1;
 #ifdef __alpha__
-- 
2.20.1

