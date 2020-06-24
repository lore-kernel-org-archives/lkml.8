Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD0DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECA620707
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BY5FnQW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389492AbgFXM2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388296AbgFXM2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:28:48 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B18C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p0kBSMT/fu/rPYSInmx/NcnvSTQq1hWoN5HJf9kznb8=; b=BY5FnQW2JaWt9zPy4xJIPJiAVy
        7KH8lucO65rP6NhfplKEQMw9/7ZvO5hXlXzBmz+aYnF7Kb6DdP8okf6+NLnbPAS6PofQqzZ1yoFzU
        LkaXPWJJ/mfFmGqXolNFuFOr99KKrTzeuKakX1wue35bq4QW/zpWtaLDMalAxy77arol+/22aVtvv
        nJkQpHV0HNc9Zf1/+IGKsyHAfuFWbtrq5wc6ZF7NySVVqmqvRFMgwnLmc9dps45foYXl6G59Yu89O
        ryBShwpTuJaKX5JDo5kv6NYkiZWcpPCz4pL485o9w4UELBzyjWeNxHXmsvAimTDDzkfZybQDSz0Qa
        o8l/Opzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo4Vo-0003WT-PD; Wed, 24 Jun 2020 12:28:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D4BDC3003E5;
        Wed, 24 Jun 2020 14:28:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA00B21211CCA; Wed, 24 Jun 2020 14:28:19 +0200 (CEST)
Date:   Wed, 24 Jun 2020 14:28:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200624122819.GG4781@hirez.programming.kicks-ass.net>
References: <20200619172011.5810-1-qais.yousef@arm.com>
 <20200619172011.5810-3-qais.yousef@arm.com>
 <87pn9oor2t.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn9oor2t.derkling@matbug.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 09:34:02AM +0200, Patrick Bellasi wrote:
> > +static DEFINE_STATIC_KEY_TRUE(sched_uclamp_unused);
> 
> I would personally prefer a non negated semantic.

That's what I said earlier as well.


> > +	 */
> > +	if (static_branch_likely(&sched_uclamp_unused))
> > +		return;
> 
> Moreover, something like:
> 
>        if (static_key_false(&sched_uclamp_enabled))
>                 return;
> 
> is not just good enough?

static_key_true/false() are the deprecated API.
