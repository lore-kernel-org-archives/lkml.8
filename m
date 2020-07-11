Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD69C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85832076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGKBOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 21:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbgGKBOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 21:14:30 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC582077D;
        Sat, 11 Jul 2020 01:14:27 +0000 (UTC)
Date:   Fri, 10 Jul 2020 21:14:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 15/17] static_call: Allow early init
Message-ID: <20200710211426.298a3d94@oasis.local.home>
In-Reply-To: <20200710134337.036717190@infradead.org>
References: <20200710133831.943894387@infradead.org>
        <20200710134337.036717190@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 15:38:46 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> In order to use static_call() to wire up x86_pmu, we need to
> initialize earlier; copy some of the tricks from jump_label to enable
> this.
> 
> Primarily we overload key->next to store a sites pointer when there
> are no modules, this avoids having to use kmalloc() to initialize the
> sites and allows us to run much earlier.
> 

I'm confused. What was the need to have key->next store site pointers
in order to move it up earlier?

-- Steve


> (arguably, this is much much earlier than needed for perf, but it
> might allow other uses.)
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/setup.c       |    2 +
>  arch/x86/kernel/static_call.c |    8 +++++-
>  include/linux/static_call.h   |   15 +++++++++--
>  kernel/static_call.c          |   55 +++++++++++++++++++++++++++++++++++++++---
>  4 files changed, 74 insertions(+), 6 deletions(-)
> 
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -19,6 +19,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/tboot.h>
>  #include <linux/usb/xhci-dbgp.h>
> +#include <linux/static_call.h>
>  
>  #include <uapi/linux/mount.h>
>  
> @@ -848,6 +849,7 @@ void __init setup_arch(char **cmdline_p)
>  	early_cpu_init();
>  	arch_init_ideal_nops();
>  	jump_label_init();
> +	static_call_init();
>  	early_ioremap_init();
>  
>  	setup_olpc_ofw_pgd();
> --- a/arch/x86/kernel/static_call.c
> +++ b/arch/x86/kernel/static_call.c
> @@ -11,7 +11,7 @@ enum insn_type {
>  	RET = 3,  /* tramp / site cond-tail-call */
>  };
>  
> -static void __static_call_transform(void *insn, enum insn_type type, void *func)
> +static void __ref __static_call_transform(void *insn, enum insn_type type, void *func)
>  {
>  	int size = CALL_INSN_SIZE;
>  	const void *code;
> @@ -33,11 +33,17 @@ static void __static_call_transform(void
>  		code = text_gen_insn(RET_INSN_OPCODE, insn, func);
>  		size = RET_INSN_SIZE;
>  		break;
> +
> +	default: /* GCC is a moron -- it figures @code can be uninitialized below */
> +		BUG();
>  	}
>  
>  	if (memcmp(insn, code, size) == 0)
>  		return;
>  
> +	if (unlikely(system_state == SYSTEM_BOOTING))
> +		return text_poke_early(insn, code, size);
> +
>  	text_poke_bp(insn, code, size, NULL);
>  }
>  
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -99,6 +99,8 @@ extern void arch_static_call_transform(v
>  
>  #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
>  
> +extern void __init static_call_init(void);
> +
>  struct static_call_mod {
>  	struct static_call_mod *next;
>  	struct module *mod; /* for vmlinux, mod == NULL */
> @@ -107,7 +109,12 @@ struct static_call_mod {
>  
>  struct static_call_key {
>  	void *func;
> -	struct static_call_mod *mods;
> +	union {
> +		/* bit 0: 0 = mods, 1 = sites */
> +		unsigned long type;
> +		struct static_call_mod *mods;
> +		struct static_call_site *sites;
> +	};
>  };
>  
>  extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
> @@ -118,7 +125,7 @@ extern int static_call_text_reserved(voi
>  	DECLARE_STATIC_CALL(name, _func);				\
>  	struct static_call_key STATIC_CALL_KEY(name) = {		\
>  		.func = _func,						\
> -		.mods = NULL,						\
> +		.type = 1,						\
>  	};								\
>  	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
>  
> @@ -143,6 +150,8 @@ extern int static_call_text_reserved(voi
>  
>  #elif defined(CONFIG_HAVE_STATIC_CALL)
>  
> +static inline void static_call_init(void) { }
> +
>  struct static_call_key {
>  	void *func;
>  };
> @@ -188,6 +197,8 @@ static inline int static_call_text_reser
>  
>  #else /* Generic implementation */
>  
> +static inline void static_call_init(void) { }
> +
>  struct static_call_key {
>  	void *func;
>  };
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -94,10 +94,31 @@ static inline void static_call_sort_entr
>  	     static_call_site_cmp, static_call_site_swap);
>  }
>  
> +static inline bool static_call_key_has_mods(struct static_call_key *key)
> +{
> +	return !(key->type & 1);
> +}
> +
> +static inline struct static_call_mod *static_call_key_next(struct static_call_key *key)
> +{
> +	if (!static_call_key_has_mods(key))
> +		return NULL;
> +
> +	return key->mods;
> +}
> +
> +static inline struct static_call_site *static_call_key_sites(struct static_call_key *key)
> +{
> +	if (static_call_key_has_mods(key))
> +		return NULL;
> +
> +	return (struct static_call_site *)(key->type & ~1);
> +}
> +
>  void __static_call_update(struct static_call_key *key, void *tramp, void *func)
>  {
>  	struct static_call_site *site, *stop;
> -	struct static_call_mod *site_mod;
> +	struct static_call_mod *site_mod, first;
>  
>  	cpus_read_lock();
>  	static_call_lock();
> @@ -116,13 +137,22 @@ void __static_call_update(struct static_
>  	if (WARN_ON_ONCE(!static_call_initialized))
>  		goto done;
>  
> -	for (site_mod = key->mods; site_mod; site_mod = site_mod->next) {
> +	first = (struct static_call_mod){
> +		.next = static_call_key_next(key),
> +		.mod = NULL,
> +		.sites = static_call_key_sites(key),
> +	};
> +
> +	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
>  		struct module *mod = site_mod->mod;
>  
>  		if (!site_mod->sites) {
>  			/*
>  			 * This can happen if the static call key is defined in
>  			 * a module which doesn't use it.
> +			 *
> +			 * It also happens in the has_mods case, where the
> +			 * 'first' entry has no sites associated with it.
>  			 */
>  			continue;
>  		}
> @@ -192,16 +222,35 @@ static int __static_call_init(struct mod
>  		if (key != prev_key) {
>  			prev_key = key;
>  
> +			if (!mod) {
> +				key->sites = site;
> +				key->type |= 1;
> +				goto do_transform;
> +			}
> +
>  			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
>  			if (!site_mod)
>  				return -ENOMEM;
>  
> +			if (!static_call_key_has_mods(key)) {
> +				site_mod->mod = NULL;
> +				site_mod->next = NULL;
> +				site_mod->sites = static_call_key_sites(key);
> +
> +				key->mods = site_mod;
> +
> +				site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
> +				if (!site_mod)
> +					return -ENOMEM;
> +			}
> +
>  			site_mod->mod = mod;
>  			site_mod->sites = site;
>  			site_mod->next = key->mods;
>  			key->mods = site_mod;
>  		}
>  
> +do_transform:
>  		arch_static_call_transform(site_addr, NULL, key->func,
>  				static_call_is_tail(site));
>  	}
> @@ -344,7 +393,7 @@ int static_call_text_reserved(void *star
>  	return ret;
>  }
>  
> -static void __init static_call_init(void)
> +void __init static_call_init(void)
>  {
>  	int ret;
>  
> 

