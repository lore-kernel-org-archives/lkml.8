Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6ADC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46DAE21548
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nr0oj9+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbgFSSNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732041AbgFSSNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:13:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30482C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RmbBPWj+7r7cqSwWtOeyaSwx07WIPg3ahEci8gVOaTA=; b=nr0oj9+i1nU+XggYl68VFl4O20
        ycUQUbuGYzrReMInedxQ7HLFwcZYS62ox4SNXYmTmfEytI7VL1Kt/gsT3/FcuW/xZqY9KM03Z1JIi
        uYw2CLEHjQpEXulaXvMAoSP38iBlwwJz2mWpVYXsyTd5oUJDdmv/YK8+6Zp6FUrYaENNZMsICdAC9
        sDoUjoIwzmAu668dtmk03w0uA/zA6fXSuE+GVJYtcRNXUgPZOhCJX1AjUMxAX5Elo3FdNvkG0S7mO
        higWTDwSFZawGMFn+cWyj/Fju8qMPIjSFhrZ2L07vbmzEjpR5IHkS7hi6diEqTjYJ590/MZqx3HDM
        /e9liLgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmLVh-000625-Bj; Fri, 19 Jun 2020 18:13:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92EE230018A;
        Fri, 19 Jun 2020 20:13:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 836BE2C27FBC0; Fri, 19 Jun 2020 20:13:03 +0200 (CEST)
Date:   Fri, 19 Jun 2020 20:13:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Fix initialization of strut uclamp_rq
Message-ID: <20200619181303.GD576888@hirez.programming.kicks-ass.net>
References: <20200618195525.7889-1-qais.yousef@arm.com>
 <20200618195525.7889-2-qais.yousef@arm.com>
 <20200619173055.GA576888@hirez.programming.kicks-ass.net>
 <20200619173944.blwuimtuqmcxlj2v@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619173944.blwuimtuqmcxlj2v@e107158-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 06:39:44PM +0100, Qais Yousef wrote:
> On 06/19/20 19:30, Peter Zijlstra wrote:
> > On Thu, Jun 18, 2020 at 08:55:24PM +0100, Qais Yousef wrote:
> > 
> > > +	for_each_clamp_id(clamp_id) {
> > > +		memset(uc_rq[clamp_id].bucket,
> > > +		       0,
> > > +		       sizeof(struct uclamp_bucket)*UCLAMP_BUCKETS);
> > > +
> > > +		uc_rq[clamp_id].value = uclamp_none(clamp_id);
> > 
> > I think you can replace all that with:
> > 
> > 		*uc_rq = (struct uclamp_rq){
> > 			.value = uclamp_none(clamp_id),
> > 		};
> > 
> > it's shorter and is free or weird line-breaks :-)
> 
> Sure. I just sent v2 so that people will be encouraged to run tests hopefully.
> But will fix in v3.
> 
> Do we actually need to 0 out anything here? Shouldn't the runqueues all be in
> BSS which gets initialized to 0 by default at boot?
> 
> Maybe better stay explicit..

C99 named initializer (as used here) explicitly zero initializes all
unnamed members. Is that explicit enough? ;-)
