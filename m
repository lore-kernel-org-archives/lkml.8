Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B0AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332F32076E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDGBhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:37:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:11375 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgDGBhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:37:54 -0400
IronPort-SDR: Yj5BJG+m6YRsmSGFdK86NCelNkELfM9cgZMOv5RHlXOVuQWnkc9YWNpmF6RGicjFoIiGYEgsyc
 NTn+8aiytCcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 18:37:53 -0700
IronPort-SDR: L2tZHmATMTT96PrJec6ZYFGWL2imiJ0BfM/mDixY7CjP1OvNEGVRL3993mr8iy62076UpNZQ7S
 h1aopbH8ZSDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,353,1580803200"; 
   d="scan'208";a="274934745"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 06 Apr 2020 18:37:53 -0700
Date:   Mon, 6 Apr 2020 18:38:43 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri@intel.com>, X86 ML <x86@kernel.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH] x86/cpufeatures: Add enumeration for serialize
 instruction
Message-ID: <20200407013843.GB5587@ranerica-svr.sc.intel.com>
References: <20200403014026.19137-1-ricardo.neri-calderon@linux.intel.com>
 <20200403081217.GA20218@zn.tnic>
 <20200404052039.GA14886@ranerica-svr.sc.intel.com>
 <CALCETrXegOiQ3+dVNbmbR9ECXVJL2cgCc87gRqMKA+pHOAkcQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXegOiQ3+dVNbmbR9ECXVJL2cgCc87gRqMKA+pHOAkcQA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 02:15:57PM -0700, Andy Lutomirski wrote:
> On Fri, Apr 3, 2020 at 10:19 PM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > On Fri, Apr 03, 2020 at 10:12:17AM +0200, Borislav Petkov wrote:
> > > On Thu, Apr 02, 2020 at 06:40:26PM -0700, Ricardo Neri wrote:
> > > > The serialize instruction ensures that before the next instruction is
> > > > fetched and executed, all the modifications to flags, registers, and memory
> > > > made by previous instructions are completed, draining all buffered writes
> > > > to memory.
> > > >
> > > > Importantly, the serialize instruction does not modify registers,
> > > > arithmetic flags or memory.
> > > >
> > > > Hence, the serialize instructions provides a better way for software
> > > > to serialize execution than using instructions such as cpuid, which does
> > > > modify registers and, in virtual machines, causes a VM exit.
> > > >
> > > > This instruction is supported by the CPU if CPUID.7H.EDX[bit 14] is
> > > > set.
> > > >
> > > > Cc: x86@kernel.org
> > > > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > > ---
> > > > This new instruction is documented in the latest version of the Intel
> > > > Architecture Instruction Set Extensions and Future Features Programming
> > > > Reference Chapter 2.1 located at
> > > > https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
> > > > ---
> > > >  arch/x86/include/asm/cpufeatures.h | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > > > index db189945e9b0..cd9b1ec022ec 100644
> > > > --- a/arch/x86/include/asm/cpufeatures.h
> > > > +++ b/arch/x86/include/asm/cpufeatures.h
> > > > @@ -364,6 +364,7 @@
> > > >  #define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
> > > >  #define X86_FEATURE_MD_CLEAR               (18*32+10) /* VERW clears CPU buffers */
> > > >  #define X86_FEATURE_TSX_FORCE_ABORT        (18*32+13) /* "" TSX_FORCE_ABORT */
> > > > +#define X86_FEATURE_SERIALIZE              (18*32+14) /* SERIALIZE instruction */
> > > >  #define X86_FEATURE_PCONFIG                (18*32+18) /* Intel PCONFIG */
> > > >  #define X86_FEATURE_SPEC_CTRL              (18*32+26) /* "" Speculation Control (IBRS + IBPB) */
> > > >  #define X86_FEATURE_INTEL_STIBP            (18*32+27) /* "" Single Thread Indirect Branch Predictors */
> > > > --
> > >
> > > Send this together with code which is using it, pls.
> >
> > Do you mean code in the kernel using this instructions. Thus far, I
> > don't have any kernel use cases for this instruction. My intention is to expose
> > this instruction to user space via /proc/cpuinfo. Is that not
> > acceptable?
> 
> Presumably sync_core() should do, roughly:
> 
> if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
>   asm volatile("serialize");
>   return;
> }

Sure Andy, I will look at implementing something as you propose.

> 
> but with the appropriate magic to build it on older binutils.  

But old binutils will not be aware of this new instruction, right? How
could they be impacted?

> should make sure that the in-kernel instruction decoder doesn't
> explode when it sees serialize, presumably.

Sure Andy. I will also test for this.

Thanks and BR,
Ricardo
