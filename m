Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9750C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7FB206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JRz/i/Dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389961AbgFSTlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389884AbgFSTlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:41:46 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70977C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Q3hTbtsEGNa78bwtirDIeZMoSG4nGARy90K4bO5bC8=; b=JRz/i/Dd6FTt8j7A1HyxlWDBk6
        pzyxA42GzemAwRBJ8ZLP0OwZQAtVggWvhtu5DZ78Haj3qLLKGzRETtUQ0SX7vlg+nmG4wKztXwmcv
        +VGJrTINfhnCHtFF2i96d1xooLcFjKmCluVlFdI41SugkyRYBIGxEakHHZ1ai9LeEGaTl5Rv6TZcY
        JDOIZHG/TPgv6GPEwOVEVtGbgVkmUGtR2pmViUHc52A1whbCobBsCxJPSh8s0xzeJKLylxD5ypbZT
        9RIJe6TrUbRsbn0G/L1KOY/BgiRiDI925GF1x1GwzeewuSLVk7oZMMmRqHen/IPBvKJO5S8dTcmWB
        /xYIRqOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmMt4-00060L-As; Fri, 19 Jun 2020 19:41:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C101D3060FD;
        Fri, 19 Jun 2020 21:41:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD99F2C28ECDC; Fri, 19 Jun 2020 21:41:15 +0200 (CEST)
Date:   Fri, 19 Jun 2020 21:41:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com
Subject: Re: [PATCH 20/21] perf/x86/intel/lbr: Support XSAVES/XRSTORS for LBR
 context switch
Message-ID: <20200619194115.GJ576888@hirez.programming.kicks-ass.net>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-21-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592575449-64278-21-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 07:04:08AM -0700, kan.liang@linux.intel.com wrote:
> The XSAVE instruction requires 64-byte alignment for state buffers. A
> 64-byte aligned kmem_cache is created for architecture LBR.

> +		pmu->task_ctx_cache = create_lbr_kmem_cache(size,
> +							    XSAVE_ALIGNMENT);

> +struct x86_perf_task_context_arch_lbr_xsave {
> +	struct x86_perf_task_context_opt	opt;
> +	union {
> +		struct xregs_state		xsave;

Due to x86_perf_task_context_opt, what guarantees you're actually at the
required alignment here?

> +		struct {
> +			struct fxregs_state	i387;
> +			struct xstate_header	header;
> +			struct arch_lbr_state	lbr;
> +		};
> +	};
> +};
