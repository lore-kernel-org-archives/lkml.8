Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F574C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4ECE2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="If4ikD3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgCRLLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:11:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52822 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgCRLLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=oooF/CiXm0kuOdVPSQzsBNN53ECZtpWwj04MDqQMoOM=; b=If4ikD3FN9UgSYsml8er58Q8Pq
        h1ZFmyurBcjP9DIJvKdLZCd7yCuepSxkMZVnLQT5IXL9MQHMGSf0X8TTeUWxnT2y2Yh3qnSQhcFyq
        zKvozujouZWn8/Wc+N7gLOrKGlzUbF4XTfAWidvlLp1dAOGt14xaZ+qQhmDpFBwvPpCT80W8G7IXp
        Bx11Yps51HSHbLLZlPUhoAeziqJw4UfeMaROIFAp8T3hczXsestkw+/WUVllkSPjYpRItNGrXJ1is
        uuzSzNeFUknYwvReoi4uABBM+VD9r74epFnmR57ERaE2CyCR8LEgFDXhwuQR/EoVlcNiuPLN4cmZK
        GzhTyQJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEWb5-0000N9-S3; Wed, 18 Mar 2020 11:10:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C01C130047A;
        Wed, 18 Mar 2020 12:10:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A30A620427392; Wed, 18 Mar 2020 12:10:48 +0100 (CET)
Date:   Wed, 18 Mar 2020 12:10:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: avoid scale real weight down to zero
Message-ID: <20200318111048.GF20730@hirez.programming.kicks-ass.net>
References: <38e8e212-59a1-64b2-b247-b6d0b52d8dc1@linux.alibaba.com>
 <234bfc8a-c60d-c375-f681-e4230d8c5a20@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <234bfc8a-c60d-c375-f681-e4230d8c5a20@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 10:23:49AM +0800, 王贇 wrote:
> Hi Peter, Vincent
> 
> My apologies to missing the case when CONFIG_FAIR_GROUP_SCHED
> is disabled, I've replaced the MIN_SHARE with 2UL as it was
> defined, sorry for the trouble...

No worries, that's what we have those robots for ;-) I'll update the
patch and send it off again shortly.
