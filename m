Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CA3C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253052087E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgDIWS1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgDIWS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 18:18:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7509206F7;
        Thu,  9 Apr 2020 22:18:24 +0000 (UTC)
Date:   Thu, 9 Apr 2020 18:18:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, thellstrom@vmware.com,
        tony.luck@intel.com, gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Message-ID: <20200409181823.00bcd14a@gandalf.local.home>
In-Reply-To: <87imi8pdl9.fsf@nanos.tec.linutronix.de>
References: <20200407110236.930134290@infradead.org>
        <20200407111007.429362016@infradead.org>
        <20200408092726.7c2bda01@gandalf.local.home>
        <20200408154419.GP20730@hirez.programming.kicks-ass.net>
        <20200408154602.GA24869@infradead.org>
        <2b0dc69c-f7f9-985d-fc40-8b7bbd927e4f@redhat.com>
        <20200409085632.GB20713@hirez.programming.kicks-ass.net>
        <9A25271A-71F7-4EA1-9D1C-23B53E35C281@gmail.com>
        <87imi8pdl9.fsf@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Apr 2020 23:13:22 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Nadav Amit <nadav.amit@gmail.com> writes:
> >> On Apr 9, 2020, at 1:56 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >> Speaking with my virt ignorance hat on, how impossible is it to provide
> >> generic/useful VMLAUNCH/VMRESUME wrappers?
> >> 
> >> Because a lot of what happens around VMEXIT/VMENTER is very much like
> >> the userspace entry crud, as per that series from Thomas that fixes all
> >> that. And surely we don't need various broken copies of that in all the
> >> out-of-tree hypervisors.
> >> 
> >> Also, I suppose if you have this, we no longer need to excempt CR2.  
> >
> > It depends on what you mean by “VMLAUNCH/VMRESUME”. If you only consider the
> > instructions themselves, as Sean did in vmx_vmenter() and vmx_vmexit(),
> > there is no problem. Even if you consider saving the general purpose
> > registers as done in __vmx_vcpu_run() - that’s relatively easy.  
> 
> __vmx_vcpu_run() is roughly the scope, but that wont work.
> 
> Looking at the vmmon source:
> 
> Task_Switch()
> 
>     1) Mask all APIC LVTs which have NMI delivery mode enabled, e.g. PERF
> 
>     2) Disable interrupts
> 
>     3) Disable PEBS
> 
>     4) Disable PT
> 
>     5) Load a magic IDT
> 
>        According to comments these are stubs to catch any exception which
>        happens while switching over.
> 
>     6) Write CR0 and CR4 directly which is "safe" as the the IDT is
>        redirected to the monitor stubs.
> 
>     7) VMXON()
> 
>     8) Invoke monitor on some magic page which switches CR3 and GDT and
>        clears CR4.PCIDE (at least thats what the comments claim)
> 
>        The monitor code is loaded from a binary only blob and that does
>        the actual vmlaunch/vmresume ...

From what I understand (never looked at the code), is that this binary blob
is the same for Windows and Apple. It's basically its own operating system
that does all the work and vmmon is the way to switch to and from it. When
this blob gets an interrupt that it doesn't know about, it assumes it
belongs to the operating system its sharing the machine with and exits back
to it, whether that's Linux, Windows or OSX.

It's not too unlike what jailhouse does with its hypervisor, to take over
the machine and place the running Linux into its own "cell", except that it
will switch full control of the machine back to Linux.

-- Steve


> 
>        And as this runs with a completely different CR3 sharing that
>        code is impossible.
> 
>     When returning the above is undone in reverse order and any catched
>     exceptions / interrupts are replayed via "int $NR".
> 
> So it's pretty much the same mess as with vbox just different and
> binary. Oh well...
> 
> The "good" news is that it's not involved in any of the context tracking
> stuff so RCU wont ever be affected when a vmware vCPU runs. It's not
> pretty, but TBH I don't care.
> 
> Thanks,
> 
>         tglx
> 

