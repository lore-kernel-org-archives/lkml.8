Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D4EC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1102073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMou+tiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgBMPAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:00:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37552 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725781AbgBMPAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581606041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mS8HSIrPqIGt4Gqhb5Ucgp3mXTU2UblfRhbkdd/ImLw=;
        b=iMou+tiuivNyRdmS0ADnyfWSvZWqm0ULO9p5haxE4XavDcQdOq7kZriFZnOthh+9p4uHPH
        Wrj1LBM/CDzl6iPA+9t3YOS6k3cRapRU/QxRTZjLhs2ge8U+sM/PKQsI7kJVPIW7UEx2Qp
        XYBVmPw9qmoB7NKntfuafaHx+k2XM5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-LQMoDHeyNn6TjPj8kEtIHA-1; Thu, 13 Feb 2020 10:00:35 -0500
X-MC-Unique: LQMoDHeyNn6TjPj8kEtIHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BEB2DB6F;
        Thu, 13 Feb 2020 15:00:33 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-117-160.phx2.redhat.com [10.3.117.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AE935C102;
        Thu, 13 Feb 2020 15:00:28 +0000 (UTC)
Date:   Thu, 13 Feb 2020 10:00:26 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Hillf Danton <hdanton@sina.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [RFC 2/4] sched/numa: replace runnable_load_avg by load_avg
Message-ID: <20200213150026.GB6541@lorien.usersys.redhat.com>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-3-vincent.guittot@linaro.org>
 <20200212133715.GU3420@suse.de>
 <20200212194903.GS3466@techsingularity.net>
 <CAKfTPtDA5GamN4A1SnegYwYCk123TqUDE9EHFbHTgKCMR+yqGQ@mail.gmail.com>
 <20200213131658.9600-1-hdanton@sina.com>
 <20200213134655.GX3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213134655.GX3466@techsingularity.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 01:46:55PM +0000 Mel Gorman wrote:
> On Thu, Feb 13, 2020 at 09:16:58PM +0800, Hillf Danton wrote:
> > > -	load = task_h_load(env->p);
> > > -	dst_load = env->dst_stats.load + load;
> > > -	src_load = env->src_stats.load - load;
> > > -
> > >  	/*
> > > -	 * If the improvement from just moving env->p direction is better
> > > -	 * than swapping tasks around, check if a move is possible.
> > > +	 * If dst node has spare capacity, then check if there is an
> > > +	 * imbalance that would be overruled by the load balancer.
> > >  	 */
> > > -	maymove = !load_too_imbalanced(src_load, dst_load, env);
> > > +	if (env->dst_stats.node_type == node_has_spare) {
> > > +		unsigned int imbalance;
> > > +		int src_running, dst_running;
> > > +
> > > +		/* Would movement cause an imbalance? */
> > > +		src_running = env->src_stats.nr_running - 1;
> > > +		dst_running = env->src_stats.nr_running + 1;
> > > +		imbalance = max(0, dst_running - src_running);
> > 
> > Have trouble working out why 2 is magician again to make your test data nicer :P
> > 
> 
> This is calculating what the nr_running would be after the move and
> checking if an imbalance exists after the move forcing the load balancer
> to intervene.

Isn't that always going to work out to 2? 


Cheers,
Phil

> 
> -- 
> Mel Gorman
> SUSE Labs
> 

-- 

