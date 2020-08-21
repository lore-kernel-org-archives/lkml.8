Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A91CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A7420702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgHURgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:36:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64244 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHURgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:36:47 -0400
Received: from 89-64-88-37.dynamic.chello.pl (89.64.88.37) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id 46880135231ebf0e; Fri, 21 Aug 2020 19:36:44 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, joel@joelfernandes.org,
        svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH v2 02/11] cpuidle: Fixup IRQ state
Date:   Fri, 21 Aug 2020 19:36:43 +0200
Message-ID: <2397536.RUgnjfFTVL@kreacher>
In-Reply-To: <20200821085348.251340558@infradead.org>
References: <20200821084738.508092956@infradead.org> <20200821085348.251340558@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 21, 2020 10:47:40 AM CEST Peter Zijlstra wrote:
> Match the pattern elsewhere in this file.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Marco Elver <elver@google.com>

For all patches in the series:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/cpuidle/cpuidle.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -153,7 +153,8 @@ static void enter_s2idle_proper(struct c
>  	 */
>  	stop_critical_timings();
>  	drv->states[index].enter_s2idle(dev, drv, index);
> -	WARN_ON(!irqs_disabled());
> +	if (WARN_ON_ONCE(!irqs_disabled()))
> +		local_irq_disable();
>  	/*
>  	 * timekeeping_resume() that will be called by tick_unfreeze() for the
>  	 * first CPU executing it calls functions containing RCU read-side
> 
> 
> 




