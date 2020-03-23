Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ECFC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E98820735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgCWNaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:30:30 -0400
Received: from foss.arm.com ([217.140.110.172]:49058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgCWNa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:30:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12D151FB;
        Mon, 23 Mar 2020 06:30:29 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D9823F52E;
        Mon, 23 Mar 2020 06:30:28 -0700 (PDT)
References: <20200320151245.21152-1-mgorman@techsingularity.net> <20200320151245.21152-3-mgorman@techsingularity.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] sched/fair: Track efficiency of task recent_used_cpu
In-reply-to: <20200320151245.21152-3-mgorman@techsingularity.net>
Date:   Mon, 23 Mar 2020 13:30:25 +0000
Message-ID: <jhj1rpjmc5q.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Mar 20 2020, Mel Gorman wrote:
> SIS Recent Used Hit: A recent CPU was eligible and used. Each hit is
>       a domain search avoided.
>
> SIS Recent Used Miss: A recent CPU was eligible but unavailable. Each
>       time this is hit, there was a penalty to the fast path before
>       a domain search happened.
>
> SIS Recent Success Rate: A percentage of the number of hits versus
>       the total attempts to use the recent CPU.
>
> SIS Recent Attempts: The total number of times the recent CPU was examined.
>       A high number of Recent Attempts with a low Success Rate implies
>       the fast path is being punished severely. This could have been
>       presented as a weighting of hits and misses but calculating an
>       appropriate weight for misses is problematic.
>

Ditto on the raw vs post-processed detail in the changelog, otherwise:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
