Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234F7C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62EB206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgDCQgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:36:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:5492 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgDCQgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:36:06 -0400
IronPort-SDR: 5wECPqqMmb/QGhn7rZkZIg6q5Psmn8Xv8wCjHJPD2r40IJnb4j0cz4wrv+cWEu3ViMiQyH128v
 w8tshwFQlt1w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 09:36:06 -0700
IronPort-SDR: nfqsA8ph8/sO0PRYiwmKh85h3V8Mrzb76AlSI/SwIUCBAnpKzbPIxjQi2mSqEC8nvocUE/q65/
 Bgk4YSmo0yWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="253417422"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga006.jf.intel.com with ESMTP; 03 Apr 2020 09:36:05 -0700
Date:   Fri, 3 Apr 2020 09:36:05 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200403163605.GC2701@linux.intel.com>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402124205.242674296@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 02:32:59PM +0200, Thomas Gleixner wrote:
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -24,6 +24,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/setup.h>
>  #include <asm/unwind.h>
> +#include <asm/cpu.h>
>  
>  #if 0
>  #define DEBUGP(fmt, ...)				\
> @@ -253,6 +254,11 @@ int module_finalize(const Elf_Ehdr *hdr,
>  					    tseg, tseg + text->sh_size);
>  	}
>  
> +	if (text && !me->sld_safe) {

As also reported by the test bot, sld_safe only exist if CPU_SUP_INTEL=y.

This can also be conditioned on boot_cpu_has(X86_FEATURE_VMX), or the
static variant.  If CPU_SUP_INTEL=y, X86_FEATURE_VMX will be set if and
only if VMX is fully enabled, i.e. supported by the CPU and enabled in
MSR_IA32_FEATURE_CONTROl.

> +		void *tseg = (void *)text->sh_addr;
> +		split_lock_validate_module_text(me, tseg, tseg + text->sh_size);
> +	}
> +
>  	if (para) {
>  		void *pseg = (void *)para->sh_addr;
>  		apply_paravirt(pseg, pseg + para->sh_size);
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -407,6 +407,10 @@ struct module {
>  	bool sig_ok;
>  #endif
>  
> +#ifdef CONFIG_CPU_SUP_INTEL
> +	bool sld_safe;
> +#endif
> +
>  	bool async_probe_requested;
>  
>  	/* symbols that will be GPL-only in the near future. */
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3096,6 +3096,11 @@ static int check_modinfo(struct module *
>  			"is unknown, you have been warned.\n", mod->name);
>  	}
>  
> +#ifdef CONFIG_CPU_SUP_INTEL
> +	if (get_modinfo(info, "sld_safe"))
> +		mod->sld_safe = true;
> +#endif
> +
>  	err = check_modinfo_livepatch(mod, info);
>  	if (err)
>  		return err;
> 
