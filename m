Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D37C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180A524693
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgB0MYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:24:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56541 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbgB0MYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:24:30 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j7IDM-0004b4-Ip; Thu, 27 Feb 2020 12:24:28 +0000
Date:   Thu, 27 Feb 2020 13:24:27 +0100
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
Subject: Re: [PATCH 3/3] openrisc: Cleanup copy_thread_tls docs and comments
Message-ID: <20200227122427.bt3zvtdibpss46nw@wittgenstein>
References: <20200226225625.28935-1-shorne@gmail.com>
 <20200226225625.28935-4-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200226225625.28935-4-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 07:56:25AM +0900, Stafford Horne wrote:
> Previously copy_thread_tls was copy_thread and before that something
> else.  Remove the documentation about the regs parameter that didn't
> exist in either version.
> 
> Next, fix comment wrapping and details about how TLS pointer gets to the
> copy_thread_tls function.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> ---
>  arch/openrisc/kernel/process.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> index 6695f167e126..b442e7b59e17 100644
> --- a/arch/openrisc/kernel/process.c
> +++ b/arch/openrisc/kernel/process.c
> @@ -122,7 +122,6 @@ extern asmlinkage void ret_from_fork(void);
>   * @usp: user stack pointer or fn for kernel thread
>   * @arg: arg to fn for kernel thread; always NULL for userspace thread
>   * @p: the newly created task
> - * @regs: CPU context to copy for userspace thread; always NULL for kthread
>   * @tls: the Thread Local Storate pointer for the new process
>   *
>   * At the top of a newly initialized kernel stack are two stacked pt_reg
> @@ -180,7 +179,8 @@ copy_thread_tls(unsigned long clone_flags, unsigned long usp,
>  			userregs->sp = usp;
>  
>  		/*
> -		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer passed to sys_clone.
> +		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer passed
> +		 * in clone_args to sys_clone3.

As I said in my other reply, I'd not reference any specific caller since
we have at least two.

Christian
