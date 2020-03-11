Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA36C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFAF22464
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgCKOAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729479AbgCKOAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:00:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2385C21D7E;
        Wed, 11 Mar 2020 14:00:22 +0000 (UTC)
Date:   Wed, 11 Mar 2020 10:00:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] sched/rt: Fix pushing unfit tasks to a better
 CPU
Message-ID: <20200311100020.63bb81e5@gandalf.local.home>
In-Reply-To: <20200302132721.8353-7-qais.yousef@arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
        <20200302132721.8353-7-qais.yousef@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Mar 2020 13:27:21 +0000
Qais Yousef <qais.yousef@arm.com> wrote:

> +			 * Don't bother moving it if the destination CPU is
> +			 * not running a lower priority task.
> +			 */
> +			if (p->prio < cpu_rq(target)->rt.highest_prio.curr) {
> +
> +				cpu = target;
> +
> +			} else if (p->prio == cpu_rq(target)->rt.highest_prio.curr) {
> +
> +				/*
> +				 * If the priority is the same and the new CPU
> +				 * is a better fit, then move, otherwise don't
> +				 * bother here either.
> +				 */
> +				if (fit_target)
> +					cpu = target;
> +			}

BTW, A little better algorithm would be to test fit_target first:

	target_prio = cpu_rq(target)->rt.hightest_prio.curr;
	if (p->prio < target_prio) {
		cpu = target;

	} else if (fit_target && p->prio == target_prio) {
		cpu = target;
	}

Which can also just be a single if statement:

	if (p->prio < target_prio ||
	    (fit_target && p->prio == target_prio)
		cpu = target;

-- Steve
