Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396E2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1686B206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H1VGQHOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGILrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgGILrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:47:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42227C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jwBkggp/9SDR2NBbKDrX7UsLr9nx6UUjUaSdXDeg+/c=; b=H1VGQHOBrIsAiZUkDj9nu8eOaW
        Zp3FQ6s558T2eW/iAvO8B4Yo6qVV72ZfWuhKt1v/+WUJVEGqVy+AWQ0zXswqJrZ/PEdIlOGz8e5Xu
        2rSxELHP11pEsakqwu6SIDfLWAJfjElYtkLjuMSAFPVczJAjEuxHLAp4oBy9lw6fW31nCtsyIy0XD
        NAcPvQGKL1OPJLOm6I5++2V4QLM6RvorJBoQ1pQmH4yIJSjHf/cUOBAy646UHeABXpiTa5JeXmkVi
        ffd4wGQAK+zc1TdcpkZUKATzc6NgIhEhuh0jYY8rOqx7SmAMYcsgH3OcrwD9YNEUoLr973Blzx+Ew
        dG8VrBhg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtV18-00057j-TW; Thu, 09 Jul 2020 11:47:07 +0000
Date:   Thu, 9 Jul 2020 12:47:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Andy Lutomirski <luto@kernel.org>,
        Paul Gofman <gofmanp@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] kernel: Implement selective syscall userspace
 redirection
Message-ID: <20200709114706.GB12769@casper.infradead.org>
References: <20200709043840.4189530-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709043840.4189530-1-krisman@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 12:38:40AM -0400, Gabriel Krisman Bertazi wrote:
> The proposed interface looks like this:
> 
>   prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <dispatcher>, [selector])
> 
> Dispatcher is the address of a syscall instruction that is allowed to
> by-pass the blockage, such that in fast paths you don't need to disable
> the trap nor check the selector.  This is essential to return from
> SIGSYS to a blocked area without triggering another SIGSYS from the
> rt_sigreturn.

Should <dispatcher> be a single pointer or should the interface specify
a range from which syscalls may be made without being redirected?  eg,
one could specify the whole of libc.

prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <start>, <inclusive-end>, [selector])

> +++ b/include/linux/syscall_user_dispatch.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _SYSCALL_USER_DISPATCH_H
> +#define _SYSCALL_USER_DISPATCH_H
> +
> +struct task_struct;
> +static void clear_tsk_thread_flag(struct task_struct *tsk, int flag);
> +
> +#ifdef CONFIG_SYSCALL_USER_DISPATCH
> +struct syscall_user_dispatch {
> +	int __user *selector;
> +	unsigned long __user dispatcher;

The __user annotation is on the pointer, not the value.  ie, it's

	unsigned long foo;
	unsigned long __user *p;

	get_user(foo, p)

> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -285,6 +285,7 @@ typedef struct siginfo {
>   */
>  #define SYS_SECCOMP	1	/* seccomp triggered */
>  #define NSIGSYS		1
> +#define SYS_USER_REDIRECT 2

I'd suggest that SYS_USER_REDIRECT should be moved up by one line.

> +int set_syscall_user_dispatch(int mode, unsigned long __user dispatcher,
> +			      int __user *selector)
> +{
> +	switch (mode) {
> +	case PR_SYSCALL_DISPATCH_DISABLE:
> +		if (dispatcher || selector)
> +			return -EINVAL;
> +		break;
> +	case PR_SYSCALL_DISPATCH_ENABLE:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (selector) {
> +		if (!access_ok(selector, sizeof(int)))
> +			return -EFAULT;
> +	}

You're not enforcing the alignment requirement here.  

> +	spin_lock_irq(&current->sighand->siglock);
> +
> +	current->syscall_dispatch.selector = selector;
> +	current->syscall_dispatch.dispatcher = dispatcher;
> +
> +	/* make sure fastlock is committed before setting the flag. */

fastlock?  ;-)
I don't think you actually need this.  You're setting per-thread state on
yourself, so what's the race that you're concerned about?

> +	smp_mb__before_atomic();
> +
> +	if (mode == PR_SYSCALL_DISPATCH_ENABLE)
> +		set_tsk_thread_flag(current, TIF_SYSCALL_USER_DISPATCH);
> +	else
> +		clear_tsk_thread_flag(current, TIF_SYSCALL_USER_DISPATCH);
> +
> +	spin_unlock_irq(&current->sighand->siglock);
> +
> +	return 0;
> +}
> -- 
> 2.27.0
> 
