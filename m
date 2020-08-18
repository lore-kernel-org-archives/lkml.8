Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FA6C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E9222CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597762205;
	bh=aC0a+9Dqz+xL6DqOsy65jLPJS026yhiSAzjqQcepjuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mggFI0t2ivw5FdLD6Od9qJP+ejMLWkxLzmXzRpX9EjN71KzfzeMePqv6zBOAqKIQ1
	 FlfCCFU7U3OJ6rgwdC4dxoRPrRyQ02gIX0bcJKMfaolPycXaC2IchVNv46LQilLIc2
	 EWvWBU952cR6LfgTJf+GAhQqFLVeZSkqWR5GwHF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgHROuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgHROuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:50:03 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FFC420866;
        Tue, 18 Aug 2020 14:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597762203;
        bh=aC0a+9Dqz+xL6DqOsy65jLPJS026yhiSAzjqQcepjuo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JshAvEf5sD0uKtjIkYZf5OeOLR+8ZCAUEzYqTrQmuoKBBkZf1y04mfkcT7FfRYXsc
         a6XmQbbDaXcMnq1VXll9PBZdC3HdVUTiatqWSpvaaymLU/Dupw+zTw2Q8jwVMf3RGi
         pwQL+oINPDOHIgkjlQsGrwAOtyckKKbc6rGNcQM4=
Date:   Tue, 18 Aug 2020 23:49:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kprobes: Use module_name() macro
Message-Id: <20200818234956.c616371d8766e74aef5e7bd2@kernel.org>
In-Reply-To: <20200818050857.117998-1-jarkko.sakkinen@linux.intel.com>
References: <20200818050857.117998-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 08:08:57 +0300
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> It is advised to use module_name() macro instead of dereferencing mod->name
> directly. This makes sense for consistencys sake and also it prevents a
> hard dependency to CONFIG_MODULES.
> 
> Cc: linux-mm@kvack.org
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>,
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

OK, this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> ---
> I thought that to get things moving it would make sense to fix this low
> hanging fruit issue first. Similarly as Masami's fix kernel/kprobes.c
> this will make my patch set less rambling, and thus easier to follow.
>  kernel/trace/trace_kprobe.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index aefb6065b508..19c00ee90945 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -106,9 +106,10 @@ static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
>  static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
>  						 struct module *mod)
>  {
> -	int len = strlen(mod->name);
> +	int len = strlen(module_name(mod));
>  	const char *name = trace_kprobe_symbol(tk);
> -	return strncmp(mod->name, name, len) == 0 && name[len] == ':';
> +
> +	return strncmp(module_name(mod), name, len) == 0 && name[len] == ':';
>  }
>  
>  static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> @@ -688,7 +689,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
>  			if (ret)
>  				pr_warn("Failed to re-register probe %s on %s: %d\n",
>  					trace_probe_name(&tk->tp),
> -					mod->name, ret);
> +					module_name(mod), ret);
>  		}
>  	}
>  	mutex_unlock(&event_mutex);
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
