Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC87EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B489A2071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgGWPvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:51:25 -0400
Received: from foss.arm.com ([217.140.110.172]:47906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgGWPvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:51:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FC831FB;
        Thu, 23 Jul 2020 08:51:24 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DB4B3F66F;
        Thu, 23 Jul 2020 08:51:22 -0700 (PDT)
Date:   Thu, 23 Jul 2020 16:51:20 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] sched/uclamp: Fix a deadlock when enabling uclamp
 static key
Message-ID: <20200723155119.gs34voui4jx7cilb@e107158-lin.cambridge.arm.com>
References: <20200716110347.19553-1-qais.yousef@arm.com>
 <20200716110347.19553-4-qais.yousef@arm.com>
 <20200716111328.zkhncw2aurrs4mad@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716111328.zkhncw2aurrs4mad@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/20 12:13, Qais Yousef wrote:
> On 07/16/20 12:03, Qais Yousef wrote:
> 
> [...]
> 
> > Fix by ensuring we enable the key outside of the critical section in
> > __sched_setscheduler()
> > 
> > Fixes: 46609ce22703 ("sched/uclamp: Protect uclamp fast path code with static key")
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> 
> I am assuming this Fixes tag is still valid given the patch is only in
> tip/sched/core only. And that the hash value won't change after Linus merges
> it.

Gentle ping that this patch is actually a fix that I happened to uncover while
testing this series.

Happy to send separately. It should apply on its own too as it has no
dependency on previous patches.

Thanks

--
Qais Yousef
