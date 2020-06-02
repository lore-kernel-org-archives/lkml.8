Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E19C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8BC206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="B3oreK4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgFBKL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 06:11:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53312 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgFBKL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 06:11:27 -0400
Received: from zn.tnic (p200300ec2f0bbb00c19a54a9b37b354f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bb00:c19a:54a9:b37b:354f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FD0A1EC0347;
        Tue,  2 Jun 2020 12:11:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591092684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=E9T/HabNgVix0HGmzgMiiCCUQS+zo6hmepO7JaKWrB8=;
        b=B3oreK4ONPoAH+ECjzrZLiPMmiIDCPDgKODo+BDRNvk1nM8whW54/wBSsjxsvoT867MdjO
        4bCaZoCY5HqhxFPLugPztbwxbS2A4SrCZKjiiZTuhoeUcFCcYVAYcg/crUErvPRPTWdw3j
        ctLETx1BECpsFSk4NV3or/tfwEv6Lic=
Date:   Tue, 2 Jun 2020 12:11:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Petteri Aimonen <jpa@git.mail.kapsi.fi>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] arch/x86: reset MXCSR to default in kernel_fpu_begin()
Message-ID: <20200602101119.GA11634@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching to mail where patches are discussed.

> Subject: [PATCH] arch/x86: reset MXCSR to default in kernel_fpu_begin()

Fix formatting to:

Subject: [PATCH] x86/fpu: Reset MXCSR to default in kernel_fpu_begin()

> From: Petteri Aimonen <jpa@git.mail.kapsi.fi>
> 
> Previously kernel floating point code would run with the control
> register value last set by userland code. This could affect calculation
> results or cause floating point exceptions, leading to a crash.

Please expand that paragraph here as you have it in the bugzilla so that
it is clear in the future how that can happen.

> This commit also adds a selftest for the usage of FPU code in kernel

s/This commit adds/Add/

> mode and a new FPU_CFLAGS variable in Makefile for building code that
> uses floating point.
> 
> Currently only implemented for x86 (32 and 64-bit). In future kernel FPU
> usage could be unified between the different architectures supporting it.
> 
> Signed-off-by: Petteri Aimonen <jpa@git.mail.kapsi.fi>

Add here:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=207979

> ---
>  arch/x86/Makefile                      |  16 ++++
>  arch/x86/include/asm/fpu/internal.h    |   5 ++
>  arch/x86/kernel/fpu/core.c             |   1 +
>  lib/Kconfig.debug                      |  10 +++
>  lib/Makefile                           |   5 ++
>  lib/test_fpu.c                         | 104 +++++++++++++++++++++++++
>  tools/testing/selftests/x86/Makefile   |   4 +-
>  tools/testing/selftests/x86/test_fpu.c |  56 +++++++++++++
>  8 files changed, 200 insertions(+), 1 deletion(-)
>  create mode 100644 lib/test_fpu.c
>  create mode 100644 tools/testing/selftests/x86/test_fpu.c
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index b65ec63c7..be35e240a 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -149,6 +149,22 @@ ifdef CONFIG_X86_X32
>  endif
>  export CONFIG_X86_X32_ABI
>  
> +#
> +# CFLAGS for compiling floating point code inside the kernel
> +#
> +FPU_CFLAGS += -mhard-float -msse
> +ifdef CONFIG_CC_IS_GCC
> +  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> +    # Stack alignment mismatch, proceed with caution.
> +    # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> +    # (8B stack alignment).
> +    FPU_CFLAGS += -mpreferred-stack-boundary=4
> +  else
> +    FPU_CFLAGS += -msse2
> +  endif
> +endif
> +export FPU_CFLAGS

Ok, thanks for this. Here's what I think you should do but I'm open to
better ideas:

Instead of adding that kernel module which is x86-specific
to a generic lib/ directory, it should be in, say,
tools/testing/selftests/x86/test_fpu_module.c or so and instead of
reading /proc/sys/debug/test_fpu, the user portion of the code would
simply modprobe it.

Upon load, the module would simply execute its test_fpu() function and
that's it. The user side could then test the modprobe result. And rmmod.
Rinse and repeat for the next test.

But maybe others think the proc fs file is better. Adding Andy who likes
to play with selftests. In any case, the file should not be in /proc but
in debugfs.

What is also missing is the user portion doing ldmxcsr before running
the test and the test should be causing at least one exception which
MXCSR masks off.

