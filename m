Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E84C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F3620663
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rYC1u3HC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgGFUuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGFUun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:50:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4291C08C5DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pnifVjsntKfs1JPdhOlwOFevgRndLjyc6X8OSzSOKZw=; b=rYC1u3HCUu+K9no/ujCyhm9HNo
        F01dT1Ax6WlbxTODPFT83FFKLR3e+/g0Akc27FeoCEvWs6KCIFq33ZZGCSWOZnbWYDKkzLHjjTtcA
        /HR7qI/rzNbaFs44D0DE7bdXBrGPgCNeGV63aIRjdFtG9vqaQFQHvMFdxrdHre0n7CZfgFr6iUetz
        5FiTx99fjHKOudBMxb2SvxEMxAigyMbBUjoWSrKKArAaH/45SUMgbB1IbrdARs6KofNzFXJip/IL6
        lkAy710KBmDL1393IaqYBhYHl47mQgjNl+SDdutXC1qgtU+vt/aXwy7LGwQq/dpaLMkA47FGjVw6y
        ge3vxTMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsY47-0001mR-MK; Mon, 06 Jul 2020 20:50:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 563CA9816EA; Mon,  6 Jul 2020 22:50:04 +0200 (CEST)
Date:   Mon, 6 Jul 2020 22:50:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/20] lockdep: Add preemption enabled/disabled
 assertion APIs
Message-ID: <20200706205004.GC5523@worktop.programming.kicks-ass.net>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-5-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630054452.3675847-5-a.darwish@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 07:44:36AM +0200, Ahmed S. Darwish wrote:
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d74ac0fd6b2d..e5e2e632b749 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1118,6 +1118,7 @@ config PROVE_LOCKING
>  	select DEBUG_RWSEMS
>  	select DEBUG_WW_MUTEX_SLOWPATH
>  	select DEBUG_LOCK_ALLOC
> +	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
>  	select TRACE_IRQFLAGS
>  	default n
>  	help

I suspect this can be done unconditional, the thing that requires arch
support is CONFIG_PREEMPTION.
