Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A72C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959E120771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594060625;
	bh=GlThzl5PWwzIhOtA1jSC3YB8qCAnpFS1BqH0NFtIUhY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=RT/ebVjKviLDtznjsQrzD35BjH70k9FO689F8pJjiHgtundw2gVknl7BIBA06+hZN
	 +ERlD4LfzG0VKS9mUFTv7H+MHcjLI2IiTA7rNLvKYgd/s6WFXaQ1KPy12ijsdXuDKf
	 aBU+wtOBEnqJf7pngOn2+P9yuWmrQMK30+CLVpLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgGFShE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbgGFShE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:37:04 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB022206DF;
        Mon,  6 Jul 2020 18:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594060623;
        bh=GlThzl5PWwzIhOtA1jSC3YB8qCAnpFS1BqH0NFtIUhY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PDBgPQkN7rHNruB0OJx8a0oO9h5DXvc4w2rapEJi6Eyn46p7k/t3lYINXUCcd1yJZ
         Dq8QKZIc26AU6AXZYe5qc1ypbUio4upvcOBL6w14kI7kwJmdLj0ZhmyHAhpWvEJehS
         NTrHCuC3uI/hsbTKx19wqNs0HDOSmpgycL76tJYk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AF4043522637; Mon,  6 Jul 2020 11:37:03 -0700 (PDT)
Date:   Mon, 6 Jul 2020 11:37:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] smp: Make symbol 'csd_bug_count' static
Message-ID: <20200706183703.GD9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200706134941.80472-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706134941.80472-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 09:49:41PM +0800, Wei Yongjun wrote:
> The sparse tool complains as follows
> 
> kernel/smp.c:107:10: warning:
>  symbol 'csd_bug_count' was not declared. Should it be static?
> 
> This variable is not used outside of smp.c, s this commit marks
> it static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Good catches, applied both, thank you!

							Thanx, Paul

> ---
>  kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 6ec6c9578225..65822c1c3e67 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -104,7 +104,7 @@ void __init call_function_init(void)
>  }
>  
>  #define CSD_LOCK_TIMEOUT (5 * 1000ULL) /* Milliseconds. */
> -atomic_t csd_bug_count = ATOMIC_INIT(0);
> +static atomic_t csd_bug_count = ATOMIC_INIT(0);
>  
>  /* Record current CSD work for current CPU, NULL to erase. */
>  static void csd_lock_record(call_single_data_t *csd)
> 
