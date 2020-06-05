Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7B5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65881206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591369332;
	bh=bgpj3gym6zcyvL/796ubDk2qM6lfHTKVZtpH2tmkf9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0xM0M6ZUkliAwHWyfLbMHw0OjxR7iSrp7sDq7pPSekahaUpAqksnc4qI8gIM+PWMt
	 Cd221atisCb8gClODMBeqFjKxm5bCElY+vjz1597ZUV6l75UeNGI+z+IXSY3kxhSK6
	 KZKCY6ZzF2LPHULEKYc+ZbKyE1x+40drSp/fK5mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgFEPCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgFEPCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:02:11 -0400
Received: from localhost (lfbn-ncy-1-324-171.w83-196.abo.wanadoo.fr [83.196.159.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4582A2065C;
        Fri,  5 Jun 2020 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591369330;
        bh=bgpj3gym6zcyvL/796ubDk2qM6lfHTKVZtpH2tmkf9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzA81FUfegKp0dfBpnQUt8XpUpBzawuvILeJRfM+nYLMdlLKlodlV8zxWDCGKJMPW
         ZG3lFRIy+reihhtlXBx6kqEgxcyGZL/F87aP0pSv7V/qx0jwOq8hH11UiqxdbRMqHy
         pUjTUVGvXHA9qHRLvna8jym0tLANpot9QJo5pGMo=
Date:   Fri, 5 Jun 2020 17:02:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net, sfr@canb.auug.org.au,
        linux@roeck-us.net
Subject: Re: [RFC][PATCH 5/7] irq_work, smp: Allow irq_work on
 call_single_queue
Message-ID: <20200605150207.GA9599@lenoir>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.011635912@infradead.org>
 <20200528234031.GB551@lenoir>
 <20200529133641.GM706495@hirez.programming.kicks-ass.net>
 <20200605093704.GB2948@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605093704.GB2948@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 11:37:04AM +0200, Peter Zijlstra wrote:
> On Fri, May 29, 2020 at 03:36:41PM +0200, Peter Zijlstra wrote:
> > Maybe I can anonymous-union my way around it, dunno. I'll think about
> > it. I'm certainly not proud of this. But at least the BUILD_BUG_ON()s
> > should catch the more blatant breakage here.
> 
> How's this then? Differently ugly, but at least it compiles with that
> horrible struct randomization junk enabled.
> 
> ---
>  include/linux/irq_work.h  |   28 ++++++-------------
>  include/linux/sched.h     |    4 +-
>  include/linux/smp.h       |   25 ++++++-----------
>  include/linux/smp_types.h |   66 ++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/core.c       |    6 ++--
>  kernel/smp.c              |   18 ------------
>  6 files changed, 89 insertions(+), 58 deletions(-)
> 
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -2,7 +2,7 @@
>  #ifndef _LINUX_IRQ_WORK_H
>  #define _LINUX_IRQ_WORK_H
>  
> -#include <linux/llist.h>
> +#include <linux/smp_types.h>
>  
>  /*
>   * An entry can be in one of four states:
> @@ -13,26 +13,16 @@
>   * busy      NULL, 2 -> {free, claimed} : callback in progress, can be claimed
>   */
>  
> -/* flags share CSD_FLAG_ space */
> -
> -#define IRQ_WORK_PENDING	BIT(0)
> -#define IRQ_WORK_BUSY		BIT(1)
> -
> -/* Doesn't want IPI, wait for tick: */
> -#define IRQ_WORK_LAZY		BIT(2)
> -/* Run hard IRQ context, even on RT */
> -#define IRQ_WORK_HARD_IRQ	BIT(3)
> -
> -#define IRQ_WORK_CLAIMED	(IRQ_WORK_PENDING | IRQ_WORK_BUSY)
> -
> -/*
> - * structure shares layout with single_call_data_t.
> - */
>  struct irq_work {
> -	struct llist_node llnode;
> -	atomic_t flags;
> +	union {
> +		struct __call_single_node node;
> +		struct {
> +			struct llist_node llnode;
> +			atomic_t flags;
> +		};
> +	};

So why not just embed struct __call_single_node in
struct irq_work and struct __call_single_data ?

Is the point of that anonymous second union layer to
shorten the lines while accessing members?

Thanks.
