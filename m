Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F950C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E4C20730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0qaYNvZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgAPPTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:19:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34730 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAPPTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=svMQJiwp5Oy+aNLrAs8hBdA9OsRR5/uwv6LYplokKl4=; b=0qaYNvZzKX6o8a8LgxCFk4HvX
        T9snhLthtVgpMr+i5rgvSc5T920218F6utSra7AWWBW0nFSlFLgIbsZ0n4HPNxhQO/QZcRTVTNP2F
        O7IM5Z8cQ8YV0WyC1eKRtBdGI7/VFRFD3gdVcX7Aav0eMV6YGs85Z6dmc/j3ZdkbY+bw/7rJncVUG
        DEmPlBC+4MT6Vb8uTOd6I+UgUQeVV+UQdN2Zkrp6d5FkfMkH6jR1JU1zwoywZZi0DEZnJSf16bYff
        6oaIG5z9uF066bicjvPmH/jPAG89wox6wqLXLNdiNhINUE7lYECNOsMSOaSQ2qndy3gQ3o+Cd9pUq
        peDXQ+sZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1is6vv-0003hI-VB; Thu, 16 Jan 2020 15:19:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50CD8302524;
        Thu, 16 Jan 2020 16:18:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 210642B6D1E1B; Thu, 16 Jan 2020 16:19:42 +0100 (CET)
Date:   Thu, 16 Jan 2020 16:19:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        prime.zeng@hisilicon.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, mingo@kernel.org
Subject: Re: [PATCH] sched/topology: Assert non-NUMA topology masks don't
 (partially) overlap
Message-ID: <20200116151942.GW2871@hirez.programming.kicks-ass.net>
References: <20200115160915.22575-1-valentin.schneider@arm.com>
 <20200116104428.GP2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116104428.GP2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:44:28AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 15, 2020 at 04:09:15PM +0000, Valentin Schneider wrote:
> > @@ -1975,6 +2011,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >  				has_asym = true;
> >  			}
> >  
> > +			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
> > +				goto error;
> > +
> >  			sd = build_sched_domain(tl, cpu_map, attr, sd, dflags, i);
> >  
> >  			if (tl == sched_domain_topology)
> 
> This is O(nr_cpus), but then, that function already is, so I don't see a
> problem with this.

Clearly I meant to write O(nr_cpus^2), there's a bunch of nested
for_each_cpu() in there.

> I'll take it, thanks!
