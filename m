Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE6DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A395D2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tpJhfIRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgGOIiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbgGOIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:38:18 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA65C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0kjsVOfV30caO/5Zchs4MAMTJc5SZZBY2bLlqPn+b6U=; b=tpJhfIRz2E8zQ08WOsHHmIFe5n
        n9VDMj5cagstx5VgIfC8HrUizrdH2KsxuEcSQ3kqH1OGGV4BmDaQo1O6T7I1bvC989Ir6Jp7Gzubw
        0psAguRiKJMhYikHNoyv5ZHNTXFbaBbj1etTPSQjmrV74UUNsc3zRD6pX7pSjPhWOzuE5F5BPVf9W
        y5rD+K6aWXI7tPr4Ak21vZ8NZHN+X84PkS/C/ZUgWd2nlfM/w3hxxRWBZhKZETjUJod2xVJQq0yTW
        uSMvVysCOzvfoN+FaQKelHCUlAOedsCbHLsgL3WbnzgfKYhkquEqPJjEfhp9VOsuEMy7Kulb/aEJj
        eC6sUKAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvcvV-0000Bo-Oa; Wed, 15 Jul 2020 08:38:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2B1A300446;
        Wed, 15 Jul 2020 10:38:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B270023648708; Wed, 15 Jul 2020 10:38:00 +0200 (CEST)
Date:   Wed, 15 Jul 2020 10:38:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] arm64: perf: Implement correct cap_user_time
Message-ID: <20200715083800.GC10769@hirez.programming.kicks-ass.net>
References: <20200715020512.20991-1-leo.yan@linaro.org>
 <20200715020512.20991-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715020512.20991-3-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:05:08AM +0800, Leo Yan wrote:

> [leoyan: Use quot/rem to convert cyc to ns to avoid overflow]

> +		quot = rd->epoch_cyc >> rd->shift;
> +		rem = rd->epoch_cyc & (((u64)1 << rd->shift) - 1);
> +		ns = quot * rd->mult + ((rem * rd->mult) >> rd->shift);
> +		userpg->time_zero -= ns;

I think we have mul_u64_u32_shr() for that.

