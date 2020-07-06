Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71791C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC5320739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HcDRxMgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgGFK03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgGFK02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:26:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACB0C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 03:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DO2KNfV25p99iD95AUadv9FxSJQkZQYKa7yNp8dBJiU=; b=HcDRxMggRHhiVOqWI/4UIkoQ3h
        njtVVbtOHuQ9VctkAQ9Gyr5zh+gfWWepvtNakancjUJCg9EXV3T+WbAK4+iHwBF7Y3mDRSnxKzqKy
        3JvREmHwy3UBQUVFTigEU5FwCNfnl2AjiAkj1S3Egk1ePlX084NFqBUryClxnFXVnn2e+40dnJrSH
        lHiL9dhIXAJ37mx88mr7FHEPBCuq3Kxa4Ck9wk0Sy6xxLZNLCtx+LIqKvfjPxrKMz5GwDpyVVJn6H
        lZ2duYhNN/491PcSSb5Qt2ODEKsPGgxpOeUbdSTVyhbCozIHiQJsc1VGHMe8ocpiLxt2uP9Fg+SUZ
        TrngIMug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsOK1-0002FP-FR; Mon, 06 Jul 2020 10:26:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7D303028C8;
        Mon,  6 Jul 2020 12:25:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F8A6213912E8; Mon,  6 Jul 2020 12:25:57 +0200 (CEST)
Date:   Mon, 6 Jul 2020 12:25:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH V3 13/23] perf/x86/intel/lbr: Factor out
 intel_pmu_store_lbr
Message-ID: <20200706102557.GA597537@hirez.programming.kicks-ass.net>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
 <1593780569-62993-14-git-send-email-kan.liang@linux.intel.com>
 <20200703195024.GI2483@worktop.programming.kicks-ass.net>
 <bf63dee4-d25f-89d8-1893-572d84cfa667@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf63dee4-d25f-89d8-1893-572d84cfa667@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 04:59:49PM -0400, Liang, Kan wrote:
> On 7/3/2020 3:50 PM, Peter Zijlstra wrote:

> > If I'm not mistaken, this correctly deals with LBR_FORMAT_INFO, so can't
> > we also use the intel_pmu_arch_lbr_read() function for that case?
> 
> But the intel_pmu_arch_lbr_read() doesn't have the optimization
> (LBR_NO_INFO) for the LBR_FORMAT_INFO.
> https://lkml.kernel.org/r/tip-b16a5b52eb90d92b597257778e51e1fdc6423e64@git.kernel.org
> 
> To apply the optimization, we need extra codes as below.

Right, I saw that, but shouldn't we support that for anything with this
format anyway? That is, it's weird and inconsistent to not support
PERF_SAMPLE_BRANCH_NO_{CYCLES,FLAGS} for PEBS/ARCH-LBR output.

Arguably, we should even support NO_CYCLES for FORMAT_TIME. Yes it's
daft, but that's what you get for adding the ABI.

