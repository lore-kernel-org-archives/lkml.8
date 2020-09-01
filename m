Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A151BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B57206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgIAM0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:26:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46547 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgIAMVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:21:23 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kD5HM-0001Aw-G3; Tue, 01 Sep 2020 12:20:48 +0000
Date:   Tue, 1 Sep 2020 14:20:47 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     oleg@redhat.com, axboe@kernel.dk, ebiederm@xmission.com,
        madhuparnabhowmik10@gmail.com, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: clean up codestyle
Message-ID: <20200901122047.7hzztrssvr72wb2d@wittgenstein>
References: <20200901115800.7916-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200901115800.7916-1-linmiaohe@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 07:58:00AM -0400, Miaohe Lin wrote:
> No functional change intended.

Hey Miaohe,

Thank you for the patch.
I'm sure this is well-intended but afaict the whole file has more or
less a consistent style already where e.g. sig-1 without spaces seems to
be preferred. The same for the casts where most places use a single
space.

Now, I know CodingStyle.rst is on your side at least when it comes to
the first point:

Use one space around (on each side of) most binary and ternary operators,
such as any of these::

	=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :

but then you'd need to change each place in kernel/signal.c where that
is currently not the case. Otherwise we end up with a weird mix.

Thanks!
Christian

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/signal.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index a38b3edc6851..10a31fafc35b 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1115,8 +1115,8 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
>  	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit);
>  	if (q) {
>  		list_add_tail(&q->list, &pending->list);
> -		switch ((unsigned long) info) {
> -		case (unsigned long) SEND_SIG_NOINFO:
> +		switch ((unsigned long)info) {
> +		case (unsigned long)SEND_SIG_NOINFO:
>  			clear_siginfo(&q->info);
>  			q->info.si_signo = sig;
>  			q->info.si_errno = 0;
> @@ -1129,7 +1129,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
>  						 current_uid());
>  			rcu_read_unlock();
>  			break;
> -		case (unsigned long) SEND_SIG_PRIV:
> +		case (unsigned long)SEND_SIG_PRIV:
>  			clear_siginfo(&q->info);
>  			q->info.si_signo = sig;
>  			q->info.si_errno = 0;
> @@ -1314,7 +1314,7 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t)
>  	int sig = info->si_signo;
>  
>  	spin_lock_irqsave(&t->sighand->siglock, flags);
> -	action = &t->sighand->action[sig-1];
> +	action = &t->sighand->action[sig - 1];
>  	ignored = action->sa.sa_handler == SIG_IGN;
>  	blocked = sigismember(&t->blocked, sig);
>  	if (blocked || ignored) {
> -- 
> 2.19.1
> 
