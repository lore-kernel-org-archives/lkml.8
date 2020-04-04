Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B8BC2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 21:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475FF206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 21:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586034973;
	bh=3py+rr0AmqRVqiWoFCB/Dhhhx5SI71guQ1FdTW+0/lg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VEpp5GhhK/F0Tf/IkZjo+kDsfTGnrCg5YzpJJV1wy4Rz4mT/mZq4zaT4ClmvfVt7E
	 uCuW8+zGq+cqKW+7kZd8K5L/wXWfW7NxH4xTw/0I5gwrGQpCOmCNCOxeXZz1gRCDAC
	 fgG9U2mDqyfUAFifY5ofWWrwXQMY5KO/AhJQek+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDDVQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 17:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgDDVQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 17:16:11 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C29C32071C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Apr 2020 21:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586034971;
        bh=3py+rr0AmqRVqiWoFCB/Dhhhx5SI71guQ1FdTW+0/lg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KfEmvXQpyG1+PTeXFH7luU7pgfP3ac3VFy/bvFGcF6D8l7S0QWaMiTUQty4ky/hoU
         bLUoo8zEUziEKxgTfrgmPmuy/p6yKHJSJVT1GJNIdCTa9Pr4zhmrGIxMk/voWFx+Yf
         o68i16Kbb7PudeexaP0H/R3VdqxJpsqMc0tIDJ7o=
Received: by mail-wr1-f47.google.com with SMTP id j17so12748415wru.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 14:16:10 -0700 (PDT)
X-Gm-Message-State: AGi0PuaonSSgYZ/gyPrDQ08xqyRJL3Fe4EBM1LN7hj65uIMOG7NvUOEF
        HQ7gdLNyD57jyXP2JjXbw66i/f0WYAQW2c7gywhgPQ==
X-Google-Smtp-Source: APiQypLNJafEj2QFwHprZe9PeyQm2Ea1H29qnO2entnf/2t6Fgzqm8cbPVOpV+TAL+z5acmhWwLMtJ1YbIWzwHY1wkk=
X-Received: by 2002:a5d:5226:: with SMTP id i6mr4404872wra.257.1586034969151;
 Sat, 04 Apr 2020 14:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200403014026.19137-1-ricardo.neri-calderon@linux.intel.com>
 <20200403081217.GA20218@zn.tnic> <20200404052039.GA14886@ranerica-svr.sc.intel.com>
In-Reply-To: <20200404052039.GA14886@ranerica-svr.sc.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 4 Apr 2020 14:15:57 -0700
X-Gmail-Original-Message-ID: <CALCETrXegOiQ3+dVNbmbR9ECXVJL2cgCc87gRqMKA+pHOAkcQA@mail.gmail.com>
Message-ID: <CALCETrXegOiQ3+dVNbmbR9ECXVJL2cgCc87gRqMKA+pHOAkcQA@mail.gmail.com>
Subject: Re: [PATCH] x86/cpufeatures: Add enumeration for serialize instruction
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri@intel.com>, X86 ML <x86@kernel.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 10:19 PM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Fri, Apr 03, 2020 at 10:12:17AM +0200, Borislav Petkov wrote:
> > On Thu, Apr 02, 2020 at 06:40:26PM -0700, Ricardo Neri wrote:
> > > The serialize instruction ensures that before the next instruction is
> > > fetched and executed, all the modifications to flags, registers, and memory
> > > made by previous instructions are completed, draining all buffered writes
> > > to memory.
> > >
> > > Importantly, the serialize instruction does not modify registers,
> > > arithmetic flags or memory.
> > >
> > > Hence, the serialize instructions provides a better way for software
> > > to serialize execution than using instructions such as cpuid, which does
> > > modify registers and, in virtual machines, causes a VM exit.
> > >
> > > This instruction is supported by the CPU if CPUID.7H.EDX[bit 14] is
> > > set.
> > >
> > > Cc: x86@kernel.org
> > > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > ---
> > > This new instruction is documented in the latest version of the Intel
> > > Architecture Instruction Set Extensions and Future Features Programming
> > > Reference Chapter 2.1 located at
> > > https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
> > > ---
> > >  arch/x86/include/asm/cpufeatures.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > > index db189945e9b0..cd9b1ec022ec 100644
> > > --- a/arch/x86/include/asm/cpufeatures.h
> > > +++ b/arch/x86/include/asm/cpufeatures.h
> > > @@ -364,6 +364,7 @@
> > >  #define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
> > >  #define X86_FEATURE_MD_CLEAR               (18*32+10) /* VERW clears CPU buffers */
> > >  #define X86_FEATURE_TSX_FORCE_ABORT        (18*32+13) /* "" TSX_FORCE_ABORT */
> > > +#define X86_FEATURE_SERIALIZE              (18*32+14) /* SERIALIZE instruction */
> > >  #define X86_FEATURE_PCONFIG                (18*32+18) /* Intel PCONFIG */
> > >  #define X86_FEATURE_SPEC_CTRL              (18*32+26) /* "" Speculation Control (IBRS + IBPB) */
> > >  #define X86_FEATURE_INTEL_STIBP            (18*32+27) /* "" Single Thread Indirect Branch Predictors */
> > > --
> >
> > Send this together with code which is using it, pls.
>
> Do you mean code in the kernel using this instructions. Thus far, I
> don't have any kernel use cases for this instruction. My intention is to expose
> this instruction to user space via /proc/cpuinfo. Is that not
> acceptable?

Presumably sync_core() should do, roughly:

if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
  asm volatile("serialize");
  return;
}

but with the appropriate magic to build it on older binutils.  And you
should make sure that the in-kernel instruction decoder doesn't
explode when it sees serialize, presumably.
