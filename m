Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7DDC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA022073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCFQAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:00:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59320 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgCFQAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:00:50 -0500
Received: from [88.128.88.76] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jAFP0-0005xk-KP; Fri, 06 Mar 2020 16:00:47 +0000
Date:   Fri, 6 Mar 2020 17:00:20 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     minyard@acm.org
Cc:     linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        stable@vger.kernel.org, Adrian Reber <areber@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH] pid: Fix error return value in some cases
Message-ID: <20200306160020.orvb3frtsu2yvfe3@wittgenstein>
References: <20200306152001.30442-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200306152001.30442-1-minyard@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 09:20:01AM -0600, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Recent changes to alloc_pid() allow the pid number to be specified on
> the command line.  If set_tid_size is set, then the code scanning the
> levels will hard-set retval to -EPERM, overriding it's previous -ENOMEM
> value.
> 
> After the code scanning the levels, there are error returns that do not
> set retval, assuming it is still set to -ENOMEM.
> 
> In the first place, pid_ns_prepare_proc() returns its own error, just
> use that.
> 
> In the second place:
> 
> 	if (!(ns->pid_allocated & PIDNS_ADDING))
> 		goto out_unlock;
> 
> a return value of -ENOMEM is probably wrong, since that means that the
> namespace is in deletion while this happened.  -EINVAL is probably a
> better choice.
> 
> Fixes: 49cb2fc42ce4 "fork: extend clone3() to support setting a PID"
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: <stable@vger.kernel.org> # 5.5
> Cc: Adrian Reber <areber@redhat.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  kernel/pid.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 0f4ecb57214c..1921f7f4b236 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -248,7 +248,8 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  	}
>  
>  	if (unlikely(is_child_reaper(pid))) {
> -		if (pid_ns_prepare_proc(ns))
> +		retval = pid_ns_prepare_proc(ns);
> +		if (retval)
>  			goto out_free;
>  	}
>  
> @@ -261,8 +262,10 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  
>  	upid = pid->numbers + ns->level;
>  	spin_lock_irq(&pidmap_lock);
> -	if (!(ns->pid_allocated & PIDNS_ADDING))
> +	if (!(ns->pid_allocated & PIDNS_ADDING)) {
> +		retval = -EINVAL;
>  		goto out_unlock;
> +	}
>  	for ( ; upid >= pid->numbers; --upid) {
>  		/* Make the PID visible to find_pid_ns. */
>  		idr_replace(&upid->ns->idr, pid, upid->nr);

Thanks for the patch.

We definitely regressed the ENOMEM return value case. But both of the
changes here are userspace visible and break assumptions. So I'd rather
just ensure that ENOMEM is returned in both cases like it was before.
In fact, ENOMEM is documented on the pid_namespace man page so we can't
really change it.
Btw, this is the same problem as we had with:

commit 35f71bc0a09a45924bed268d8ccd0d3407bc476f
Author: Michal Hocko <mhocko@suse.cz>
Date:   Thu Apr 16 12:47:38 2015 -0700

    fork: report pid reservation failure properly

So please restore just restore the old behavior. Can you add --base to
your next commit, please? Makes it easier for me to pick up.

Thanks!
Christian
