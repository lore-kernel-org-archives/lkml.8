Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3A5C3F2C0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D55B246A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582838174;
	bh=UrHtwRX+59wxj5FsZ103No416/pe7XwytFFHZcMTKG0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=N5mClV+IkMHvIQ/5WZ1NRB68BDP8dB+MymYz+BO3OuXrEC9Qq1QTCgistn0EamGdQ
	 gi6D8bYuMxgLxWzWEDS9osaYdoSW9+NU2wQ5VLDBG2v5iJ5+S5uNGfa9zL+c8ybZ+k
	 UMDO0buTE0S2LJXYDFni1br79oyBOOBHu0Qlfrf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgB0VQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:16:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgB0VQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:16:12 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [163.114.132.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23631246A1;
        Thu, 27 Feb 2020 21:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582838172;
        bh=UrHtwRX+59wxj5FsZ103No416/pe7XwytFFHZcMTKG0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Lzi9gISWF37BTk5WlvsEV0DmcMyXH7kVG9kJkP8IIfk1Q0UYPIC2zvCNX7Y/BHNXK
         i6na91nmvmvY4KaL+/elQnQhyzC41efAbYMxC8hi4ONKbfN/c02JVWCf1spjgMqI3D
         RbT+57gypKIq4ki6CWYnhFVcfPJzhWO0dMHGX5lI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9A73F35226F3; Thu, 27 Feb 2020 13:16:11 -0800 (PST)
Date:   Thu, 27 Feb 2020 13:16:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [PATCH] Enable RCU list lockdep debugging and drop
 CONFIG_PROVE_RCU_LIST
Message-ID: <20200227211611.GF2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200227202355.6163-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227202355.6163-1-madhuparnabhowmik10@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 01:53:55AM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> This patch drops the CONFIG_PROVE_RCU_LIST option and instead
> uses CONFIG_PROVE_RCU for RCU list lockdep debugging.
> 
> With this change, RCU list lockdep debugging will be default
> enabled in CONFIG_PROVE_RCU=y kernels.
> 
> Most of the RCU users (in core kernel/, drivers/, and net/
> subsystem) have already been modified to include lockdep
> expressions hence RCU list debugging can be enabled by
> default.
> 
> However, there are still chances of enountering
> false-positive lockdep splats because not everything is converted,
> in case RCU list primitives are used in non-RCU read-side critical
> section but under the protection of a lock. It would be okay to
> have a few false-positives, as long as bugs are identified, since this
> patch only affects debugging kernels.
> 
> Co-developed-by: Amol Grover <frextrite@gmail.com>
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Good idea, but could you please left PROVE_RCU_LIST and "select" it from
CONFIG_PROVE_RCU instead?  This gets the same effect, but also makes it
easier to change our minds later if we wish to.  It also makes it easier
to find the various different types of debugging.

For a template, please see how CONFIG_PROVE_LOCKING controls the
value of CONFIG_PROVE_RCU in kernel/rcu/Kconfig.debug.

							Thanx, Paul

> ---
>  include/linux/rculist.h  |  2 +-
>  kernel/rcu/Kconfig.debug | 11 -----------
>  2 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 63726577c6b8..f517eb421b5e 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -56,7 +56,7 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
>  
>  #define check_arg_count_one(dummy)
>  
> -#ifdef CONFIG_PROVE_RCU_LIST
> +#ifdef CONFIG_PROVE_RCU
>  #define __list_check_rcu(dummy, cond, extra...)				\
>  	({								\
>  	check_arg_count_one(extra);					\
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index 4aa02eee8f6c..5ec3ea4028e2 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -8,17 +8,6 @@ menu "RCU Debugging"
>  config PROVE_RCU
>  	def_bool PROVE_LOCKING
>  
> -config PROVE_RCU_LIST
> -	bool "RCU list lockdep debugging"
> -	depends on PROVE_RCU && RCU_EXPERT
> -	default n
> -	help
> -	  Enable RCU lockdep checking for list usages. By default it is
> -	  turned off since there are several list RCU users that still
> -	  need to be converted to pass a lockdep expression. To prevent
> -	  false-positive splats, we keep it default disabled but once all
> -	  users are converted, we can remove this config option.
> -
>  config TORTURE_TEST
>  	tristate
>  	default n
> -- 
> 2.17.1
> 
