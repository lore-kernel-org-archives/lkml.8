Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAFFC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254CB20731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEHSsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:48:54 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54612 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgEHSsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:48:53 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX83I-0005SA-Sr; Fri, 08 May 2020 12:48:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX83I-0002xa-4g; Fri, 08 May 2020 12:48:52 -0600
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
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
Date:   Fri, 08 May 2020 13:45:25 -0500
In-Reply-To: <87sgga6ze4.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 08 May 2020 13:43:31 -0500")
Message-ID: <87blmy6zay.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jX83I-0002xa-4g;;;mid=<87blmy6zay.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/M8xbipLE7+kJXgkEYUSylu3e6cNqDnCs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 3/6] exec: Stop open coding mutex_lock_killable of cred_guard_mutex
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Oleg modified the code that did
"mutex_lock_interruptible(&current->cred_guard_mutex)" to return
-ERESTARTNOINTR instead of -EINTR, so that userspace will never see a
failure to grab the mutex.

Slightly earlier Liam R. Howlett defined mutex_lock_killable for
exactly the same situation but it does it a little more cleanly.

Switch the code to mutex_lock_killable so that it is clearer what the
code is doing.

Ref: ad776537cc6b ("Add mutex_lock_killable")
Ref: 793285fcafce ("cred_guard_mutex: do not return -EINTR to user-space")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c       | 5 +++--
 kernel/ptrace.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 82106241ed53..11a5c073aa35 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1493,8 +1493,9 @@ EXPORT_SYMBOL(finalize_exec);
  */
 static int prepare_bprm_creds(struct linux_binprm *bprm)
 {
-	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
-		return -ERESTARTNOINTR;
+	int retval = mutex_lock_killable(&current->signal->cred_guard_mutex);
+	if (retval)
+		return retval;
 
 	bprm->cred = prepare_exec_creds();
 	if (likely(bprm->cred))
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..1876b3392488 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -391,8 +391,8 @@ static int ptrace_attach(struct task_struct *task, long request,
 	 * SUID, SGID and LSM creds get determined differently
 	 * under ptrace.
 	 */
-	retval = -ERESTARTNOINTR;
-	if (mutex_lock_interruptible(&task->signal->cred_guard_mutex))
+	retval = mutex_lock_killable(&task->signal->cred_guard_mutex);
+	if (retval)
 		goto out;
 
 	task_lock(task);
-- 
2.20.1

