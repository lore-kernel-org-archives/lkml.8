Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BC1C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453142072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="swL03vpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgAJNR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:17:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgAJNR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GoJ/f0Fq70LSZhFTT9Pl1YpUrxt52JUe7bDNzMBe450=; b=swL03vpBvw32P5Ma7x9MAisgA
        GZu9+2dX89NBDP8YjBDeD02MuHzYpeT1wSu8oESkWnSul0LV7Y0+DPNKZtgfIl7LFZrIohzG6OCzU
        jqZ2GXPo13e2lOIhr7q1mQhiUAl8b6RdC3Nr+qN3gv820wCKMCPCYkIKqNLulllfwleBhGzww4gSz
        +BQD6OjjwKLkC6gb3v29ke2qFyDNNfkeSwx3yxu2KZcRDDPu9L3m6iK5YyACEp3L1zQGUhEqBtl46
        UedbXNOqEkenXIzh95VnKFADOgesTHCveRWDcfiiy3Z2lPBbmKY+8vz+ypxU4McIKxYhulZTsLyjl
        c0UMIIFOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipuAi-0005rn-HY; Fri, 10 Jan 2020 13:17:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 115D630018B;
        Fri, 10 Jan 2020 14:16:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE9852B612611; Fri, 10 Jan 2020 14:17:49 +0100 (CET)
Date:   Fri, 10 Jan 2020 14:17:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V5 RESEND 00/14] TopDown metrics support for Icelake
Message-ID: <20200110131749.GD2827@hirez.programming.kicks-ass.net>
References: <20200106202919.2943-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106202919.2943-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 12:29:05PM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Icelake has support for measuring the level 1 TopDown metrics
> directly in hardware. This is implemented by an additional METRICS
> register, and a new Fixed Counter 3 that measures pipeline SLOTS.
> 
> New in Icelake
> - Do not require generic counters. This allows to collect TopDown always
>   in addition to other events.
> - Measuring TopDown per thread/process instead of only per core
> 
> For the Ice Lake implementation of performance metrics, the values in
> PERF_METRICS MSR are derived from fixed counter 3. Software should start
> both registers, PERF_METRICS and fixed counter 3, from zero.
> Additionally, software is recommended to periodically clear both
> registers in order to maintain accurate measurements. The latter is
> required for certain scenarios that involve sampling metrics at high
> rates. Software should always write fixed counter 3 before write to
> PERF_METRICS.

Do we really have to support this trainwreck? This is such ill designed
hardware, I'm loath to support it, it might encourage more such
'creative' things and we really don't need that.


