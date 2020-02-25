Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31D6C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B050A20658
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbgBYOYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:24:35 -0500
Received: from outbound-smtp05.blacknight.com ([81.17.249.38]:38356 "EHLO
        outbound-smtp05.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729721AbgBYOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:24:35 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id 15E90CCA65
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 14:24:33 +0000 (GMT)
Received: (qmail 7086 invoked from network); 25 Feb 2020 14:24:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Feb 2020 14:24:32 -0000
Date:   Tue, 25 Feb 2020 14:24:30 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200225142430.GC3466@techsingularity.net>
References: <20200224095223.13361-1-mgorman@techsingularity.net>
 <20200224151641.GA24316@gmail.com>
 <20200225115901.GB3466@techsingularity.net>
 <CAKfTPtDN-XP7LAyy-zQ-J=nxv5M1x_f2AZ2qJ8CK6B82f5WwYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDN-XP7LAyy-zQ-J=nxv5M1x_f2AZ2qJ8CK6B82f5WwYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 02:28:16PM +0100, Vincent Guittot wrote:
> >
> > Will do.
> >
> > However I noticed that "sched/fair: Fix find_idlest_group() to handle
> > CPU affinity" did not make it to tip/sched/core. Peter seemed to think it
> > was fine. Was it rejected or is it just sitting in Peter's queue somewhere?
> 
> The patch has already reached mainline through tip/sched-urgent-for-linus
> 

Bah, I pasted the wrong subject. I am thinking of your
patch "sched/fair: fix statistics for find_idlest_group" --
https://lore.kernel.org/lkml/20200218144534.4564-1-vincent.guittot@linaro.org/
It still appears to be relevant or did I miss something else?

-- 
Mel Gorman
SUSE Labs
