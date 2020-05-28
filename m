Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDA8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 00:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B514420888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 00:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590625526;
	bh=Qdsa0olgyVlXg3qKetOzPTyrk1FZhWKBrDNkUI3BpLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DeOaUdl03CY9QKJD0LXeAmUDIVfeMbm5RRTeIiT5HfKpmcl8mSPEkL0Optn6f7EOI
	 64pBfBwOCs+BnfSOUQUsmY2PTgdmjWYRYyk5CAFYe4QqsxzOtQsiOyKXUW3Nj41hJ8
	 GjVoZ3fvvsibh+YEYDvhfKvgyfz0Bn63myfgkfQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgE1AZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 20:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE1AZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 20:25:25 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 682E8207CB;
        Thu, 28 May 2020 00:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590625523;
        bh=Qdsa0olgyVlXg3qKetOzPTyrk1FZhWKBrDNkUI3BpLw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DHOusV+AMCybNY2dWzJXGltd0CU//wwVo38S7yuRIHo/krf7WsMMgQXWqjAXXb84q
         pkJxN7TyvcxeVrlRRMU7rACUHWYdd8cwncFSCw/LScoQJMRIC83Ql8l5AtIgmei8Vb
         bmYDkGYt89+gMVhSJb1CSskZrX2azDqSvKocr5tE=
Date:   Thu, 28 May 2020 09:25:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 03/15] kprobes: Add symbols for kprobe insn pages
Message-Id: <20200528092515.6d5fbe560cfd13c899ea39bd@kernel.org>
In-Reply-To: <20200512121922.8997-4-adrian.hunter@intel.com>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
        <20200512121922.8997-4-adrian.hunter@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 15:19:10 +0300
Adrian Hunter <adrian.hunter@intel.com> wrote:

> Symbols are needed for tools to describe instruction addresses. Pages
> allocated for kprobe's purposes need symbols to be created for them.
> Add such symbols to be visible via /proc/kallsyms.
> 
> Note: kprobe insn pages are not used if ftrace is configured. To see the
> effect of this patch, the kernel must be configured with:

Note, if you put a probe inside the function body, kprobe_insn_pages is
used even if ftrace is configured.
(Ftrace is used only for the function entry)

> 
> 	# CONFIG_FUNCTION_TRACER is not set
> 	CONFIG_KPROBES=y
> 
> and for optimised kprobes:
> 
> 	CONFIG_OPTPROBES=y
> 
> Example on x86:
> 
> 	# perf probe __schedule
> 	Added new event:
> 	  probe:__schedule     (on __schedule)
> 	# cat /proc/kallsyms | grep '\[__builtin__kprobes\]'
> 	ffffffffc00d4000 t kprobe_insn_page     [__builtin__kprobes]
> 	ffffffffc00d6000 t kprobe_optinsn_page  [__builtin__kprobes]
> 
> Note: This patch adds "__builtin__kprobes" as a module name in
> /proc/kallsyms for symbols for pages allocated for kprobes' purposes, even
> though "__builtin__kprobes" is not a module.

