Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC31C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 22:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E23820737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 22:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGXWSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 18:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgGXWSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 18:18:50 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1D71206D7;
        Fri, 24 Jul 2020 22:18:48 +0000 (UTC)
Date:   Fri, 24 Jul 2020 18:18:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peterz@infradead.org
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, sfr@canb.auug.org.au
Subject: Re: [PATCH v2] sched,tracing: Convert to sched_set_fifo()
Message-ID: <20200724181846.415bfd43@oasis.local.home>
In-Reply-To: <20200724215003.GY119549@hirez.programming.kicks-ass.net>
References: <202006192249.AYnVBGCH%lkp@intel.com>
        <20200709124505.GT597537@hirez.programming.kicks-ass.net>
        <20200709115818.36a956a4@oasis.local.home>
        <20200720214918.GM5523@worktop.programming.kicks-ass.net>
        <20200724213911.GX119549@hirez.programming.kicks-ass.net>
        <20200724174618.7487ee7c@oasis.local.home>
        <20200724215003.GY119549@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 23:50:03 +0200
peterz@infradead.org wrote:

> -	if (producer_fifo < 0)
> +	if (producer_fifo)
> +		trace_printk("Running Producer at SCHED_FIFO %s\n",
> +			     consumer_fifo == 1 ? "low" : "high");

I'm going to take cut-and-paste away from you!

-- Steve

> +	else
>  		trace_printk("Running Producer at nice: %d\n",
>  			     producer_nice);
