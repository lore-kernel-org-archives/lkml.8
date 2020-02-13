Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2786CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDF124650
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581599129;
	bh=oy3UMihHye/Ay+usDPrNLLichk0bRf+L2LB6gIxWzqo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=blFrljVqiUPxiuI2OvqOUw7PmoCQf5WoqebBarJsRVjgRL0NbnPPMs70ygYGq/Ehb
	 wXtIbRTzDY9R8q4iIIalS4xFccsO3Ngr3MYGLQr71AmnUbc11XJMPO1b75hNLZXCqQ
	 gEf50a7jafTZJ6L/mcWIDtPmjIlvmKe8jQVxN/hE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbgBMNF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbgBMNF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:05:27 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A0282168B;
        Thu, 13 Feb 2020 13:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581599127;
        bh=oy3UMihHye/Ay+usDPrNLLichk0bRf+L2LB6gIxWzqo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=N0TEoS+xVOo8EsA3haxJQKOpVDuExSCgPIcIcNi7n2xk5d+rnaBrqbgIft/ktpWrX
         YzPoxvDn53P27yP+KH6y216YVJ8R8EarQo9phdrjKGN5EgrDBxqWtNhKlRDeTrMFdD
         p9ZWr+5mtQ6RxEptf2Iowp8YaGx7mo8TdoU9Emns=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EBC7535226E8; Thu, 13 Feb 2020 05:05:23 -0800 (PST)
Date:   Thu, 13 Feb 2020 05:05:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hongbo Yao <yaohongbo@huawei.com>
Cc:     linux-kernel@vger.kernel.org, chenzhou10@huawei.com,
        dave@stgolabs.net, josh@joshtriplett.org
Subject: Re: [PATCH RESEND -next] torture: avoid build error without
 CONFIG_RCU_TORTURE_TEST
Message-ID: <20200213130523.GY2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200213115313.4794-1-yaohongbo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213115313.4794-1-yaohongbo@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 07:53:13PM +0800, Hongbo Yao wrote:
> If TORTURE_TEST=y(selected by TORTURE_LOCK_TEST) and RCU_TORTURE_TEST=n,
> the following error is seen while building kernel/torture.c
> 
> kernel/torture.c: In function torture_onoff:
> kernel/torture.c:239:3: error: implicit declaration of function
> rcutorture_sched_setaffinity; did you mean __NR_ia32_sched_setaffinity?
> [-Werror=implicit-function-declaration]
>    rcutorture_sched_setaffinity(current->pid, cpumask_of(0));
> 
> Using sched_setaffnity() instead of rcutorture_sched_setaffinity() to
> avoid the error.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: bc3db9afb849 ("EXP: rcutorture hack to force CPU hotplug onto CPU 0")
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>

Thank you for finding this!

However, this was due to a debugging commit used to chase a particular
bug (hence the "EXP:" at the beginning of the subject line).  Now that
this bug has been fixes (woo-hoo!!!), I will be dropping this commit.
In case you are interested, the fix is here:

97be2ad9946f ("rcu: Make rcu_barrier() account for offline no-CBs CPUs")

Either way, thank you for your testing efforts!

							Thanx, Paul

> ---
>  kernel/torture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/torture.c b/kernel/torture.c
> index b29adec50e01..834214cbd1cd 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -236,7 +236,7 @@ torture_onoff(void *arg)
>  			schedule_timeout_interruptible(HZ / 10);
>  			continue;
>  		}
> -		rcutorture_sched_setaffinity(current->pid, cpumask_of(0));
> +		sched_setaffinity(current->pid, cpumask_of(0));
>  		cpu = (torture_random(&rand) >> 4) % (maxcpu + 1);
>  		if (!torture_offline(cpu,
>  				     &n_offline_attempts, &n_offline_successes,
> -- 
> 2.17.1
> 
