Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE854C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F4820702
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i6meoyrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbgGTRlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgGTRlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 13:41:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A78C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AWNrwfzfBGodpnmjdycyfV82k00iHUEKY/clERDb8ag=; b=i6meoyrEOgmr3Zbfs6rF5k7Ue9
        ktcjIfl+hIfW5HmIobzjzR4HViho7qTjOCfcQKhZAx78HpOtvS94OgqYDiUops2l3EFPaymdwCykM
        iDYQCdBsk61MxhPTipYnj2Z3U/3Hla5sIFzKhgJWJnFrMrEQRUyNonQ0vd1xi1fxS527aSf75vgst
        e5QhI5SxkpWziCw1AsECLt56XBFWJbsVm3EaeEHYcGb9ooClv/isOZFW3vTeEWN4Un9rL9eSBXtWA
        jj/fewa7QmugfFOWUQfBj3kvuV5mGQUDpeVkJaJ8eLCwmJ/Nacyi89R1OkP0TJwNzu+qN9XmHqWRj
        hT8u365w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxZmm-00076x-Fy; Mon, 20 Jul 2020 17:41:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 063133050F0;
        Mon, 20 Jul 2020 19:41:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E49AB20D27A9D; Mon, 20 Jul 2020 19:41:03 +0200 (CEST)
Date:   Mon, 20 Jul 2020 19:41:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V6 07/14] perf/x86/intel: Generic support for hardware
 TopDown metrics
Message-ID: <20200720174103.GV10769@hirez.programming.kicks-ass.net>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-8-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717140554.22863-8-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 07:05:47AM -0700, kan.liang@linux.intel.com wrote:

> For the event mapping, a special 0x00 event code is used, which is
> reserved for fake events. The metric events start from umask 0x10.

> +#define INTEL_PMC_IDX_METRIC_BASE		(INTEL_PMC_IDX_FIXED + 16)
> +#define INTEL_PMC_IDX_TD_RETIRING		(INTEL_PMC_IDX_METRIC_BASE + 0)
> +#define INTEL_PMC_IDX_TD_BAD_SPEC		(INTEL_PMC_IDX_METRIC_BASE + 1)
> +#define INTEL_PMC_IDX_TD_FE_BOUND		(INTEL_PMC_IDX_METRIC_BASE + 2)
> +#define INTEL_PMC_IDX_TD_BE_BOUND		(INTEL_PMC_IDX_METRIC_BASE + 3)

So this is internal and we can change it around if/when needed, right?

> +#define INTEL_PMC_IDX_METRIC_END		INTEL_PMC_IDX_TD_BE_BOUND
> +#define INTEL_PMC_MSK_TOPDOWN			((0xfull << INTEL_PMC_IDX_METRIC_BASE) | \
> +						INTEL_PMC_MSK_FIXED_SLOTS)
> +
> +/*
> + * There is no event-code assigned to the TopDown events.
> + *
> + * For the slots event, use the pseudo code of the fixed counter 3.
> + *
> + * For the metric events, the pseudo event-code is 0x00.
> + * The pseudo umask-code starts from 0x10.
> + */
> +#define INTEL_TD_SLOTS				0x0400	/* TOPDOWN.SLOTS */
> +/* Level 1 metrics */
> +#define INTEL_TD_METRIC_RETIRING		0x1000	/* Retiring metric */
> +#define INTEL_TD_METRIC_BAD_SPEC		0x1100	/* Bad speculation metric */
> +#define INTEL_TD_METRIC_FE_BOUND		0x1200	/* FE bound metric */
> +#define INTEL_TD_METRIC_BE_BOUND		0x1300	/* BE bound metric */
> +#define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_BE_BOUND
> +#define INTEL_TD_METRIC_NUM			4

But this is ABI, once we merge this, it's stuck.

Also, per how Fixed2 is 0x0300, should not Fixed16 (aka
METRICS_RETIRING) be 0x1100 ?

But aside of that, are we sure the hardware will never grow a Fixed16?
Or do we want to be paranoid and move the metrics events up in the
pseudo event space?
