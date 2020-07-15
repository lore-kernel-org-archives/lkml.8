Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AFEC433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFE820657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594801672;
	bh=qGb0YPwemNdz/a7HEDVtuPhoJwQFsspP4paClTm11fQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=C0sqH6dCwligQQ9FAXqMlNEmH0QY1ZboaLqyuLWAYkK+SJhDAnUpqoFozpABg2tIL
	 gESJaFu2p/Mk97idkRGHjfwrNPnLNNc/7kPhep95t7Y5zwyt9P5T9LC7qL05fhD1Wc
	 EjN0PFt+NPSlAJ2P8I11pdQC2RUcKq36EhyUdiKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgGOI1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgGOI1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:27:46 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B24BC206D5;
        Wed, 15 Jul 2020 08:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594801665;
        bh=qGb0YPwemNdz/a7HEDVtuPhoJwQFsspP4paClTm11fQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ncwm3q4tsI1/f2ZO8r9V+Hj+XAonXZp3IyfdE9+UjSMNG9PMt6+7R98W0cxec7iKb
         vgNIhxA9sadskAYqzAAUQT9xCY8SHU1ZC3dtG52sroPSnLoU/EmtvgkVFfyRYHDOiT
         De9ah3Lz8fVdTUx2nukJuXaTvy2+0j4tmS2hWl/E=
Date:   Wed, 15 Jul 2020 17:27:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Babu Moger <Babu.Moger@amd.com>,
        Omar Sandoval <osandov@fb.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Marco Elver <elver@google.com>,
        Brian Gerst <brgerst@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] kprobes: Add text_alloc() and text_free()
Message-Id: <20200715172732.35110a4e53e84fcec9aeac83@kernel.org>
In-Reply-To: <20200714223239.1543716-2-jarkko.sakkinen@linux.intel.com>
References: <20200714223239.1543716-1-jarkko.sakkinen@linux.intel.com>
        <20200714223239.1543716-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On Wed, 15 Jul 2020 01:32:27 +0300
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> Introduce new API for allocating space for code generaed at run-time
> leveraging from module_alloc() and module_memfree() code. Use this to
> perform memory allocations in the kprobes code in order to loose the
> bound between kprobes and modules subsystem.
> 
> Initially, use this API only with arch/x86 and define a new config
> flag CONFIG_ARCH_HAS_TEXT_ALLOC to promote the availability of the
> new API.

This might need to be extended for the text_alloc() flags as we discuss
in previous thread. (e.g. bpf on arm64)

> Cc: Andi Kleen <ak@linux.intel.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  arch/Kconfig             |  2 +-
>  arch/x86/Kconfig         |  3 ++
>  arch/x86/kernel/Makefile |  1 +
>  arch/x86/kernel/module.c | 49 ---------------------------
>  arch/x86/kernel/text.c   | 71 ++++++++++++++++++++++++++++++++++++++++

I think this would better be arch/x86/mm/text_alloc.c (text.c is too
generic, and this only provides memory allocation.)

>  include/linux/text.h     | 17 ++++++++++

"text_alloc.h" would be better, or puting the prototype in vmalloc.h
will be easier to use.

