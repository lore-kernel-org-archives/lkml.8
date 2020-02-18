Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9D0C34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 00:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F5920801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 00:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581986669;
	bh=GlF7tsNGHn7ate9mU1/VWHoZi1IO50fGecOk1KZoByA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HEj1jFmIs9Ovoj3CVyEyFFIz+bZsogL3fEDKREXjdJYsM4vA0+cVmonlKSXseIVNd
	 03CgVpWtQ24Fk1Vn55qcFME6BjVnLY5ynczwvAkaUI+1B8bv7+1kojvqZ2Gq1qw0Fa
	 LJJHad0oHbaqchBxyNErC1LX8K+c45AD9tRrbsUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgBRAo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 19:44:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgBRAo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 19:44:28 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50BF520718;
        Tue, 18 Feb 2020 00:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581986666;
        bh=GlF7tsNGHn7ate9mU1/VWHoZi1IO50fGecOk1KZoByA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1zuBOljaPmfo1ySuLtV3H4a7rdz65oBuqOnGS/aZED5i0lMSv8XDNvYvI58o7a9Ez
         jrvE6ApzevgE0DFQ17roXJZ55/Ywf89FVmEJSSThI6pPbPxIC71W7MCRQhhrIMDbw8
         1Nfg+Fpx1BRNN39bZskt6JHvYcqn+ws123oWgZVI=
Date:   Tue, 18 Feb 2020 09:44:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        stable@kernel.vger.org,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] powerpc/kprobes: Fix trap address when trap happened in
 real mode
Message-Id: <20200218094421.6d402de389ce23a55a3ec084@kernel.org>
In-Reply-To: <c6257b49-bf02-d30a-1e2e-99abba5955e6@c-s.fr>
References: <b1451438f7148ad0e03306a1f1409f4ad1d6ec7c.1581684263.git.christophe.leroy@c-s.fr>
        <20200214225434.464ec467ad9094961abb8ddc@kernel.org>
        <e09d3c42-542e-48c1-2f1e-cfe605b05bec@c-s.fr>
        <20200216213411.824295a321d8fa979dedbbbe@kernel.org>
        <baee8186-549a-f6cf-3619-884b6d708185@c-s.fr>
        <20200217192735.5070f0925c4159ccffa4e465@kernel.org>
        <c6257b49-bf02-d30a-1e2e-99abba5955e6@c-s.fr>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 16:38:50 +0100
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> 
> 
> Le 17/02/2020 à 11:27, Masami Hiramatsu a écrit :
> > On Mon, 17 Feb 2020 10:03:22 +0100
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> > 
> >>
> >>
> >> Le 16/02/2020 à 13:34, Masami Hiramatsu a écrit :
> >>> On Sat, 15 Feb 2020 11:28:49 +0100
> >>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >>>
> >>>> Hi,
> >>>>
> >>>> Le 14/02/2020 à 14:54, Masami Hiramatsu a écrit :
> >>>>> Hi,
> >>>>>
> >>>>> On Fri, 14 Feb 2020 12:47:49 +0000 (UTC)
> >>>>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >>>>>
> >>>>>> When a program check exception happens while MMU translation is
> >>>>>> disabled, following Oops happens in kprobe_handler() in the following
> >>>>>> test:
> >>>>>>
> >>>>>> 		} else if (*addr != BREAKPOINT_INSTRUCTION) {
> >>>>>
> >>>>> Thanks for the report and patch. I'm not so sure about powerpc implementation
> >>>>> but at where the MMU translation is disabled, can the handler work correctly?
> >>>>> (And where did you put the probe on?)
> >>>>>
> >>>>> Your fix may fix this Oops, but if the handler needs special care, it is an
> >>>>> option to blacklist such place (if possible).
> >>>>
> >>>> I guess that's another story. Here we are not talking about a place
> >>>> where kprobe has been illegitimately activated, but a place where there
> >>>> is a valid trap, which generated a valid 'program check exception'. And
> >>>> kprobe was off at that time.
> >>>
> >>> Ah, I got it. It is not a kprobe breakpoint, but to check that correctly,
> >>> it has to know the address where the breakpoint happens. OK.
> >>>
> >>>>
> >>>> As any 'program check exception' due to a trap (ie a BUG_ON, a WARN_ON,
> >>>> a debugger breakpoint, a perf breakpoint, etc...) calls
> >>>> kprobe_handler(), kprobe_handler() must be prepared to handle the case
> >>>> where the MMU translation is disabled, even if probes are not supposed
> >>>> to be set for functions running with MMU translation disabled.
> >>>
> >>> Can't we check the MMU is disabled there (as same as checking the exception
> >>> happened in user space or not)?
> >>>
> >>
> >> What do you mean by 'there' ? At the entry of kprobe_handler() ?
> >>
> >> That's what my patch does, it checks whether MMU is disabled or not. If
> >> it is, it converts the address to a virtual address.
> >>
> >> Do you mean kprobe_handler() should bail out early as it does when the
> >> trap happens in user mode ?
> > 
> > Yes, that is what I meant.
> > 
> >> Of course we can do that, I don't know
> >> enough about kprobe to know if kprobe_handler() should manage events
> >> that happened in real-mode or just ignore them. But I tested adding an
> >> event on a function that runs in real-mode, and it (now) works.
> >>
> >> So, what should we do really ?
> > 
> > I'm not sure how the powerpc kernel runs in real mode.
> > But clearly, at least kprobe event can not handle that case because
> > it tries to access memory by probe_kernel_read(). Unless that function
> > correctly handles the address translation, I want to prohibit kprobes
> > on such address.
> > 
> > So what I would like to see is, something like below.
> > 
> > diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> > index 2d27ec4feee4..4771be152416 100644
> > --- a/arch/powerpc/kernel/kprobes.c
> > +++ b/arch/powerpc/kernel/kprobes.c
> > @@ -261,7 +261,7 @@ int kprobe_handler(struct pt_regs *regs)
> >          unsigned int *addr = (unsigned int *)regs->nip;
> >          struct kprobe_ctlblk *kcb;
> >   
> > -       if (user_mode(regs))
> > +       if (user_mode(regs) || !(regs->msr & MSR_IR))
> >                  return 0;
> >   
> >          /*
> > 
> > 
> 
> With this instead change of my patch, I get an Oops everytime a kprobe 
> event occurs in real-mode.
> 
> This is because kprobe_handler() is now saying 'this trap doesn't belong 
> to me' for a trap that has been installed by it.

Hmm, on powerpc, kprobes is allowed to probe on the code which runs
in the real mode? I think we should also prohibit it by blacklisting.
(It is easy to add blacklist by NOKPROBE_SYMBOL(func))
Or, some parts are possble to run under both real mode and kernel mode?

> 
> So the 'program check' exception handler doesn't find the owner of the 
> trap hence generate an Oops.
> 
> Even if we don't want kprobe() to proceed with the event entirely 
> (allthough it works at least for simple events), I'd expect it to fail 
> gracefully.

Agreed. I thought it was easy to identify real mode code. But if it is
hard, we should apply your first patch and also skip user handlers
if we are in the real mode (and increment missed count).

BTW, can the emulater handle the real mode code correctly?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
