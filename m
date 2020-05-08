Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE373C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE02F207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgEHSuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:50:39 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54972 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgEHSuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:50:39 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX84z-0005ZA-W0; Fri, 08 May 2020 12:50:38 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX84z-0003BB-7i; Fri, 08 May 2020 12:50:37 -0600
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
Date:   Fri, 08 May 2020 13:47:10 -0500
In-Reply-To: <87sgga6ze4.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 08 May 2020 13:43:31 -0500")
Message-ID: <87y2q25knl.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jX84z-0003BB-7i;;;mid=<87y2q25knl.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+FnkFDblASDXzpBgep8n0qUcQ6c8wP+Zg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 5/6] exec: Move handling of the point of no return to the top level
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Move the handing of the point of no return from search_binary_handler
into __do_execve_file so that it is easier to find, and to keep
things robust in the face of change.

Make it clear that an existing fatal signal will take precedence over
a forced SIGSEGV by not forcing SIGSEGV if a fatal signal is already
pending.  This does not change the behavior but it saves a reader
of the code the tedium of reading and understanding force_sig
and the signal delivery code.

Update the comment in begin_new_exec about where SIGSEGV is forced.

Keep point_of_no_return from being a mystery by documenting
what the code is doing where it forces SIGSEGV if the
code is past the point of no return.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 15682a1dfee9..443eb960f9a0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1329,8 +1329,8 @@ int begin_new_exec(struct linux_binprm * bprm)
 	/*
 	 * With the new mm installed it is completely impossible to
 	 * fail and return to the original process.  If anything from
-	 * here on returns an error, the check in
-	 * search_binary_handler() will SEGV current.
+	 * here on returns an error, the check in __do_execve_file()
+	 * will SEGV current.
 	 */
 	bprm->point_of_no_return = true;
 	bprm->mm = NULL;
@@ -1722,13 +1722,8 @@ int search_binary_handler(struct linux_binprm *bprm)
 
 		read_lock(&binfmt_lock);
 		put_binfmt(fmt);
-		if (retval < 0 && bprm->point_of_no_return) {
-			/* we got to flush_old_exec() and failed after it */
-			read_unlock(&binfmt_lock);
-			force_sigsegv(SIGSEGV);
-			return retval;
-		}
-		if (retval != -ENOEXEC || !bprm->file) {
+		if (bprm->point_of_no_return || !bprm->file ||
+		    (retval != -ENOEXEC)) {
 			read_unlock(&binfmt_lock);
 			return retval;
 		}
@@ -1899,6 +1894,14 @@ static int __do_execve_file(int fd, struct filename *filename,
 	return retval;
 
 out:
+	/*
+	 * If past the point of no return ensure the the code never
+	 * returns to the userspace process.  Use an existing fatal
+	 * signal if present otherwise terminate the process with
+	 * SIGSEGV.
+	 */
+	if (bprm->point_of_no_return && !fatal_signal_pending(current))
+		force_sigsegv(SIGSEGV);
 	if (bprm->mm) {
 		acct_arg_size(bprm, 0);
 		mmput(bprm->mm);
-- 
2.20.1

