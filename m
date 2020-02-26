Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA33C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6ED620714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgBZSnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:43:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59116 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgBZSnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:43:09 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j71e2-0004SS-Dc; Wed, 26 Feb 2020 19:42:54 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id CA082104099; Wed, 26 Feb 2020 19:42:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 08/10] x86/entry/32: Remove the 0/-1 distinction from exception entries
In-Reply-To: <6dd020cd-e20a-be12-aba7-bfa9e1a94795@kernel.org>
References: <20200225213636.689276920@linutronix.de> <20200225220216.933457250@linutronix.de> <6dd020cd-e20a-be12-aba7-bfa9e1a94795@kernel.org>
Date:   Wed, 26 Feb 2020 19:42:53 +0100
Message-ID: <87blpli40i.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On 2/25/20 1:36 PM, Thomas Gleixner wrote:
>> Nothing cares about the -1 "mark as interrupt" in the errorcode anymore. Just
>> use 0 for all excpetions which do not have an errorcode consistently.
>> 
>
> I sincerely wish this were the case.  But look at collect_syscall() in
> lib/syscall.c.
>
> It would be really quite nice to address this for real in some
> low-overhead way.  My suggestion would be to borrow a trick from 32-bit:
> split regs->cs into ->cs and ->__csh, and stick CS_FROM_SYSCALL into
> __csh for syscalls.  This will only add any overhead at all to the int80
> case.  Then we could adjust syscall_get_nr() to look for CS_FROM_SYSCALL.
>
> What do you think?  An alternative would be to use the stack walking
> machinery in collect_syscall(), since the mere existence of that
> function is abomination and we may not care about performance.

Looking deeper. The code in common_exception does:

	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart

So whatever the exception pushed on the stack the thing what
collect_syscall finds is -1.

The pushed value is used as the error_code argument for the exception
handler and I really can't find a single one which cares (anymore).

But darn and I overlooked that, it's propagated to do_trap() and
friends, but even if this causes a user visible change, I doubt that
anything cares about it today simply because for giggles a 64bit kernel
unconditionally pushes 0 for all exceptions which do not have a hardware
error code on stack. So any 32bit application which excpects a
particular error code (0/-1) in the signal would have been broken on the
first day it ran on a x64 bit kernel.

If someone yells regression, then that's really trivial to fix in
C-code.

Let me rephrase the changelog for this.

Thanks,

        tglx
