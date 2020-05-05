Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6255BC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FC0206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgEETqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:46:08 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55434 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgEETqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:46:08 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3W0-00087g-7W; Tue, 05 May 2020 13:46:04 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3Vm-0003u4-HF; Tue, 05 May 2020 13:46:03 -0600
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
Date:   Tue, 05 May 2020 14:42:26 -0500
In-Reply-To: <87h7wujhmz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 05 May 2020 14:39:32 -0500")
Message-ID: <87zhami2xp.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jW3Vm-0003u4-HF;;;mid=<87zhami2xp.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+97DPrkHwEDW6vjLYFCW03Ty/3N9zNyBk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 3/7] exec: Rename the flag called_exec_mmap point_of_no_return
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Update the comments and make the code easier to understand by
renaming this flag.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c               | 12 ++++++------
 include/linux/binfmts.h |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6bd82a007bfc..71de9f57ae09 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1326,12 +1326,12 @@ int flush_old_exec(struct linux_binprm * bprm)
 		goto out;
 
 	/*
-	 * After setting bprm->called_exec_mmap (to mark that current is
-	 * using the prepared mm now), we have nothing left of the original
-	 * process. If anything from here on returns an error, the check
-	 * in search_binary_handler() will SEGV current.
+	 * With the new mm installed it is completely impossible to
+	 * fail and return to the original process.  If anything from
+	 * here on returns an error, the check in
+	 * search_binary_handler() will SEGV current.
 	 */
-	bprm->called_exec_mmap = 1;
+	bprm->point_of_no_return = true;
 	bprm->mm = NULL;
 
 #ifdef CONFIG_POSIX_TIMERS
@@ -1720,7 +1720,7 @@ int search_binary_handler(struct linux_binprm *bprm)
 
 		read_lock(&binfmt_lock);
 		put_binfmt(fmt);
-		if (retval < 0 && bprm->called_exec_mmap) {
+		if (retval < 0 && bprm->point_of_no_return) {
 			/* we got to flush_old_exec() and failed after it */
 			read_unlock(&binfmt_lock);
 			force_sigsegv(SIGSEGV);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 6f564b9ad882..8f479dad7931 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -46,10 +46,10 @@ struct linux_binprm {
 		 */
 		secureexec:1,
 		/*
-		 * Set by flush_old_exec, when exec_mmap has been called.
-		 * This is past the point of no return.
+		 * Set when errors can no longer be returned to the
+		 * original userspace.
 		 */
-		called_exec_mmap:1;
+		point_of_no_return:1;
 #ifdef __alpha__
 	unsigned int taso:1;
 #endif
-- 
2.20.1