Perhaps then having a debugfs to control the module might make more
sense... just thinking out loud here.

Leaving in the rest for the others to see.

Thx.

>  #
>  # If the function graph tracer is used with mcount instead of fentry,
>  # '-maccumulate-outgoing-args' is needed to prevent a GCC bug
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 44c48e34d..00eac7f15 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -619,6 +619,11 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
>   * MXCSR and XCR definitions:
>   */
>  
> +static inline void ldmxcsr(u32 mxcsr)
> +{
> +	asm volatile("ldmxcsr %0" :: "m" (mxcsr));
> +}
> +
>  extern unsigned int mxcsr_feature_mask;
>  
>  #define XCR_XFEATURE_ENABLED_MASK	0x00000000
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 12c708409..8d660890b 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -101,6 +101,7 @@ void kernel_fpu_begin(void)
>  		copy_fpregs_to_fpstate(&current->thread.fpu);
>  	}
>  	__cpu_invalidate_fpregs_state();
> +	ldmxcsr(MXCSR_DEFAULT);
>  }
>  EXPORT_SYMBOL_GPL(kernel_fpu_begin);
>  
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 21d9c5f6e..f3989c43c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2201,6 +2201,16 @@ config TEST_MEMINIT
>  
>  	  If unsure, say N.
>  
> +config TEST_FPU
> +	tristate "Test floating point operations inside kernel"

s/inside kernel/in kernel space/

or so.

