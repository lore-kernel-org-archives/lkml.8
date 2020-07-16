Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4575FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AE42071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgGPRgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:36:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:41307 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgGPRgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:36:36 -0400
IronPort-SDR: oIn/uVRhiptHY+JRgFYAx8vOjbkPwKF1MWELHbOCXn5ErrLGaLVjdjKh/LbYfT/5zrZgpyrw2i
 cVLef/zb4Q0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="148609836"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="148609836"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 10:36:35 -0700
IronPort-SDR: RrEqMM+RXqeRfz3aAQyUhPVJ/WdVp8OGTktWDm5+ZMajgogAQbcmX5DjY0DFkzAlqCcqt4IjSl
 bRAUY9wKDiug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="325207529"
Received: from unknown (HELO localhost) ([10.249.34.156])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2020 10:36:30 -0700
Date:   Thu, 16 Jul 2020 20:36:28 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, Jessica Yu <jeyu@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 3/3] kprobes: Flag out CONFIG_MODULES dependent code
Message-ID: <20200716173628.GE14135@linux.intel.com>
References: <20200714223239.1543716-1-jarkko.sakkinen@linux.intel.com>
 <20200714223239.1543716-4-jarkko.sakkinen@linux.intel.com>
 <20200715173524.0f21afce3574b8e8596e751e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715173524.0f21afce3574b8e8596e751e@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 05:35:24PM +0900, Masami Hiramatsu wrote:
> Hi Jarkko,
> 
> On Wed, 15 Jul 2020 01:32:29 +0300
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > Remove CONFIG_MODULES dependency by flagging out the dependent code. This
> > allows to use kprobes in a kernel without support for loadable modules,
> > which could be useful for a test kernel or perhaps an embedded kernel.
> > 
> 
> OK, looks good, I just have 2 comments below.
> 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  include/linux/module.h      | 14 +++++++-------
> >  kernel/kprobes.c            |  7 +++++++
> >  kernel/trace/trace_kprobe.c | 16 +++++++++++++++-
> >  3 files changed, 29 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 857b84bf9e90..eaa8ad02f75c 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -290,6 +290,13 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
> >  
> >  struct notifier_block;
> >  
> > +enum module_state {
> > +	MODULE_STATE_LIVE,	/* Normal state. */
> > +	MODULE_STATE_COMING,	/* Full formed, running module_init. */
> > +	MODULE_STATE_GOING,	/* Going away. */
> > +	MODULE_STATE_UNFORMED,	/* Still setting it up. */
> > +};
> > +
> >  #ifdef CONFIG_MODULES
> >  
> >  extern int modules_disabled; /* for sysctl */
> > @@ -305,13 +312,6 @@ struct module_use {
> >  	struct module *source, *target;
> >  };
> >  
> > -enum module_state {
> > -	MODULE_STATE_LIVE,	/* Normal state. */
> > -	MODULE_STATE_COMING,	/* Full formed, running module_init. */
> > -	MODULE_STATE_GOING,	/* Going away. */
> > -	MODULE_STATE_UNFORMED,	/* Still setting it up. */
> > -};
> > -
> >  struct mod_tree_node {
> >  	struct module *mod;
> >  	struct latch_tree_node node;
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index b4f3c24cd2ef..3039df13d34e 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2225,6 +2225,7 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_MODULES
> >  /* Remove all symbols in given area from kprobe blacklist */
> >  static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
> >  {
> > @@ -2242,6 +2243,7 @@ static void kprobe_remove_ksym_blacklist(unsigned long entry)
> >  {
> >  	kprobe_remove_area_blacklist(entry, entry + 1);
> >  }
> > +#endif
> >  
> >  int __init __weak arch_populate_kprobe_blacklist(void)
> >  {
> > @@ -2285,6 +2287,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
> >  	return ret ? : arch_populate_kprobe_blacklist();
> >  }
> >  
> > +#ifdef CONFIG_MODULES
> >  static void add_module_kprobe_blacklist(struct module *mod)
> >  {
> >  	unsigned long start, end;
> > @@ -2330,6 +2333,10 @@ static void remove_module_kprobe_blacklist(struct module *mod)
> >  		kprobe_remove_area_blacklist(start, end);
> >  	}
> >  }
> > +#else
> > +static void add_module_kprobe_blacklist(struct module *mod) {}
> > +static void remove_module_kprobe_blacklist(struct module *mod) {}
> > +#endif /* CONFIG_MODULES */
> 
> Please feel free to move the function. I would like to see;
> 
> #ifdef CONFIG_MODULES
> /* Remove all symbols in given area from kprobe blacklist */
> static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
> {
> ...
> }
> static void add_module_kprobe_blacklist(struct module *mod)
> {
> ...
> }
> #else
> static void add_module_kprobe_blacklist(struct module *mod) {}
> static void remove_module_kprobe_blacklist(struct module *mod) {}
> #endif /* CONFIG_MODULES */
> 
> Rather than split #ifdefs.
> 
> >  
> >  /* Module notifier call back, checking kprobes on the module */
> >  static int kprobes_module_callback(struct notifier_block *nb,
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 710ec6a6aa8f..7fcd1bf2d96e 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -103,8 +103,9 @@ static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
> >  	return !!(kprobe_gone(&tk->rp.kp));
> >  }
> >  
> > +#ifdef CONFIG_MODULES
> >  static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
> > -						 struct module *mod)
> > +						       struct module *mod)
> >  {
> >  	int len = strlen(mod->name);
> >  	const char *name = trace_kprobe_symbol(tk);
> > @@ -129,6 +130,17 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> >  
> >  	return ret;
> >  }
> > +#else
> > +static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
> > +						       struct module *mod)
> > +{
> > +	return false;
> > +}
> > +static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> > +{
> > +	return false;
> > +}
> > +#endif
> >  
> >  static bool trace_kprobe_is_busy(struct dyn_event *ev)
> >  {
> > @@ -685,10 +697,12 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
> >  			/* Don't need to check busy - this should have gone. */
> >  			__unregister_trace_kprobe(tk);
> >  			ret = __register_trace_kprobe(tk);
> > +#ifdef CONFIG_MODULES
> >  			if (ret)
> >  				pr_warn("Failed to re-register probe %s on %s: %d\n",
> >  					trace_probe_name(&tk->tp),
> >  					mod->name, ret);
> > +#endif
> 
> I guess this CONFIG_MODULES is for avoiding build error according to mod->name,
> if so, please use module_name(mod) macro instead of this #ifdef.
> 
> >  		}
> >  	}
> >  	mutex_unlock(&event_mutex);
> > -- 
> > 2.25.1
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

Thanks, agree with the remarks.

/Jarkko
