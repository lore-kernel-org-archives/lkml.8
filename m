Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F0BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1762068F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QZh45lqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgGCTur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCTur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:50:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159AC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cP/hgmND0dlqwbtMZ9aiGE8S/1wWsox3pMl6OlshHxQ=; b=QZh45lqDj+dHk/Ag2APZ+Z2ZdM
        83GvIL5g2VTBRzZamkLsqg0ESy88feppouo1cbyimsVaT2iCvzSLLDtk1DjdCCPDTG1F6g/Jpgdxr
        rx/KT6usWAeFEreEbv4wpmlfCufuKMZGDLbnV28C+VeReNhIF+JxImB3dRkEgF0PZluoXWRPsnmiY
        gu5/MnjEbt0xL7FaCSgpxqKzCkol1aD1jrmnfun2SzjrvM9334IiYz7Qu0+nFc67foA/AL0+kmPVj
        9lxEUW0nfv2ONYg07tezvH7dWCrZMKGEzlPebEhCkVLLgGyH8cIBjJ/qZpVyGHSR8c1yfVl6RHshz
        doGykV/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrRhb-0005Ys-LD; Fri, 03 Jul 2020 19:50:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABFE8984C50; Fri,  3 Jul 2020 21:50:24 +0200 (CEST)
Date:   Fri, 3 Jul 2020 21:50:24 +0200
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
Subject: Re: [PATCH V3 13/23] perf/x86/intel/lbr: Factor out
 intel_pmu_store_lbr
Message-ID: <20200703195024.GI2483@worktop.programming.kicks-ass.net>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
 <1593780569-62993-14-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593780569-62993-14-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 05:49:19AM -0700, kan.liang@linux.intel.com wrote:
> +static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
> +				struct lbr_entry *entries)
> +{
> +	struct perf_branch_entry *e;
> +	struct lbr_entry *lbr;
> +	u64 from, to, info;
> +	int i;
> +
> +	for (i = 0; i < x86_pmu.lbr_nr; i++) {
> +		lbr = entries ? &entries[i] : NULL;
> +		e = &cpuc->lbr_entries[i];
> +
> +		from = rdlbr_from(i, lbr);
> +		/*
> +		 * Read LBR entries until invalid entry (0s) is detected.
> +		 */
> +		if (!from)
> +			break;
> +
> +		to = rdlbr_to(i, lbr);
> +		info = rdlbr_info(i, lbr);
> +
> +		e->from		= from;
> +		e->to		= to;
> +		e->mispred	= !!(info & LBR_INFO_MISPRED);
> +		e->predicted	= !(info & LBR_INFO_MISPRED);
> +		e->in_tx	= !!(info & LBR_INFO_IN_TX);
> +		e->abort	= !!(info & LBR_INFO_ABORT);
> +		e->cycles	= info & LBR_INFO_CYCLES;
> +		e->type		= 0;
> +		e->reserved	= 0;
> +	}
> +
> +	cpuc->lbr_stack.nr = i;
> +}

If I'm not mistaken, this correctly deals with LBR_FORMAT_INFO, so can't
we also use the intel_pmu_arch_lbr_read() function for that case?

Then we can delete that section from read_64...

Index: linux-2.6/arch/x86/events/intel/core.c
===================================================================
--- linux-2.6.orig/arch/x86/events/intel/core.c
+++ linux-2.6/arch/x86/events/intel/core.c
@@ -4664,6 +4664,9 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_read = intel_pmu_lbr_read_32;
 	}
 
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
+		x86_pmu.lbr_read = intel_pmu_arch_lbr_read;
+
 	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
 		intel_pmu_arch_lbr_init();
 
 
