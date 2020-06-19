Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AE6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7CA206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="toRtjS2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390434AbgFSTsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390375AbgFSTsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:48:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE12DC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JyoFHOysemYMV4OtT/Cn9dnH7GbrwqvQTPVUggspfwk=; b=toRtjS2dGGLS+laiL9DUPLTG5U
        4kn3stmgbaPlkbIxHqDIRuugIMeZLwsCZI1WCCrzU7ReoJCWrQ64ST4Q2HH7HKkFVFWKKab/mMTcc
        uUjRImaYUhSoFkF15DWx14nOlIuf054AjW2DsjyzAejKAuXeO0Jrap4cn1SxMqZc/krJB3TZp9pad
        BHP2ltr64PgCXxrOVjzoCbOxTT9vAEOR3mf+SX9ngHVZBmomQ6I0mpb3M6gtGpnmL0rkH1wSxHWqx
        Nqk6IOo8Z819g1rN/2x9t+KbdQx4v5fmvKIMFKlsTQ2GvqkAbkjH6aW7BYY09A5dC4VwNQ7Bgw/jM
        MI99CQnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmMzP-0005Yk-WC; Fri, 19 Jun 2020 19:47:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 060B03003E5;
        Fri, 19 Jun 2020 21:47:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E135F2C36DD88; Fri, 19 Jun 2020 21:47:49 +0200 (CEST)
Date:   Fri, 19 Jun 2020 21:47:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200619194749.GK576888@hirez.programming.kicks-ass.net>
References: <20200618195525.7889-1-qais.yousef@arm.com>
 <20200618195525.7889-3-qais.yousef@arm.com>
 <jhjwo43cpfl.mognet@arm.com>
 <20200619125148.y4cq3hwllgozbutq@e107158-lin.cambridge.arm.com>
 <jhjsgerchmn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjsgerchmn.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 02:25:20PM +0100, Valentin Schneider wrote:
> 
> On 19/06/20 13:51, Qais Yousef wrote:
> > On 06/19/20 11:36, Valentin Schneider wrote:
> >>
> >> On 18/06/20 20:55, Qais Yousef wrote:
> >> > There is a report that when uclamp is enabled, a netperf UDP test
> >> > regresses compared to a kernel compiled without uclamp.
> >> >
> >> > https://lore.kernel.org/lkml/20200529100806.GA3070@suse.de/
> >> >
> >>
> >> ISTR the perennial form for those is: https://lkml.kernel.org/r/<message-id>
> >
> > The link is correct permalinnk from lore and contains the message-id as Peter
> > likes and he has accepted this form before.
> >
> 
> I think the objections I remember were on using lkml.org rather than
> lkml.kernel.org. Sorry!

:-) Yeah, lkml.org is bad.

That said, I prefer the lkml.kernel.org/r/ variant over
lore.kernel.org/lkml/ in part because it existed first and I'm lazy, in
part because it's shorter and in part because lkml.kernel.org/r/ is an
explicit redirect and lore is 'just' an archive it can redirect to
(although admittedly, it looks rather unlikely lore is going to die).

I'll not make a big point of it though and will in all likelyhood accept
lore links. The important point is that it has the MessageID in.
