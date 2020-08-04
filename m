Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B327C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB8C72070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LioAvB/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgHDKpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgHDKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:45:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E23FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w5o5IcAoNXwLVf59c401lTKK0QArdzdHQ89b1oA1ILw=; b=LioAvB/iKgUeNOGdS6342XE/WZ
        nRhe2eYGe9CGIXNs0McyJ7E1ly+G+Vj6Qe81zusLriWie0PCmW8m97VWpfGS/pBrEYsdW7z086s3O
        gKyBtV30aLLnMB5k7eOLgs0P1O/cqftYA9QcP7nFWF5eFvOpub9Dqh/ykq/tRhUl8o9+v0lq04wwM
        GVVcVmjdybTNg+ZoqfT+9FjtYyKuAAUdGSi5yCrN2mnMdL0S/U2VC22sbBHiqbYaA2QgIWuidATd2
        FQThuaXFPax0FXVcGtokbfXJleTGWpc/qyrF5J0YfFRFIGOjHOd68m0a3xDhydCeR10lLQC9/iZS6
        HCMsY0Aw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2uRf-00013s-Gz; Tue, 04 Aug 2020 10:45:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D8778301A66;
        Tue,  4 Aug 2020 12:45:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C5AC2B94E749; Tue,  4 Aug 2020 12:45:20 +0200 (CEST)
Date:   Tue, 4 Aug 2020 12:45:20 +0200
From:   peterz@infradead.org
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Subject: Re: [PATCH 1/2] sched/topology: Allow archs to override cpu_smt_mask
Message-ID: <20200804104520.GB2657@hirez.programming.kicks-ass.net>
References: <20200804033307.76111-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804033307.76111-1-srikar@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 09:03:06AM +0530, Srikar Dronamraju wrote:
> cpu_smt_mask tracks topology_sibling_cpumask. This would be good for
> most architectures. One of the users of cpu_smt_mask(), would be to
> identify idle-cores. On Power9, a pair of cores can be presented by the
> firmware as a big-core for backward compatibility reasons.
> 
> In order to maintain userspace backward compatibility with previous
> versions of processor, (since Power8 had SMT8 cores), Power9 onwards there
> is option to the firmware to advertise a pair of SMT4 cores as a fused
> cores (referred to as the big_core mode in the Linux Kernel). On Power9
> this pair shares the L2 cache as well. However, from the scheduler's point
> of view, a core should be determined by SMT4. The load-balancer already
> does this. Hence allow PowerPc architecture to override the default
> cpu_smt_mask() to point to the SMT4 cores in a big_core mode.

I'm utterly confused.

Why can't you set your regular siblings mask to the smt4 thing? Who
cares about the compat stuff, I thought that was an LPAR/AIX thing.
