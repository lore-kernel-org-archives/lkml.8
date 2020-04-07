Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD6FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD092054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgDGBem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:34:42 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43816 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGBem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:34:42 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jLd8T-0003KF-9S; Mon, 06 Apr 2020 19:34:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jLd8S-0002Vt-FJ; Mon, 06 Apr 2020 19:34:41 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
        <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
        <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
        <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
        <87lfnda3w3.fsf@x220.int.ebiederm.org>
        <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
        <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 06 Apr 2020 20:31:52 -0500
In-Reply-To: <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 06 Apr 2020 20:29:50 -0500")
Message-ID: <87imic3wtz.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jLd8S-0002Vt-FJ;;;mid=<87imic3wtz.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18oi+lq2LNPkBvf0FQ+az02C9Ie0QAYJFE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 2/3] exec: Make unlocking exec_update_mutex explict
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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
index d55710a36056..28c87020da9b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1318,7 +1318,7 @@ int flush_old_exec(struct linux_binprm * bprm)
 	 */
 	retval = unshare_sighand(me);
 	if (retval)
-		goto out;
+		goto out_unlock;
 
 	set_fs(USER_DS);
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
@@ -1335,6 +1335,8 @@ int flush_old_exec(struct linux_binprm * bprm)
 	do_close_on_exec(me->files);
 	return 0;
 
+out_unlock:
+	mutex_unlock(&me->signal->exec_update_mutex);
 out:
 	return retval;
 }
@@ -1451,8 +1453,6 @@ static void free_bprm(struct linux_binprm *bprm)
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
2.25.0

