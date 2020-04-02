Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E7FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE732072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbgDBJgg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:36:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36764 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBJgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:36:36 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJwGv-0000jL-VM; Thu, 02 Apr 2020 11:36:26 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E6FF1100D52; Thu,  2 Apr 2020 11:36:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jann Horn <jannh@google.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2 without any visible FPU state protection
In-Reply-To: <CAG48ez1nHt2BRApHPp2S6rd4kr3P2kFsgHvStUsW7rqHSJprgg@mail.gmail.com>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com> <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com> <CAG48ez1nHt2BRApHPp2S6rd4kr3P2kFsgHvStUsW7rqHSJprgg@mail.gmail.com>
Date:   Thu, 02 Apr 2020 11:36:24 +0200
Message-ID: <87k12yns9z.fsf@nanos.tec.linutronix.de>
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

Jann Horn <jannh@google.com> writes:
> On Thu, Apr 2, 2020 at 9:34 AM Christian König <christian.koenig@amd.com> wrote:
>> Am 02.04.20 um 04:34 schrieb Jann Horn:
>> > [x86 folks in CC so that they can chime in on the precise rules for
>> > this stuff]

They are pretty simple.

Any code using FPU needs to be completely isolated from regular code
either by using inline asm or by moving it to a different compilation
unit. The invocations need fpu_begin/end() of course.

>> > I noticed that several makefiles under drivers/gpu/drm/amd/display/dc/
>> > turn on floating-point instructions in the compiler flags
>> > (-mhard-float, -msse and -msse2) in order to make the "float" and
>> > "double" types usable from C code without requiring helper functions.
>> >
>> > However, as far as I know, code running in normal kernel context isn't
>> > allowed to use floating-point registers without special protection
>> > using helpers like kernel_fpu_begin() and kernel_fpu_end() (which also
>> > require that the protected code never blocks). If you violate that
>> > rule, that can lead to various issues - among other things, I think
>> > the kernel will clobber userspace FPU register state, and I think the
>> > kernel code can blow up if a context switch happens at the wrong time,
>> > since in-kernel task switches don't preserve FPU state.
>> >
>> > Is there some hidden trick I'm missing that makes it okay to use FPU
>> > registers here?
>> >
>> > I would try testing this, but unfortunately none of the AMD devices I
>> > have here have the appropriate graphics hardware...
>>
>> yes, using the floating point calculations in the display code has been
>> a source of numerous problems and confusion in the past.
>>
>> The calls to kernel_fpu_begin() and kernel_fpu_end() are hidden behind
>> the DC_FP_START() and DC_FP_END() macros which are supposed to hide the
>> architecture depend handling for x86 and PPC64.
>
> Hmm... but as far as I can tell, you're using those macros from inside
> functions that are already compiled with the FPU on:
>
>  - drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c uses the macros,
> but is already compiled with calcs_ccflags
>  - drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c uses the
> macros, but is already compiled with "-mhard-float -msse -msse2"
>  - drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c uses the
> macros, but is already compiled with "-mhard-float -msse -msse2"
>
> AFAIK as soon as you enter any function in any file compiled with FPU
> instructions, you may encounter SSE instructions, e.g. via things like
> compiler-generated memory-zeroing code - not just when you're actually
> using doubles or floats.

That's correct and this will silently cause FPU state corruption ...

We really need objtool support to validate that.

Peter, now that we know how to do it (noinstr, clac/stac) we can emit
annotations (see patch below) and validate that any FPU instruction is
inside a safe region. Hmm?

Thanks,

        tglx

8<---------------
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -19,8 +19,27 @@
  * If you intend to use the FPU in softirq you need to check first with
  * irq_fpu_usable() if it is possible.
  */
-extern void kernel_fpu_begin(void);
-extern void kernel_fpu_end(void);
+extern void __kernel_fpu_begin(void);
+extern void __kernel_fpu_end(void);
+
+static inline void kernel_fpu_begin(void)
+{
+	asm volatile("%c0:\n\t"
+		     ".pushsection .discard.fpu_begin\n\t"
+		     ".long %c0b - .\n\t"
+		     ".popsection\n\t" : : "i" (__COUNTER__));
+	__kernel_fpu_begin();
+}
+
+static inline void kernel_fpu_end(void)
+{
+	__kernel_fpu_end();
+	asm volatile("%c0:\n\t"
+		     ".pushsection .discard.fpu_end\n\t"
+		     ".long %c0b - .\n\t"
+		     ".popsection\n\t" : : "i" (__COUNTER__));
+}
+
 extern bool irq_fpu_usable(void);
 extern void fpregs_mark_activate(void);
 
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -82,7 +82,7 @@ bool irq_fpu_usable(void)
 }
 EXPORT_SYMBOL(irq_fpu_usable);
 
-void kernel_fpu_begin(void)
+void __kernel_fpu_begin(void)
 {
 	preempt_disable();
 
@@ -102,16 +102,16 @@ void kernel_fpu_begin(void)
 	}
 	__cpu_invalidate_fpregs_state();
 }
-EXPORT_SYMBOL_GPL(kernel_fpu_begin);
+EXPORT_SYMBOL_GPL(__kernel_fpu_begin);
 
-void kernel_fpu_end(void)
+void __kernel_fpu_end(void)
 {
 	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
 
 	this_cpu_write(in_kernel_fpu, false);
 	preempt_enable();
 }
-EXPORT_SYMBOL_GPL(kernel_fpu_end);
+EXPORT_SYMBOL_GPL(__kernel_fpu_end);
 
 /*
  * Save the FPU state (mark it for reload if necessary):



