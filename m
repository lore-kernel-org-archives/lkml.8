Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D55C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD19206F8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584975638;
	bh=sOwqdzjNyDhqWaqPuKSrOiqTlX2z5cN/FIXJ3P/xkjI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=se/7tHkw0h+oOPd0teEMEsj9gNNSOJnD0a9dGmp+kNaMsdJ9E4uWOAYaQ8mpy+suK
	 oAKXp5olhQhs3FaaNe20/jGerV7iDCnh5de40TYCkUhMvYj7VdSah0jTQg8jL9ZE9j
	 iqYr4GniEa7moNa86+QPPI3MUyQLlEAkTwOaR7k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgCWPAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbgCWPAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:00:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0182076A;
        Mon, 23 Mar 2020 15:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584975634;
        bh=sOwqdzjNyDhqWaqPuKSrOiqTlX2z5cN/FIXJ3P/xkjI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zCkspbRTmHUxF9l9kRPZQnxtYGdYi8+u6rRR3/9+G3jy+1Py13gdsJwR0GL7JDxJY
         DSpD2HdIdJvkPPQPC0zgJceBlBX5G9X0TWzOx+qjPICnwN5AmkaI4wgCQcYvkrDVkI
         xQOQ+kQyCeBEE5NPoHcjWNEc/LS2t4bjGP3+oOWY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5B36B35226C6; Mon, 23 Mar 2020 08:00:34 -0700 (PDT)
Date:   Mon, 23 Mar 2020 08:00:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        Juergen Gross <jgross@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        xen-devel@lists.xenproject.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v4 01/17] cpu: Add new {add,remove}_cpu() functions
Message-ID: <20200323150034.GG3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200323135110.30522-1-qais.yousef@arm.com>
 <20200323135110.30522-2-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323135110.30522-2-qais.yousef@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 01:50:54PM +0000, Qais Yousef wrote:
> The new functions use device_{online,offline}() which are userspace
> safe.
> 
> This is in preparation to move cpu_{up, down} kernel users to use
> a safer interface that is not racy with userspace.
> 
> Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: "Paul E. McKenney" <paulmck@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> CC: Helge Deller <deller@gmx.de>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Juergen Gross <jgross@suse.com>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: xen-devel@lists.xenproject.org
> CC: linux-parisc@vger.kernel.org
> CC: sparclinux@vger.kernel.org
> CC: linuxppc-dev@lists.ozlabs.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: x86@kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  include/linux/cpu.h |  2 ++
>  kernel/cpu.c        | 24 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 1ca2baf817ed..cf8cf38dca43 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -89,6 +89,7 @@ extern ssize_t arch_cpu_release(const char *, size_t);
>  #ifdef CONFIG_SMP
>  extern bool cpuhp_tasks_frozen;
>  int cpu_up(unsigned int cpu);
> +int add_cpu(unsigned int cpu);
>  void notify_cpu_starting(unsigned int cpu);
>  extern void cpu_maps_update_begin(void);
>  extern void cpu_maps_update_done(void);
> @@ -118,6 +119,7 @@ extern void cpu_hotplug_disable(void);
>  extern void cpu_hotplug_enable(void);
>  void clear_tasks_mm_cpumask(int cpu);
>  int cpu_down(unsigned int cpu);
> +int remove_cpu(unsigned int cpu);
>  
>  #else /* CONFIG_HOTPLUG_CPU */
>  
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 9c706af713fb..069802f7010f 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1057,6 +1057,18 @@ int cpu_down(unsigned int cpu)
>  }
>  EXPORT_SYMBOL(cpu_down);
>  
> +int remove_cpu(unsigned int cpu)
> +{
> +	int ret;
> +
> +	lock_device_hotplug();
> +	ret = device_offline(get_cpu_device(cpu));
> +	unlock_device_hotplug();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(remove_cpu);
> +
>  #else
>  #define takedown_cpu		NULL
>  #endif /*CONFIG_HOTPLUG_CPU*/
> @@ -1209,6 +1221,18 @@ int cpu_up(unsigned int cpu)
>  }
>  EXPORT_SYMBOL_GPL(cpu_up);
>  
> +int add_cpu(unsigned int cpu)
> +{
> +	int ret;
> +
> +	lock_device_hotplug();
> +	ret = device_online(get_cpu_device(cpu));
> +	unlock_device_hotplug();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(add_cpu);
> +
>  #ifdef CONFIG_PM_SLEEP_SMP
>  static cpumask_var_t frozen_cpus;
>  
> -- 
> 2.17.1
> 
