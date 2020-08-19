Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F010C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E183E2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lt+K5Zju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgHSOXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgHSOXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:23:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8273BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6jkd2KQnDmb11AhWH/o7SaB0T5YK6OXJV+5xJo0MfG4=; b=Lt+K5Zju1LJvBjwSVTyQwxo91l
        7kGb1KiLSv7PPXrRkCsZiijnLIxSpJOCJcXlU6oqe2v5IrYACvSq2kz6ICtryMrr5CGyTV+n5eAsJ
        pfpYWVzTpg4fRG9SG2CkglhcyZgroe2YRWDBxBvd9em/QBq4/BR4KTilLd62NLYj4quR5pvGeGaRE
        yWh2r5QhzZJqHhSoUWZSBpTHbPTsCQlMXZnTwL1g+sDa15t1cYszmahFB78te08nVZH7cBK4wDMF6
        ilEpLrNfJDxCFz5BmeQYXWZjk7J3z4pYXvlCGD7gw6Op9LKYitbIeT3f1+MV8DYb5ixkzO6fAXwew
        eso1Iuaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Ozv-0005en-Aj; Wed, 19 Aug 2020 14:23:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F26D3059C6;
        Wed, 19 Aug 2020 16:23:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AF8C20D805B3; Wed, 19 Aug 2020 16:23:26 +0200 (CEST)
Date:   Wed, 19 Aug 2020 16:23:26 +0200
From:   peterz@infradead.org
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, maz@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, swboyd@chromium.org,
        sumit.garg@linaro.org, Julien Thierry <julien.thierry@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 4/7] arm64: perf: Defer irq_work to IPI_IRQ_WORK
Message-ID: <20200819142326.GE2674@hirez.programming.kicks-ass.net>
References: <20200819133419.526889-1-alexandru.elisei@arm.com>
 <20200819133419.526889-5-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819133419.526889-5-alexandru.elisei@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 02:34:16PM +0100, Alexandru Elisei wrote:
> From: Julien Thierry <julien.thierry@arm.com>
> 
> When handling events, armv8pmu_handle_irq() calls perf_event_overflow(),
> and subsequently calls irq_work_run() to handle any work queued by
> perf_event_overflow(). As perf_event_overflow() raises IPI_IRQ_WORK when
> queuing the work, this isn't strictly necessary and the work could be
> handled as part of the IPI_IRQ_WORK handler.
> 
> In the common case the IPI handler will run immediately after the PMU IRQ
> handler, and where the PE is heavily loaded with interrupts other handlers
> may run first, widening the window where some counters are disabled.
> 
> In practice this window is unlikely to be a significant issue, and removing
> the call to irq_work_run() would make the PMU IRQ handler NMI safe in
> addition to making it simpler, so let's do that.

Makes sense, IIRC this code was written before ARM grew IPI_IRQ_WORK
support and then it makes sense, but now that you have it and are moving
to NMI-like context this is absolutely the right thing to do.
