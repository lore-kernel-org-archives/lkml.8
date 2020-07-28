Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87024C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AEA82065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgG1Ukf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:40:35 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49940 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgG1Uke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:40:34 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 074701C0BD8; Tue, 28 Jul 2020 22:40:31 +0200 (CEST)
Date:   Tue, 28 Jul 2020 22:40:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: Re: [PATCH v3 19/19] arm64: lto: Strengthen READ_ONCE() to acquire
 when CONFIG_LTO=y
Message-ID: <20200728204029.GB1012@bug>
References: <20200710165203.31284-1-will@kernel.org>
 <20200710165203.31284-20-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710165203.31284-20-will@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-07-10 17:52:03, Will Deacon wrote:
> When building with LTO, there is an increased risk of the compiler
> converting an address dependency headed by a READ_ONCE() invocation
> into a control dependency and consequently allowing for harmful
> reordering by the CPU.
> 
> Ensure that such transformations are harmless by overriding the generic
> READ_ONCE() definition with one that provides acquire semantics when
> building with LTO.

Traditionally, READ_ONCE had only effects on compiler optimalizations, not on
special semantics of the load instruction.

Do you have example how LTO optimalizations break the code?

Should some documentation be added? Because I believe users will need to understand
what is going on there. 

It is not LTO-only problem and it is not arm64-only problem, right?

Best regards,
									Pavel


> +#ifdef CONFIG_AS_HAS_LDAPR
> +#define __LOAD_RCPC(sfx, regs...)					\
> +	ALTERNATIVE(							\
> +		"ldar"	#sfx "\t" #regs,				\
> +		".arch_extension rcpc\n"				\
> +		"ldapr"	#sfx "\t" #regs,				\
> +	ARM64_HAS_LDAPR)
> +#else
> +#define __LOAD_RCPC(sfx, regs...)	"ldar" #sfx "\t" #regs
> +#endif /* CONFIG_AS_HAS_LDAPR */
> +
> +#define __READ_ONCE(x)							\
> +({									\
> +	typeof(&(x)) __x = &(x);					\
> +	int atomic = 1;							\
> +	union { __unqual_scalar_typeof(*__x) __val; char __c[1]; } __u;	\
> +	switch (sizeof(x)) {						\
> +	case 1:								\
> +		asm volatile(__LOAD_RCPC(b, %w0, %1)			\
> +			: "=r" (*(__u8 *)__u.__c)			\
> +			: "Q" (*__x) : "memory");			\
> +		break;							\
> +	case 2:								\
> +		asm volatile(__LOAD_RCPC(h, %w0, %1)			\
> +			: "=r" (*(__u16 *)__u.__c)			\
> +			: "Q" (*__x) : "memory");			\
> +		break;							\
> +	case 4:								\
> +		asm volatile(__LOAD_RCPC(, %w0, %1)			\
> +			: "=r" (*(__u32 *)__u.__c)			\
> +			: "Q" (*__x) : "memory");			\
> +		break;							\
> +	case 8:								\
> +		asm volatile(__LOAD_RCPC(, %0, %1)			\
> +			: "=r" (*(__u64 *)__u.__c)			\
> +			: "Q" (*__x) : "memory");			\
> +		break;							\
> +	default:							\
> +		atomic = 0;						\
> +	}								\
> +	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(__x))__x);\
> +})
> +
> +#endif	/* !BUILD_VDSO */
> +#endif	/* CONFIG_LTO */
> +
> +#include <asm-generic/rwonce.h>
> +
> +#endif	/* __ASM_RWONCE_H */
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 45d5cfe46429..60df97f2e7de 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -28,7 +28,7 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv	\
>  	     $(btildflags-y) -T
>  
>  ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
> -ccflags-y += -DDISABLE_BRANCH_PROFILING
> +ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
>  
>  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS)
>  KBUILD_CFLAGS			+= $(DISABLE_LTO)
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index d88148bef6b0..4fdf3754a058 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -43,7 +43,7 @@ cc32-as-instr = $(call try-run,\
>  # As a result we set our own flags here.
>  
>  # KBUILD_CPPFLAGS and NOSTDINC_FLAGS from top-level Makefile
> -VDSO_CPPFLAGS := -D__KERNEL__ -nostdinc -isystem $(shell $(CC_COMPAT) -print-file-name=include)
> +VDSO_CPPFLAGS := -DBUILD_VDSO -D__KERNEL__ -nostdinc -isystem $(shell $(CC_COMPAT) -print-file-name=include)
>  VDSO_CPPFLAGS += $(LINUXINCLUDE)
>  
>  # Common C and assembly flags
> -- 
> 2.27.0.383.g050319c2ae-goog

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
