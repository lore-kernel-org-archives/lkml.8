Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEDCC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797FC206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHKUKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:10:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54530 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgHKUKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:10:48 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k5abe-0003Nk-Gh; Tue, 11 Aug 2020 20:10:46 +0000
Date:   Tue, 11 Aug 2020 22:10:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-doc@vger.kernel.org
Subject: Re: pidfd and O_NONBLOCK
Message-ID: <20200811201045.jw2bc3yegrgrvnpz@wittgenstein>
References: <20200811181236.GA18763@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200811181236.GA18763@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:12:36AM -0700, Josh Triplett wrote:
> As far as I can tell, O_NONBLOCK has no effect on a pidfd. When calling
> waitid on a pidfd for a running process, it always blocks unless you
> provide WNOHANG.
> 
> I don't think anything depends on that behavior. Would it be possible to
> make O_NONBLOCK on a pidfd cause waitid on a running process to return
> EWOULDBLOCK?
> 
> This would make it easier to use pidfd in some non-blocking event loops.

Hey Josh,

Just to see I did a _horrible_ draft (cf. [1]) and it seems doable to me
and if you can provide a good rationale and a use-case then I think that
would be ok.

[1]:
diff --git a/kernel/exit.c b/kernel/exit.c
index 727150f28103..b43a0e126cee 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -934,6 +934,7 @@ struct wait_opts {

        wait_queue_entry_t              child_wait;
        int                     notask_error;
+       bool                    wo_pidfd_nonblock;
 };

 static int eligible_pid(struct wait_opts *wo, struct task_struct *p)
@@ -1462,6 +1463,11 @@ static long do_wait(struct wait_opts *wo)
 notask:
        retval = wo->notask_error;
        if (!retval && !(wo->wo_flags & WNOHANG)) {
+               if (wo->wo_pidfd_nonblock) {
+                       retval = -EWOULDBLOCK;
+                       goto end;
+               }
+
                retval = -ERESTARTSYS;
                if (!signal_pending(current)) {
                        schedule();
@@ -1495,9 +1501,10 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
                          int options, struct rusage *ru)
 {
        struct wait_opts wo;
+       struct fd f;
        struct pid *pid = NULL;
        enum pid_type type;
-       long ret;
+       long ret = 0;

        if (options & ~(WNOHANG|WNOWAIT|WEXITED|WSTOPPED|WCONTINUED|
                        __WNOTHREAD|__WCLONE|__WALL))
@@ -1505,6 +1512,7 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
        if (!(options & (WEXITED|WSTOPPED|WCONTINUED)))
                return -EINVAL;

+       wo.wo_pidfd_nonblock = false;
        switch (which) {
        case P_ALL:
                type = PIDTYPE_MAX;
@@ -1531,9 +1539,22 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
                if (upid < 0)
                        return -EINVAL;

-               pid = pidfd_get_pid(upid);
+               f = fdget(upid);
+               if (!f.file)
+                       return ERR_PTR(-EBADF);
+
+               pid = pidfd_pid(f.file);
+
+               if (f.file->f_flags & O_NONBLOCK)
+                       wo.wo_pidfd_nonblock = true;
+
                if (IS_ERR(pid))
-                       return PTR_ERR(pid);
+                       ret = PTR_ERR(pid);
+               else
+                       get_pid(pid);
+               fdput(f);
+               if (ret)
+                       return ret;
                break;
        default:
                return -EINVAL;

