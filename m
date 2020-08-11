Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74BAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE6220658
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0i0sScr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgHKHyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgHKHyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:54:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C88C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BJ6NngLNkSYp1sT0N1/N2C51huBBRbAX2VjGCXSkBSg=; b=0i0sScr/Cr7h1kkBEKTDu101YF
        qtTsZ2DEO1xzwMWXsvaJAH7bq3GzL2PmLIge+QKKoAfGVDsMrAsPitjkPH9vUBvFFXshSHlkROMOD
        FoFlSItG/vqJBs/HcY2qMTDQZ+Cgtu0eRebEHbrJnpYlRErTnocI0fuPgVcKJVGCYSAslQcv4t2tF
        10upX3tTokJhm0n8kVHY+0F05ZsLkzNH+7P62RpTeN8K7m6+CrVdh+LlHny+BQUmZSkn57NtVyzHV
        e/QNH5AfOmd29El/b5rcKAZeAs2WHRtj33PEltpe6yRAO/y2BqaXUUszut+gBpThSosIoMWcVJ46l
        GTVwEHfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5P70-000204-6o; Tue, 11 Aug 2020 07:54:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D56D980C9D; Tue, 11 Aug 2020 09:54:20 +0200 (CEST)
Date:   Tue, 11 Aug 2020 09:54:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH 1/2 v3] rseq/membarrier: add
 MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Message-ID: <20200811075420.GA5637@worktop.programming.kicks-ass.net>
References: <20200811000959.2486636-1-posk@google.com>
 <20200811062733.GP3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811062733.GP3982@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 08:27:33AM +0200, Peter Zijlstra wrote:
>  SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
>  {
> +	int cflags = 0, int cpuid = -1;
> +
>  	if (unlikely(flags) && cmd != MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)
>  		return -EINVAL;
> +
> +	if (cmd & (MEMBARRIER_CMD_PRIVATE_EXPEDITED |
> +		   MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE |
> +		   MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)) {
> +
> +		if (cmd & MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)
> +			cflags |= MEMBARRIER_FLAG_RSEQ;
> +
> +		if (cmd & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
> +			cflags |= MEMBARRIER_FLAG_SYNC_CORE;
> +			cpuid = flags;
> +		}
> +
> +		cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED;
> +	}

This of course fails to check if other bits are set, and it goes really
'funny' if you use cpuid != -1.

That all needs a little more thought.
