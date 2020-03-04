Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1BCC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD2C20866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgCDSjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:39:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:7521 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDSjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:39:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 10:39:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="scan'208";a="240546711"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga003.jf.intel.com with ESMTP; 04 Mar 2020 10:39:31 -0800
Message-ID: <53e795ffbc029de316985476fd61845b7a9e824f.camel@intel.com>
Subject: Re: [PATCH v2 8/8] x86/fpu/xstate: Restore supervisor xstates for
 __fpu__restore_sig()
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Wed, 04 Mar 2020 10:18:46 -0800
In-Reply-To: <6778d141a3cdbbe51cdeb3a8efb9c34e0951f6c6.camel@intel.com>
References: <20200228121724.GA25261@zn.tnic>
         <89bcab262d6dad4c08c4a21e522796fea2320db3.camel@intel.com>
         <20200228162359.GC25261@zn.tnic>
         <6f91699c91f9ea0f527e80ed3ea2999444a8d2d1.camel@intel.com>
         <20200228172202.GD25261@zn.tnic>
         <9a283ad42da140d73de680b1975da142e62e016e.camel@intel.com>
         <20200228183131.GE25261@zn.tnic>
         <7c6560b067436e2ec52121bba6bff64833e28d8d.camel@intel.com>
         <20200228214742.GF25261@zn.tnic>
         <c8da950a64db495088f0abe3932a489a84e4da97.camel@intel.com>
         <20200229143644.GA1129@zn.tnic>
         <6778d141a3cdbbe51cdeb3a8efb9c34e0951f6c6.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-02 at 10:09 -0800, Yu-cheng Yu wrote:
> On Sat, 2020-02-29 at 15:36 +0100, Borislav Petkov wrote:
> > On Fri, Feb 28, 2020 at 02:13:29PM -0800, Yu-cheng Yu wrote:
> > > If the XSAVES buffer already has current data (i.e. TIF_NEED_FPU_LOAD is
> > > set), then skip copy_xregs_to_kernel().  This happens when the task was
> > > context-switched out and has not returned to user-mode.
> > 
> > So I got tired of this peacemeal game back'n'forth and went and did your
> > work for ya.
> > 
> > First of all, on my fairly new KBL test box, the context size is almost
> > a kB:
> > 
> > [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> > [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> > [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> > [    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> > [    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> > [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> > [    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> > [    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> > [    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
> > 
> > Then, I added this ontop of your patchset:
> > 
> > diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> > index 0d3e06a772b0..2e57b8d79c0e 100644
> > --- a/arch/x86/kernel/fpu/signal.c
> > +++ b/arch/x86/kernel/fpu/signal.c
> > @@ -337,6 +337,8 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
> >          */
> >         fpregs_lock();
> >         if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
> > +               trace_printk("!NEED_FPU_LOAD, size: %d, supervisor: 0x%llx\n",
> > +                            size, xfeatures_mask_supervisor());
> >                 if (xfeatures_mask_supervisor())
> >                         copy_xregs_to_kernel(&fpu->state.xsave);
> >                 set_thread_flag(TIF_NEED_FPU_LOAD);
> > 
> > and traced a fairly boring kernel build workload where the kernel
> > .config is not even a distro one but a tailored for this machine.
> > 
> > Which means, it took 3m35.058s to build and the trace buffer had 53973
> > entries like this one:
> > 
> > bash-1211  [002] ...1   648.238585: __fpu__restore_sig: !NEED_FPU_LOAD, size: 1092, supervisor: 0x0
> > 
> > which means I have
> > 
> > 53973 / (3*60 + 35) =~ 251 XSAVES invocations per second!
> > 
> > And this only during this single workload - I don't even wanna imagine
> > what that number would be if it were a huge, overloaded box with a
> > signal heavy workload.
> > 
> > And all this overhead to save 16 + 24 bytes supervisor states and throw
> > away the rest up to 960 bytes each time.
> > 
> > Err, I don't think so.
> 
> This patch serves supervisor states that has not been saved prior to
> sigreturn.  CET state is in sigcontext and does not need to be saved here.
> 
> We can drop this for now, and for new supervisor states, replace
> copy_xregs_to_kernel() with a callback that saves only necessary
> information.
> 
> I will send out v3.

There is another way to keep this patch...

if (xfeatures_mask_supervisor()) {
	fpu->state.xsave.xfeatures &= xfeatures_mask_supervisor();
	copy_xregs_to_kernel(&fpu->state.xsave);
}

That way, all the user states are in init state and only supervisor states
are saved, and the buffer format is unchanged.

Yu-cheng


