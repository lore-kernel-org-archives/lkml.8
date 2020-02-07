Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8029C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB29A217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581104423;
	bh=ulxptYKoi30zUziVN+g5ACpr4FlhctQvC/XKjr24dPc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Je/F5ILmjY26VYiMOVU5yakvzu/FzG5K8AqPxBrNQdcIqsb7juX7QfroFbL1V+Hcq
	 adxqinZkd5Qxjx/dgEnnauondvFkhcOk4n9+Ng6fosIW8lu0v/cytTm8EExzcWcg0E
	 cy0B5+amcoexzMk0ateTWX5yhWzL88A219XfPAdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBGTkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 14:40:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgBGTkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 14:40:22 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B5CD20726;
        Fri,  7 Feb 2020 19:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581104421;
        bh=ulxptYKoi30zUziVN+g5ACpr4FlhctQvC/XKjr24dPc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vkh70UPwTTZoJBPTB/o+/ChdgecXXDbzyTCLwZRwNE9FrgLuMzU9cPxmEEWhB6aPe
         O9hAjmj2SUI0OvAnHWDrmoJvf+OaMsXGiJ/RAFORf/XDre8pvSXxGSBcU3qBjLypfL
         Cl654iXLd3kVqSYqb8F75mw8QTdlE5yUiJ12f8NE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 641F535219BF; Fri,  7 Feb 2020 11:40:21 -0800 (PST)
Date:   Fri, 7 Feb 2020 11:40:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>, mingo@kernel.org, will@kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] kcsan: Expose core configuration parameters as module
 params
Message-ID: <20200207194021.GO2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200207185910.162512-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207185910.162512-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 07:59:10PM +0100, Marco Elver wrote:
> This adds early_boot, udelay_{task,interrupt}, and skip_watch as module
> params. The latter parameters are useful to modify at runtime to tune
> KCSAN's performance on new systems. This will also permit auto-tuning
> these parameters to maximize overall system performance and KCSAN's race
> detection ability.
> 
> None of the parameters are used in the fast-path and referring to them
> via static variables instead of CONFIG constants will not affect
> performance.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Qian Cai <cai@lca.pw>

Thank you both!

I have pulled this in, and have also rebased the KCSAN commits into a
separate branch named kcsan in -rcu.  This allows people to use current
KCSAN without exposing themselves to random RCU changes.

f60f0f543333 ("kcsan: Expose core configuration parameters as module params")

git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

I just now kicked off a short sanity test with rcutorture, and will of
course do more testing over time.

							Thanx, Paul

> ---
>  kernel/kcsan/core.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 87ef01e40199d..498b1eb3c1cda 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -6,6 +6,7 @@
>  #include <linux/export.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/moduleparam.h>
>  #include <linux/percpu.h>
>  #include <linux/preempt.h>
>  #include <linux/random.h>
> @@ -16,6 +17,20 @@
>  #include "encoding.h"
>  #include "kcsan.h"
>  
> +static bool kcsan_early_enable = IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
> +static unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
> +static unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
> +static long kcsan_skip_watch = CONFIG_KCSAN_SKIP_WATCH;
> +
> +#ifdef MODULE_PARAM_PREFIX
> +#undef MODULE_PARAM_PREFIX
> +#endif
> +#define MODULE_PARAM_PREFIX "kcsan."
> +module_param_named(early_enable, kcsan_early_enable, bool, 0);
> +module_param_named(udelay_task, kcsan_udelay_task, uint, 0644);
> +module_param_named(udelay_interrupt, kcsan_udelay_interrupt, uint, 0644);
> +module_param_named(skip_watch, kcsan_skip_watch, long, 0644);
> +
>  bool kcsan_enabled;
>  
>  /* Per-CPU kcsan_ctx for interrupts */
> @@ -239,9 +254,9 @@ should_watch(const volatile void *ptr, size_t size, int type)
>  
>  static inline void reset_kcsan_skip(void)
>  {
> -	long skip_count = CONFIG_KCSAN_SKIP_WATCH -
> +	long skip_count = kcsan_skip_watch -
>  			  (IS_ENABLED(CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE) ?
> -				   prandom_u32_max(CONFIG_KCSAN_SKIP_WATCH) :
> +				   prandom_u32_max(kcsan_skip_watch) :
>  				   0);
>  	this_cpu_write(kcsan_skip, skip_count);
>  }
> @@ -253,8 +268,7 @@ static __always_inline bool kcsan_is_enabled(void)
>  
>  static inline unsigned int get_delay(void)
>  {
> -	unsigned int delay = in_task() ? CONFIG_KCSAN_UDELAY_TASK :
> -					 CONFIG_KCSAN_UDELAY_INTERRUPT;
> +	unsigned int delay = in_task() ? kcsan_udelay_task : kcsan_udelay_interrupt;
>  	return delay - (IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
>  				prandom_u32_max(delay) :
>  				0);
> @@ -527,7 +541,7 @@ void __init kcsan_init(void)
>  	 * We are in the init task, and no other tasks should be running;
>  	 * WRITE_ONCE without memory barrier is sufficient.
>  	 */
> -	if (IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE))
> +	if (kcsan_early_enable)
>  		WRITE_ONCE(kcsan_enabled, true);
>  }
>  
> -- 
> 2.25.0.341.g760bfbb309-goog
> 
