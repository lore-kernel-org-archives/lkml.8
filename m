Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FA8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F70220775
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgGISg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgGISg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:36:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28C3C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:36:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 16DD426D948
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Andy Lutomirski <luto@kernel.org>,
        Paul Gofman <gofmanp@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] kernel: Implement selective syscall userspace redirection
Organization: Collabora
References: <20200709043840.4189530-1-krisman@collabora.com>
        <20200709114706.GB12769@casper.infradead.org>
Date:   Thu, 09 Jul 2020 14:36:52 -0400
In-Reply-To: <20200709114706.GB12769@casper.infradead.org> (Matthew Wilcox's
        message of "Thu, 9 Jul 2020 12:47:06 +0100")
Message-ID: <87a7087cxn.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Jul 09, 2020 at 12:38:40AM -0400, Gabriel Krisman Bertazi wrote:
>> The proposed interface looks like this:
>> 
>>   prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <dispatcher>, [selector])
>> 
>> Dispatcher is the address of a syscall instruction that is allowed to
>> by-pass the blockage, such that in fast paths you don't need to disable
>> the trap nor check the selector.  This is essential to return from
>> SIGSYS to a blocked area without triggering another SIGSYS from the
>> rt_sigreturn.
>
> Should <dispatcher> be a single pointer or should the interface specify
> a range from which syscalls may be made without being redirected?  eg,
> one could specify the whole of libc.
>
> prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <start>, <inclusive-end>,
> [selector])

I liked this suggestion a lot, since user can just pass a single address
to get the original interface, but it still let us not pay the cost of
__get_user on more paths.  I will add it to v3.

>
>> +++ b/include/linux/syscall_user_dispatch.h
>> @@ -0,0 +1,45 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _SYSCALL_USER_DISPATCH_H
>> +#define _SYSCALL_USER_DISPATCH_H
>> +
>> +struct task_struct;
>> +static void clear_tsk_thread_flag(struct task_struct *tsk, int flag);
>> +
>> +#ifdef CONFIG_SYSCALL_USER_DISPATCH
>> +struct syscall_user_dispatch {
>> +	int __user *selector;
>> +	unsigned long __user dispatcher;
>
> The __user annotation is on the pointer, not the value.  ie, it's
>
> 	unsigned long foo;
> 	unsigned long __user *p;
>
> 	get_user(foo, p)
>
>> +++ b/include/uapi/asm-generic/siginfo.h
>> @@ -285,6 +285,7 @@ typedef struct siginfo {
>>   */
>>  #define SYS_SECCOMP	1	/* seccomp triggered */
>>  #define NSIGSYS		1
>> +#define SYS_USER_REDIRECT 2
>
> I'd suggest that SYS_USER_REDIRECT should be moved up by one line.
>
>> +int set_syscall_user_dispatch(int mode, unsigned long __user dispatcher,
>> +			      int __user *selector)
>> +{
>> +	switch (mode) {
>> +	case PR_SYSCALL_DISPATCH_DISABLE:
>> +		if (dispatcher || selector)
>> +			return -EINVAL;
>> +		break;
>> +	case PR_SYSCALL_DISPATCH_ENABLE:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (selector) {
>> +		if (!access_ok(selector, sizeof(int)))
>> +			return -EFAULT;
>> +	}
>
> You're not enforcing the alignment requirement here.  
>
>> +	spin_lock_irq(&current->sighand->siglock);
>> +
>> +	current->syscall_dispatch.selector = selector;
>> +	current->syscall_dispatch.dispatcher = dispatcher;
>> +
>> +	/* make sure fastlock is committed before setting the flag. */
>
> fastlock?  ;-)

Gee, keeping variable renames updated on comments is hard, compiler
won't catch those. :)

> I don't think you actually need this.  You're setting per-thread state on
> yourself, so what's the race that you're concerned about?

Good point.  I was assuming this would be modifiable from under it, but
it is not the case.

>
>> +	smp_mb__before_atomic();
>> +
>> +	if (mode == PR_SYSCALL_DISPATCH_ENABLE)
>> +		set_tsk_thread_flag(current, TIF_SYSCALL_USER_DISPATCH);
>> +	else
>> +		clear_tsk_thread_flag(current, TIF_SYSCALL_USER_DISPATCH);
>> +
>> +	spin_unlock_irq(&current->sighand->siglock);
>> +
>> +	return 0;
>> +}
>> -- 
>> 2.27.0
>> 

-- 
Gabriel Krisman Bertazi
