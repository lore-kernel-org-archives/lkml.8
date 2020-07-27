Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0040BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F822070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgG0PXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:23:11 -0400
Received: from foss.arm.com ([217.140.110.172]:46718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbgG0PXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:23:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96F94D6E;
        Mon, 27 Jul 2020 08:23:10 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 970BB3F718;
        Mon, 27 Jul 2020 08:23:09 -0700 (PDT)
Date:   Mon, 27 Jul 2020 16:23:03 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: provide u64 read for 32-bits arch helper
Message-ID: <20200727152303.GA301827@e120877-lin.cambridge.arm.com>
References: <1595847564-239957-1-git-send-email-vincent.donnefort@arm.com>
 <20200727123801.GJ119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727123801.GJ119549@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 02:38:01PM +0200, peterz@infradead.org wrote:
> On Mon, Jul 27, 2020 at 11:59:24AM +0100, vincent.donnefort@arm.com wrote:
> > From: Vincent Donnefort <vincent.donnefort@arm.com>
> > 
> > Introducing two macro helpers u64_32read() and u64_32read_set_copy() to
> > factorize the u64 vminruntime and last_update_time read on a 32-bits
> > architecture. Those new helpers encapsulate smp_rmb() and smp_wmb()
> > synchronization and therefore, have a small penalty in set_task_rq_fair()
> > and init_cfs_rq().
> > 
> > The choice of using a macro over an inline function is driven by the
> > conditional u64 variable copy declarations.
> > 
> >   #ifndef CONFIG_64BIT
> >      u64 [vminruntime|last_update_time]_copy;
> >   #endif
> 
> This lacks a *why*... why did you get up this morning and wrote us this
> patch.
> 
>

For 32-bit architectures, both min_vruntime and last_update_time are using
similar access. This patch is simply an attempt to unify their usage by
introducing two macros to rely on when accessing those. At the same time, it
brings a comment regarding the barriers usage, as per the kernel policy. So
overall this is just a clean-up without any functional changes.

-- 
Vincent.
