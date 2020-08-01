Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C53C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 00:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458752083B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 00:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgHAAVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 20:21:46 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:52730 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgHAAVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 20:21:45 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8E59372CCDC;
        Sat,  1 Aug 2020 03:21:42 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 61DA17CFBFC; Sat,  1 Aug 2020 03:21:42 +0300 (MSK)
Date:   Sat, 1 Aug 2020 03:21:42 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] ptrace: Prevent kernel-infoleak
 in ptrace_get_syscall_info()
Message-ID: <20200801002142.GA27762@altlinux.org>
References: <20200727213644.328662-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727213644.328662-1-yepeilin.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 05:36:44PM -0400, Peilin Ye wrote:
> ptrace_get_syscall_info() is copying uninitialized stack memory to
> userspace due to the compiler not initializing holes in statically
> allocated structures. Fix it by initializing `info` with memset().
> 
> Cc: stable@vger.kernel.org
> Fixes: 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
>  kernel/ptrace.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 43d6179508d6..e48d05b765b5 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -960,15 +960,17 @@ ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
>  			void __user *datavp)
>  {
>  	struct pt_regs *regs = task_pt_regs(child);
> -	struct ptrace_syscall_info info = {
> -		.op = PTRACE_SYSCALL_INFO_NONE,
> -		.arch = syscall_get_arch(child),
> -		.instruction_pointer = instruction_pointer(regs),
> -		.stack_pointer = user_stack_pointer(regs),
> -	};
> +	struct ptrace_syscall_info info;
>  	unsigned long actual_size = offsetof(struct ptrace_syscall_info, entry);
>  	unsigned long write_size;
>  
> +	memset(&info, 0, sizeof(info));
> +
> +	info.op	= PTRACE_SYSCALL_INFO_NONE;
> +	info.arch = syscall_get_arch(child);
> +	info.instruction_pointer = instruction_pointer(regs);
> +	info.stack_pointer = user_stack_pointer(regs);
> +

No, please don't do it this way.  If there is a hole in the structure that
the compiler is unable to initialize properly (and there is a 3-byte hole
in the beginning indeed), please plug the hole by turning it into
something that the compiler is capable of initializing.

Also, please do not forget to Cc authors of the commit you are fixing.


-- 
ldv
