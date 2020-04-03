Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE2AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38BB20787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmbK+X+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390599AbgDCJLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:11:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56234 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388221AbgDCJLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585905111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TIhasx7mfHmhChZxkyzVH37c41A+dmsixY6NsWrnvsA=;
        b=gmbK+X+egGGx7McKcCG+zTSKKxGomZM0pwr7byiZ+0DEZSDvwTh8d3fIfCrGmzIQ/vtv05
        AkUWlecTePRq4q8V2QeUqzPARuwSiHF28d1S7o73bxLrKT02OQtsy+igNfXEctKAmfd7BE
        8Zfe70zeVUBm737kK26/clSrNmgul8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-PZEwFqdQPl6ImvTESWcrBg-1; Fri, 03 Apr 2020 05:11:47 -0400
X-MC-Unique: PZEwFqdQPl6ImvTESWcrBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8741D477;
        Fri,  3 Apr 2020 09:11:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.202])
        by smtp.corp.redhat.com (Postfix) with SMTP id DAB7A50BEE;
        Fri,  3 Apr 2020 09:11:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  3 Apr 2020 11:11:43 +0200 (CEST)
Date:   Fri, 3 Apr 2020 11:11:35 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     syzbot <syzbot+f675f964019f884dbd0f@syzkaller.appspotmail.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        allison@lohutok.net, areber@redhat.com, aubrey.li@linux.intel.com,
        avagin@gmail.com, bfields@fieldses.org, christian@brauner.io,
        cyphar@cyphar.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, guro@fb.com, jlayton@kernel.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linmiaohe@huawei.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, mingo@kernel.org,
        peterz@infradead.org, sargun@sargun.me,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Subject: Re: possible deadlock in send_sigurg
Message-ID: <20200403091135.GA3645@redhat.com>
References: <00000000000011d66805a25cd73f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000011d66805a25cd73f@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02, syzbot wrote:
>
>                       lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
>                       __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>                       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
>                       spin_lock include/linux/spinlock.h:353 [inline]
>                       proc_pid_make_inode+0x1f9/0x3c0 fs/proc/base.c:1880

Yes, spin_lock(wait_pidfd.lock) is not safe...

Eric, at first glance the fix is simple.

Oleg.


diff --git a/fs/proc/base.c b/fs/proc/base.c
index 74f948a6b621..9ec8c114aa60 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1839,9 +1839,9 @@ void proc_pid_evict_inode(struct proc_inode *ei)
 	struct pid *pid = ei->pid;
 
 	if (S_ISDIR(ei->vfs_inode.i_mode)) {
-		spin_lock(&pid->wait_pidfd.lock);
+		spin_lock_irq(&pid->wait_pidfd.lock);
 		hlist_del_init_rcu(&ei->sibling_inodes);
-		spin_unlock(&pid->wait_pidfd.lock);
+		spin_unlock_irq(&pid->wait_pidfd.lock);
 	}
 
 	put_pid(pid);
@@ -1877,9 +1877,9 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 	/* Let the pid remember us for quick removal */
 	ei->pid = pid;
 	if (S_ISDIR(mode)) {
-		spin_lock(&pid->wait_pidfd.lock);
+		spin_lock_irq(&pid->wait_pidfd.lock);
 		hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
-		spin_unlock(&pid->wait_pidfd.lock);
+		spin_unlock_irq(&pid->wait_pidfd.lock);
 	}
 
 	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 1e730ea1dcd6..6b7ee76e1b36 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -123,9 +123,9 @@ void proc_invalidate_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock
 		if (!node)
 			break;
 		ei = hlist_entry(node, struct proc_inode, sibling_inodes);
-		spin_lock(lock);
+		spin_lock_irq(lock);
 		hlist_del_init_rcu(&ei->sibling_inodes);
-		spin_unlock(lock);
+		spin_unlock_irq(lock);
 
 		inode = &ei->vfs_inode;
 		sb = inode->i_sb;

