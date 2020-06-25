Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1593C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D244520672
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbgFYAKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:10:02 -0400
Received: from foss.arm.com ([217.140.110.172]:57682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388061AbgFYAKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:10:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A8081FB;
        Wed, 24 Jun 2020 17:10:01 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABDC13F6CF;
        Wed, 24 Jun 2020 17:09:59 -0700 (PDT)
References: <20200624172605.26715-1-qais.yousef@arm.com> <20200624172605.26715-2-qais.yousef@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] sched/uclamp: Fix initialization of strut uclamp_rq
In-reply-to: <20200624172605.26715-2-qais.yousef@arm.com>
Date:   Thu, 25 Jun 2020 01:09:54 +0100
Message-ID: <jhj7dvwrood.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/20 18:26, Qais Yousef wrote:
> struct uclamp_rq was zeroed out entirely in assumption that in the first
> call to uclamp_rq_inc() they'd be initialized correctly in accordance to
> default settings.
>
> But when next patch introduces a static key to skip
> uclamp_rq_{inc,dec}() until userspace opts in to use uclamp, schedutil
> will fail to perform any frequency changes because the
> rq->uclamp[UCLAMP_MAX].value is zeroed at init and stays as such. Which
> means all rqs are capped to 0 by default.
>
> Fix it by making sure we do proper initialization at init without
> relying on uclamp_rq_inc() doing it later.
>
> Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> CC: Patrick Bellasi <patrick.bellasi@matbug.net>
> Cc: Chris Redpath <chris.redpath@arm.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>


