Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D690AC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09962071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B0zSPUUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgA2Ths (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:37:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgA2Thr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SHW9Gob0MkiPOzOTwsKmQgiOuwGrX2bI7Xumj7zaNQc=; b=B0zSPUUjUi4L4yL/9dwu88LCm
        GfX5d57GJdHdLXEtk2trk82tuL9+2uXXDF/ojG1M0ByFRnaBwc5nexp1eDsnu3DiT/Yj3VRx/yXhg
        b82Q8RH0RS7+gT0GN+hL9nwBLU2NZID5CFXtfL4af+Q2BHAkZKa5dcXomvOclQkQc1RmVBbmjLaVJ
        xP+G8pnkK8HPilSbRN3L9N0Yn2pHzaFpYs4OXxKBme5WDMPEdMTq1+ZNoFftzfhUDev4axoC0ptKh
        DUIr425R1cg4Sz9Ivz9bIzWyGHk0JwIQ+9mDfksLNpH+eNV2ypsssZAuNq19PPLnsl8LnSInfI3Eu
        cg+jarshg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwt9j-0005iI-2Q; Wed, 29 Jan 2020 19:37:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78B90300606;
        Wed, 29 Jan 2020 20:35:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 440C82B7337BB; Wed, 29 Jan 2020 20:37:41 +0100 (CET)
Date:   Wed, 29 Jan 2020 20:37:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2 5/6] TEMP: sched: add interface for counter-based
 frequency invariance
Message-ID: <20200129193741.GU14914@hirez.programming.kicks-ass.net>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-6-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218182607.21607-6-ionela.voinescu@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:26:06PM +0000, Ionela Voinescu wrote:
> To be noted that this patch is a temporary one. It introduces the
> interface added by the patches at [1] to allow update of the frequency
> invariance scale factor based on counters. If [1] is merged there is
> not need for this patch.
> 
> For platforms that support counters (x86 - APERF/MPERF, arm64 - AMU
> counters) the frequency invariance correction factor can be obtained
> using a core counter and a fixed counter to get information on the
> performance (frequency based only) obtained in a period of time. This
> will more accurately reflect the actual current frequency of the CPU,
> compared with the alternative implementation that reflects the request
> of a performance level from the OS through the cpufreq framework
> (arch_set_freq_scale).
> 
> Therefore, introduce an interface - arch_scale_freq_tick, to be
> implemented by each architecture and called for each CPU on the tick
> to update the scale factor based on the delta in the counter values,
> if counter support is present on the CPU.
> 
> Either because reading counters is expensive or because reading
> counters from remote CPUs is not possible or is expensive, only
> update the counter based frequency scale factor on the tick for
> now. A tick based update will definitely be necessary either due to
> it being the only point of update for certain architectures or in
> order to cache the counter values for a particular CPU, if a
> further update from that CPU is not possible.
> 
> [1]
> https://lore.kernel.org/lkml/20191113124654.18122-1-ggherdovich@suse.cz/

FWIW, those patches just landed in tip/sched/core
