Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEF8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09BF920760
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OdpXLhqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389696AbgF3PoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389655AbgF3PoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:44:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C833EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 08:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OQxTXNj9yDq06FjwILkGgyBd+fyQSISd2el9foUvjmY=; b=OdpXLhqmUTkQpG7XO1b4vM2siS
        LFD48OPxmpiQ1k/FJWZRuQNCjQQnUoe0X9k8ddv79/uljEi9sxD1111DCbMvEXycp8wcxTWcO1mK9
        KRQzy/tHwt0XIw7lL62vuKr0LY9AvqcnxsdD1BgSDc9pXU4EmE2ytWGPDvO6YfK6/1uP2tThFQ/Uk
        yluCvkQpfaEFS66KAYfsNV/C8EQHT6kSDaJAZ/ntsj+7lt8mBXFzKzF5a0sMOCz/gWtAkQtr8nVKW
        bnOaRFOOQ0qoJc3twdZXS3IApeVQ3HNiWoHR5Etd1AqSFMIcqP2648EgviZ4TM4jVY1JUxaphRrvY
        VuGpRCpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqIPy-0003te-3d; Tue, 30 Jun 2020 15:43:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C4B3230015A;
        Tue, 30 Jun 2020 17:43:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B164B20CF3979; Tue, 30 Jun 2020 17:43:26 +0200 (CEST)
Date:   Tue, 30 Jun 2020 17:43:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH V2 13/23] perf/x86/intel/lbr: Factor out
 intel_pmu_store_lbr
Message-ID: <20200630154326.GT4781@hirez.programming.kicks-ass.net>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
 <1593195620-116988-14-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593195620-116988-14-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 11:20:10AM -0700, kan.liang@linux.intel.com wrote:
> -static inline u64 rdlbr_from(unsigned int idx)
> +static inline u64 rdlbr_from(unsigned int idx, struct lbr_entry *lbr)
>  {
>  	u64 val;
>  
> +	if (lbr)
> +		return lbr->from;
> +
>  	rdmsrl(x86_pmu.lbr_from + idx, val);
>  
>  	return lbr_from_signext_quirk_rd(val);
>  }
>  
> -static inline u64 rdlbr_to(unsigned int idx)
> +static inline u64 rdlbr_to(unsigned int idx, struct lbr_entry *lbr)
>  {
>  	u64 val;
>  
> +	if (lbr)
> +		return lbr->to;
> +
>  	rdmsrl(x86_pmu.lbr_to + idx, val);
>  
>  	return val;
>  }
>  
> -static inline u64 rdlbr_info(unsigned int idx)
> +static inline u64 rdlbr_info(unsigned int idx, struct lbr_entry *lbr)
>  {
>  	u64 val;
>  
> +	if (lbr)
> +		return lbr->info;
> +
>  	rdmsrl(x86_pmu.lbr_info + idx, val);
>  
>  	return val;

These should probably be __always_inline, just to make sure the compiler
doesn't do anything stupid.