> +	depends on X86
> +	help
> +	  Enable this option to add /proc/sys/debug/test_fpu which will trigger
> +	  a sequence of floating point operations. This is used for self-testing
> +	  floating point control register setting in kernel_fpu_begin().
> +
> +	  If unsure, say N.
> +
>  endif # RUNTIME_TESTING_MENU
>  
>  config MEMTEST
> diff --git a/lib/Makefile b/lib/Makefile
> index 685aee60d..94b0373d2 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -93,6 +93,11 @@ obj-$(CONFIG_TEST_BLACKHOLE_DEV) += test_blackhole_dev.o
>  obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
>  obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
>  
> +ifdef FPU_CFLAGS
> +obj-$(CONFIG_TEST_FPU) += test_fpu.o
> +CFLAGS_test_fpu.o += $(FPU_CFLAGS)
> +endif
> +
>  obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
>  
>  obj-$(CONFIG_KUNIT) += kunit/
> diff --git a/lib/test_fpu.c b/lib/test_fpu.c
> new file mode 100644
> index 000000000..4aaf1d711
> --- /dev/null
> +++ b/lib/test_fpu.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Test cases for using floating point operations inside a kernel module.
> + * This tests kernel_fpu_begin() and kernel_fpu_end() functions, especially
> + * when userland has modified the floating point control registers.
> + *
> + * To facilitate the test, this module registers file /proc/sys/debug/test_fpu,
> + * which when read causes a sequence of floating point operations. If the
> + * operations fail, either the read returns error status or the kernel crashes.
> + * If the operations succeed, the read returns 0 bytes.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <asm/fpu/api.h>
> +
> +static int test_fpu(void)
> +{
> +	/* This sequence of operations tests that rounding mode is
> +	 * to nearest and that denormal numbers are supported.
> +	 * Volatile variables are used to avoid compiler optimizing
> +	 * the calculations away.
> +	 */
> +	volatile double a, b, c, d, e, f, g;
> +
> +	a = 4.0;
> +	b = 1e-15;
> +	c = 1e-310;
> +	d = a + b;     /* Sets precision flag */
> +	e = a + b / 2; /* Result depends on rounding mode */
> +	f = b / c;     /* Denormal and very large values */
> +	g = a + c * f; /* Depends on denormal support */
> +
> +	if (d > a && e > a && g > a)
> +		return 0;
> +	else
> +		return -EINVAL;
> +}
> +
> +static int test_fpu_sysctl(struct ctl_table *ctl, int write,
> +                           void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int status = -EINVAL;
> +
> +	kernel_fpu_begin();
> +	status = test_fpu();
> +	kernel_fpu_end();
> +
> +	*lenp = 0;
> +	return status;
> +}
> +
> +static struct ctl_table test_fpu_table[] = {
> +	{
> +		.procname       = "test_fpu",
> +		.data           = NULL,
> +		.maxlen         = 0,
> +		.mode           = 0444,
> +		.proc_handler   = test_fpu_sysctl,
> +	},
> +	{ }
> +};
> +
> +static struct ctl_table test_fpu_root_table[] = {
> +	{
> +		.procname       = "debug",
> +		.maxlen         = 0,
> +		.mode           = 0555,
> +		.child          = test_fpu_table,
> +	},
> +	{ }
> +};
> +
> +static struct ctl_table_header *test_fpu_header;
> +
> +static int __init test_fpu_init(void)
> +{
> +	int status = -EINVAL;
> +
> +	test_fpu_header = register_sysctl_table(test_fpu_root_table);
> +	if (!test_fpu_header)
> +		return -ENOMEM;
> +
> +	/* FPU operations are tested both during the module loader and
> +	 * later from syscalls.
> +     */
> +	kernel_fpu_begin();
> +	status = test_fpu();
> +	kernel_fpu_end();
> +
> +	return status;
> +}
> +
> +
> +static void __exit test_fpu_exit(void)
> +{
> +	if (test_fpu_header)
> +		unregister_sysctl_table(test_fpu_header);
> +}
> +
> +module_init(test_fpu_init);
> +module_exit(test_fpu_exit);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index 5d49bfec1..e1992fb0c 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -12,7 +12,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
>  
>  TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
>  			check_initial_reg_state sigreturn iopl ioperm \
> -			protection_keys test_vdso test_vsyscall mov_ss_trap \
> +			protection_keys test_fpu test_vdso test_vsyscall mov_ss_trap \
>  			syscall_arg_fault
>  TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
>  			test_FCMOV test_FCOMI test_FISTTP \
> @@ -98,6 +98,8 @@ endif
>  $(OUTPUT)/sysret_ss_attrs_64: thunks.S
>  $(OUTPUT)/ptrace_syscall_32: raw_syscall_helper_32.S
>  $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
> +$(OUTPUT)/test_fpu_64: -lm
> +$(OUTPUT)/test_fpu_32: -lm
>  
>  # check_initial_reg_state is special: it needs a custom entry, and it
>  # needs to be static so that its interpreter doesn't destroy its initial
> diff --git a/tools/testing/selftests/x86/test_fpu.c b/tools/testing/selftests/x86/test_fpu.c
> new file mode 100644
> index 000000000..4c564f268
> --- /dev/null
> +++ b/tools/testing/selftests/x86/test_fpu.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* This testcase operates with the test_fpu kernel driver.
> + * It modifies the FPU control register in user mode and calls the kernel
> + * module to perform floating point operations in the kernel. The control
> + * register value should be independent between kernel and user mode.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <fenv.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +
> +int main(void)
> +{
> +	char dummy[1];
> +	int fd = open("/proc/sys/debug/test_fpu", O_RDONLY);
> +
> +	if (fd < 0)	{
> +		printf("[SKIP]\ttest_fpu kernel module missing\n");
> +		return 0;
> +	}
> +
> +	if (read(fd, dummy, 1) != 0) {
> +		printf("[FAIL]\taccess with default rounding mode failed\n");
> +		return 1;
> +	}
> +
> +	fesetround(FE_DOWNWARD);
> +	if (read(fd, dummy, 1) != 0) {
> +		printf("[FAIL]\taccess with downward rounding mode failed\n");
> +		return 2;
> +	}
> +	if (fegetround() != FE_DOWNWARD) {
> +		printf("[FAIL]\tusermode rounding mode clobbered\n");
> +		return 3;
> +	}
> +
> +	/* Note: the tests up to this point are quite safe and will only return
> +	 * an error. But the exception mask setting can cause misbehaving kernel
> +	 * to crash.
> +	 */
> +	feclearexcept(FE_ALL_EXCEPT);
> +	feenableexcept(FE_ALL_EXCEPT);
> +	if (read(fd, dummy, 1) != 0) {
> +		printf("[FAIL]\taccess with fpu exceptions unmasked failed\n");
> +		return 4;
> +	}
> +	if (fegetexcept() != FE_ALL_EXCEPT) {
> +		printf("[FAIL]\tusermode fpu exception mask clobbered\n");
> +		return 5;
> +	}
> +
> +	printf("[OK]\ttest_fpu\n");
> +	return 0;
> +}
> -- 
> 2.25.1


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
