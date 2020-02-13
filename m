Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B63C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA68C20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="086QjF+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgBMKbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:31:31 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46482 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMKba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wGenxf8UJH3izSqwDx/MBzsW0er3OIFpLvfK35ZpkIE=; b=086QjF+UsBncBX6aGl6GNjoS7r
        vlwpOT3AVbX5mAt3khO6zseZ4xHUmYr5YgCvsEOi3B/5GZUgvNPpZAERyN9Q71e8owhHAaQ58xx3/
        tBITRL4NzDRfUYNnPrgk5CU/AIWu1TaDq50mUMtHaugjzbuhDAZrIx59kfKI8vmSYZD2Vl2l72g5I
        9fnSaUzvWrDGOOwG+aknLsoS7bli1wFyoJ6c9hm2aKs0MnUKoCetNxdsTaS9cleDFKxL9/0uqVxqV
        UXkVb7LoW+aekkeA03M9L6NkUZxt2EFHNtSjMyd+qC3Ahn594Ms7vTda3fx1RwCijgEXEDwUQo0tn
        AvDTE3zA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2Bm3-0007uX-Cl; Thu, 13 Feb 2020 10:31:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2EFEC300446;
        Thu, 13 Feb 2020 11:29:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB29720206D61; Thu, 13 Feb 2020 11:31:08 +0100 (CET)
Date:   Thu, 13 Feb 2020 11:31:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/11] sched/numa: Bias swapping tasks based on their
 preferred node
Message-ID: <20200213103108.GG14914@hirez.programming.kicks-ass.net>
References: <20200212093654.4816-1-mgorman@techsingularity.net>
 <20200212093654.4816-9-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212093654.4816-9-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 09:36:51AM +0000, Mel Gorman wrote:
> When swapping tasks for NUMA balancing, it is preferred that tasks move
> to or remain on their preferred node. When considering an imbalance,
> encourage tasks to move to their preferred node and discourage tasks from
> moving away from their preferred node.

Wasn't there an issue for workloads that span multiple nodes?

Say a 4 node system with 2 warehouses? Then each JVM will want 2 nodes,
instead of a single node, and strong preferred node stuff makes it
difficult to achieve this.

I forgot how we dealt with these cases, just something I worry about
when reading this.
