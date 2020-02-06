Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF0DC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE48A217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gFlFa2U3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgBFQW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:22:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBFQW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AzV8bSdDGgVKZs92FHMuEsz6tJR6h7zonhrA9C1/LTo=; b=gFlFa2U3/zdh/0xQV7yzvpRGHU
        ykGhF3JKowaIxPAFilcrGFtr8IEGv3nG6e1GHgNMh+wi5IzA7Lz7zUNAz8S0UYcjvKNDdLmuFMXF4
        XHq32JQ1Qxhfyom+PKRVoww/QARpgSbeYrj4eEvmu8qWL0QRJQ0OZmRl2o0GIymKKe2cbpxeDSv5q
        GMfi//MfXs1SqbnJXG2r+tQ6dCgkj/VO1X+jUXcbVnTA9JT280PbOkmK+YiYYuz0B6Kxt2HQ31y+8
        Cvng7BJRKq2mzBwdqdnnf2IQ34SQ0wSrEeznp+mLoXJ8mdD+ohXx1ntB08ECZuXi/RwqLRa8sGfA0
        8sDJQVvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izjv1-0005Af-6q; Thu, 06 Feb 2020 16:22:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C2B13016E5;
        Thu,  6 Feb 2020 17:20:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3E0525BBB13B; Thu,  6 Feb 2020 17:22:16 +0100 (CET)
Date:   Thu, 6 Feb 2020 17:22:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     eranian@google.com, acme@redhat.com, mingo@kernel.org,
        mpe@ellerman.id.au, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com
Subject: Re: [PATCH V6 0/2] Stitch LBR call stack (kernel)
Message-ID: <20200206162216.GZ14879@hirez.programming.kicks-ass.net>
References: <20200127165355.27495-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127165355.27495-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Kan Liang (2):
>   perf/core: Add new branch sample type for HW index of raw branch
>     records
>   perf/x86/intel: Output LBR TOS information
> 
>  arch/powerpc/perf/core-book3s.c |  1 +
>  arch/x86/events/intel/lbr.c     |  9 +++++++++
>  include/linux/perf_event.h      | 12 ++++++++++++
>  include/uapi/linux/perf_event.h |  8 +++++++-
>  kernel/events/core.c            | 10 ++++++++++
>  5 files changed, 39 insertions(+), 1 deletion(-)

Thanks!
