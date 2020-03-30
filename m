Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3065EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8E020716
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0pGJ266V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgC3L23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:28:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52698 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbgC3L23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6HSKuiUK92cwLefCahGkgWj1LgTRxgjNuT2ADazqsek=; b=0pGJ266VLnq8q9CG2dCeXKvW4s
        zG14zn5P7ZAJMM/U4wtxqxU6/OkwkcJYK0PFLUTdKcLp7xKJV3wU8gjA+FHIh2xGqmAxY76d6AZRt
        V1Mn/xpGwyvr1vBn+aypfyMxXJ3RYq1YeRODjm4sjgRe3ln7DxVI7vERSLqnQ5YuNnD3dOXWn6Qfn
        fIyXFLf+/aOBx4wuzSg+PF6rYbb6OiU+zuv7tjeG2DoizD+OxSMiuSN8Izki5OFdOep/bOED0imps
        j7VQIztSRJgNF5PYu+YFoH60ndZXkPsg60XWk/q1mfdxZgRlY+UykBwDGHmTSkENPqm8jvs83Iz1R
        p4Oig+1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIsaA-0002Ed-Jq; Mon, 30 Mar 2020 11:27:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C4DE1300F28;
        Mon, 30 Mar 2020 13:27:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE03329D04D69; Mon, 30 Mar 2020 13:27:52 +0200 (CEST)
Date:   Mon, 30 Mar 2020 13:27:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     julia.lawall@lip6.fr, boqun.feng@gmail.com,
        Jules Irenge <jbi.octave@example.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/10] sched/topology: Replace 1 and 0 by boolean value
Message-ID: <20200330112752.GJ20696@hirez.programming.kicks-ass.net>
References: <0/10>
 <20200327212358.5752-1-jbi.octave@gmail.com>
 <20200327212358.5752-3-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327212358.5752-3-jbi.octave@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:23:49PM +0000, Jules Irenge wrote:
> From: Jules Irenge <jbi.octave@example.com>
> 
> Coccinelle reports a warning inside sched_energy_aware_handler()
> 
> WARNING: Assignment of 0/1 to bool variable

That's definitely not a warning and quite sensible in any case. Please
learn C.
