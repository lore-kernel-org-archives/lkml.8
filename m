Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90408C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65774206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594802133;
	bh=Ox43SIMUWgQaXB3i+UOOy7ao2qOQdpYQtJCeLUAPGk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=f9xik9kPutBB15GCqtZr9J2YdSi76tZqTBVkVKgDqpuU5C8OJQAW3m4qZvuApnRu3
	 SvKEnbuY6Q6l/KwFwKEd2cqetdHtGQ6dJMaO5FuHEHm8us+apkwOOzE/Ulxxi9ymDM
	 8m96Yr0Ph5OFnpSIW4bOe/Rh1hKcbgclmEyiNIbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgGOIfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730224AbgGOIfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:35:30 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD652065D;
        Wed, 15 Jul 2020 08:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594802129;
        bh=Ox43SIMUWgQaXB3i+UOOy7ao2qOQdpYQtJCeLUAPGk0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LwtBgKWVLrxa9jeFRbsT9NRk351F+8baad7pbFJebQxf8s8+TVabITgJHMeWMu0fe
         HUCUGS/2/sOXjD99U0dJ2bWIPzS2RLkc6rSr2NzU/iY4EelmsB2idUMv7vOXWNY6Gk
         hvcpB7nYoPK1472Ta1KLEx4kb5A6MzuqGPr7ml80=
Date:   Wed, 15 Jul 2020 17:35:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, Jessica Yu <jeyu@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 3/3] kprobes: Flag out CONFIG_MODULES dependent code
Message-Id: <20200715173524.0f21afce3574b8e8596e751e@kernel.org>
In-Reply-To: <20200714223239.1543716-4-jarkko.sakkinen@linux.intel.com>
References: <20200714223239.1543716-1-jarkko.sakkinen@linux.intel.com>
        <20200714223239.1543716-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On Wed, 15 Jul 2020 01:32:29 +0300
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> Remove CONFIG_MODULES dependency by flagging out the dependent code. This
> allows to use kprobes in a kernel without support for loadable modules,
> which could be useful for a test kernel or perhaps an embedded kernel.
> 

OK, looks good, I just have 2 comments below.

> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  include/linux/module.h      | 14 +++++++-------
>  kernel/kprobes.c            |  7 +++++++
>  kernel/trace/trace_kprobe.c | 16 +++++++++++++++-
>  3 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 857b84bf9e90..eaa8ad02f75c 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -290,6 +290,13 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
>  
>  struct notifier_block;
>  
> +enum module_state {
> +	MODULE_STATE_LIVE,	/* Normal state. */
> +	MODULE_STATE_COMING,	/* Full formed, running module_init. */
> +	MODULE_STATE_GOING,	/* Going away. */
> +	MODULE_STATE_UNFORMED,	/* Still setting it up. */
> +};
> +
>  #ifdef CONFIG_MODULES
>  
>  extern int modules_disabled; /* for sysctl */
> @@ -305,13 +312,6 @@ struct module_use {
>  	struct module *source, *target;
>  };
>  
> -enum module_state {
> -	MODULE_STATE_LIVE,	/* Normal state. */
> -	MODULE_STATE_COMING,	/* Full formed, running module_init. */
> -	MODULE_STATE_GOING,	/* Going away. */
> -	MODULE_STATE_UNFORMED,	/* Still setting it up. */
> -};
> -
>  struct mod_tree_node {
>  	struct module *mod;
>  	struct latch_tree_node node;
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index b4f3c24cd2ef..3039df13d34e 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2225,6 +2225,7 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_MODULES
>  /* Remove all symbols in given area from kprobe blacklist */
>  static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
>  {
> @@ -2242,6 +2243,7 @@ static void kprobe_remove_ksym_blacklist(unsigned long entry)
>  {
>  	kprobe_remove_area_blacklist(entry, entry + 1);
>  }
> +#endif
>  
>  int __init __weak arch_populate_kprobe_blacklist(void)
>  {
> @@ -2285,6 +2287,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
>  	return ret ? : arch_populate_kprobe_blacklist();
>  }
>  
> +#ifdef CONFIG_MODULES
>  static void add_module_kprobe_blacklist(struct module *mod)
>  {
>  	unsigned long start, end;
> @@ -2330,6 +2333,10 @@ static void remove_module_kprobe_blacklist(struct module *mod)
>  		kprobe_remove_area_blacklist(start, end);
>  	}
>  }
> +#else
> +static void add_module_kprobe_blacklist(struct module *mod) {}
> +static void remove_module_kprobe_blacklist(struct module *mod) {}
> +#endif /* CONFIG_MODULES */

Please feel free to move the function. I would like to see;

#ifdef CONFIG_MODULES
/* Remove all symbols in given area from kprobe blacklist */
static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
{
...
}
static void add_module_kprobe_blacklist(struct module *mod)
{
...
}
#else
static void add_module_kprobe_blacklist(struct module *mod) {}
static void remove_module_kprobe_blacklist(struct module *mod) {}
#endif /* CONFIG_MODULES */

Rather than split #ifdefs.

>  
>  /* Module notifier call back, checking kprobes on the module */
>  static int kprobes_module_callback(struct notifier_block *nb,
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 710ec6a6aa8f..7fcd1bf2d96e 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -103,8 +103,9 @@ static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
>  	return !!(kprobe_gone(&tk->rp.kp));
>  }
>  
> +#ifdef CONFIG_MODULES
>  static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
> -						 struct module *mod)
> +						       struct module *mod)
>  {
>  	int len = strlen(mod->name);
>  	const char *name = trace_kprobe_symbol(tk);
> @@ -129,6 +130,17 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
>  
>  	return ret;
>  }
> +#else
> +static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
> +						       struct module *mod)
> +{
> +	return false;
> +}
> +static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> +{
> +	return false;
> +}
> +#endif
>  
>  static bool trace_kprobe_is_busy(struct dyn_event *ev)
>  {
> @@ -685,10 +697,12 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
>  			/* Don't need to check busy - this should have gone. */
>  			__unregister_trace_kprobe(tk);
>  			ret = __register_trace_kprobe(tk);
> +#ifdef CONFIG_MODULES
>  			if (ret)
>  				pr_warn("Failed to re-register probe %s on %s: %d\n",
>  					trace_probe_name(&tk->tp),
>  					mod->name, ret);
> +#endif

I guess this CONFIG_MODULES is for avoiding build error according to mod->name,
if so, please use module_name(mod) macro instead of this #ifdef.

>  		}
>  	}
>  	mutex_unlock(&event_mutex);
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
