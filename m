Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DA1C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB6F2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgGPReE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:34:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:8310 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgGPReE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:34:04 -0400
IronPort-SDR: prXYuzaGFeHTcVC1whhMDAqFCnFNwvZLy0x4YzUr+ST3behykREDK28TQXsznCTWIH2g5+ELCY
 bZQEr64c3f6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129530697"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="129530697"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 10:33:02 -0700
IronPort-SDR: /A1swBRl2D9D4iQMPYPf3LMDW/IgGaM1OQNxeDzcYuWsWQCRDvldwa9AjpJeb3FhAJXATv0eVl
 WuIeCyDhhPQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="325206927"
Received: from unknown (HELO localhost) ([10.249.34.156])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2020 10:32:45 -0700
Date:   Thu, 16 Jul 2020 20:32:44 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
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
Message-ID: <20200716173244.GD14135@linux.intel.com>
References: <20200714223239.1543716-1-jarkko.sakkinen@linux.intel.com>
 <20200714223239.1543716-2-jarkko.sakkinen@linux.intel.com>
 <20200715172732.35110a4e53e84fcec9aeac83@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715172732.35110a4e53e84fcec9aeac83@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 05:27:32PM +0900, Masami Hiramatsu wrote:
> Hi Jarkko,
> 
> On Wed, 15 Jul 2020 01:32:27 +0300
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > Introduce new API for allocating space for code generaed at run-time
> > leveraging from module_alloc() and module_memfree() code. Use this to
> > perform memory allocations in the kprobes code in order to loose the
> > bound between kprobes and modules subsystem.
> > 
> > Initially, use this API only with arch/x86 and define a new config
> > flag CONFIG_ARCH_HAS_TEXT_ALLOC to promote the availability of the
> > new API.
> 
> This might need to be extended for the text_alloc() flags as we discuss
> in previous thread. (e.g. bpf on arm64)
> 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  arch/Kconfig             |  2 +-
> >  arch/x86/Kconfig         |  3 ++
> >  arch/x86/kernel/Makefile |  1 +
> >  arch/x86/kernel/module.c | 49 ---------------------------
> >  arch/x86/kernel/text.c   | 71 ++++++++++++++++++++++++++++++++++++++++
> 
> I think this would better be arch/x86/mm/text_alloc.c (text.c is too
> generic, and this only provides memory allocation.)

Agreed.

