Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6349BC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4457A2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgCYNVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:21:33 -0400
Received: from foss.arm.com ([217.140.110.172]:48312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgCYNVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:21:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E442B31B;
        Wed, 25 Mar 2020 06:21:31 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6D813F71F;
        Wed, 25 Mar 2020 06:21:29 -0700 (PDT)
Date:   Wed, 25 Mar 2020 13:21:27 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: entry: Enable random_kstack_offset support
Message-ID: <20200325132127.GB12236@lakrids.cambridge.arm.com>
References: <20200324203231.64324-1-keescook@chromium.org>
 <20200324203231.64324-6-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324203231.64324-6-keescook@chromium.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 01:32:31PM -0700, Kees Cook wrote:
> Allow for a randomized stack offset on a per-syscall basis, with roughly
> 5 bits of entropy.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Just to check, do you have an idea of the impact on arm64? Patch 3 had
figures for x86 where it reads the TSC, and it's unclear to me how
get_random_int() compares to that.

Otherwise, this looks sound to me; I'd jsut like to know whether the
overhead is in the same ballpark.

Thanks
Mark.

> ---
>  arch/arm64/Kconfig          |  1 +
>  arch/arm64/kernel/syscall.c | 10 ++++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0b30e884e088..4d5aa4959f72 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -127,6 +127,7 @@ config ARM64
>  	select HAVE_ARCH_MMAP_RND_BITS
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>  	select HAVE_ARCH_PREL32_RELOCATIONS
> +	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_STACKLEAK
>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index a12c0c88d345..238dbd753b44 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -5,6 +5,7 @@
>  #include <linux/errno.h>
>  #include <linux/nospec.h>
>  #include <linux/ptrace.h>
> +#include <linux/randomize_kstack.h>
>  #include <linux/syscalls.h>
>  
>  #include <asm/daifflags.h>
> @@ -42,6 +43,8 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  {
>  	long ret;
>  
> +	add_random_kstack_offset();
> +
>  	if (scno < sc_nr) {
>  		syscall_fn_t syscall_fn;
>  		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
> @@ -51,6 +54,13 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  	}
>  
>  	regs->regs[0] = ret;
> +
> +	/*
> +	 * Since the compiler chooses a 4 bit alignment for the stack,
> +	 * let's save one additional bit (9 total), which gets us up
> +	 * near 5 bits of entropy.
> +	 */
> +	choose_random_kstack_offset(get_random_int() & 0x1FF);
>  }
>  
>  static inline bool has_syscall_work(unsigned long flags)
> -- 
> 2.20.1
> 
