Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C59C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5249D217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgBNHut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:50:49 -0500
Received: from outbound-smtp63.blacknight.com ([46.22.136.252]:44713 "EHLO
        outbound-smtp63.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725990AbgBNHut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:50:49 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id E35A8FAE43
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 07:50:46 +0000 (GMT)
Received: (qmail 27957 invoked from network); 14 Feb 2020 07:50:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Feb 2020 07:50:46 -0000
Date:   Fri, 14 Feb 2020 07:50:45 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/11] sched/numa: Bias swapping tasks based on their
 preferred node
Message-ID: <20200214075045.GB3466@techsingularity.net>
References: <20200212093654.4816-1-mgorman@techsingularity.net>
 <20200214041232.18904-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200214041232.18904-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 12:12:32PM +0800, Hillf Danton wrote:
> > +	if (cur->numa_preferred_nid == env->dst_nid)
> > +		imp -= imp / 16;
> > +
> > +	/*
> > +	 * Encourage picking a task that moves to its preferred node.
> > +	 * This potentially makes imp larger than it's maximum of
> > +	 * 1998 (see SMALLIMP and task_weight for why) but in this
> > +	 * case, it does not matter.
> > +	 */
> > +	if (cur->numa_preferred_nid == env->src_nid)
> > +		imp += imp / 8;
> > +
> >  	if (maymove && moveimp > imp && moveimp > env->best_imp) {
> >  		imp = moveimp;
> >  		cur = NULL;
> >  		goto assign;
> >  	}
> >  
> > +	/*
> > +	 * If a swap is required then prefer moving a task to its preferred
> > +	 * nid over a task that is not moving to a preferred nid.
> 
> after checking if imp is above SMALLIMP.
> 

It is preferable to move a task to its preferred node over one that
does not even if the improvement is lsss than SMALLIMP. The reasoning is
that NUMA balancing retries moving tasks to their preferred node
periodically and moving "now" reduces the chance of a task having to
retry its move later.

-- 
Mel Gorman
SUSE Labs
