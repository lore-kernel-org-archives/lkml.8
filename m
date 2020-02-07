Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F4DC04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A1C20720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBGOov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:44:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41014 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBGOov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 09:44:51 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j04sB-0005PM-8I; Fri, 07 Feb 2020 15:44:47 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 71EB5100F58; Fri,  7 Feb 2020 14:44:46 +0000 (GMT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Eric Dumazet <edumazet@google.com>, Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/traps: do not hash pointers in handle_stack_overflow()
In-Reply-To: <20200207043836.106657-1-edumazet@google.com>
References: <20200207043836.106657-1-edumazet@google.com>
Date:   Fri, 07 Feb 2020 14:44:46 +0000
Message-ID: <87tv42xxr5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <edumazet@google.com> writes:

> Mangling stack pointers in handle_stack_overflow() is moot,
> as registers (including RSP/RBP) are clear anyway.
>
> BUG: stack guard page was hit at 0000000063381e80 (stack is
> 000000008edc5696..0000000012256c50)

To illustrate your argument above it would be useful to provide the post
patch output as well.

> kernel stack overflow (double-fault): 0000 [#1] PREEMPT SMP KASAN
> ...
> RSP: 0018:ffffc90002c1ffc0 EFLAGS: 00010802
> RAX: 1ffff11004a0094c RBX: ffff888025004180 RCX: c9d82d1007bb146c
> RDX: dffffc0000000000 RSI: ffff888025004a40 RDI: ffff888025004180
> RBP: ffffc90002c201c0 R08: dffffc0000000000 R09: fffffbfff1405915
> R10: fffffbfff1405915 R11: 0000000000000000 R12: ffff888025004a60
> R13: ffff888025004a10 R14: c9d82d1007bb146c R15: ffff888025004180
> ...
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 6ef00eb6fbb925e86109f86845e2b3ccef4023ec..44873df292bd3f9f77bb721c53cb8a1c40994cca 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -296,7 +296,7 @@ __visible void __noreturn handle_stack_overflow(const char *message,
>  						struct pt_regs *regs,
>  						unsigned long fault_address)
>  {
> -	printk(KERN_EMERG "BUG: stack guard page was hit at %p (stack is %p..%p)\n",
> +	printk(KERN_EMERG "BUG: stack guard page was hit at %px (stack
> is %px..%px)\n",

While touching this, can you please switch it to pr_emerg() ?

Thanks,

        tglx
