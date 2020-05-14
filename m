Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E378AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3F02065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgENL4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:56:32 -0400
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:40324 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgENL4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:56:32 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 May 2020 07:56:31 EDT
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id A6AD4C0CAE
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 12:50:52 +0100 (IST)
Received: (qmail 7587 invoked from network); 14 May 2020 11:50:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 May 2020 11:50:52 -0000
Date:   Thu, 14 May 2020 12:50:50 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200514115050.GI3758@techsingularity.net>
References: <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <CAE4VaGBq5+ucS4p+0AzFsNP7YDsg7dLZ73dzuhBerHiM4EYP_Q@mail.gmail.com>
 <20200514095055.GG3758@techsingularity.net>
 <CAE4VaGCGUFOAZ+YHDnmeJ95o4W0j04Yb7EWnf8a43caUQs_WuQ@mail.gmail.com>
 <20200514100814.GH3758@techsingularity.net>
 <CAE4VaGBwFvduqOyn8pQnN3U4ozuB=4DVx6i1vheAg-2PegvE9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGBwFvduqOyn8pQnN3U4ozuB=4DVx6i1vheAg-2PegvE9Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 12:22:05PM +0200, Jirka Hladky wrote:
> Thanks!
> 
> Do you have a link? I cannot find it on github
> (https://github.com/gormanm/mmtests, searched for
> config-network-netperf-cstate-small-cross-socket)
> 

https://github.com/gormanm/mmtests/blob/master/configs/config-network-netperf-cstate-small-cross-socket

-- 
Mel Gorman
SUSE Labs
