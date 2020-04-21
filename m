Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F911C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B96020644
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HTj4tJC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgDUN5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUN5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:57:38 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17A6C061A10;
        Tue, 21 Apr 2020 06:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pp2bG4fEbryHc3bEtGL1LFuRU1cWx4G4+7sc9Othu1I=; b=HTj4tJC67EYOgK0QECIFmCjDq2
        21F8Clxqw+0cNAw8vb5Ch1Z60ErYNeLv3JvecCZTWpnd/y0UHVf2/x3sptdRiRDuLIPfYArRTq0Rh
        UTxf5Y9PYN16bjwvebhPSiX36ouWYtDHwYsqcf1YINvEOjhA9GWtEM35IhAus34CYcKHAYy/Z3Srw
        KTeYWcD8/3tarYix+ekD/Hpx9XbhrqyKDv33lxxl/w/IXk3tjcf7bH/4y6V5NMLLi3+0AQUfmWE5j
        j43DhsWBA67Taj6/B6+RRXxpok6kqcfE2j73Q5djFQJ/XaWu3UOjgIYazNBPQGQ1szPRYOyyO0iJm
        p6eMMAWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQtOA-0000CI-6H; Tue, 21 Apr 2020 13:56:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B31F5300739;
        Tue, 21 Apr 2020 15:56:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9906D2BAC7931; Tue, 21 Apr 2020 15:56:35 +0200 (CEST)
Date:   Tue, 21 Apr 2020 15:56:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, tglx@linutronix.de,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@HansenPartnership.com>, deller@gmx.de,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] sched/core: fix illegal RCU from offline CPUs
Message-ID: <20200421135635.GT20730@hirez.programming.kicks-ass.net>
References: <20200401214033.8448-1-cai@lca.pw>
 <87369mt9kf.fsf@mpe.ellerman.id.au>
 <BBA124FA-7924-4782-AC9D-7B1B98BE817F@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BBA124FA-7924-4782-AC9D-7B1B98BE817F@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 09:26:56AM -0400, Qian Cai wrote:

> > Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> 
> Peter, can you take a look at this patch when you have a chance?

Sorry, -ETOOMUCHEMAIL, got it now, thanks!
