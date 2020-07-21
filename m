Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C9EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4FD120792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgGUNiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:38:01 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35670 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgGUNiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:38:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jxsT1-0008VP-GH; Tue, 21 Jul 2020 07:37:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jxsSz-00010q-Fy; Tue, 21 Jul 2020 07:37:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200721130449.5008-1-hch@lst.de>
Date:   Tue, 21 Jul 2020 08:35:00 -0500
In-Reply-To: <20200721130449.5008-1-hch@lst.de> (Christoph Hellwig's message
        of "Tue, 21 Jul 2020 15:04:49 +0200")
Message-ID: <87eep5ng8r.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jxsSz-00010q-Fy;;;mid=<87eep5ng8r.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/2DM0dlThUoCuTHrfp3jCy5tEe/n0ohBk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kernel: add a kernel_wait helper
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Add a helper that waits for a pid and stores the status in the passed
> in kernel pointer.  Use it to fix the usage of kernel_wait4 in
> call_usermodehelper_exec_sync that only happens to work due to the
> implicit set_fs(KERNEL_DS) for kernel threads.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/sched/task.h |  1 +
>  kernel/exit.c              | 16 ++++++++++++++++
>  kernel/umh.c               | 29 ++++-------------------------
>  3 files changed, 21 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 38359071236ad7..a80007df396e95 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -102,6 +102,7 @@ struct task_struct *fork_idle(int);
>  struct mm_struct *copy_init_mm(void);
>  extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
>  extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
> +int kernel_wait(pid_t pid, int *stat);
>  
>  extern void free_task(struct task_struct *tsk);
>  
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 727150f2810338..fd598846df0b17 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1626,6 +1626,22 @@ long kernel_wait4(pid_t upid, int __user *stat_addr, int options,
>  	return ret;
>  }
>  
> +int kernel_wait(pid_t pid, int *stat)
> +{
> +	struct wait_opts wo = {
> +		.wo_type	= PIDTYPE_PID,
> +		.wo_pid		= find_get_pid(pid),
> +		.wo_flags	= WEXITED,
> +	};
> +	int ret;
> +
> +	ret = do_wait(&wo);
> +	if (ret > 0 && wo.wo_stat)
> +		*stat = wo.wo_stat;
> +	put_pid(wo.wo_pid);
> +	return ret;
> +}
> +
>  SYSCALL_DEFINE4(wait4, pid_t, upid, int __user *, stat_addr,
>  		int, options, struct rusage __user *, ru)
>  {
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 79f139a7ca03c6..733430921f47d7 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -130,37 +130,16 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
>  {
>  	pid_t pid;
>  
> -	/* If SIGCLD is ignored kernel_wait4 won't populate the status. */
> +	/* If SIGCLD is ignored do_wait won't populate the status. */
>  	kernel_sigaction(SIGCHLD, SIG_DFL);
>  	pid = kernel_thread(call_usermodehelper_exec_async, sub_info, SIGCHLD);
> -	if (pid < 0) {
> +	if (pid < 0)
>  		sub_info->retval = pid;
> -	} else {
> -		int ret = -ECHILD;
> -		/*
> -		 * Normally it is bogus to call wait4() from in-kernel because
> -		 * wait4() wants to write the exit code to a userspace address.
> -		 * But call_usermodehelper_exec_sync() always runs as kernel
> -		 * thread (workqueue) and put_user() to a kernel address works
> -		 * OK for kernel threads, due to their having an mm_segment_t
> -		 * which spans the entire address space.
> -		 *
> -		 * Thus the __user pointer cast is valid here.
> -		 */
> -		kernel_wait4(pid, (int __user *)&ret, 0, NULL);
> -
> -		/*
> -		 * If ret is 0, either call_usermodehelper_exec_async failed and
> -		 * the real error code is already in sub_info->retval or
> -		 * sub_info->retval is 0 anyway, so don't mess with it then.
> -		 */
> -		if (ret)
> -			sub_info->retval = ret;
> -	}
> +	else
> +		kernel_wait(pid, &sub_info->retval);
>  
>  	/* Restore default kernel sig handler */
>  	kernel_sigaction(SIGCHLD, SIG_IGN);
> -
>  	umh_complete(sub_info);
>  }
