Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324B9C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E782072F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgDIVNv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:13:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53710 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgDIVNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:13:51 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jMeUF-0004z0-44; Thu, 09 Apr 2020 23:13:23 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7E127101150; Thu,  9 Apr 2020 23:13:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, thellstrom@vmware.com,
        tony.luck@intel.com, gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
In-Reply-To: <9A25271A-71F7-4EA1-9D1C-23B53E35C281@gmail.com>
References: <20200407110236.930134290@infradead.org> <20200407111007.429362016@infradead.org> <20200408092726.7c2bda01@gandalf.local.home> <20200408154419.GP20730@hirez.programming.kicks-ass.net> <20200408154602.GA24869@infradead.org> <2b0dc69c-f7f9-985d-fc40-8b7bbd927e4f@redhat.com> <20200409085632.GB20713@hirez.programming.kicks-ass.net> <9A25271A-71F7-4EA1-9D1C-23B53E35C281@gmail.com>
Date:   Thu, 09 Apr 2020 23:13:22 +0200
Message-ID: <87imi8pdl9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav Amit <nadav.amit@gmail.com> writes:
>> On Apr 9, 2020, at 1:56 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> Speaking with my virt ignorance hat on, how impossible is it to provide
>> generic/useful VMLAUNCH/VMRESUME wrappers?
>> 
>> Because a lot of what happens around VMEXIT/VMENTER is very much like
>> the userspace entry crud, as per that series from Thomas that fixes all
>> that. And surely we don't need various broken copies of that in all the
>> out-of-tree hypervisors.
>> 
>> Also, I suppose if you have this, we no longer need to excempt CR2.
>
> It depends on what you mean by “VMLAUNCH/VMRESUME”. If you only consider the
> instructions themselves, as Sean did in vmx_vmenter() and vmx_vmexit(),
> there is no problem. Even if you consider saving the general purpose
> registers as done in __vmx_vcpu_run() - that’s relatively easy.

__vmx_vcpu_run() is roughly the scope, but that wont work.

Looking at the vmmon source:

Task_Switch()

    1) Mask all APIC LVTs which have NMI delivery mode enabled, e.g. PERF

    2) Disable interrupts

    3) Disable PEBS

    4) Disable PT

    5) Load a magic IDT

       According to comments these are stubs to catch any exception which
       happens while switching over.

    6) Write CR0 and CR4 directly which is "safe" as the the IDT is
       redirected to the monitor stubs.

    7) VMXON()

    8) Invoke monitor on some magic page which switches CR3 and GDT and
       clears CR4.PCIDE (at least thats what the comments claim)

       The monitor code is loaded from a binary only blob and that does
       the actual vmlaunch/vmresume ...

       And as this runs with a completely different CR3 sharing that
       code is impossible.

    When returning the above is undone in reverse order and any catched
    exceptions / interrupts are replayed via "int $NR".

So it's pretty much the same mess as with vbox just different and
binary. Oh well...

The "good" news is that it's not involved in any of the context tracking
stuff so RCU wont ever be affected when a vmware vCPU runs. It's not
pretty, but TBH I don't care.

Thanks,

        tglx


