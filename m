Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A04EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 777332065F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgGJWAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgGJWAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:00:17 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B6F12075D;
        Fri, 10 Jul 2020 22:00:15 +0000 (UTC)
Date:   Fri, 10 Jul 2020 18:00:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>, mhiramat@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 08/17] static_call: Avoid kprobes on inline
 static_call()s
Message-ID: <20200710180014.08803c91@oasis.local.home>
In-Reply-To: <20200710134336.619632370@infradead.org>
References: <20200710133831.943894387@infradead.org>
        <20200710134336.619632370@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 15:38:39 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Similar to how we disallow kprobes on any other dynamic text
> (ftrace/jump_label) also disallow kprobes on inline static_call()s.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I'd like to have Masami review this patch too.

> ---
>  arch/x86/kernel/kprobes/opt.c |    4 +-
>  include/linux/static_call.h   |   11 +++++++
>  kernel/kprobes.c              |    2 +
>  kernel/static_call.c          |   64 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 80 insertions(+), 1 deletion(-)
> 
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -17,6 +17,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/frame.h>
>  #include <linux/pgtable.h>
> +#include <linux/static_call.h>
>  
>  #include <asm/text-patching.h>
>  #include <asm/cacheflush.h>
> @@ -209,7 +210,8 @@ static int copy_optimized_instructions(u
>  	/* Check whether the address range is reserved */
>  	if (ftrace_text_reserved(src, src + len - 1) ||
>  	    alternatives_text_reserved(src, src + len - 1) ||
> -	    jump_label_text_reserved(src, src + len - 1))
> +	    jump_label_text_reserved(src, src + len - 1) ||
> +	    static_call_text_reserved(src, src + len - 1))
>  		return -EBUSY;
>  
>  	return len;
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -110,6 +110,7 @@ struct static_call_key {
>  
>  extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
>  extern int static_call_mod_init(struct module *mod);
> +extern int static_call_text_reserved(void *start, void *end);
>  
>  #define DEFINE_STATIC_CALL(name, _func)					\
>  	DECLARE_STATIC_CALL(name, _func);				\
> @@ -153,6 +154,11 @@ void __static_call_update(struct static_
>  	cpus_read_unlock();
>  }
>  
> +static inline int static_call_text_reserved(void *start, void *end)
> +{
> +	return 0;
> +}
> +
>  #define EXPORT_STATIC_CALL(name)					\
>  	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
>  	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
> @@ -182,6 +188,11 @@ void __static_call_update(struct static_
>  	WRITE_ONCE(key->func, func);
>  }
>  
> +static inline int static_call_text_reserved(void *start, void *end)
> +{
> +	return 0;
> +}
> +
>  #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
>  #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
>  
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -35,6 +35,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/cpu.h>
>  #include <linux/jump_label.h>
> +#include <linux/static_call.h>
>  
>  #include <asm/sections.h>
>  #include <asm/cacheflush.h>
> @@ -1591,6 +1592,7 @@ static int check_kprobe_address_safe(str
>  	if (!kernel_text_address((unsigned long) p->addr) ||
>  	    within_kprobe_blacklist((unsigned long) p->addr) ||
>  	    jump_label_text_reserved(p->addr, p->addr) ||
> +	    static_call_text_reserved(p->addr, p->addr) ||
>  	    find_bug((unsigned long)p->addr)) {
>  		ret = -EINVAL;
>  		goto out;
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -204,8 +204,58 @@ static int __static_call_init(struct mod
>  	return 0;
>  }
>  
> +static int addr_conflict(struct static_call_site *site, void *start, void *end)
> +{
> +	unsigned long addr = (unsigned long)static_call_addr(site);
> +
> +	if (addr <= (unsigned long)end &&
> +	    addr + CALL_INSN_SIZE > (unsigned long)start)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int __static_call_text_reserved(struct static_call_site *iter_start,
> +				       struct static_call_site *iter_stop,
> +				       void *start, void *end)
> +{
> +	struct static_call_site *iter = iter_start;
> +
> +	while (iter < iter_stop) {
> +		if (addr_conflict(iter, start, end))
> +			return 1;
> +		iter++;
> +	}
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_MODULES
>  
> +static int __static_call_mod_text_reserved(void *start, void *end)
> +{
> +	struct module *mod;
> +	int ret;
> +
> +	preempt_disable();
> +	mod = __module_text_address((unsigned long)start);
> +	WARN_ON_ONCE(__module_text_address((unsigned long)end) != mod);
> +	if (!try_module_get(mod))
> +		mod = NULL;
> +	preempt_enable();
> +
> +	if (!mod)
> +		return 0;
> +
> +	ret = __static_call_text_reserved(mod->static_call_sites,
> +			mod->static_call_sites + mod->num_static_call_sites,
> +			start, end);
> +
> +	module_put(mod);
> +
> +	return ret;
> +}
> +
>  static int static_call_add_module(struct module *mod)
>  {
>  	return __static_call_init(mod, mod->static_call_sites,
> @@ -275,6 +325,20 @@ static struct notifier_block static_call
>  
>  #endif /* CONFIG_MODULES */
>  
> +int static_call_text_reserved(void *start, void *end)
> +{
> +	int ret = __static_call_text_reserved(__start_static_call_sites,
> +			__stop_static_call_sites, start, end);
> +
> +	if (ret)
> +		return ret;
> +
> +#ifdef CONFIG_MODULES
> +	ret = __static_call_mod_text_reserved(start, end);
> +#endif

Nit, but why not have a #else /* !CONFIG_MODULE */ above and just:

static inline int __static_call_mod_text_reserve(..)
{
	return 0;
}
#endif

?

Then you don't need the extra #ifdef above, and just end it with:

	return __static_call_mod_next_reserved(start, end);

-- Steve


> +	return ret;
> +}
> +
>  static void __init static_call_init(void)
>  {
>  	int ret;
> 

