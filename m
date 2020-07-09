Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69A0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A21F207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594313976;
	bh=MjLxmKFsCwQKcejuUVJLBgHqXfK23AAaD9TAFxzTGAo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Sc8UAxWge1AdP3uytqLUsQW6AOpJ0qjI+7vOTTp2edjMrJngDzs5qSefngGTPoNch
	 HKOqck5jW/A50qjnB4JH9ouTc2VtorTStcwBBrAUV1Rr2/l+0mCEeRkUIh2dFI0IGi
	 aSQhe1p28gJr/p5v3iI2MSJtvN8BJj+LTkf8BzsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgGIQ7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgGIQ7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:59:34 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7554D2078B;
        Thu,  9 Jul 2020 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594313974;
        bh=MjLxmKFsCwQKcejuUVJLBgHqXfK23AAaD9TAFxzTGAo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KSVyWHH2ritXsbDHAwt85ewJORhs7pRZVmsaIl1rUWFIoSrcLmzxfKg1Zqtqwsujj
         h/HYzcc7kN+kQjyc+bBie7dfANi6hBh8xZLQtKw5UP8MWhsf5lSHNrSjPKM2fdrK8P
         niekjdreA1SFdFZqVzJ+k74RUULknxQX1aojKLJ0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5AB3A3522CE7; Thu,  9 Jul 2020 09:59:34 -0700 (PDT)
Date:   Thu, 9 Jul 2020 09:59:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kaitao Cheng <pilgrimtao@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kernel/smp: Fix an off by one in csd_lock_wait_toolong()
Message-ID: <20200709165934.GD9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200709104818.GC20875@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709104818.GC20875@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 01:48:18PM +0300, Dan Carpenter wrote:
> The __per_cpu_offset[] array has "nr_cpu_ids" elements so change the >
> >= to prevent a read one element beyond the end of the array.
> 
> Fixes: 0504bc41a62c ("kernel/smp: Provide CSD lock timeout diagnostics")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good eyes, thank you!  Folding this into the original with
attribution.

							Thanx, Paul

> ---
>  kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 78b602cae6c2..f49966713ac3 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -171,7 +171,7 @@ static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 t
>  		*bug_id = atomic_inc_return(&csd_bug_count);
>  	cpu = csd_lock_wait_getcpu(csd);
>  	smp_mb(); // No stale cur_csd values!
> -	if (WARN_ONCE(cpu < 0 || cpu > nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
> +	if (WARN_ONCE(cpu < 0 || cpu >= nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
>  		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, 0));
>  	else
>  		cpu_cur_csd = READ_ONCE(per_cpu(cur_csd, cpu));
> -- 
> 2.27.0
> 
