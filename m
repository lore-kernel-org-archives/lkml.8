Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CACC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0565E20838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RiurZ3h3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgBCP4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:56:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52716 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgBCP4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IZ+2IhtH9Wkn/JPrwSM2mpEcPwZEZbOVR1hOCann57s=; b=RiurZ3h3eS5nuMtjXg5FMdIjhR
        coQQnqM3nX7kE6gUYmY5LRk5Fo8cGcPIV4FhaPrYcmTHwCcAGZvug0BbyINskEAdjbyQoaLmPZHX5
        Yad/7eRL19t07CTL9oISrxVFaEYyDO4NSeUfgEeuZkYgXoj+zERvXQUeCZ5hawAuyHjhelQRDPQQ9
        Ym1aGZVXiUksWi9GYOqxFhtlzO7DUTxr+ocW15tXfr6V1nCCZAX9lpVOgM1k2MJa/dSMGi29vrZ5c
        Kt205eOeDJltdnRbOqY7OJXQbsc74smcRS7g7y4QYBqmoaulkealVDcqbaJBMtOCTGjy/eQ/VfeUT
        ZTbDiYQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iye4l-0007B1-Dv; Mon, 03 Feb 2020 15:55:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C67B30220B;
        Mon,  3 Feb 2020 16:54:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABC182B6E6441; Mon,  3 Feb 2020 16:55:49 +0100 (CET)
Date:   Mon, 3 Feb 2020 16:55:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com, qperret@google.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rostedt@goodmis.org, will@kernel.org, catalin.marinas@arm.com,
        sudeep.holla@arm.com, juri.lelli@redhat.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: Re: [Patch v9 7/8] sched/fair: Enable tuning of decay period
Message-ID: <20200203155549.GL14914@hirez.programming.kicks-ass.net>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-8-git-send-email-thara.gopinath@linaro.org>
 <4eb10687-1a62-cee3-7285-3f50cc023071@infradead.org>
 <5E380D1D.7020500@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5E380D1D.7020500@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 07:07:57AM -0500, Thara Gopinath wrote:
> On 01/28/2020 06:56 PM, Randy Dunlap wrote:
> > Hi,
> > 
> > On 1/28/20 2:36 PM, Thara Gopinath wrote:
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index e35b28e..be4147b 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -4376,6 +4376,11 @@
> >>  			incurs a small amount of overhead in the scheduler
> >>  			but is useful for debugging and performance tuning.
> >>  
> >> +	sched_thermal_decay_shift=
> >> +			[KNL, SMP] Set decay shift for thermal pressure signal.
> >> +			Format: integer between 0 and 10
> >> +			Default is 0.
> >> +
> > 
> > That tells an admin [or any reader] almost nothing about this kernel parameter
> > or what it does.  And nothing about what unit the value is in.
> > Does the value 0 disable this feature?
> 
> Thanks for the review. 0 does not disable "thermal pressure" feature. 0
> means the default decay period for averaging PELT signals (which is
> usually 32 but configurable) will also be applied for thermal pressure
> signal. A shift will shift the default decay period.
> 
> You are right. It needs more explanation here. I will fix it and send v10.

Or just send an update for this patch? I'm thinking most of this is
looking good.
