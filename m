Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78435C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567A124699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgB0MT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:19:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56424 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbgB0MTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:19:55 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j7I8v-0004CK-6h; Thu, 27 Feb 2020 12:19:53 +0000
Date:   Thu, 27 Feb 2020 13:19:52 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH 1/3] openrisc: Convert copy_thread to copy_thread_tls
Message-ID: <20200227121952.hywkuydswvdn3myc@wittgenstein>
References: <20200226225625.28935-1-shorne@gmail.com>
 <20200226225625.28935-2-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200226225625.28935-2-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 07:56:23AM +0900, Stafford Horne wrote:
> This is required for clone3 which passes the TLS value through a
> struct rather than a register.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/Kconfig          |  1 +
>  arch/openrisc/kernel/process.c | 15 +++++----------
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 1928e061ff96..5debdbe6fc35 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -14,6 +14,7 @@ config OPENRISC
>  	select HANDLE_DOMAIN_IRQ
>  	select GPIOLIB
>  	select HAVE_ARCH_TRACEHOOK
> +	select HAVE_COPY_THREAD_TLS
>  	select SPARSE_IRQ
>  	select GENERIC_IRQ_CHIP
>  	select GENERIC_IRQ_PROBE
> diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> index b06f84f6676f..6695f167e126 100644
> --- a/arch/openrisc/kernel/process.c
> +++ b/arch/openrisc/kernel/process.c
> @@ -117,12 +117,13 @@ void release_thread(struct task_struct *dead_task)
>  extern asmlinkage void ret_from_fork(void);
>  
>  /*
> - * copy_thread
> + * copy_thread_tls
>   * @clone_flags: flags
>   * @usp: user stack pointer or fn for kernel thread
>   * @arg: arg to fn for kernel thread; always NULL for userspace thread
>   * @p: the newly created task
>   * @regs: CPU context to copy for userspace thread; always NULL for kthread
> + * @tls: the Thread Local Storate pointer for the new process
>   *
>   * At the top of a newly initialized kernel stack are two stacked pt_reg
>   * structures.  The first (topmost) is the userspace context of the thread.
> @@ -148,8 +149,8 @@ extern asmlinkage void ret_from_fork(void);
>   */
>  
>  int
> -copy_thread(unsigned long clone_flags, unsigned long usp,
> -	    unsigned long arg, struct task_struct *p)
> +copy_thread_tls(unsigned long clone_flags, unsigned long usp,
> +		unsigned long arg, struct task_struct *p, unsigned long tls)
>  {
>  	struct pt_regs *userregs;
>  	struct pt_regs *kregs;
> @@ -180,15 +181,9 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
>  
>  		/*
>  		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer passed to sys_clone.

Maybe reword this to:

For CLONE_SETTLS set "tp" (r10) to the TLS pointer. We probably
shouldn't mention clone() explicitly anymore, since we now have
clone3() and therefore two callers that pass in tls arguments.

Thanks!
Christian
