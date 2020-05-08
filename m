Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FD8C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D9320870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588919413;
	bh=DsBI2tKeZG0oDtQeqm3vu57VuCyo8ZBWV4i5q+u5v9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oNArR2r2ZvVkE27/6wKsddp/R4nns0hxs+bbtU7ooLTaheC/37owswIbB/gmUAVBL
	 djc2TQgBI7PwNk1dRGz383htDstq8WXeiQWW+n8U9FO2g5WhBh2efM3P561v7tr7A/
	 BXw3cPSBWsG+g5UARst3Yegwp4PyTyXbZGrwiQko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgEHGaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgEHGaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:30:12 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A825207DD;
        Fri,  8 May 2020 06:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588919411;
        bh=DsBI2tKeZG0oDtQeqm3vu57VuCyo8ZBWV4i5q+u5v9o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ev9QafGe9gy2/KarHvTwizPchA+tbt8VkaD6BYqvjvjPZkhWBOZ4FrJZ/uLMB6J0a
         5nM54PkSlXf3gCbnTGdwrXmDWRDd56Lm0djYpAlqWGtiM/BSgwYoZNO1pw6Lw5SkEx
         1RdmNTrGKw8r3IoF9b5wqQlE3+Gzpz4TBNR/u6ME=
Date:   Fri, 8 May 2020 15:30:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 21/36] kprobes: Prevent probes in
 .noinstr.text section
Message-Id: <20200508153005.1e53f54a85d19f007a950b44@kernel.org>
In-Reply-To: <20200505134100.179862032@linutronix.de>
References: <20200505131602.633487962@linutronix.de>
        <20200505134100.179862032@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 May 2020 15:16:23 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Instrumentation is forbidden in the .noinstr.text section. Make kprobes
> respect this.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!


> ---
>  include/linux/module.h |    2 ++
>  kernel/kprobes.c       |   18 ++++++++++++++++++
>  kernel/module.c        |    3 +++
>  3 files changed, 23 insertions(+)
> 
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -458,6 +458,8 @@ struct module {
>  	void __percpu *percpu;
>  	unsigned int percpu_size;
>  #endif
> +	void *noinstr_text_start;
> +	unsigned int noinstr_text_size;
>  
>  #ifdef CONFIG_TRACEPOINTS
>  	unsigned int num_tracepoints;
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2229,6 +2229,12 @@ static int __init populate_kprobe_blackl
>  	/* Symbols in __kprobes_text are blacklisted */
>  	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
>  					(unsigned long)__kprobes_text_end);
> +	if (ret)
> +		return ret;
> +
> +	/* Symbols in noinstr section are blacklisted */
> +	ret = kprobe_add_area_blacklist((unsigned long)__noinstr_text_start,
> +					(unsigned long)__noinstr_text_end);
>  
>  	return ret ? : arch_populate_kprobe_blacklist();
>  }
> @@ -2248,6 +2254,12 @@ static void add_module_kprobe_blacklist(
>  		end = start + mod->kprobes_text_size;
>  		kprobe_add_area_blacklist(start, end);
>  	}
> +
> +	start = (unsigned long)mod->noinstr_text_start;
> +	if (start) {
> +		end = start + mod->noinstr_text_size;
> +		kprobe_add_area_blacklist(start, end);
> +	}
>  }
>  
>  static void remove_module_kprobe_blacklist(struct module *mod)
> @@ -2265,6 +2277,12 @@ static void remove_module_kprobe_blackli
>  		end = start + mod->kprobes_text_size;
>  		kprobe_remove_area_blacklist(start, end);
>  	}
> +
> +	start = (unsigned long)mod->noinstr_text_start;
> +	if (start) {
> +		end = start + mod->noinstr_text_size;
> +		kprobe_remove_area_blacklist(start, end);
> +	}
>  }
>  
>  /* Module notifier call back, checking kprobes on the module */
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3150,6 +3150,9 @@ static int find_module_sections(struct m
>  	}
>  #endif
>  
> +	mod->noinstr_text_start = section_objs(info, ".noinstr.text", 1,
> +						&mod->noinstr_text_size);
> +
>  #ifdef CONFIG_TRACEPOINTS
>  	mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
>  					     sizeof(*mod->tracepoints_ptrs),
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
