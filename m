Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F13C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC61206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgDCSyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:54:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40852 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgDCSyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:54:11 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jKRRp-0002dL-MO; Fri, 03 Apr 2020 20:53:45 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id EEDC6103A01; Fri,  3 Apr 2020 20:53:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org, vbox-dev@virtualbox.org
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable Split-Lock-Detect
In-Reply-To: <20200403152158.GR20730@hirez.programming.kicks-ass.net>
References: <20200402123258.895628824@linutronix.de> <20200402124205.242674296@linutronix.de> <bc9a0c9a-7bd0-c85d-4795-ae0b4faa5e84@prevas.dk> <20200403143459.GA30424@linux-8ccs> <20200403152158.GR20730@hirez.programming.kicks-ass.net>
Date:   Fri, 03 Apr 2020 20:53:44 +0200
Message-ID: <87o8s8l7t3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Fri, Apr 03, 2020 at 04:35:00PM +0200, Jessica Yu wrote:
>> +++ Rasmus Villemoes [03/04/20 01:42 +0200]:
>> > On 02/04/2020 14.32, Thomas Gleixner wrote:
>> > > From: Peter Zijlstra <peterz@infradead.org>
>> > > 
>> > > It turns out that with Split-Lock-Detect enabled (default) any VMX
>> > > hypervisor needs at least a little modification in order to not blindly
>> > > inject the #AC into the guest without the guest being ready for it.
>> > > 
>> > > Since there is no telling which module implements a hypervisor, scan the
>> > > module text and look for the VMLAUNCH instruction. If found, the module is
>> > > assumed to be a hypervisor of some sort and SLD is disabled.
>> > 
>> > How long does that scan take/add to module load time? Would it make
>> > sense to exempt in-tree modules?
>> > 
>> > Rasmus
>> 
>> I second Rasmus's question. It seems rather unfortunate that we have
>> to do this text scan for every module load on x86, when it doesn't
>> apply to the majority of them, and only to a handful of out-of-tree
>> hypervisor modules (assuming kvm is taken care of already).
>> 
>> I wonder if it would make sense then to limit the text scans to just
>> out-of-tree modules (i.e., missing the intree modinfo flag)?
>
> It would; didn't know there was one.

But that still would not make it complete.

I was staring at virtualbox today after Jann pointed out that this
sucker does complete backwards things.

  The kernel driver does not contain any VM* instructions at all.

The actual hypervisor code is built as a separate binary and somehow
loaded into the kernel with their own magic fixup of relocations and
function linking. This "design" probably comes from the original
virtualbox implementation which circumvented GPL that way.

TBH, I don't care if we wreckage virtualbox simply because that thing is
already a complete and utter trainwreck violating taste and common sense
in any possible way. Just for illustration:

  - It installs preempt notifiers and the first thing in the callback
    function is to issue 'stac()'!

  - There is quite some other horrible code in there which fiddles in
    the guts of the kernel just because it can.

  - Conditionals in release code which check stuff like
    VBOX_WITH_TEXT_MODMEM_HACK, VBOX_WITH_EFLAGS_AC_SET_IN_VBOXDRV,
    VBOX_WITH_NON_PROD_HACK_FOR_PERF_STACKS along with the most absurd
    hacks ever.

If you feel the need to look yourself, please use your eyecancer
protection gear.

Can someone at Oracle please make sure, that this monstrosity gets shred
in pieces?

Enough vented, but that still does not solve the SLD problem in any
sensible way.

Thanks,

        tglx
