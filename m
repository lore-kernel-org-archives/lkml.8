Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02619C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF04020679
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dDyV+xKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgBQOwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:52:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgBQOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U7gTvZ10HqXW1+B6BzN1yumffwsvQ1VIrk/v3lBL9EU=; b=dDyV+xKXUACPSRwFjJ64uIae5N
        hFCxS8VjHW7zRILDJ0hS5rWM52kUuyYng5eYEtqxuO/2hE9XG8DTpLER4uLcspOkhktwCoiYBAFnC
        hznRwgWQBylH06QdyCXH97a+cXOD9gXFf7HRCsEXcBZfgMYpGsj5zo+FuI/IaFdXZ9YTHmawdNj9T
        qzG/lxrxJeuQ4Z4DDJuubx+3mOfaHvYPAQwTtbj3RBTLzhpJwCzOoG5AC42DRPdJzF7Nn4LHOQUlh
        tmxmtbj/v5NH2sRkg2M5yVcnO729UFbo/ifmNMq25piEb7XG2emF6R8dzIOcSmz6A9PzQ/drqVLSl
        GSIpE2+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3hkx-00036p-65; Mon, 17 Feb 2020 14:52:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3286300565;
        Mon, 17 Feb 2020 15:50:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 527372B910518; Mon, 17 Feb 2020 15:52:16 +0100 (CET)
Date:   Mon, 17 Feb 2020 15:52:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v3
Message-ID: <20200217145216.GR14897@hirez.programming.kicks-ass.net>
References: <20200217104402.11643-1-mgorman@techsingularity.net>
 <CAKfTPtBfV1QGi2utnmnR21MapKw1g2mTFA_aRxOxXvpWTRX+wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBfV1QGi2utnmnR21MapKw1g2mTFA_aRxOxXvpWTRX+wA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 02:49:11PM +0100, Vincent Guittot wrote:
> > Patches 4-5 are Vincent's and use very similar code patterns and logic
> > between NUMA and load balancer. Patch 6 is a fix to Vincent's work that
> > is necessary to avoid serious imbalances being introduced by the NUMA
> 
> Yes the test added in load_too_imbalanced() by patch 5 doesn't seem to
> be a good choice.
> I haven't remove it as it was done by your patch 6 but it might worth
> removing it directly if a new version is needed

Aside of that, Vincent's patches look good to me.
