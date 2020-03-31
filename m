Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874C5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649BA206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbgCaKdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:33:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:38938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730217AbgCaKdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:33:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 42A83BC21;
        Tue, 31 Mar 2020 10:33:37 +0000 (UTC)
Date:   Tue, 31 Mar 2020 11:33:33 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [GIT PULL] scheduler changes for v5.7
Message-ID: <20200331103333.GM3772@suse.de>
References: <20200330173159.GA128106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200330173159.GA128106@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 07:31:59PM +0200, Ingo Molnar wrote:
> Linus,
> 
> Please pull the latest sched-core-for-linus git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus
> 
>    # HEAD: 313f16e2e35abb833eab5bdebc6ae30699adca18 Merge branch 'sched/rt' into sched/core, to pick up completed topic tree
> 
> The main changes in this cycle are:
> 
>  - Various NUMA scheduling updates: harmonize the load-balancer and NUMA 
>    placement logic to not work against each other. The intended result is 
>    better locality, better utilization and fewer migrations.
> 

Thanks Ingo.

I noticed that the following patch did not make it to the list.

sched/fair: Fix negative imbalance in imbalance calculation
https://lore.kernel.org/lkml/1585201349-70192-1-git-send-email-aubrey.li@intel.com/

I think it's still relevant even after 6ce4b05e75f6 ("sched/fair: Improve
spreading of utilization") but I could be missing something obvious.

-- 
Mel Gorman
SUSE Labs
