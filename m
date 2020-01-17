Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC9AC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0527B2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RSMVzOWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgAQPLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:11:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgAQPLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6XkN9OOxlWNG+NnNqQFZrrwnqRAB2I/Nrd6IFwG7+RY=; b=RSMVzOWHXhbXk5ybQd1Ac8U8n
        mr0pOzNXDL8GNif+bLGGz7kTu4dfR9Y1ATuXasz97lbZ1uSNU6Q58wCj9hxLDKAuMt2FE0HikFYZG
        yyGJwwGolFaHsIqxQOF7T2DRetuhzhzVGLPxzN6E8XC/2Oyy8RiIf8AiH90jcTM5ZXFUUaV9KpiM/
        Ua1abFQGKzfocrNi/931/DqM8YWzhPVSZh6QsfT6FaaW5JP44iTAfBwj0eV1UURyCU/CbQ7uJFDLC
        QyNDoFvCbEAAkPyfLJghZPnoXNvSz+LOsiKqvwObJHceNoJbQgkY7sykpk8cmUEh8TR/jvPQgPRmi
        I0q0iEddQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isTHZ-0006sX-K9; Fri, 17 Jan 2020 15:11:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 143B3300F4B;
        Fri, 17 Jan 2020 16:09:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 492602020D8FC; Fri, 17 Jan 2020 16:11:31 +0100 (CET)
Date:   Fri, 17 Jan 2020 16:11:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
Message-ID: <20200117151131.GG14879@hirez.programming.kicks-ass.net>
References: <20200114101319.GO3466@techsingularity.net>
 <CAKfTPtC7zuvWym8tSxXx6d+FhiSsedrS5sRZZagR5B7pXgZewA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtC7zuvWym8tSxXx6d+FhiSsedrS5sRZZagR5B7pXgZewA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 04:09:33PM +0100, Vincent Guittot wrote:
> On Tue, 14 Jan 2020 at 11:13, Mel Gorman <mgorman@techsingularity.net> wrote:

> > In general, the patch simply seeks to avoid unnecessary cross-node
> > migrations in the basic case where imbalances are very small.  For low
> > utilisation communicating workloads, this patch generally behaves better
> > with less NUMA balancing activity. For high utilisation, there is no
> > change in behaviour.
> >
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks all!
