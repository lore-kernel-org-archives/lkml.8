Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E23FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E01220814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391005AbgE1ORF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:17:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55944 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390866AbgE1ORC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:17:02 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jeJL9-0001pt-SB; Thu, 28 May 2020 14:17:00 +0000
Date:   Thu, 28 May 2020 16:16:58 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <20200528141658.dfjple4zddzkc3bj@wittgenstein>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
 <202005271408.58F806514@keescook>
 <20200527220532.jplypougn3qzwrms@wittgenstein>
 <202005271537.75548B6@keescook>
 <20200527224501.jddwcmvtvjtjsmsx@wittgenstein>
 <20200527231646.4v743erjpzh6qe5f@wittgenstein>
 <202005271851.B7FBA02F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202005271851.B7FBA02F@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 06:59:54PM -0700, Kees Cook wrote:
> On Thu, May 28, 2020 at 01:16:46AM +0200, Christian Brauner wrote:
> > I'm also starting to think this isn't even possible or currently doable
> > safely.
> > The fdtable in the kernel would end up with a dangling pointer, I would
> > think. Unless you backtrack all fds that still have a reference into the
> > fdtable and refer to that file and close them all in the kernel which I
> > don't think is possible and also sounds very dodgy. This also really
> > seems like we would be breaking a major contract, namely that fds stay
> > valid until userspace calls close, execve(), or exits.
> 
> Right, I think I was just using the wrong words? I was looking at it
> like a pipe, or a socket, where you still have an fd, but reads return
> 0, you might get SIGPIPE, etc. The VFS clearly knows what a
> "disconnected" fd is, and I had assumed there was general logic for it
> to indicate "I'm not here any more".
> 
> I recently did something very similar to the pstore filesystem, but I got
> to cheat with some massive subsystem locks. In that case I needed to clear
> all the inodes out of the tmpfs, so I unlink them all and manage the data
> lifetimes pointing back into the (waiting to be unloaded) backend module
> by NULLing the pointer back, which is safe because of the how the locking
> there happens to work. Any open readers, when they close, will have the
> last ref count dropped, at which point the record itself is released too.
> 
> Back to the seccomp subject: should "all tasks died" be distinguishable
> from "I can't find that notification" in the ioctl()? (i.e. is ENOENT
> sufficient, or does there need to be an EIO or ESRCH there?)

I personally think it's fine as it is but as it might help users if we
reported ESRCH something like the patch below might do.
Actual cleanup of the notifier should still happen in
seccomp_notify_release() imho, and not in __poll_t both conceptually and
also because f_op->release() happens on finaly fput() which punts it to
task_work() which finishes when the task returns from kernel mode (or
exits) - or - if the task is not alive anymore just puts it on the
kernel global workqueue which is perfect for non-high-priority cleanup
stuff. It's better than making __poll_t heavier than it needs to be.
Unless there's an obvious reason not to.

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 9fa642d6d549..e6fa03cc4840 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1221,6 +1221,9 @@ static __poll_t seccomp_notify_poll(struct file *file,

        poll_wait(file, &filter->wqh, poll_tab);

+       if (refcount_read(&filter->live) == 0)
+               ret |= EPOLLHUP;
+
        if (mutex_lock_interruptible(&filter->notify_lock) < 0)
                return EPOLLERR;

@@ -1231,13 +1234,17 @@ static __poll_t seccomp_notify_poll(struct file *file,
                        ret |= EPOLLOUT | EPOLLWRNORM;
                if ((ret & EPOLLIN) && (ret & EPOLLOUT))
                        break;
+
+               if ((ret & EPOLLHUP) && cur->state != SECCOMP_NOTIFY_REPLIED) {
+                       knotif->state = SECCOMP_NOTIFY_REPLIED;
+                       knotif->error = -ESRCH;
+                       knotif->val = 0;
+                       complete(&knotif->ready);
+               }
        }

        mutex_unlock(&filter->notify_lock);

-       if (refcount_read(&filter->live) == 0)
-               ret |= EPOLLHUP;
-
        return ret;
 }

Christian
