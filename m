Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379B3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFD62075D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgGBKyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:54:40 -0400
Received: from foss.arm.com ([217.140.110.172]:38268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgGBKyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:54:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82FB61FB;
        Thu,  2 Jul 2020 03:54:39 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63C613F71E;
        Thu,  2 Jul 2020 03:54:38 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:54:36 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v2] Sched: Add a tracepoint to track rq->nr_running
Message-ID: <20200702105435.na2vumpnov5w5tis@e107158-lin.cambridge.arm.com>
References: <20200619141120.1476-1-pauld@redhat.com>
 <20200629192303.GC120228@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200629192303.GC120228@lorien.usersys.redhat.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/20 15:23, Phil Auld wrote:
> Add a bare tracepoint trace_sched_update_nr_running_tp which tracks
> ->nr_running CPU's rq. This is used to accurately trace this data and
> provide a visualization of scheduler imbalances in, for example, the
> form of a heat map.  The tracepoint is accessed by loading an external
> kernel module. An example module (forked from Qais' module and including
> the pelt related tracepoints) can be found at:
> 
>   https://github.com/auldp/tracepoints-helpers.git
> 
> A script to turn the trace-cmd report output into a heatmap plot can be
> found at:
> 
>   https://github.com/jirvoz/plot-nr-running
> 
> The tracepoints are added to add_nr_running() and sub_nr_running() which
> are in kernel/sched/sched.h. In order to avoid CREATE_TRACE_POINTS in
> the header a wrapper call is used and the trace/events/sched.h include
> is moved before sched.h in kernel/sched/core.
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> CC: Qais Yousef <qais.yousef@arm.com>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Vincent Guittot <vincent.guittot@linaro.org>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: linux-kernel@vger.kernel.org
> ---

LGTM.

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks

--
Qais Yousef
