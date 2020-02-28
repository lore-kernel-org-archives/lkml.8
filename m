Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26322C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF0B246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgB1Q1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:27:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1Q1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:27:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5804A2468E;
        Fri, 28 Feb 2020 16:27:43 +0000 (UTC)
Date:   Fri, 28 Feb 2020 11:27:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 06/13] ftrace: Add symbols for ftrace trampolines
Message-ID: <20200228112741.1758f933@gandalf.local.home>
In-Reply-To: <20200228135125.567-7-adrian.hunter@intel.com>
References: <20200228135125.567-1-adrian.hunter@intel.com>
        <20200228135125.567-7-adrian.hunter@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 15:51:18 +0200
Adrian Hunter <adrian.hunter@intel.com> wrote:

> Symbols are needed for tools to describe instruction addresses. Pages
> allocated for ftrace's purposes need symbols to be created for them.
> Add such symbols to be visible via /proc/kallsyms.
> 
> Example on x86 with CONFIG_DYNAMIC_FTRACE=y
> 
> 	# echo function > /sys/kernel/debug/tracing/current_tracer
> 	# cat /proc/kallsyms | grep '\[ftrace\]'
> 	ffffffffc02f8000 t ftrace_trampoline    [ftrace]
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  arch/x86/kernel/ftrace.c | 26 +++++++++++---------
>  include/linux/ftrace.h   | 15 +++++++++---
>  kernel/trace/ftrace.c    | 53 +++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 77 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 108ee96f8b66..76920ce85b9c 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -307,9 +307,9 @@ union ftrace_op_code_union {
>  
>  #define RET_SIZE		1
>  
> -static unsigned long
> -create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
> +static void create_trampoline(struct ftrace_ops *ops)
>  {
> +	unsigned int tramp_size;

Nit, please move this down below the unsigned longs.

>  	unsigned long start_offset;
>  	unsigned long end_offset;
>  	unsigned long op_offset;
> @@ -347,10 +347,10 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
>  	 */
>  	trampoline = alloc_tramp(size + RET_SIZE + sizeof(void *));
>  	if (!trampoline)
> -		return 0;
> +		return;
>  
> -	*tramp_size = size + RET_SIZE + sizeof(void *);
> -	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
> +	tramp_size = size + RET_SIZE + sizeof(void *);
> +	npages = DIV_ROUND_UP(tramp_size, PAGE_SIZE);
>  
>  	/* Copy ftrace_caller onto the trampoline memory */
>  	ret = probe_kernel_read(trampoline, (void *)start_offset, size);
> @@ -403,15 +403,18 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
>  
>  	/* ALLOC_TRAMP flags lets us know we created it */
>  	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
> +	ops->trampoline = (unsigned long)trampoline;
> +	ops->trampoline_size = tramp_size;
> +
> +	ftrace_add_trampoline_to_kallsyms(ops);

Why do this here and not in ftrace_update_trampoline() if it changes?
>  
>  	set_vm_flush_reset_perms(trampoline);
>  
>  	set_memory_ro((unsigned long)trampoline, npages);
>  	set_memory_x((unsigned long)trampoline, npages);
> -	return (unsigned long)trampoline;
> +	return;
>  fail:
>  	tramp_free(trampoline);
> -	return 0;
>  }
>  
>  static unsigned long calc_trampoline_call_offset(bool save_regs)
> @@ -435,14 +438,10 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
>  	ftrace_func_t func;
>  	unsigned long offset;
>  	unsigned long ip;
> -	unsigned int size;
>  	const char *new;
>  
>  	if (!ops->trampoline) {
> -		ops->trampoline = create_trampoline(ops, &size);
> -		if (!ops->trampoline)
> -			return;
> -		ops->trampoline_size = size;
> +		create_trampoline(ops);

I think this should be broken into two patches. Placing the code nicely in
create_trampoline() is more of a clean up and unrelated to the kallsyms
code. Make one patch that puts everything in create_trampoline() as that
can even go in the kernel separately outside this patch set.

Then another patch to add the kallsym code.


>  		return;
>  	}
>  
> @@ -535,6 +534,9 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
>  	if (!ops || !(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
>  		return;
>  
> +	ftrace_remove_trampoline_from_kallsyms(ops);
> +	synchronize_rcu();

Then perhaps we should have this in ftrace_trampoline_free(ops) (which
would need to be created).

That is, in kernel/trace/ftrace.c: ftrace_update_trampoline():

static void ftrace_update_trampoline(struct ftrace_ops *ops)
{
	unsigned long trampoline = ops->trampoline;

	arch_ftrace_update_trampoline(ops);
	if (ops->trampoline && ops->trampoline != trampoline)
		ftrace_add_trampoline_to_kallsyms(ops);
}

and add to kernel/trace/ftrace.c:

static void ftrace_trampoline_free(ops)
{
	if (ops && (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP) &&
	    ops->trampoline)
		ftrace_remove_trampoline_from_kallsyms(ops);

	arch_ftrace_trampoline_free(ops);
}

And call this instead of arch_ftrace_trapoline_free() directly.

-- Steve

> +
>  	tramp_free((void *)ops->trampoline);
>  	ops->trampoline = 0;
>  }
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index db95244a62d4..70dea4785443 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -58,9 +58,6 @@ struct ftrace_direct_func;
>  const char *
>  ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
>  		   unsigned long *off, char **modname, char *sym);
> -int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
> -			   char *type, char *name,
> -			   char *module_name, int *exported);
>  #else
>  static inline const char *
>  ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
> @@ -68,6 +65,13 @@ ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
>  {
>  	return NULL;
>  }
> +#endif
> +
> +#if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_DYNAMIC_FTRACE)
> +int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
> +			   char *type, char *name,
> +			   char *module_name, int *exported);
> +#else
>  static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
>  					 char *type, char *name,
>  					 char *module_name, int *exported)
> @@ -76,7 +80,6 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
>  }
>  #endif
>  
> -
>  #ifdef CONFIG_FUNCTION_TRACER
>  
>  extern int ftrace_enabled;
> @@ -179,6 +182,9 @@ struct ftrace_ops_hash {
>  
>  void ftrace_free_init_mem(void);
>  void ftrace_free_mem(struct module *mod, void *start, void *end);
> +#define FTRACE_TRAMPOLINE_SYM "ftrace_trampoline"
> +void ftrace_add_trampoline_to_kallsyms(struct ftrace_ops *ops);
> +void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops);
>  #else
>  static inline void ftrace_free_init_mem(void) { }
>  static inline void ftrace_free_mem(struct module *mod, void *start, void *end) { }
> @@ -207,6 +213,7 @@ struct ftrace_ops {
>  	struct ftrace_ops_hash		old_hash;
>  	unsigned long			trampoline;
>  	unsigned long			trampoline_size;
> +	struct list_head		list;
>  #endif
>  };
>  
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 9bf1f2cd515e..1911fa832a79 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6174,6 +6174,42 @@ struct ftrace_mod_map {
>  	unsigned int		num_funcs;
>  };
>  
> +/* List of trace_ops that have allocated trampolines */
> +static LIST_HEAD(ftrace_ops_trampoline_list);
> +
> +void ftrace_add_trampoline_to_kallsyms(struct ftrace_ops *ops)
> +{
> +	lockdep_assert_held(&ftrace_lock);
> +	list_add_rcu(&ops->list, &ftrace_ops_trampoline_list);
> +}
> +
> +void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops)
> +{
> +	lockdep_assert_held(&ftrace_lock);
> +	list_del_rcu(&ops->list);
> +}
> +
> +static int ftrace_get_trampoline_kallsym(unsigned int symnum,
> +					 unsigned long *value, char *type,
> +					 char *name, char *module_name,
> +					 int *exported)
> +{
> +	struct ftrace_ops *op;
> +
> +	list_for_each_entry_rcu(op, &ftrace_ops_trampoline_list, list) {
> +		if (!op->trampoline || symnum--)
> +			continue;
> +		*value = op->trampoline;
> +		*type = 't';
> +		strlcpy(name, FTRACE_TRAMPOLINE_SYM, KSYM_NAME_LEN);
> +		strlcpy(module_name, "ftrace", MODULE_NAME_LEN);
> +		*exported = 0;
> +		return 0;
> +	}
> +
> +	return -ERANGE;
> +}
> +
>  #ifdef CONFIG_MODULES
>  
>  #define next_to_ftrace_page(p) container_of(p, struct ftrace_page, next)
> @@ -6510,6 +6546,7 @@ int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
>  {
>  	struct ftrace_mod_map *mod_map;
>  	struct ftrace_mod_func *mod_func;
> +	int ret;
>  
>  	preempt_disable();
>  	list_for_each_entry_rcu(mod_map, &ftrace_mod_maps, list) {
> @@ -6536,8 +6573,10 @@ int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
>  		WARN_ON(1);
>  		break;
>  	}
> +	ret = ftrace_get_trampoline_kallsym(symnum, value, type, name,
> +					    module_name, exported);
>  	preempt_enable();
> -	return -ERANGE;
> +	return ret;
>  }
>  
>  #else
> @@ -6549,6 +6588,18 @@ allocate_ftrace_mod_map(struct module *mod,
>  {
>  	return NULL;
>  }
> +int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
> +			   char *type, char *name, char *module_name,
> +			   int *exported)
> +{
> +	int ret;
> +
> +	preempt_disable();
> +	ret = ftrace_get_trampoline_kallsym(symnum, value, type, name,
> +					    module_name, exported);
> +	preempt_enable();
> +	return ret;
> +}
>  #endif /* CONFIG_MODULES */
>  
>  struct ftrace_init_func {

