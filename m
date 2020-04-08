Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A57C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8A120768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgDHUbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:31:49 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:58030 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgDHUbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:31:49 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMHME-0004Sh-5A; Wed, 08 Apr 2020 14:31:34 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMHMC-0006QZ-IJ; Wed, 08 Apr 2020 14:31:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        syzbot <syzbot+f675f964019f884dbd0f@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        allison@lohutok.net, areber@redhat.com, aubrey.li@linux.intel.com,
        avagin@gmail.com, bfields@fieldses.org, christian@brauner.io,
        cyphar@cyphar.com, gregkh@linuxfoundation.org, guro@fb.com,
        jlayton@kernel.org, joel@joelfernandes.org, keescook@chromium.org,
        linmiaohe@huawei.com, linux-fsdevel@vger.kernel.org,
        mhocko@suse.com, mingo@kernel.org, peterz@infradead.org,
        sargun@sargun.me, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk
References: <00000000000011d66805a25cd73f@google.com>
        <20200403091135.GA3645@redhat.com>
Date:   Wed, 08 Apr 2020 15:28:40 -0500
In-Reply-To: <20200403091135.GA3645@redhat.com> (Oleg Nesterov's message of
        "Fri, 3 Apr 2020 11:11:35 +0200")
Message-ID: <87pnchwwlj.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jMHMC-0006QZ-IJ;;;mid=<87pnchwwlj.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1++6KsIaJkmWP6lC1k/JL9e4EdcFQS0Cxk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH] proc: Use a dedicated lock in struct pid
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


syzbot wrote:
> ========================================================
> WARNING: possible irq lock inversion dependency detected
> 5.6.0-syzkaller #0 Not tainted
> --------------------------------------------------------
> swapper/1/0 just changed the state of lock:
> ffffffff898090d8 (tasklist_lock){.+.?}-{2:2}, at: send_sigurg+0x9f/0x320 fs/fcntl.c:840
> but this lock took another, SOFTIRQ-unsafe lock in the past:
>  (&pid->wait_pidfd){+.+.}-{2:2}
>
>
> and interrupts could create inverse lock ordering between them.
>
>
> other info that might help us debug this:
>  Possible interrupt unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&pid->wait_pidfd);
>                                local_irq_disable();
>                                lock(tasklist_lock);
>                                lock(&pid->wait_pidfd);
>   <Interrupt>
>     lock(tasklist_lock);
>
>  *** DEADLOCK ***
>
> 4 locks held by swapper/1/0:

The problem is that because wait_pidfd.lock is taken under the tasklist
lock.  It must always be taken with irqs disabled as tasklist_lock can be
taken from interrupt context and if wait_pidfd.lock was already taken this
would create a lock order inversion.

Oleg suggested just disabling irqs where I have added extra calls to
wait_pidfd.lock.  That should be safe and I think the code will eventually
do that.  It was rightly pointed out by Christian that sharing the
wait_pidfd.lock was a premature optimization.

It is also true that my pre-merge window testing was insufficient.  So
remove the premature optimization and give struct pid a dedicated lock of
it's own for struct pid things.  I have verified that lockdep sees all 3
paths where we take the new pid->lock and lockdep does not complain.

It is my current day dream that one day pid->lock can be used to guard the
task lists as well and then the tasklist_lock won't need to be held to
deliver signals.  That will require taking pid->lock with irqs disabled.

Link: https://lore.kernel.org/lkml/00000000000011d66805a25cd73f@google.com/
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Reported-by: syzbot+343f75cdeea091340956@syzkaller.appspotmail.com
Reported-by: syzbot+832aabf700bc3ec920b9@syzkaller.appspotmail.com
Reported-by: syzbot+f675f964019f884dbd0f@syzkaller.appspotmail.com
Reported-by: syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com
Fixes: 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

If anyone sees an issue please holer otherwise I plan on sending
this fix to Linus.

 fs/proc/base.c      | 10 +++++-----
 include/linux/pid.h |  1 +
 kernel/pid.c        |  1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 74f948a6b621..6042b646ab27 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1839,9 +1839,9 @@ void proc_pid_evict_inode(struct proc_inode *ei)
 	struct pid *pid = ei->pid;
 
 	if (S_ISDIR(ei->vfs_inode.i_mode)) {
-		spin_lock(&pid->wait_pidfd.lock);
+		spin_lock(&pid->lock);
 		hlist_del_init_rcu(&ei->sibling_inodes);
-		spin_unlock(&pid->wait_pidfd.lock);
+		spin_unlock(&pid->lock);
 	}
 
 	put_pid(pid);
@@ -1877,9 +1877,9 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 	/* Let the pid remember us for quick removal */
 	ei->pid = pid;
 	if (S_ISDIR(mode)) {
-		spin_lock(&pid->wait_pidfd.lock);
+		spin_lock(&pid->lock);
 		hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
-		spin_unlock(&pid->wait_pidfd.lock);
+		spin_unlock(&pid->lock);
 	}
 
 	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
@@ -3273,7 +3273,7 @@ static const struct inode_operations proc_tgid_base_inode_operations = {
 
 void proc_flush_pid(struct pid *pid)
 {
-	proc_invalidate_siblings_dcache(&pid->inodes, &pid->wait_pidfd.lock);
+	proc_invalidate_siblings_dcache(&pid->inodes, &pid->lock);
 	put_pid(pid);
 }
 
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 01a0d4e28506..cc896f0fc4e3 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -60,6 +60,7 @@ struct pid
 {
 	refcount_t count;
 	unsigned int level;
+	spinlock_t lock;
 	/* lists of tasks that use this pid */
 	struct hlist_head tasks[PIDTYPE_MAX];
 	struct hlist_head inodes;
diff --git a/kernel/pid.c b/kernel/pid.c
index efd34874b3d1..517d0855d4cf 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -246,6 +246,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 
 	get_pid_ns(ns);
 	refcount_set(&pid->count, 1);
+	spin_lock_init(&pid->lock);
 	for (type = 0; type < PIDTYPE_MAX; ++type)
 		INIT_HLIST_HEAD(&pid->tasks[type]);
 
-- 
2.20.1

Eric
