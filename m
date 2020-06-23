Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AFAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED04B20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbgFWKBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:01:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43686 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbgFWKBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:01:13 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnfjh-0000U0-1Y; Tue, 23 Jun 2020 10:01:01 +0000
Date:   Tue, 23 Jun 2020 12:01:00 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Weilong Chen <chenweilong@huawei.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, lizefan@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/fork.c: annotate data races for copy_process
Message-ID: <20200623100100.bkiktqw4qhfo5a22@wittgenstein>
References: <20200623041240.154294-1-chenweilong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623041240.154294-1-chenweilong@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:12:40PM +0800, Weilong Chen wrote:
> KCSAN report there's a data race risk while using nr_threads.
> But according to the comment above it:
> '
>         /*
>          * If multiple threads are within copy_process(), then this check
>          * triggers too late. This doesn't hurt, the check is only there
>          * to stop root fork bombs.
>          */
> '
> The concurrency problem is not care. And we needn't to use READ_ONCE/atomic/etc
> to protect it. Meanwhile 'max_threads' is a sysctl variable which can
> be modified concurrently while being read, we can use
> 'data_race(nr_threads >= max_threads)' to mark both of then.
> 
> BUG: KCSAN: data-race in copy_process / copy_process
> 
> write to 0xffffffff86205cf8 of 4 bytes by task 14779 on cpu 1:
>   copy_process+0x2eba/0x3c40 kernel/fork.c:2273
>   _do_fork+0xfe/0x7a0 kernel/fork.c:2421
>   __do_sys_clone kernel/fork.c:2576 [inline]
>   __se_sys_clone kernel/fork.c:2557 [inline]
>   __x64_sys_clone+0x130/0x170 kernel/fork.c:2557
>   do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> read to 0xffffffff86205cf8 of 4 bytes by task 6944 on cpu 0:
>   copy_process+0x94d/0x3c40 kernel/fork.c:1954
>   _do_fork+0xfe/0x7a0 kernel/fork.c:2421
>   __do_sys_clone kernel/fork.c:2576 [inline]
>   __se_sys_clone kernel/fork.c:2557 [inline]
>   __x64_sys_clone+0x130/0x170 kernel/fork.c:2557
>   do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Link: https://groups.google.com/forum/#!msg/syzkaller-upstream-mo
> deration/thvp7AHs5Ew/aPdYLXfYBQAJ
> 
> Reported-by: syzbot+52fced2d288f8ecd2b20@syzkaller.appspotmail.com
> Cc: Qian Cai <cai@lca.pw>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Marco Elver <elver@google.com>
> Signed-off-by: Zefan Li <lizefan@huawei.com>
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
> ---

I'm going to fix up the commit message a little bit but otherwise I'm
going to take this unless I hear objections from someone.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks!
Christian

>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 63c8fb2f5ca7..caa9c1f27444 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1976,7 +1976,7 @@ static __latent_entropy struct task_struct *copy_process(
>  	 * to stop root fork bombs.
>  	 */
>  	retval = -EAGAIN;
> -	if (nr_threads >= max_threads)
> +	if (data_race(nr_threads >= max_threads))
>  		goto bad_fork_cleanup_count;
>  
>  	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
> -- 
> 2.17.1
> 
