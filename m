Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62750C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A3F2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgHKLB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:01:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:43620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbgHKLB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:01:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5AE3CAD1F;
        Tue, 11 Aug 2020 11:02:17 +0000 (UTC)
Date:   Tue, 11 Aug 2020 12:01:54 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     ????????? <tianchen.dingtianc@alibaba-inc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ?????? <yun.wang@linux.alibaba.com>
Subject: Re: [RFC PATCH] sched/numa: fix bug in update_task_scan_period
Message-ID: <20200811110154.GY3510@suse.de>
References: <44875b14-00ea-4e61-aba7-4809808c4b2a.tianchen.dingtianc@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <44875b14-00ea-4e61-aba7-4809808c4b2a.tianchen.dingtianc@alibaba-inc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 04:30:31PM +0800, ????????? wrote:
> When p->numa_faults_locality[2] > 0, numa_scan_period is doubled, but
> this array will never be cleared, which causes scanning period always
> reaching its max value. This patch clears numa_faults_locality after
> numa_scan_period being doubled to fix this bug.
> 

An out label at the end of the function to clears numa_faults_locality
would also work with a comment explaining why.  That aside, what is
the user-visible impact of the patch? If there are no useful faults or
migration failures, it makes sense that scanning is very slow until the
situation changes. The corner case is that a migration failure might keep
the scan rate slower than it should be but the flip side is that fixing
it might increase the scan rate and still incur migration failures which
introduces overhead with no gain.

-- 
Mel Gorman
SUSE Labs
