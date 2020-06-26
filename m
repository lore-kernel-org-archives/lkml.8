Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB80BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8BE2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v7iDdDE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgFZK2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgFZK2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:28:03 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0ECC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hs96HbG/Xh5+3hw6mjPm+ejHwdnSqO9Gma802aQU/fg=; b=v7iDdDE1GlK/vC1H80dQ1JCmjT
        NCIZLejpRZ0GIjobeJHhdgldeYqws637KzGAYqfr/Z3x9WcUkTPFK7WXZ5+tjmfNj0Jlgl1wFg0qL
        xXWbp+SxjIMP38wIY2/4wmA+z25ALxpS4X2qxrSOlJrSoiHkAk5plu958PNi5L4sToGv182ax7F3+
        n7xdR9m/HBUuMpx0+lpCwF2gCqnbxLLSx6xEzf+FXuKpSQ/9X85fSNwbSm93VfKczM0V1kP7UYkfB
        JtzQ30c/oDf1hocX3UlIf7x8FjFbtVMTWj3yBOaJIxSEi/XjFtjuFmCIZHZWXrLCLm6YyS2h1kCxN
        jV7LVSxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jolZr-0001F9-70; Fri, 26 Jun 2020 10:27:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6977E3007CD;
        Fri, 26 Jun 2020 12:27:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5048B20BE639D; Fri, 26 Jun 2020 12:27:22 +0200 (CEST)
Date:   Fri, 26 Jun 2020 12:27:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] sched: Optionally skip uclamp logic in fast path
Message-ID: <20200626102722.GA4817@hirez.programming.kicks-ass.net>
References: <20200625154352.24767-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625154352.24767-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 04:43:50PM +0100, Qais Yousef wrote:
> Qais Yousef (2):
>   sched/uclamp: Fix initialization of struct uclamp_rq
>   sched/uclamp: Protect uclamp fast path code with static key
> 
>  kernel/sched/core.c              | 80 ++++++++++++++++++++++++++++----
>  kernel/sched/cpufreq_schedutil.c |  2 +-
>  kernel/sched/sched.h             |  7 +++
>  3 files changed, 79 insertions(+), 10 deletions(-)

Thanks!
