Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685FDC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 476C920768
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595586189;
	bh=Hrp5koErF+GyuMGbWpCqTc4/hf5I1JMqOuaOD7z/Gro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MpdkRm8l4hlNBi6snaiAgTfKlde9yf07ibs1d54yz1JpOqf/eSIry425ytytoMvxO
	 dsUreuTI0UrfnnswPs0n7FG5U56sX5mIcEIrbcvUfwsK+dkuNyj4+P8fc4qSJ9ohod
	 2ngJganDs/pUJLuRpctKVYWyrJ4FuZCYcYQT8b1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgGXKXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgGXKXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:23:07 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C59552065C;
        Fri, 24 Jul 2020 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595586186;
        bh=Hrp5koErF+GyuMGbWpCqTc4/hf5I1JMqOuaOD7z/Gro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrR/MfxrjblGK3pXtQS2LXBW1dWxEzRxacNPkGrUjYpVa78pwj7Z1TGJP4gTiskGt
         F7v4+uDq0JWz5IXlDy9hyQ+df7zgodneV/i6qkTMntOC+B9P56ryUP8XBSaZhQiF63
         UoyALCrFD+KBhmqWcM+hZhmzT9B/zHNbeHvT199U=
Date:   Fri, 24 Jul 2020 13:22:58 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v5 1/6] kprobes: Remove dependency to the module_mutex
Message-ID: <20200724102258.GB2831654@kernel.org>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-2-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724050553.1724168-2-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 08:05:48AM +0300, Jarkko Sakkinen wrote:
> Add lock_modules() and unlock_modules() wrappers for acquiring module_mutex
> in order to remove the compile time dependency to it.
> 
> Cc: linux-mm@kvack.org
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  include/linux/module.h      | 18 ++++++++++++++++++
>  kernel/kprobes.c            |  4 ++--
>  kernel/trace/trace_kprobe.c |  4 ++--
>  3 files changed, 22 insertions(+), 4 deletions(-)

Any reason to convert only kprobes to the new API and leave others with
opencoded implementation?
 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 2e6670860d27..8850b9692b8f 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -705,6 +705,16 @@ static inline bool is_livepatch_module(struct module *mod)
>  bool is_module_sig_enforced(void);
>  void set_module_sig_enforced(void);
>  
> +static inline void lock_modules(void)
> +{
> +	mutex_lock(&module_mutex);
> +}
> +
> +static inline void unlock_modules(void)
> +{
> +	mutex_unlock(&module_mutex);
> +}
> +
>  #else /* !CONFIG_MODULES... */
>  
>  static inline struct module *__module_address(unsigned long addr)
> @@ -852,6 +862,14 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
>  	return ptr;
>  }
>  
> +static inline void lock_modules(void)
> +{
> +}
> +
> +static inline void unlock_modules(void)
> +{
> +}
> +
>  #endif /* CONFIG_MODULES */
>  
>  #ifdef CONFIG_SYSFS
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 2e97febeef77..4e46d96d4e16 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -564,7 +564,7 @@ static void kprobe_optimizer(struct work_struct *work)
>  	cpus_read_lock();
>  	mutex_lock(&text_mutex);
>  	/* Lock modules while optimizing kprobes */
> -	mutex_lock(&module_mutex);
> +	lock_modules();
>  
>  	/*
>  	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
> @@ -589,7 +589,7 @@ static void kprobe_optimizer(struct work_struct *work)
>  	/* Step 4: Free cleaned kprobes after quiesence period */
>  	do_free_cleaned_kprobes();
>  
> -	mutex_unlock(&module_mutex);
> +	unlock_modules();
>  	mutex_unlock(&text_mutex);
>  	cpus_read_unlock();
>  
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index aefb6065b508..710ec6a6aa8f 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -122,9 +122,9 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
>  	if (!p)
>  		return true;
>  	*p = '\0';
> -	mutex_lock(&module_mutex);
> +	lock_modules();
>  	ret = !!find_module(tk->symbol);
> -	mutex_unlock(&module_mutex);
> +	unlock_modules();
>  	*p = ':';
>  
>  	return ret;
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
