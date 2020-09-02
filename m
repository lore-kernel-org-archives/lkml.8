Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C0CC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B5D320E65
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599010519;
	bh=Rj1R+TitOo5kJVyDDRkO73BMeiL+fFoz22nKLSxPjiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hzTxO0cm+5Xoj79GOmF+3Oq4H6r70eOk/1qKdZlxdQV+8SfJg0LMPaeo96wLrXmdU
	 LHwWFFO1AWeGQSzExYsK66xB4IMjmP4lMlq++YuggyVZHXPamm289+QjrQxf4Ho6kN
	 RE2ySFBmb1GPo+NIGZNu4D8HbIsiVHcXYK7NhNfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgIBBfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgIBBfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:35:15 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C3F6206EF;
        Wed,  2 Sep 2020 01:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599010514;
        bh=Rj1R+TitOo5kJVyDDRkO73BMeiL+fFoz22nKLSxPjiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0kcRyvY7h7x1xDL2G4PdKG+tESRhsCGZNISlD9d4SH+4K3CB3ppsOT5QK2I8ILLjq
         SnWLgihh29KcoyudXCWRtB5z7qO7VZ2uZH1/IJtb4ER4sdjq/8AoOYbsh7521SpNCQ
         qYy/CDyVIaezELhamVUc33K1u/dLJAt/BW+l7Krg=
Date:   Wed, 2 Sep 2020 10:35:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v7 08/18] static_call: Avoid kprobes on inline
 static_call()s
Message-Id: <20200902103508.2872d92709fc8de7c6bffe08@kernel.org>
In-Reply-To: <20200818135804.744920586@infradead.org>
References: <20200818135735.948368560@infradead.org>
        <20200818135804.744920586@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 15:57:43 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Similar to how we disallow kprobes on any other dynamic text
> (ftrace/jump_label) also disallow kprobes on inline static_call()s.

Looks good to me. 

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

BTW, here we already have 5 subsystems which reserves texts
(ftrace, alternatives, jump_label, static_call and kprobes.)

Except for the kprobes and ftrace, we can generalize the reserved-text
code because those are section-based static address-areas (or lists).

Thank you,

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/kprobes/opt.c |    4 +-
>  include/linux/static_call.h   |   11 ++++++
>  kernel/kprobes.c              |    2 +
>  kernel/static_call.c          |   68 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 84 insertions(+), 1 deletion(-)
> 
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -18,6 +18,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/frame.h>
>  #include <linux/pgtable.h>
> +#include <linux/static_call.h>
>  
>  #include <asm/text-patching.h>
>  #include <asm/cacheflush.h>
> @@ -210,7 +211,8 @@ static int copy_optimized_instructions(u
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
> @@ -36,6 +36,7 @@
>  #include <linux/cpu.h>
>  #include <linux/jump_label.h>
>  #include <linux/perf_event.h>
> +#include <linux/static_call.h>
>  
>  #include <asm/sections.h>
>  #include <asm/cacheflush.h>
> @@ -1634,6 +1635,7 @@ static int check_kprobe_address_safe(str
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
> @@ -273,8 +323,26 @@ static struct notifier_block static_call
>  	.notifier_call = static_call_module_notify,
>  };
>  
> +#else
> +
> +static inline int __static_call_mod_text_reserved(void *start, void *end)
> +{
> +	return 0;
> +}
> +
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
> +	return __static_call_mod_text_reserved(start, end);
> +}
> +
>  static void __init static_call_init(void)
>  {
>  	int ret;
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
