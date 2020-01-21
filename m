Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BF0C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B469521734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAUS7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:59:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:60228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbgAUS7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:59:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 514D1AE44;
        Tue, 21 Jan 2020 18:59:45 +0000 (UTC)
Date:   Tue, 21 Jan 2020 10:52:50 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alexey Mateosyan <alexey.mateosyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Li Rongqing <lirongqing@baidu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: mq_notify loose notification request on fork()
Message-ID: <20200121185250.fk6nkcw5nqbkab5o@linux-p48b>
References: <CACdZwvBEsS__hiWyMGina9R3A0PUbrCD5pV2+B9Bgy65joXj5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACdZwvBEsS__hiWyMGina9R3A0PUbrCD5pV2+B9Bgy65joXj5g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020, Alexey Mateosyan wrote:

>Reported bug on bugzilla  https://bugzilla.kernel.org/show_bug.cgi?id=206207
>Duplicating here:
>
>Bug is related to implementation of POSIX mqueues, specifically
>mq_notify syscall.\n
>
>The problem is: if we do subscription on notifications with help of
>mq_notify() syscall, and then do fork() and this fork() fail for some
>reason (for example there is pending signals for the parent process),
>then we loose the subscription on the notification.
>
>The root cause is: during copy_process() we duplicate opened file
>descriptors, and then if something goes wrong inside copy_process()
>(for example there is pending signals for the parent process) we do
>cleanup for the duplicated file descriptors via exit_files() which is
>finally calling filp_close() and flush(). From the other side, current
>implementation of ipc/mqueue.c implements file_operations.flush so
>that it removes notification for the current process, which is
>certainly not designed(desired) behavior.
>
>There is another case how to reproduce this behavior. Do fd =
>mq_open("my_queue"); mq_notify(fd, ...); and never do close(fd) to
>preserve notifications. Then if we open() and close() the queue file
>from the same process - we loose the notification request
>(subscription) for the still opened fd. I.e. current behavior is the
>first close() removes notification.

Is this a real issue? Do you have an actual reproducer? See below.

>
>If we do remove_notification() in file_ops.release instead of
>file_ops.flush in mqueue.c then this change fixes the described above
>fork() related problem. But this will change the behavior so that the
>last close() will remove the notifications.

Right, we don't want to change any user-visible behavior; and only
address the failed fork case.

I guess mqueue_flush_file() really wants to be using the result of
copy_process() task_struct pointer for its cleanup, instead of the
parent 'current'. The following does this but adds a way of getting
the pointer back from files_struct, perhaps you could test this?

Alternatively we could 'hijack' the fl_owner_t id before performing
f_op->flush() callback in filp_close() -- afaict no users actually
use the fl_owner_t field during flush callback, then we could just
restore it back to 'files' before dnotify_flush() etc paths, but I'm
not certain and is rather hacky to begin with.

Thanks,
Davidlohr

--------8<--------------------------------------------------------
diff --git a/fs/file.c b/fs/file.c
index 2f4fcf985079..70e5fe1c70d5 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -440,6 +440,7 @@ void exit_files(struct task_struct *tsk)
 
 	if (files) {
 		task_lock(tsk);
+		files->tsk = NULL;
 		tsk->files = NULL;
 		task_unlock(tsk);
 		put_files_struct(files);
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index f07c55ea0c22..29f906157b73 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -55,6 +55,7 @@ struct files_struct {
 
 	struct fdtable __rcu *fdt;
 	struct fdtable fdtab;
+	struct task_struct *tsk;
   /*
    * written part on a separate cache line in SMP
    */
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 3d920ff15c80..22300f0fb35a 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
+#include <linux/fdtable.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
 #include <linux/namei.h>
@@ -589,10 +590,12 @@ static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
 static int mqueue_flush_file(struct file *filp, fl_owner_t id)
 {
 	struct mqueue_inode_info *info = MQUEUE_I(file_inode(filp));
+	struct files_struct *files = id;
 
 	spin_lock(&info->lock);
-	if (task_tgid(current) == info->notify_owner)
+	if (task_tgid(files->tsk) == info->notify_owner) {
 		remove_notification(info);
+	}
 
 	spin_unlock(&info->lock);
 	return 0;
diff --git a/kernel/fork.c b/kernel/fork.c
index 2508a4f238a3..8a85858db9f5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1467,6 +1467,7 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 	if (!newf)
 		goto out;
 
+	newf->tsk = tsk;
 	tsk->files = newf;
 	error = 0;
 out:
