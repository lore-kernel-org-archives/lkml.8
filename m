Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56858C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B45320857
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDXUxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:53:32 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:39094 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXUxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:53:31 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jS5KE-0001YR-MD; Fri, 24 Apr 2020 14:53:30 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jS5KE-0007t9-0i; Fri, 24 Apr 2020 14:53:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
Date:   Fri, 24 Apr 2020 15:50:20 -0500
In-Reply-To: <20200424173927.GB26802@redhat.com> (Oleg Nesterov's message of
        "Fri, 24 Apr 2020 19:39:28 +0200")
Message-ID: <875zdopq0j.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jS5KE-0007t9-0i;;;mid=<875zdopq0j.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/PjcqSz7yy9YnzAu0s9P2ZBtebHz3Fjs4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH] proc: Put thread_pid in release_task not proc_flush_pid
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Oleg pointed out that in the unlikely event the kernel is compiled
with CONFIG_PROC_FS unset that release_task will now leak the pid.

Move the put_pid out of proc_flush_pid into release_task to fix this
and to guarantee I don't make that mistake again.

When possible it makes sense to keep get and put in the same function
so it can easily been seen how they pair up.

Fixes: 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")
Reported-by: Oleg Nesterov <oleg@redhat.com>
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

