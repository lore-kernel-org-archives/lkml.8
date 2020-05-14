Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C7FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E172065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgENKIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:08:18 -0400
Received: from outbound-smtp54.blacknight.com ([46.22.136.238]:48215 "EHLO
        outbound-smtp54.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgENKIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:08:17 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp54.blacknight.com (Postfix) with ESMTPS id EEEF7FADE8
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:08:15 +0100 (IST)
Received: (qmail 3837 invoked from network); 14 May 2020 10:08:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 May 2020 10:08:15 -0000
Date:   Thu, 14 May 2020 11:08:14 +0100
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
Message-ID: <20200514100814.GH3758@techsingularity.net>
References: <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <CAE4VaGBq5+ucS4p+0AzFsNP7YDsg7dLZ73dzuhBerHiM4EYP_Q@mail.gmail.com>
 <20200514095055.GG3758@techsingularity.net>
 <CAE4VaGCGUFOAZ+YHDnmeJ95o4W0j04Yb7EWnf8a43caUQs_WuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGCGUFOAZ+YHDnmeJ95o4W0j04Yb7EWnf8a43caUQs_WuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 11:58:36AM +0200, Jirka Hladky wrote:
> Thank you, Mel!
> 
> We are using netperf as well, but AFAIK it's running on two different
> hosts. I will check with colleagues, if they can
> add network-netperf-unbound run on the localhost.
> 
> Is this the right config?
> https://github.com/gormanm/mmtests/blob/345f82bee77cbf09ba57f470a1cfc1ae413c97df/bin/generate-generic-configs
> sed -e 's/NETPERF_BUFFER_SIZES=.*/NETPERF_BUFFER_SIZES=64/'
> config-network-netperf-unbound > config-network-netperf-unbound-small
> 

That's one I was using at the moment to have a quick test after
the reconciliation series was completed. It has since changed to
config-network-netperf-cstate-small-cross-socket to limit cstates, bind
the client and server to two local CPUs and using one buffer size. It
was necessary to get an ftrace function graph of the wakeup path that
was readable and not too noisy due to migrations, cpuidle exit costs etc.

-- 
Mel Gorman
SUSE Labs