> 
> >  include/linux/text.h     | 17 ++++++++++
> 
> "text_alloc.h" would be better, or puting the prototype in vmalloc.h
> will be easier to use.
> 
> >  kernel/kprobes.c         | 11 +++++++
> >  kernel/module.c          | 10 ++++++
> >  8 files changed, 114 insertions(+), 50 deletions(-)
> >  create mode 100644 arch/x86/kernel/text.c
> >  create mode 100644 include/linux/text.h
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 8cc35dc556c7..e3d6b6868ccb 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -61,7 +61,7 @@ config OPROFILE_NMI_TIMER
> >  
> >  config KPROBES
> >  	bool "Kprobes"
> > -	depends on MODULES
> > +	depends on MODULES || ARCH_HAS_TEXT_ALLOC
> >  	depends on HAVE_KPROBES
> >  	select KALLSYMS
> >  	help
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 0dea7fdd7a00..a4ee5d1300f6 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2035,6 +2035,9 @@ config KEXEC_FILE
> >  config ARCH_HAS_KEXEC_PURGATORY
> >  	def_bool KEXEC_FILE
> >  
> > +config ARCH_HAS_TEXT_ALLOC
> > +	def_bool y
> > +
> >  config KEXEC_SIG
> >  	bool "Verify kernel signature during kexec_file_load() syscall"
> >  	depends on KEXEC_FILE
> > diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> > index e77261db2391..2878e4b753a0 100644
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -68,6 +68,7 @@ obj-y			+= tsc.o tsc_msr.o io_delay.o rtc.o
> >  obj-y			+= pci-iommu_table.o
> >  obj-y			+= resource.o
> >  obj-y			+= irqflags.o
> > +obj-y			+= text.o
> >  
> >  obj-y				+= process.o
> >  obj-y				+= fpu/
> > diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> > index 34b153cbd4ac..261df078f127 100644
> > --- a/arch/x86/kernel/module.c
> > +++ b/arch/x86/kernel/module.c
> > @@ -36,55 +36,6 @@ do {							\
> >  } while (0)
> >  #endif
> >  
> > -#ifdef CONFIG_RANDOMIZE_BASE
> > -static unsigned long module_load_offset;
> > -
> > -/* Mutex protects the module_load_offset. */
> > -static DEFINE_MUTEX(module_kaslr_mutex);
> > -
> > -static unsigned long int get_module_load_offset(void)
> > -{
> > -	if (kaslr_enabled()) {
> > -		mutex_lock(&module_kaslr_mutex);
> > -		/*
> > -		 * Calculate the module_load_offset the first time this
> > -		 * code is called. Once calculated it stays the same until
> > -		 * reboot.
> > -		 */
> > -		if (module_load_offset == 0)
> > -			module_load_offset =
> > -				(get_random_int() % 1024 + 1) * PAGE_SIZE;
> > -		mutex_unlock(&module_kaslr_mutex);
> > -	}
> > -	return module_load_offset;
> > -}
> > -#else
> > -static unsigned long int get_module_load_offset(void)
> > -{
> > -	return 0;
> > -}
> > -#endif
> > -
> > -void *module_alloc(unsigned long size)
> > -{
> > -	void *p;
> > -
> > -	if (PAGE_ALIGN(size) > MODULES_LEN)
> > -		return NULL;
> > -
> > -	p = __vmalloc_node_range(size, MODULE_ALIGN,
> > -				    MODULES_VADDR + get_module_load_offset(),
> > -				    MODULES_END, GFP_KERNEL,
> > -				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> > -				    __builtin_return_address(0));
> > -	if (p && (kasan_module_alloc(p, size) < 0)) {
> > -		vfree(p);
> > -		return NULL;
> > -	}
> > -
> > -	return p;
> > -}
> 
> Please don't touch this module_alloc() at all. Then we can
> just call __vmalloc_node_range() in the text_alloc().

This is my mistake, not intentional. Had a fixup that by mistake did not
end up to the final patch set. Sorry about that.

