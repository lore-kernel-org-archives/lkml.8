Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179E5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC85206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgG2G76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:59:58 -0400
Received: from verein.lst.de ([213.95.11.211]:51231 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgG2G76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:59:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E3DD968B05; Wed, 29 Jul 2020 08:59:55 +0200 (CEST)
Date:   Wed, 29 Jul 2020 08:59:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH 2/6] arch: x86: Wrap TIF_IA32 checks
Message-ID: <20200729065955.GA32309@lst.de>
References: <20200728202229.1195682-1-krisman@collabora.com> <20200728202229.1195682-3-krisman@collabora.com> <CALCETrV_HJCrDLCKLrqNbLiOsoEcC9M7zn-v_hcVMvDgnWW8yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV_HJCrDLCKLrqNbLiOsoEcC9M7zn-v_hcVMvDgnWW8yw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 08:43:27PM -0700, Andy Lutomirski wrote:
> > index d4edf281fff4..d39f9b3ae683 100644
> > --- a/arch/x86/include/asm/compat.h
> > +++ b/arch/x86/include/asm/compat.h
> > @@ -181,7 +181,7 @@ static inline void __user *arch_compat_alloc_user_space(long len)
> >  {
> >         compat_uptr_t sp;
> >
> > -       if (test_thread_flag(TIF_IA32)) {
> > +       if (TASK_IA32(current)) {
> >                 sp = task_pt_regs(current)->sp;
> 
> Christoph, you spend a *lot* more time looking at this stuff lately
> than I do, but this looks totally wrong.  Shouldn't this be either:
> 
> sp = task_pt_regs(current)->sp;
> 
> /* This might be a compat syscall issued via int $0x80 from 64-bit-ABI code. */
> if (user_64bit_mode(task_pt_regs(current))
>   sp -= 128;
> 
> Or perhaps the same thing without the user_64bit_mode() check at all?
> There shouldn't be much if any harm done by respecting the redzone
> unnecessarily.

compat_alloc_user_space is only used when either called from compat
calls or if in_compat_syscall() is true (and there are very few callers
left, and we plan to kill it off entirely..).

Which means we are either called from an i386 or x32 syscall, but then
again IIRC user_64bit_mode would also return true for x32.  So your
above version looks correct, and I'd also be tempted to just always
respect the redzone.

> Surely this should be:
> 
> if (user_64bit_mode(task_pt_regs(regs))

s/regs/current/

Btw, I wonder if want a shorthand for

	user_64bit_mode(task_pt_regs(thread))

instead of always open coding it.
