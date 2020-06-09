Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A55C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D229E207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgFIK2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:28:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37480 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgFIK2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:28:12 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jibU9-0001xw-M9; Tue, 09 Jun 2020 10:28:01 +0000
Date:   Tue, 9 Jun 2020 12:28:01 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Weilong Chen <chenweilong@huawei.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, lizefan@huawei.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Subject: Re: [PATCH linux-next] kernel/fork.c: annotate data races for
 copy_process
Message-ID: <20200609102801.q2dum323zw7ltlw3@wittgenstein>
References: <20200609030801.272704-1-chenweilong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200609030801.272704-1-chenweilong@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 11:08:01AM +0800, Weilong Chen wrote:
> The check is only there to stop root fork bombs.
> 
> BUG: KCSAN: data-race in copy_process / copy_process
> 
> write to 0xffffffff86f87d20 of 4 bytes by task 7121 on cpu 5:
>  copy_process+0x2e1a/0x3af0 kernel/fork.c:2285
>  _do_fork+0xf7/0x790 kernel/fork.c:2430
>  __do_sys_clone+0xf9/0x130 kernel/fork.c:2585
>  __se_sys_clone kernel/fork.c:2566 [inline]
>  __x64_sys_clone+0x6c/0x80 kernel/fork.c:2566
>  do_syscall_64+0xc7/0x3b0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> read to 0xffffffff86f87d20 of 4 bytes by task 7125 on cpu 3:
>  copy_process+0x9eb/0x3af0 kernel/fork.c:1967
>  _do_fork+0xf7/0x790 kernel/fork.c:2430
>  __do_sys_clone+0xf9/0x130 kernel/fork.c:2585
>  __se_sys_clone kernel/fork.c:2566 [inline]
>  __x64_sys_clone+0x6c/0x80 kernel/fork.c:2566
>  do_syscall_64+0xc7/0x3b0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>

Plumbing data_race() in there just to taper over this seems ugly.
Before we do that we should probably simply make nr_threads atomic_t.
Also, where's the link to the syzbot/kcsan report? Or did you get this
report from somewhere else?

diff --git a/kernel/exit.c b/kernel/exit.c
index c300253a7b8e..42e1cf640b20 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -71,7 +71,7 @@

 static void __unhash_process(struct task_struct *p, bool group_dead)
 {
-       nr_threads--;
+       atomic_dec(&nr_threads);
        detach_pid(p, PIDTYPE_PID);
        if (group_dead) {
                detach_pid(p, PIDTYPE_TGID);
diff --git a/kernel/fork.c b/kernel/fork.c
index cefe8745c46e..c8355448d7c6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -122,7 +122,7 @@
  * Protected counters by write_lock_irq(&tasklist_lock)
  */
 unsigned long total_forks;     /* Handle normal Linux uptimes. */
-int nr_threads;                        /* The idle threads do not count.. */
+atomic_t nr_threads;           /* The idle threads do not count.. */

 static int max_threads;                /* tunable limit on nr_threads */

@@ -1978,7 +1978,7 @@ static __latent_entropy struct task_struct *copy_process(
         * to stop root fork bombs.
         */
        retval = -EAGAIN;
-       if (nr_threads >= max_threads)
+       if (atomic_read(&nr_threads) >= max_threads)
                goto bad_fork_cleanup_count;

        delayacct_tsk_init(p);  /* Must remain after dup_task_struct() */
@@ -2296,7 +2296,7 @@ static __latent_entropy struct task_struct *copy_process(
                                          &p->signal->thread_head);
                }
                attach_pid(p, PIDTYPE_PID);
-               nr_threads++;
+               atomic_inc(&nr_threads);
        }
        total_forks++;
        hlist_del_init(&delayed.node);

> ---
>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 142b23645d82..efc5493203ae 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1977,7 +1977,7 @@ static __latent_entropy struct task_struct *copy_process(
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
