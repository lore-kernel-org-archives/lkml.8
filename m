Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EB8C43457
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8632822D71
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dpiWAUFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgHFIy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgHFIyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 04:54:55 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D0C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 01:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sjPmb+gKsoTr4gKJxpXZXAXQKQybWUTDRfPhRmtRJlU=; b=dpiWAUFOI4iJE6fUsW+QV7ZkXa
        3x7q97QuD47tPatxuiiBA1P/Eep1oUtAWOT92PyLEhU6C9/Z8UitQ402UZeE9c1UKKNrbO5irRBp0
        Enx+csJ8wy5fBJqVwlsjoFybJ8npL89aW15HpTNnOQRTZ0rJsPu6MFixyeZTzcMqofbz63Jpsr5jv
        z/Gwf9hhnmiqm/9Iy4467sJv4j45XA0HNJ3V0XZBKVgjjIhgPzqlxkamOQptyfSZAhwtMuhwtN58h
        fhGPSupzZpnZyFtJRTZvDL9DzOO7Qq1oA0bF2ubMk956U/AUoeo2im/KJzY2iGpRzF9Mou7o4LY2a
        zB6S1g8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3bfV-00041J-VU; Thu, 06 Aug 2020 08:54:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F0F2304D28;
        Thu,  6 Aug 2020 10:54:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5274C220F91BB; Thu,  6 Aug 2020 10:54:29 +0200 (CEST)
Date:   Thu, 6 Aug 2020 10:54:29 +0200
From:   peterz@infradead.org
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Subject: Re: [PATCH 1/2] sched/topology: Allow archs to override cpu_smt_mask
Message-ID: <20200806085429.GX2674@hirez.programming.kicks-ass.net>
References: <20200804033307.76111-1-srikar@linux.vnet.ibm.com>
 <20200804104520.GB2657@hirez.programming.kicks-ass.net>
 <20200804121007.GJ24375@linux.vnet.ibm.com>
 <20200804124755.GJ2674@hirez.programming.kicks-ass.net>
 <87ft90z6dy.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft90z6dy.fsf@mpe.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 03:32:25PM +1000, Michael Ellerman wrote:

> That brings with it a bunch of problems, such as existing software that
> has been developed/configured for Power8 and expects to see SMT8.
> 
> We also allow LPARs to be live migrated from Power8 to Power9 (and back), so
> maintaining the illusion of SMT8 is considered a requirement to make that work.

So how does that work if the kernel booted on P9 and demuxed the SMT8
into 2xSMT4? If you migrate that state onto a P8 with actual SMT8 you're
toast again.

> Yeah I agree the naming is confusing.
> 
> Let's call them "SMT4 cores" and "SMT8 cores"?

Works for me, thanks!

> The problem is we are already lying to userspace, because firmware lies to us.
> 
> ie. the firmware on these systems shows us an SMT8 core, and so current kernels
> show SMT8 to userspace. I don't think we can realistically change that fact now,
> as these systems are already out in the field.
> 
> What this patch tries to do is undo some of the mess, and at least give the
> scheduler the right information.

What a mess... I think it depends on what you do with that P9 to P8
migration case. Does it make sense to have a "p8_compat" boot arg for
the case where you want LPAR migration back onto P8 systems -- in which
case it simply takes the firmware's word as gospel and doesn't untangle
things, because it can actually land on a P8.