Anyway, except for the Peter's sparc64 issue, the code is good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/kprobes.h | 15 ++++++++++++++
>  kernel/kallsyms.c       | 37 +++++++++++++++++++++++++++++----
>  kernel/kprobes.c        | 45 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 04bdaf01112c..62d682f47b5e 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -242,6 +242,7 @@ struct kprobe_insn_cache {
>  	struct mutex mutex;
>  	void *(*alloc)(void);	/* allocate insn page */
>  	void (*free)(void *);	/* free insn page */
> +	const char *sym;	/* symbol for insn pages */
>  	struct list_head pages; /* list of kprobe_insn_page */
>  	size_t insn_size;	/* size of instruction slot */
>  	int nr_garbage;
> @@ -272,6 +273,8 @@ static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
>  {									\
>  	return __is_insn_slot_addr(&kprobe_##__name##_slots, addr);	\
>  }
> +#define KPROBE_INSN_PAGE_SYM		"kprobe_insn_page"
> +#define KPROBE_OPTINSN_PAGE_SYM		"kprobe_optinsn_page"
>  #else /* __ARCH_WANT_KPROBES_INSN_SLOT */
>  #define DEFINE_INSN_CACHE_OPS(__name)					\
>  static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
> @@ -373,6 +376,13 @@ void dump_kprobe(struct kprobe *kp);
>  void *alloc_insn_page(void);
>  void free_insn_page(void *page);
>  
> +int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> +		       char *sym);
> +int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
> +			     unsigned long *value, char *type, char *sym);
> +
> +int arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
> +			    char *type, char *sym);
>  #else /* !CONFIG_KPROBES: */
>  
>  static inline int kprobes_built_in(void)
> @@ -435,6 +445,11 @@ static inline bool within_kprobe_blacklist(unsigned long addr)
>  {
>  	return true;
>  }
> +static inline int kprobe_get_kallsym(unsigned int symnum, unsigned long *value,
> +				     char *type, char *sym)
> +{
> +	return -ERANGE;
> +}
>  #endif /* CONFIG_KPROBES */
>  static inline int disable_kretprobe(struct kretprobe *rp)
>  {
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 16c8c605f4b0..c6cc293c0e67 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -24,6 +24,7 @@
>  #include <linux/slab.h>
>  #include <linux/filter.h>
>  #include <linux/ftrace.h>
> +#include <linux/kprobes.h>
>  #include <linux/compiler.h>
>  
>  /*
> @@ -437,6 +438,7 @@ struct kallsym_iter {
>  	loff_t pos_arch_end;
>  	loff_t pos_mod_end;
>  	loff_t pos_ftrace_mod_end;
> +	loff_t pos_bpf_end;
>  	unsigned long value;
>  	unsigned int nameoff; /* If iterating in core kernel symbols. */
>  	char type;
> @@ -496,11 +498,33 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
>  
>  static int get_ksymbol_bpf(struct kallsym_iter *iter)
>  {
> +	int ret;
> +
>  	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
>  	iter->exported = 0;
> -	return bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
> -			       &iter->value, &iter->type,
> -			       iter->name) < 0 ? 0 : 1;
> +	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
> +			      &iter->value, &iter->type,
> +			      iter->name);
> +	if (ret < 0) {
> +		iter->pos_bpf_end = iter->pos;
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +/*
> + * This uses "__builtin__kprobes" as a module name for symbols for pages
> + * allocated for kprobes' purposes, even though "__builtin__kprobes" is not a
> + * module.
> + */
> +static int get_ksymbol_kprobe(struct kallsym_iter *iter)
> +{
> +	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
> +	iter->exported = 0;
> +	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
> +				  &iter->value, &iter->type,
> +				  iter->name) < 0 ? 0 : 1;
>  }
>  
>  /* Returns space to next name. */
> @@ -527,6 +551,7 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
>  		iter->pos_arch_end = 0;
>  		iter->pos_mod_end = 0;
>  		iter->pos_ftrace_mod_end = 0;
> +		iter->pos_bpf_end = 0;
>  	}
>  }
>  
> @@ -551,7 +576,11 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
>  	    get_ksymbol_ftrace_mod(iter))
>  		return 1;
>  
> -	return get_ksymbol_bpf(iter);
> +	if ((!iter->pos_bpf_end || iter->pos_bpf_end > pos) &&
> +	    get_ksymbol_bpf(iter))
> +		return 1;
> +
> +	return get_ksymbol_kprobe(iter);
>  }
>  
>  /* Returns false if pos at or past end of file. */
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 2625c241ac00..229d1b596690 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -118,6 +118,7 @@ struct kprobe_insn_cache kprobe_insn_slots = {
>  	.mutex = __MUTEX_INITIALIZER(kprobe_insn_slots.mutex),
>  	.alloc = alloc_insn_page,
>  	.free = free_insn_page,
> +	.sym = KPROBE_INSN_PAGE_SYM,
>  	.pages = LIST_HEAD_INIT(kprobe_insn_slots.pages),
>  	.insn_size = MAX_INSN_SIZE,
>  	.nr_garbage = 0,
> @@ -296,6 +297,7 @@ struct kprobe_insn_cache kprobe_optinsn_slots = {
>  	.mutex = __MUTEX_INITIALIZER(kprobe_optinsn_slots.mutex),
>  	.alloc = alloc_insn_page,
>  	.free = free_insn_page,
> +	.sym = KPROBE_OPTINSN_PAGE_SYM,
>  	.pages = LIST_HEAD_INIT(kprobe_optinsn_slots.pages),
>  	/* .insn_size is initialized later */
>  	.nr_garbage = 0,
> @@ -2179,6 +2181,49 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
>  	return 0;
>  }
>  
> +int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
> +			     unsigned long *value, char *type, char *sym)
> +{
> +	struct kprobe_insn_page *kip;
> +	int ret = -ERANGE;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(kip, &c->pages, list) {
> +		if ((*symnum)--)
> +			continue;
> +		strlcpy(sym, c->sym, KSYM_NAME_LEN);
> +		*type = 't';
> +		*value = (unsigned long)kip->insns;
> +		ret = 0;
> +		break;
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
> +				   char *type, char *sym)
> +{
> +	return -ERANGE;
> +}
> +
> +int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> +		       char *sym)
> +{
> +#ifdef __ARCH_WANT_KPROBES_INSN_SLOT
> +	if (!kprobe_cache_get_kallsym(&kprobe_insn_slots, &symnum, value, type, sym))
> +		return 0;
> +#ifdef CONFIG_OPTPROBES
> +	if (!kprobe_cache_get_kallsym(&kprobe_optinsn_slots, &symnum, value, type, sym))
> +		return 0;
> +#endif
> +#endif
> +	if (!arch_kprobe_get_kallsym(&symnum, value, type, sym))
> +		return 0;
> +	return -ERANGE;
> +}
> +
>  int __init __weak arch_populate_kprobe_blacklist(void)
>  {
>  	return 0;
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
