Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8321CC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 12:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627F12071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 12:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgBVMSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 07:18:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53229 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgBVMSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 07:18:10 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j5TjN-0004Bh-RQ; Sat, 22 Feb 2020 12:18:01 +0000
Date:   Sat, 22 Feb 2020 13:18:01 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH][next] clone3: fix an unsigned args.cgroup comparison to
 less than zero
Message-ID: <20200222121801.cu4dfnk4z5xd5uc2@wittgenstein>
References: <20200222001513.43099-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200222001513.43099-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 12:15:13AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The less than zero comparison of args.cgroup is aways false because
> args.cgroup is a u64 and can never be less than zero.  I believe the
> correct check is to cast args.cgroup to a s64 first to ensure an
> invalid value is not copied to kargs->cgroup.
> 
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, Colin.
Dan has reported this issue a few days prior on the janitors list so he
likely should get a 
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
too. I've been sending Dan's bug report to the kernel-mentee list too in
case someone wanted to fix it there. So I'm Ccing them again here so
they know someone's working on this!

> ---
>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 67a5d691ffa8..98513a122dd1 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2635,7 +2635,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  		     !valid_signal(args.exit_signal)))
>  		return -EINVAL;
>  
> -	if ((args.flags & CLONE_INTO_CGROUP) && args.cgroup < 0)
> +	if ((args.flags & CLONE_INTO_CGROUP) && (s64)args.cgroup < 0)

I think my code here needs a little more fixing. I'm doing

	if ((args.flags & CLONE_INTO_CGROUP) && args.cgroup < 0)
		return -EINVAL;

and then later

	*kargs = (struct kernel_clone_args){
		.cgroup		= args.cgroup,
	};

blindly casting from a u64 in struct clone_args to an int in struct
kernel_clone_args. I think we want to check that we're within a sane
range. Maybe something like:

diff --git a/kernel/fork.c b/kernel/fork.c
index 2diff --git a/kernel/fork.c b/kernel/fork.c
index 2853e258fe1f..dca4dde3b5b2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2618,7 +2618,8 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
                     !valid_signal(args.exit_signal)))
                return -EINVAL;

-       if ((args.flags & CLONE_INTO_CGROUP) && args.cgroup < 0)
+       if ((args.flags & CLONE_INTO_CGROUP) &&
+           (args.cgroup > INT_MAX || (s64)args.cgroup < 0))
                return -EINVAL;

        *kargs = (struct kernel_clone_args){

Christian
