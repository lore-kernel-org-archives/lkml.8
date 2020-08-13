Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328A6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020D120716
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHMHrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:47:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57701 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgHMHrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:47:05 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k67wu-0004u4-Gj; Thu, 13 Aug 2020 07:46:56 +0000
Date:   Thu, 13 Aug 2020 09:46:55 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     hui yang <yanghui.def@gmail.com>
Cc:     christian@brauner.io, peterz@infradead.org, christian@kellner.me,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, wad@chromium.org
Subject: Re: [PATCH v2] mm: LMK, adjust oom_score_adj when fork a new process
Message-ID: <20200813074655.vypcjscabep2cpri@wittgenstein>
References: <1597287211-4291-1-git-send-email-yanghui.def@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1597287211-4291-1-git-send-email-yanghui.def@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 10:53:31AM +0800, hui yang wrote:
> From: YangHui <yanghui.def@gmail.com>
> 
> Also it rely on inheritance,But there are some things you need't inheriting
> if all children oom_score_adj is -1000,the oom is meaningless

I can just reapeat what I said before: we will not be changing
inheritance behavior. It will break userspace.

And there's more problems.
Changing oom_score_adj is usually guarded by CAP_SYS_RESOURCE. It
doesn't seem like the change here adresses that in the code or in the
commit message. So from what I can tell this change here means, that a
parent process that has a "always kill" or "never kill" oom score can
spawn children that don't. That's at least surprising and at worst a
potential security issue.

In addition, given that you assign OOM_SCORE_ADJ_MIN to
oom_score_adj_min you also seem to basically allow the child process to
set /proc/<pid>/oom_score_adj to whatever low value after fork the
process sees fit without requiring CAP_SYS_RESOURCE basically enabling a
process to set itself to never be killed even though it's parent might
have been in "always kill" mode. See in fs/proc/base.c:

if ((short)oom_adj < task->signal->oom_score_adj_min &&
		!capable(CAP_SYS_RESOURCE)) {
	err = -EACCES;
	goto err_unlock;
}

Excuse my french but that's crazy and a security issue imho.

So we won't be taking this patch, sorry!

For future patches, you should also explain why you need this change.
The commit message here makes it seem you're asking for that change
without any specific reason. That's not just against expectations but
also problematic here because this is a uapi change where we're usually
very strict.

Christian

> 
> Signed-off-by: YangHui <yanghui.def@gmail.com>
> ---
>  include/uapi/linux/oom.h | 1 +
>  kernel/fork.c            | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/oom.h b/include/uapi/linux/oom.h
> index 750b1c5..0251f23 100644
> --- a/include/uapi/linux/oom.h
> +++ b/include/uapi/linux/oom.h
> @@ -8,6 +8,7 @@
>   */
>  #define OOM_SCORE_ADJ_MIN	(-1000)
>  #define OOM_SCORE_ADJ_MAX	1000
> +#define OOM_SCORE_ADJ_DEFAULT  0
>  
>  /*
>   * /proc/<pid>/oom_adj set to -17 protects from the oom killer for legacy
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 4d32190..9dfa388 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1584,8 +1584,8 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
>  	tty_audit_fork(sig);
>  	sched_autogroup_fork(sig);
>  
> -	sig->oom_score_adj = current->signal->oom_score_adj;
> -	sig->oom_score_adj_min = current->signal->oom_score_adj_min;
> +	sig->oom_score_adj = OOM_SCORE_ADJ_DEFAULT;
> +	sig->oom_score_adj_min = OOM_SCORE_ADJ_MIN;
>  
>  	mutex_init(&sig->cred_guard_mutex);
>  	mutex_init(&sig->exec_update_mutex);
> -- 
> 2.7.4
> 
