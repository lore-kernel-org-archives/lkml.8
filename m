Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7381C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803AD206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgFKOn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:43:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:55066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbgFKOn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:43:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0E820AC51;
        Thu, 11 Jun 2020 14:43:30 +0000 (UTC)
Date:   Thu, 11 Jun 2020 15:43:24 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, iwtbavbm@gmail.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/fair: fix nohz next idle balance
Message-ID: <20200611144324.GD3129@suse.de>
References: <20200609123748.18636-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200609123748.18636-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 02:37:48PM +0200, Vincent Guittot wrote:
> With commit:
>   'b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")'
> rebalance_domains of the local cfs_rq happens before others idle cpus have
> updated nohz.next_balance and its value is overwritten.
> 
> Move the update of nohz.next_balance for other idles cpus before balancing
> and updating the next_balance of local cfs_rq.
> 
> Also, the nohz.next_balance is now updated only if all idle cpus got a
> chance to rebalance their domains and the idle balance has not been aborted
> because of new activities on the CPU. In case of need_resched, the idle
> load balance will be kick the next jiffie in order to address remaining
> ilb.
> 
> Reported-by: Peng Liu <iwtbavbm@gmail.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
