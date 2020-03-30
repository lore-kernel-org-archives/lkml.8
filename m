Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AAFC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEB820716
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dMeR4qgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgC3Ki5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:38:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbgC3Ki5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=37Z3XupjvWeAcvRiuidNzgU0QpNgt+SOg1Q6TalKv8c=; b=dMeR4qgodSbCAA4ekZ7qrLzWs4
        aSQ0TJlbWAC2t9ov1DtiJd2uNIb1MJCv3i/PRJfAF7DbKrIrWRF1GAMyS2babVMPAEchCpSbJwJRK
        S/GBhE4Nh8YbqeXTaD3hPs4Yn5CU2X8KFG7Dm5mtC0ekV1I4R2Yk6+Hc1/X/HHkFyf2x0XQiQF0l8
        DGoLuJ9tbPPFm7pK2jaa/4sFVNzqn1sg1qYx+vcdqvlxm+869VNTbEBK4QPRr8KMxiOJCd3uZ5Adh
        2Jy80QxbWNj1j6EpBQ5lV2qb+83smCGcDMWWqTlQrUqSp2PQTT+tB7Q4UNfuebvz6GweGTqMp9q8t
        6cqhFTnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIroX-0006iT-W2; Mon, 30 Mar 2020 10:38:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 168AE30015A;
        Mon, 30 Mar 2020 12:38:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E619D2856DC0F; Mon, 30 Mar 2020 12:38:38 +0200 (CEST)
Date:   Mon, 30 Mar 2020 12:38:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Aubrey Li <aubrey.li@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH] sched/fair: Fix negative imbalance in imbalance
 calculation
Message-ID: <20200330103838.GE20696@hirez.programming.kicks-ass.net>
References: <1585201349-70192-1-git-send-email-aubrey.li@intel.com>
 <CAKfTPtBWQDkmkuxPTEC8QY1PXicZ51w7tjDPRm2rYM+8QN5rLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBWQDkmkuxPTEC8QY1PXicZ51w7tjDPRm2rYM+8QN5rLQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 05:03:10PM +0100, Vincent Guittot wrote:
> On Thu, 26 Mar 2020 at 06:53, Aubrey Li <aubrey.li@intel.com> wrote:
> >
> > A negative imbalance value was observed after imbalance calculation,
> > this happens when the local sched group type is group_fully_busy,
> > and the average load of local group is greater than the selected
> > busiest group. Fix this problem by comparing the average load of the
> > local and busiest group before imbalance calculation formula.
> >
> > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> > Cc: Phil Auld <pauld@redhat.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