>  kernel/kprobes.c         | 11 +++++++
>  kernel/module.c          | 10 ++++++
>  8 files changed, 114 insertions(+), 50 deletions(-)
>  create mode 100644 arch/x86/kernel/text.c
>  create mode 100644 include/linux/text.h
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8cc35dc556c7..e3d6b6868ccb 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -61,7 +61,7 @@ config OPROFILE_NMI_TIMER
>  
>  config KPROBES
>  	bool "Kprobes"
> -	depends on MODULES
> +	depends on MODULES || ARCH_HAS_TEXT_ALLOC
>  	depends on HAVE_KPROBES
>  	select KALLSYMS
>  	help
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0dea7fdd7a00..a4ee5d1300f6 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2035,6 +2035,9 @@ config KEXEC_FILE
>  config ARCH_HAS_KEXEC_PURGATORY
>  	def_bool KEXEC_FILE
>  
> +config ARCH_HAS_TEXT_ALLOC
> +	def_bool y
> +
>  config KEXEC_SIG
>  	bool "Verify kernel signature during kexec_file_load() syscall"
>  	depends on KEXEC_FILE
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index e77261db2391..2878e4b753a0 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -68,6 +68,7 @@ obj-y			+= tsc.o tsc_msr.o io_delay.o rtc.o
>  obj-y			+= pci-iommu_table.o
>  obj-y			+= resource.o
>  obj-y			+= irqflags.o
> +obj-y			+= text.o
>  
>  obj-y				+= process.o
>  obj-y				+= fpu/
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index 34b153cbd4ac..261df078f127 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -36,55 +36,6 @@ do {							\
>  } while (0)
>  #endif
>  
> -#ifdef CONFIG_RANDOMIZE_BASE
> -static unsigned long module_load_offset;
> -
> -/* Mutex protects the module_load_offset. */
> -static DEFINE_MUTEX(module_kaslr_mutex);
> -
> -static unsigned long int get_module_load_offset(void)
> -{
> -	if (kaslr_enabled()) {
> -		mutex_lock(&module_kaslr_mutex);
> -		/*
> -		 * Calculate the module_load_offset the first time this
> -		 * code is called. Once calculated it stays the same until
> -		 * reboot.
> -		 */
> -		if (module_load_offset == 0)
> -			module_load_offset =
> -				(get_random_int() % 1024 + 1) * PAGE_SIZE;
> -		mutex_unlock(&module_kaslr_mutex);
> -	}
> -	return module_load_offset;
> -}
> -#else
> -static unsigned long int get_module_load_offset(void)
> -{
> -	return 0;
> -}
> -#endif
> -
> -void *module_alloc(unsigned long size)
> -{
> -	void *p;
> -
> -	if (PAGE_ALIGN(size) > MODULES_LEN)
> -		return NULL;
> -
> -	p = __vmalloc_node_range(size, MODULE_ALIGN,
> -				    MODULES_VADDR + get_module_load_offset(),
> -				    MODULES_END, GFP_KERNEL,
> -				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> -				    __builtin_return_address(0));
> -	if (p && (kasan_module_alloc(p, size) < 0)) {
> -		vfree(p);
> -		return NULL;
> -	}
> -
> -	return p;
> -}

Please don't touch this module_alloc() at all. Then we can
just call __vmalloc_node_range() in the text_alloc().

