Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DDAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B6420814
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590757497;
	bh=5xmseH3wj1bkjpjrcWDcs26t3O2XwvF9rOv+Agfah8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GiVdlNUtGWzIt0O4fFwKY/qad8u9k4/AhrGOFNsrtSOJQ+VG5OeqjHuFi8ewr/PpK
	 Bn8XhQpGrFxkcklWS93f6RKKNbZLT2draJqXpYFKUwx7gUthJ7lj51Zw3GnKnH89U5
	 oMuVooHrOhYZH/kKuj2982LiKpdVACXxn2t0y8n8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgE2NE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgE2NE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:04:56 -0400
Received: from localhost (lfbn-ncy-1-324-171.w83-196.abo.wanadoo.fr [83.196.159.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B3E52077D;
        Fri, 29 May 2020 13:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590757496;
        bh=5xmseH3wj1bkjpjrcWDcs26t3O2XwvF9rOv+Agfah8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z/xoTBl51+PF9jpmcPDeILvKwOdk3mW7ZMiO0uauYjljHTR2i1N5w1eAb8wgIeZdg
         Mx6H8DqmeRNDF7dgYJEmPVBzQVqhiipzkP/027scNpDXRgGdg+UizA4cSQqOnDiLcA
         liX9KXZBkmis7zNTWnKELhavkP0LFExok0e085qo=
Date:   Fri, 29 May 2020 15:04:54 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 3/7] smp: Move irq_work_run() out of
 flush_smp_call_function_queue()
Message-ID: <20200529130453.GB19915@lenoir>
References: <20200526161057.531933155@infradead.org>
 <20200526161907.895109676@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526161907.895109676@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 06:11:00PM +0200, Peter Zijlstra wrote:
> This ensures flush_smp_call_function_queue() is strictly about
> call_single_queue.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/smp.c |   17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -84,6 +84,7 @@ int smpcfd_dying_cpu(unsigned int cpu)
>  	 * still pending.
>  	 */
>  	flush_smp_call_function_queue(false);
> +	irq_work_run();
>  	return 0;
>  }
>  
> @@ -191,6 +192,14 @@ static int generic_exec_single(int cpu,
>  void generic_smp_call_function_single_interrupt(void)
>  {
>  	flush_smp_call_function_queue(true);
> +
> +	/*
> +	 * Handle irq works queued remotely by irq_work_queue_on().
> +	 * Smp functions above are typically synchronous so they
> +	 * better run first since some other CPUs may be busy waiting
> +	 * for them.
> +	 */

You may want to update that comment once you merge remote irq_work and csd.

Thanks.

> +	irq_work_run();
>  }
>  
>  /**
> @@ -267,14 +276,6 @@ static void flush_smp_call_function_queu
>  		csd_unlock(csd);
>  		func(info);
>  	}
> -
> -	/*
> -	 * Handle irq works queued remotely by irq_work_queue_on().
> -	 * Smp functions above are typically synchronous so they
> -	 * better run first since some other CPUs may be busy waiting
> -	 * for them.
> -	 */
> -	irq_work_run();
>  }
>  
>  /*
> 
> 
