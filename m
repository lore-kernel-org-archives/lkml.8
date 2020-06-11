Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5362C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B14F2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591879401;
	bh=BkjoSv6oE05qU52N5VgK8gWQ6cVw3A6mBU70e+LGnsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=V3Ag3qPOUd0MjdKpZeMhIDa8OHVypuM7Z4RtFFfSuT5YvKzTtTcMuCXgY/+SRMauw
	 cdJXJhkf1YIfqXda4yEUkDqUAzODFkTA7LvpIh2yzaiKIimp5seQ0OfO3ArazGlYcj
	 pyMWLmcad2TRr56GVxah5CmCKBKYYw77HmuyQtFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgFKMnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgFKMnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:43:19 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC9720747;
        Thu, 11 Jun 2020 12:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591879399;
        bh=BkjoSv6oE05qU52N5VgK8gWQ6cVw3A6mBU70e+LGnsA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VpgaOTAQnzmZRYu8wsZ2T6pPSpFRgcnbY24W8x1BRlqmNJztAI2X+ePD64YYHjaX0
         z7Ni8Wp7rQH0RRnF44LSvWPxseGemnmL7Of45iHHpiMsW/3ELbuXxmUkFhNO5Q07fV
         mE1BB6RLWOg1DYMM3ihwtvFIZFLRC1eEx7UEkmv4=
Date:   Thu, 11 Jun 2020 21:43:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [RFC PATCH 3/4] kgdb: Add NOKPROBE labels on the trap handler
 functions
Message-Id: <20200611214314.bc3ab1fb7000cf50eb037a6f@kernel.org>
In-Reply-To: <20200605132130.1411255-4-daniel.thompson@linaro.org>
References: <20200605132130.1411255-1-daniel.thompson@linaro.org>
        <20200605132130.1411255-4-daniel.thompson@linaro.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Jun 2020 14:21:29 +0100
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> Currently kgdb honours the kprobe blacklist but doesn't place its own
> trap handling code on the list. Add macros to discourage attempting to
> use kgdb to debug itself.
> 
> These changes do not make it impossible to provoke recursive trapping
> since they do not cover all the calls that can be made on kgdb's entry
> logic. However going much further whilst we are sharing the kprobe
> blacklist risks reducing the capabilities of kprobe and this is a bad
> trade off (especially so given kgdb's users are currently conditioned to
> avoid recursive traps).
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/debug_core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 4a2df4509fe1..21d1d91da4bb 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -184,6 +184,7 @@ int __weak kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>  	return probe_kernel_write((char *)bpt->bpt_addr,
>  				  (char *)bpt->saved_instr, BREAK_INSTR_SIZE);
>  }
> +NOKPROBE_SYMBOL(kgdb_arch_remove_breakpoint);
>  
>  int __weak kgdb_validate_break_address(unsigned long addr)
>  {
> @@ -321,6 +322,7 @@ static void kgdb_flush_swbreak_addr(unsigned long addr)
>  	/* Force flush instruction cache if it was outside the mm */
>  	flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
>  }
> +NOKPROBE_SYMBOL(kgdb_flush_swbreak_addr);
>  
>  /*
>   * SW breakpoint management:
> @@ -411,6 +413,7 @@ int dbg_deactivate_sw_breakpoints(void)
>  	}
>  	return ret;
>  }
> +NOKPROBE_SYMBOL(dbg_deactivate_sw_breakpoints);
>  
>  int dbg_remove_sw_break(unsigned long addr)
>  {
> @@ -567,6 +570,7 @@ static int kgdb_reenter_check(struct kgdb_state *ks)
>  
>  	return 1;
>  }
> +NOKPROBE_SYMBOL(kgdb_reenter_check);
>  
>  static void dbg_touch_watchdogs(void)
>  {
> @@ -801,6 +805,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
>  
>  	return kgdb_info[cpu].ret_state;
>  }
> +NOKPROBE_SYMBOL(kgdb_cpu_enter);
>  
>  /*
>   * kgdb_handle_exception() - main entry point from a kernel exception
> @@ -845,6 +850,7 @@ kgdb_handle_exception(int evector, int signo, int ecode, struct pt_regs *regs)
>  		arch_kgdb_ops.enable_nmi(1);
>  	return ret;
>  }
> +NOKPROBE_SYMBOL(kgdb_handle_exception);
>  
>  /*
>   * GDB places a breakpoint at this function to know dynamically loaded objects.
> @@ -879,6 +885,7 @@ int kgdb_nmicallback(int cpu, void *regs)
>  #endif
>  	return 1;
>  }
> +NOKPROBE_SYMBOL(kgdb_nmicallback);
>  
>  int kgdb_nmicallin(int cpu, int trapnr, void *regs, int err_code,
>  							atomic_t *send_ready)
> @@ -904,6 +911,7 @@ int kgdb_nmicallin(int cpu, int trapnr, void *regs, int err_code,
>  #endif
>  	return 1;
>  }
> +NOKPROBE_SYMBOL(kgdb_nmicallin);
>  
>  static void kgdb_console_write(struct console *co, const char *s,
>     unsigned count)
> @@ -1204,7 +1212,6 @@ noinline void kgdb_breakpoint(void)
>  	atomic_dec(&kgdb_setting_breakpoint);
>  }
>  EXPORT_SYMBOL_GPL(kgdb_breakpoint);
> -NOKPROBE_SYMBOL(kgdb_breakpoint);

BTW, why did you mark this NOKPROBE in 2/4 and remove it 3/4 again?

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