> 
> > -
> >  #ifdef CONFIG_X86_32
> >  int apply_relocate(Elf32_Shdr *sechdrs,
> >  		   const char *strtab,
> > diff --git a/arch/x86/kernel/text.c b/arch/x86/kernel/text.c
> > new file mode 100644
> > index 000000000000..986b92ff1434
> > --- /dev/null
> > +++ b/arch/x86/kernel/text.c
> > @@ -0,0 +1,71 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + *  Kernel module help for x86.
> > + *  Copyright (C) 2001 Rusty Russell.
> > + */
> > +
> > +#include <linux/kasan.h>
> > +#include <linux/mm.h>
> > +#include <linux/moduleloader.h>
> > +#include <linux/vmalloc.h>
> > +#include <asm/setup.h>
> > +
> > +#ifdef CONFIG_RANDOMIZE_BASE
> > +static unsigned long module_load_offset;
> > +
> > +/* Mutex protects the module_load_offset. */
> > +static DEFINE_MUTEX(module_kaslr_mutex);
> > +
> > +static unsigned long get_module_load_offset(void)
> > +{
> > +	if (kaslr_enabled()) {
> > +		mutex_lock(&module_kaslr_mutex);
> > +		/*
> > +		 * Calculate the module_load_offset the first time this
> > +		 * code is called. Once calculated it stays the same until
> > +		 * reboot.
> > +		 */
> > +		if (module_load_offset == 0)
> > +			module_load_offset =
> > +				(get_random_int() % 1024 + 1) * PAGE_SIZE;
> > +		mutex_unlock(&module_kaslr_mutex);
> > +	}
> > +	return module_load_offset;
> > +}
> > +#else
> > +static unsigned long get_module_load_offset(void)
> > +{
> > +	return 0;
> > +}
> > +#endif
> 
> So as I pointed, we can ignore this for kprobes (and other
> dynamic allocated trampoline code).
> 
> > +
> > +void *text_alloc(unsigned long size)
> > +{
> > +	void *p;
> > +
> > +	if (PAGE_ALIGN(size) > MODULES_LEN)
> > +		return NULL;
> > +
> > +	p = __vmalloc_node_range(size, MODULE_ALIGN,
> > +				    MODULES_VADDR + get_module_load_offset(),
> > +				    MODULES_END, GFP_KERNEL,
> > +				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> > +				    __builtin_return_address(0));
> > +	if (p && (kasan_module_alloc(p, size) < 0)) {
> > +		vfree(p);
> > +		return NULL;
> > +	}
> > +
> > +	return p;
> > +}
> > +
> > +void text_free(void *region)
> > +{
> > +	/*
> > +	 * This memory may be RO, and freeing RO memory in an interrupt is not
> > +	 * supported by vmalloc.
> > +	 */
> > +	WARN_ON(in_interrupt());
> > +
> > +	vfree(region);
> > +}
> > diff --git a/include/linux/text.h b/include/linux/text.h
> > new file mode 100644
> > index 000000000000..a27d4a42ecda
> > --- /dev/null
> > +++ b/include/linux/text.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef _LINUX_TEXT_H
> > +#define _LINUX_TEXT_H
> > +
> > +/*
> > + * An allocator used for allocating modules, core sections and init sections.
> > + * Returns NULL on failure.
> > + */
> > +void *text_alloc(unsigned long size);
> > +
> > +/*
> > + * Free memory returned from text_alloc().
> > + */
> > +void text_free(void *region);
> 
> Hmm, if this is this short, in this version we might better move
> these to vmalloc.h.
> 
> > +
> > +#endif /* _LINUX_TEXT_H */
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 2e97febeef77..fa7687eb0c0e 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/ftrace.h>
> >  #include <linux/cpu.h>
> >  #include <linux/jump_label.h>
> > +#include <linux/text.h>
> >  
> >  #include <asm/sections.h>
> >  #include <asm/cacheflush.h>
> > @@ -111,12 +112,20 @@ enum kprobe_slot_state {
> >  
> >  void __weak *alloc_insn_page(void)
> >  {
> > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > +	return text_alloc(PAGE_SIZE);
> > +#else
> >  	return module_alloc(PAGE_SIZE);
> > +#endif
> >  }
> >  
> >  void __weak free_insn_page(void *page)
> >  {
> > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > +	text_free(page);
> > +#else
> >  	module_memfree(page);
> > +#endif
> >  }
> >  
> >  struct kprobe_insn_cache kprobe_insn_slots = {
> > @@ -1608,6 +1617,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
> >  			goto out;
> >  		}
> >  
> > +#ifdef CONFIG_MODULES
> >  		/*
> >  		 * If the module freed .init.text, we couldn't insert
> >  		 * kprobes in there.
> > @@ -1618,6 +1628,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
> >  			*probed_mod = NULL;
> >  			ret = -ENOENT;
> >  		}
> > +#endif
> 
> This change is not related to text_alloc(). Please move this to 3/3.
> 
> >  	}
> >  out:
> >  	preempt_enable();
> > diff --git a/kernel/module.c b/kernel/module.c
> > index aa183c9ac0a2..8adeb126b02c 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -56,6 +56,7 @@
> >  #include <linux/bsearch.h>
> >  #include <linux/dynamic_debug.h>
> >  #include <linux/audit.h>
> > +#include <linux/text.h>
> >  #include <uapi/linux/module.h>
> >  #include "module-internal.h"
> >  
> > @@ -2151,7 +2152,12 @@ void __weak module_memfree(void *module_region)
> >  	 * supported by vmalloc.
> >  	 */
> >  	WARN_ON(in_interrupt());
> > +
> > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > +	text_free(module_region);
> > +#else
> >  	vfree(module_region);
> > +#endif
> >  }
> >  
> >  void __weak module_arch_cleanup(struct module *mod)
> > @@ -2786,9 +2792,13 @@ static void dynamic_debug_remove(struct module *mod, struct _ddebug *debug)
> >  
> >  void * __weak module_alloc(unsigned long size)
> >  {
> > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > +	return text_alloc(size);
> > +#else
> >  	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> >  			GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
> >  			NUMA_NO_NODE, __builtin_return_address(0));
> > +#endif
> >  }
> 
> Please don't touch kernel/module.c too. This seems to make things complicated.
> 
> Thank you,
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

Thanks for the review. Agree with your remarks.

/Jarkko
