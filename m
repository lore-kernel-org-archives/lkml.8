Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A729FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF042076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594377190;
	bh=npIvbv2Wa7+FJItbbcYjZmbO1yKxswndYLzaIR6c2p0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xUdc4qQhNNzECx9q26R8WJdq+rWJl7opBcef9/5Qw6XSkfEp/W7vYx8LaW0N/UZ0h
	 vHrJucfyyHtcObImVi6KdX5VBuNro7KXnvHZWwYy2SK3Wskw0Di7yvYnHMtrqqqZ9D
	 WuhzRlQJP5y/RfXcZ2tXorcyOcNW+Pu8oERIOdug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgGJKdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgGJKdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:33:06 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13CDC20748;
        Fri, 10 Jul 2020 10:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594377184;
        bh=npIvbv2Wa7+FJItbbcYjZmbO1yKxswndYLzaIR6c2p0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fffv6m7F5voH3nEsLXuDWLGicno0rIYVJoCnMyVs/IVWepJ6+K0sl6K9sB9FV92bH
         D3ZB/y0Z3y/UPYn/a5Mcli2Dl2jThajTuCF/+kSu9k0vhArggiq+cqNPkOs7TAlDVN
         Zcdi76WwduBdjbuiQ99lfKdSMC1bptQMEPfTDHoU=
Date:   Fri, 10 Jul 2020 19:32:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Alexandre Ghiti <alex@ghiti.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH RFC] kprobes: Remove MODULES dependency
Message-Id: <20200710193257.4eeb19e9cd042d99cbca7f9a@kernel.org>
In-Reply-To: <20200709234521.194005-1-jarkko.sakkinen@linux.intel.com>
References: <20200709234521.194005-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On Fri, 10 Jul 2020 02:45:19 +0300
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> Remove MODULES dependency and migrate from module_alloc to vmalloc().
> According to Andi, the history with this dependency is that kprobes
> originally required custom LKM's, which does not hold today anymore.
> 
> Right now one has to compile LKM support only to enable kprobes.  With
> this change applied, it is somewhat easier to create custom test
> kernel's with a proper debugging capabilities, thus making Linux more
> developer friendly.

Agreed. Now we have several way to access kprobes via ftrace/perf/bpf
without modules. So it's a good time to remove CONFIG_MODULE dependency.

But I also would like to minimize the changes for code readability.
I made some comments below.

> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  arch/Kconfig                   |  1 -
>  arch/x86/kernel/kprobes/core.c |  5 +++--
>  kernel/kprobes.c               | 22 ++++++++++++++++++++--
>  kernel/trace/trace_kprobe.c    | 12 ++++++++++++
>  4 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8cc35dc556c7..bb59cdf335ab 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -61,7 +61,6 @@ config OPROFILE_NMI_TIMER
>  
>  config KPROBES
>  	bool "Kprobes"
> -	depends on MODULES
>  	depends on HAVE_KPROBES
>  	select KALLSYMS
>  	help
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index ada39ddbc922..dc7b8d6fd20d 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -42,6 +42,7 @@
>  #include <linux/moduleloader.h>
>  #include <linux/vmalloc.h>
>  #include <linux/pgtable.h>
> +#include <linux/vmalloc.h>
>  
>  #include <asm/text-patching.h>
>  #include <asm/cacheflush.h>
> @@ -423,7 +424,7 @@ void *alloc_insn_page(void)
>  {
>  	void *page;
>  
> -	page = module_alloc(PAGE_SIZE);
> +	page = vmalloc(PAGE_SIZE);

No, you can not use vmalloc here. The reason why we use module_alloc()
is to allocate the executable memory for trampoline code.
So, you need to use vmalloc_exec() instead.

>  	if (!page)
>  		return NULL;
>  
> @@ -446,7 +447,7 @@ void *alloc_insn_page(void)
>  /* Recover page to RW mode before releasing it */
>  void free_insn_page(void *page)
>  {
> -	module_memfree(page);
> +	vfree(page);
>  }
>  
>  static int arch_copy_kprobe(struct kprobe *p)
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 4a904cc56d68..02680642ea11 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -35,6 +35,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/cpu.h>
>  #include <linux/jump_label.h>
> +#include <linux/vmalloc.h>
>  
>  #include <asm/sections.h>
>  #include <asm/cacheflush.h>
> @@ -111,12 +112,12 @@ enum kprobe_slot_state {
>  
>  void __weak *alloc_insn_page(void)
>  {
> -	return module_alloc(PAGE_SIZE);
> +	return vmalloc(PAGE_SIZE);

Ditto.

>  }
>  
>  void __weak free_insn_page(void *page)
>  {
> -	module_memfree(page);
> +	vfree(page);
>  }
>  
>  struct kprobe_insn_cache kprobe_insn_slots = {
> @@ -563,8 +564,11 @@ static void kprobe_optimizer(struct work_struct *work)
>  	mutex_lock(&kprobe_mutex);
>  	cpus_read_lock();
>  	mutex_lock(&text_mutex);
> +
> +#ifdef CONFIG_MODULES
>  	/* Lock modules while optimizing kprobes */
>  	mutex_lock(&module_mutex);
> +#endif

Hmm, can you reduce these "#ifdef CONFIG_MODULE"s ?

e.g. 

#ifdef CONFIG_MODULES
static void lock_modules(void)
{
	mutex_lock(&module_mutex);
}
...
#else
#define lock_modules() do { } while (0)
...
#endif

>  
>  	/*
>  	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
> @@ -589,7 +593,9 @@ static void kprobe_optimizer(struct work_struct *work)
>  	/* Step 4: Free cleaned kprobes after quiesence period */
>  	do_free_cleaned_kprobes();
>  
> +#ifdef CONFIG_MODULES
>  	mutex_unlock(&module_mutex);
> +#endif
>  	mutex_unlock(&text_mutex);
>  	cpus_read_unlock();
>  
> @@ -739,6 +745,7 @@ static int reuse_unused_kprobe(struct kprobe *ap)
>  	return 0;
>  }
>  

> +#ifdef CONFIG_MODULE
>  /* Remove optimized instructions */
>  static void kill_optimized_kprobe(struct kprobe *p)
>  {
> @@ -764,6 +771,7 @@ static void kill_optimized_kprobe(struct kprobe *p)
>  	/* Don't touch the code, because it is already freed. */
>  	arch_remove_optimized_kprobe(op);
>  }
> +#endif

This optprobe related one is OK to keep in this place. 

>  
>  static inline
>  void __prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
> @@ -1608,6 +1616,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  			goto out;
>  		}
>  
> +#ifdef CONFIG_MODULE
>  		/*
>  		 * If the module freed .init.text, we couldn't insert
>  		 * kprobes in there.
> @@ -1618,6 +1627,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  			*probed_mod = NULL;
>  			ret = -ENOENT;
>  		}
> +#endif
>  	}
>  out:
>  	preempt_enable();
> @@ -2090,6 +2100,7 @@ NOKPROBE_SYMBOL(pre_handler_kretprobe);
>  
>  #endif /* CONFIG_KRETPROBES */
>  
> +#ifdef CONFIG_MODULE
>  /* Set the kprobe gone and remove its instruction buffer. */
>  static void kill_kprobe(struct kprobe *p)
>  {
> @@ -2114,6 +2125,7 @@ static void kill_kprobe(struct kprobe *p)
>  	 */
>  	arch_remove_kprobe(p);
>  }
> +#endif
>  
>  /* Disable one kprobe */
>  int disable_kprobe(struct kprobe *kp)
> @@ -2214,6 +2226,7 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_MODULE
>  /* Remove all symbols in given area from kprobe blacklist */
>  static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
>  {
> @@ -2231,6 +2244,7 @@ static void kprobe_remove_ksym_blacklist(unsigned long entry)
>  {
>  	kprobe_remove_area_blacklist(entry, entry + 1);
>  }
> +#endif
>  
>  int __init __weak arch_populate_kprobe_blacklist(void)
>  {
> @@ -2274,6 +2288,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
>  	return ret ? : arch_populate_kprobe_blacklist();
>  }
>  
> +#ifdef CONFIG_MODULE
>  static void add_module_kprobe_blacklist(struct module *mod)
>  {
>  	unsigned long start, end;
> @@ -2375,6 +2390,7 @@ static struct notifier_block kprobe_module_nb = {
>  	.notifier_call = kprobes_module_callback,
>  	.priority = 0
>  };
> +#endif /* CONFIG_MODULE */
>  
>  /* Markers of _kprobe_blacklist section */
>  extern unsigned long __start_kprobe_blacklist[];
> @@ -2425,8 +2441,10 @@ static int __init init_kprobes(void)
>  	err = arch_init_kprobes();
>  	if (!err)
>  		err = register_die_notifier(&kprobe_exceptions_nb);
> +#ifdef CONFIG_MODULE
>  	if (!err)
>  		err = register_module_notifier(&kprobe_module_nb);
> +#endif
>  
>  	kprobes_initialized = (err == 0);
>  
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index aefb6065b508..30969b38fce8 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -103,6 +103,7 @@ static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
>  	return !!(kprobe_gone(&tk->rp.kp));
>  }
>  
> +#ifdef CONFIG_MODULE
>  static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
>  						 struct module *mod)
>  {
> @@ -110,7 +111,9 @@ static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
>  	const char *name = trace_kprobe_symbol(tk);
>  	return strncmp(mod->name, name, len) == 0 && name[len] == ':';
>  }
> +#endif
>  
> +#ifdef CONFIG_MODULE
>  static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
>  {
>  	char *p;
> @@ -129,6 +132,7 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
>  
>  	return ret;
>  }
> +#endif

Here, too. If you make a dummy function in case of !CONFIG_MODULE,
we don't need to modify caller-side code.

>  
>  static bool trace_kprobe_is_busy(struct dyn_event *ev)
>  {
> @@ -608,10 +612,12 @@ static int append_trace_kprobe(struct trace_kprobe *tk, struct trace_kprobe *to)
>  
>  	/* Register k*probe */
>  	ret = __register_trace_kprobe(tk);
> +#ifdef CONFIG_MODULE
>  	if (ret == -ENOENT && !trace_kprobe_module_exist(tk)) {
>  		pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
>  		ret = 0;
>  	}
> +#endif

So, please make a dummy trace_kprobe_module_exist() and keep this untouched.

>  
>  	if (ret)
>  		trace_probe_unlink(&tk->tp);
> @@ -651,10 +657,12 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
>  
>  	/* Register k*probe */
>  	ret = __register_trace_kprobe(tk);
> +#ifdef CONFIG_MODULE
>  	if (ret == -ENOENT && !trace_kprobe_module_exist(tk)) {
>  		pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
>  		ret = 0;
>  	}
> +#endif

Ditto.

>  
>  	if (ret < 0)
>  		unregister_kprobe_event(tk);
> @@ -666,6 +674,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_MODULE
>  /* Module notifier call back, checking event on the module */
>  static int trace_kprobe_module_callback(struct notifier_block *nb,
>  				       unsigned long val, void *data)
> @@ -700,6 +709,7 @@ static struct notifier_block trace_kprobe_module_nb = {
>  	.notifier_call = trace_kprobe_module_callback,
>  	.priority = 1	/* Invoked after kprobe module callback */
>  };
> +#endif

Unless it makes any build error, please keep it untouched.

>  
>  /* Convert certain expected symbols into '_' when generating event names */
>  static inline void sanitize_event_name(char *name)
> @@ -1891,8 +1901,10 @@ static __init int init_kprobe_trace_early(void)
>  	if (ret)
>  		return ret;
>  
> +#ifdef CONFIG_MODULE
>  	if (register_module_notifier(&trace_kprobe_module_nb))
>  		return -EINVAL;
> +#endif

Ditto.

Thank you,

>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
