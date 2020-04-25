Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0941CC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 16:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9932071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 16:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDYQBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 12:01:48 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44814 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgDYQBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 12:01:47 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jSNFS-0000Sj-De; Sat, 25 Apr 2020 10:01:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jSNFR-0003rJ-HH; Sat, 25 Apr 2020 10:01:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Date:   Sat, 25 Apr 2020 10:58:35 -0500
Message-ID: <878sijo8us.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jSNFR-0003rJ-HH;;;mid=<878sijo8us.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+KHl53AStV0dEp3mzBT+inUwLnzJN78vI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] Please pull proc_flush_pid fix for v5.7-rc3
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the for-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

   HEAD: 6ade99ec6175ab2b54c227521e181e1c3c2bfc8a proc: Put thread_pid in release_task not proc_flush_pid

Oleg noticed that put_pid(thread_pid) was not getting called when proc
was not compiled in.  Let's get that fixed before 5.7 is released and
causes problems for anyone.

Eric

---

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 24 Apr 2020 15:41:20 -0500
Subject: [PATCH] proc: Put thread_pid in release_task not proc_flush_pid

Oleg pointed out that in the unlikely event the kernel is compiled
with CONFIG_PROC_FS unset that release_task will now leak the pid.

Move the put_pid out of proc_flush_pid into release_task to fix this
and to guarantee I don't make that mistake again.

When possible it makes sense to keep get and put in the same function
so it can easily been seen how they pair up.

Fixes: 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/base.c | 1 -
 kernel/exit.c  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6042b646ab27..42f43c7b9669 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3274,7 +3274,6 @@ static const struct inode_operations proc_tgid_base_inode_operations = {
 void proc_flush_pid(struct pid *pid)
 {
 	proc_invalidate_siblings_dcache(&pid->inodes, &pid->lock);
-	put_pid(pid);
 }
 
 static struct dentry *proc_pid_instantiate(struct dentry * dentry,
diff --git a/kernel/exit.c b/kernel/exit.c
index 389a88cb3081..ce2a75bc0ade 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -219,6 +219,7 @@ void release_task(struct task_struct *p)
 
 	write_unlock_irq(&tasklist_lock);
 	proc_flush_pid(thread_pid);
+	put_pid(thread_pid);
 	release_thread(p);
 	put_task_struct_rcu_user(p);
 
-- 
2.20.1