> -
>  #ifdef CONFIG_X86_32
>  int apply_relocate(Elf32_Shdr *sechdrs,
>  		   const char *strtab,
> diff --git a/arch/x86/kernel/text.c b/arch/x86/kernel/text.c
> new file mode 100644
> index 000000000000..986b92ff1434
> --- /dev/null
> +++ b/arch/x86/kernel/text.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  Kernel module help for x86.
> + *  Copyright (C) 2001 Rusty Russell.
> + */
> +
> +#include <linux/kasan.h>
> +#include <linux/mm.h>
> +#include <linux/moduleloader.h>
> +#include <linux/vmalloc.h>
> +#include <asm/setup.h>
> +
> +#ifdef CONFIG_RANDOMIZE_BASE
> +static unsigned long module_load_offset;
> +
> +/* Mutex protects the module_load_offset. */
> +static DEFINE_MUTEX(module_kaslr_mutex);
> +
> +static unsigned long get_module_load_offset(void)
> +{
> +	if (kaslr_enabled()) {
> +		mutex_lock(&module_kaslr_mutex);
> +		/*
> +		 * Calculate the module_load_offset the first time this
> +		 * code is called. Once calculated it stays the same until
> +		 * reboot.
> +		 */
> +		if (module_load_offset == 0)
> +			module_load_offset =
> +				(get_random_int() % 1024 + 1) * PAGE_SIZE;
> +		mutex_unlock(&module_kaslr_mutex);
> +	}
> +	return module_load_offset;
> +}
> +#else
> +static unsigned long get_module_load_offset(void)
> +{
> +	return 0;
> +}
> +#endif

So as I pointed, we can ignore this for kprobes (and other
dynamic allocated trampoline code).

> +
> +void *text_alloc(unsigned long size)
> +{
> +	void *p;
> +
> +	if (PAGE_ALIGN(size) > MODULES_LEN)
> +		return NULL;
> +
> +	p = __vmalloc_node_range(size, MODULE_ALIGN,
> +				    MODULES_VADDR + get_module_load_offset(),
> +				    MODULES_END, GFP_KERNEL,
> +				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> +				    __builtin_return_address(0));
> +	if (p && (kasan_module_alloc(p, size) < 0)) {
> +		vfree(p);
> +		return NULL;
> +	}
> +
> +	return p;
> +}
> +
> +void text_free(void *region)
> +{
> +	/*
> +	 * This memory may be RO, and freeing RO memory in an interrupt is not
> +	 * supported by vmalloc.
> +	 */
> +	WARN_ON(in_interrupt());
> +
> +	vfree(region);
> +}
> diff --git a/include/linux/text.h b/include/linux/text.h
> new file mode 100644
> index 000000000000..a27d4a42ecda
> --- /dev/null
> +++ b/include/linux/text.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _LINUX_TEXT_H
> +#define _LINUX_TEXT_H
> +
> +/*
> + * An allocator used for allocating modules, core sections and init sections.
> + * Returns NULL on failure.
> + */
> +void *text_alloc(unsigned long size);
> +
> +/*
> + * Free memory returned from text_alloc().
> + */
> +void text_free(void *region);

Hmm, if this is this short, in this version we might better move
these to vmalloc.h.

> +
> +#endif /* _LINUX_TEXT_H */
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 2e97febeef77..fa7687eb0c0e 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -35,6 +35,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/cpu.h>
>  #include <linux/jump_label.h>
> +#include <linux/text.h>
>  
>  #include <asm/sections.h>
>  #include <asm/cacheflush.h>
> @@ -111,12 +112,20 @@ enum kprobe_slot_state {
>  
>  void __weak *alloc_insn_page(void)
>  {
> +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> +	return text_alloc(PAGE_SIZE);
> +#else
>  	return module_alloc(PAGE_SIZE);
> +#endif
>  }
>  
>  void __weak free_insn_page(void *page)
>  {
> +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> +	text_free(page);
> +#else
>  	module_memfree(page);
> +#endif
>  }
>  
>  struct kprobe_insn_cache kprobe_insn_slots = {
> @@ -1608,6 +1617,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  			goto out;
>  		}
>  
> +#ifdef CONFIG_MODULES
>  		/*
>  		 * If the module freed .init.text, we couldn't insert
>  		 * kprobes in there.
> @@ -1618,6 +1628,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  			*probed_mod = NULL;
>  			ret = -ENOENT;
>  		}
> +#endif

This change is not related to text_alloc(). Please move this to 3/3.

>  	}
>  out:
>  	preempt_enable();
> diff --git a/kernel/module.c b/kernel/module.c
> index aa183c9ac0a2..8adeb126b02c 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -56,6 +56,7 @@
>  #include <linux/bsearch.h>
>  #include <linux/dynamic_debug.h>
>  #include <linux/audit.h>
> +#include <linux/text.h>
>  #include <uapi/linux/module.h>
>  #include "module-internal.h"
>  
> @@ -2151,7 +2152,12 @@ void __weak module_memfree(void *module_region)
>  	 * supported by vmalloc.
>  	 */
>  	WARN_ON(in_interrupt());
> +
> +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> +	text_free(module_region);
> +#else
>  	vfree(module_region);
> +#endif
>  }
>  
>  void __weak module_arch_cleanup(struct module *mod)
> @@ -2786,9 +2792,13 @@ static void dynamic_debug_remove(struct module *mod, struct _ddebug *debug)
>  
>  void * __weak module_alloc(unsigned long size)
>  {
> +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> +	return text_alloc(size);
> +#else
>  	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
>  			GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
>  			NUMA_NO_NODE, __builtin_return_address(0));
> +#endif
>  }

Please don't touch kernel/module.c too. This seems to make things complicated.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
