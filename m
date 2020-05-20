Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2526AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB7B206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iw+6J6Fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgETQIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgETQH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:07:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78D5C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:07:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so3680019wre.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9X29AKPgSRTeiMIz2DwlUf1mEfOfpjq4CbjeVik0R4o=;
        b=Iw+6J6FgX1lHR29lNCdTgOctq5/M7Gc0d38gi8K7OqpVloK49QPxDCTKzIY/SHf3pA
         NR86MiOyzSa5vRCPbMbvLcxjJArIpH2gSYW1aS17shpcS5qAvwCKuWYkI+ji3KfLFwoA
         uHzaoVbgnYn5ChYIsKYqAlTMC35pEzunaBn6WqVgps/MxaSOu75nxh49qsBaDBH3nZRh
         2s4AgH6/jqE+uf3uCiY4nVMio7e0R9wVv3VenxJBHdb6KZ2u9pXQPG5D+0UojobEU8YZ
         FsqHotBSEBi8gOYOwH4hElS8aCTxk0CRVP9HTbxMBPB/BdEBZM2driwhM3f1J8vUPFk/
         rHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9X29AKPgSRTeiMIz2DwlUf1mEfOfpjq4CbjeVik0R4o=;
        b=t7r+RcuLninuw/X61+xoC7tUSInTQpjB8R3pJw8YwKjOqcl/Stc8luTRX7gyl/pOPs
         Mgu8UlsMv38f3ZyXGgdd6R74P2OIrHV4JMFGAs1nGrTEFDMAatIs/cqhScd5e6v4AO/A
         NfbdKQ/oAujk/ezh+Enzl/K9ELHEzve2Y9N32r9266i7gQH4MlaFBFsfBq7xhGwG4aAT
         8RalH/UFUZqf+x9lUl2/8lXZZ/F7NcJ3szlDhtUT/LssHLCCqDy5xmT+8P4uI21WN8T6
         ZtKuG8AhtrIxB0zrSwKSKlncfDkjA+uAA97Y1Ex9wOjIuAWabEy3VlMgB+WIe+NUnB/e
         vxhA==
X-Gm-Message-State: AOAM533tCNpWMT52aYGBw8ALFBsXb5Gy5mA6ZjhXVaQbPF7Q5MjfN7e8
        QnOHY5IrjOmmz7PYXpuqKq28PQ==
X-Google-Smtp-Source: ABdhPJz2yVFKYuqNnJ26jFSxpfcPQbqW+whz1hqMQpRBZTL5U//k/1XfaOG637uqQhysPk2gnnuEMQ==
X-Received: by 2002:adf:a151:: with SMTP id r17mr4676896wrr.161.1589990875413;
        Wed, 20 May 2020 09:07:55 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j16sm3292414wru.13.2020.05.20.09.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:07:54 -0700 (PDT)
Date:   Wed, 20 May 2020 17:07:52 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2] printk/kdb: Redirect printk messages into kdb in any
 context
Message-ID: <20200520160752.mnkpptc2efscolcs@holly.lan>
References: <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
 <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei>
 <20200515103308.GD42471@jagdpanzerIV.localdomain>
 <20200515134806.5cw4xxnxw7k3223l@holly.lan>
 <20200518092139.GK7340@linux-b0ei>
 <20200520042102.GA938@jagdpanzerIV.localdomain>
 <20200520093557.lwwxnhvgmacipdce@holly.lan>
 <20200520102233.GC3464@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520102233.GC3464@linux-b0ei>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 12:22:33PM +0200, Petr Mladek wrote:
> kdb has to get messages on consoles even when the system is stopped.
> It uses kdb_printf() internally and calls console drivers on its own.
> 
> It uses a hack to reuse an existing code. It sets "kdb_trap_printk"
> global variable to redirect even the normal printk() into the
> kdb_printf() variant.
> 
> The variable "kdb_trap_printk" is checked in printk_default() and
> it is ignored when printk is redirected to printk_safe in NMI context.
> Solve this by moving the check into printk_func().
> 
> It is obvious that it is not fully safe. But it does not make things
> worse. The console drivers are already called in this context by
> db_printf() direct calls.
> 
> Reported-by: Sumit Garg <sumit.garg@linaro.org>
> Tested-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> Changes in v2:
> 
>    + more detailed commit message
> 
>  kernel/printk/printk.c      | 14 +-------------
>  kernel/printk/printk_safe.c |  7 +++++++
>  2 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 9a9b6156270b..63a1aa377cd9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -35,7 +35,6 @@
>  #include <linux/memblock.h>
>  #include <linux/syscalls.h>
>  #include <linux/crash_core.h>
> -#include <linux/kdb.h>
>  #include <linux/ratelimit.h>
>  #include <linux/kmsg_dump.h>
>  #include <linux/syslog.h>
> @@ -2036,18 +2035,7 @@ EXPORT_SYMBOL(vprintk);
>  
>  int vprintk_default(const char *fmt, va_list args)
>  {
> -	int r;
> -
> -#ifdef CONFIG_KGDB_KDB
> -	/* Allow to pass printk() to kdb but avoid a recursion. */
> -	if (unlikely(kdb_trap_printk && kdb_printf_cpu < 0)) {
> -		r = vkdb_printf(KDB_MSGSRC_PRINTK, fmt, args);
> -		return r;
> -	}
> -#endif
> -	r = vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
> -
> -	return r;
> +	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
>  }
>  EXPORT_SYMBOL_GPL(vprintk_default);
>  
> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index d9a659a686f3..7ccb821d0bfe 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -6,6 +6,7 @@
>  #include <linux/preempt.h>
>  #include <linux/spinlock.h>
>  #include <linux/debug_locks.h>
> +#include <linux/kdb.h>
>  #include <linux/smp.h>
>  #include <linux/cpumask.h>
>  #include <linux/irq_work.h>
> @@ -359,6 +360,12 @@ void __printk_safe_exit(void)
>  
>  __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
>  {
> +#ifdef CONFIG_KGDB_KDB
> +	/* Allow to pass printk() to kdb but avoid a recursion. */
> +	if (unlikely(kdb_trap_printk && kdb_printf_cpu < 0))
> +		return vkdb_printf(KDB_MSGSRC_PRINTK, fmt, args);
> +#endif
> +
>  	/*
>  	 * Try to use the main logbuf even in NMI. But avoid calling console
>  	 * drivers that might have their own locks.
> -- 
> 2.26.1
> 
