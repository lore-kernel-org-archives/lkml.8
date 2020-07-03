Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E00C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50FF520884
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgGCU7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 16:59:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:44919 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgGCU7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 16:59:54 -0400
IronPort-SDR: zah4OS1iSVIxcr45z9FCC9P2IPOJZWEOa/lfqYEujy0LtkRavMRa6wwoDkbdwmQbuTzoejVAKr
 JN4xMrwT/ThA==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="212209816"
X-IronPort-AV: E=Sophos;i="5.75,309,1589266800"; 
   d="scan'208";a="212209816"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 13:59:53 -0700
IronPort-SDR: MKaEulu0QJJcDM0CaSEvQlUHhMQoXr7jtcsNAlVWyLBekn2M8wq/gxzlg5iMmAxeZRez5Nc7ek
 0zmn7r2xMofw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,309,1589266800"; 
   d="scan'208";a="321871448"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jul 2020 13:59:53 -0700
Received: from [10.252.135.177] (kliang2-mobl.ccr.corp.intel.com [10.252.135.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0668E580428;
        Fri,  3 Jul 2020 13:59:50 -0700 (PDT)
Subject: Re: [PATCH V3 13/23] perf/x86/intel/lbr: Factor out
 intel_pmu_store_lbr
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
 <1593780569-62993-14-git-send-email-kan.liang@linux.intel.com>
 <20200703195024.GI2483@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <bf63dee4-d25f-89d8-1893-572d84cfa667@linux.intel.com>
Date:   Fri, 3 Jul 2020 16:59:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200703195024.GI2483@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/2020 3:50 PM, Peter Zijlstra wrote:
> On Fri, Jul 03, 2020 at 05:49:19AM -0700, kan.liang@linux.intel.com wrote:
>> +static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
>> +				struct lbr_entry *entries)
>> +{
>> +	struct perf_branch_entry *e;
>> +	struct lbr_entry *lbr;
>> +	u64 from, to, info;
>> +	int i;
>> +
>> +	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>> +		lbr = entries ? &entries[i] : NULL;
>> +		e = &cpuc->lbr_entries[i];
>> +
>> +		from = rdlbr_from(i, lbr);
>> +		/*
>> +		 * Read LBR entries until invalid entry (0s) is detected.
>> +		 */
>> +		if (!from)
>> +			break;
>> +
>> +		to = rdlbr_to(i, lbr);
>> +		info = rdlbr_info(i, lbr);
>> +
>> +		e->from		= from;
>> +		e->to		= to;
>> +		e->mispred	= !!(info & LBR_INFO_MISPRED);
>> +		e->predicted	= !(info & LBR_INFO_MISPRED);
>> +		e->in_tx	= !!(info & LBR_INFO_IN_TX);
>> +		e->abort	= !!(info & LBR_INFO_ABORT);
>> +		e->cycles	= info & LBR_INFO_CYCLES;
>> +		e->type		= 0;
>> +		e->reserved	= 0;
>> +	}
>> +
>> +	cpuc->lbr_stack.nr = i;
>> +}
> 
> If I'm not mistaken, this correctly deals with LBR_FORMAT_INFO, so can't
> we also use the intel_pmu_arch_lbr_read() function for that case?

But the intel_pmu_arch_lbr_read() doesn't have the optimization 
(LBR_NO_INFO) for the LBR_FORMAT_INFO.
https://lkml.kernel.org/r/tip-b16a5b52eb90d92b597257778e51e1fdc6423e64@git.kernel.org

To apply the optimization, we need extra codes as below.

The problem is that the arch LBR XSAVES read and the adaptive PEBS read 
don't need the optimization.

Also, the name intel_pmu_arch_lbr_read() becomes misleading. 
LBR_FORMAT_INFO doesn't have an exact format as arch LBR.


diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 213e814..9ff5ab7 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -929,7 +929,8 @@ static __always_inline bool get_lbr_cycles(u64 info)
  }

  static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
-				struct lbr_entry *entries)
+				struct lbr_entry *entries,
+				bool need_info)
  {
  	struct perf_branch_entry *e;
  	struct lbr_entry *lbr;
@@ -948,25 +949,36 @@ static void intel_pmu_store_lbr(struct 
cpu_hw_events *cpuc,
  			break;

  		to = rdlbr_to(i, lbr);
-		info = rdlbr_info(i, lbr);

  		e->from		= from;
  		e->to		= to;
-		e->mispred	= get_lbr_mispred(info);
-		e->predicted	= get_lbr_predicted(info);
-		e->in_tx	= !!(info & LBR_INFO_IN_TX);
-		e->abort	= !!(info & LBR_INFO_ABORT);
-		e->cycles	= get_lbr_cycles(info);
-		e->type		= get_lbr_br_type(info);
+		if (need_info) {
+			info = rdlbr_info(i, lbr);
+			e->mispred	= get_lbr_mispred(info);
+			e->predicted	= get_lbr_predicted(info);
+			e->in_tx	= !!(info & LBR_INFO_IN_TX);
+			e->abort	= !!(info & LBR_INFO_ABORT);
+			e->cycles	= get_lbr_cycles(info);
+			e->type		= get_lbr_br_type(info);
+		}
+
  		e->reserved	= 0;
  	}

  	cpuc->lbr_stack.nr = i;
  }

+static __always_inline bool lbr_need_info(struct cpu_hw_events *cpuc)
+{
+	if (cpuc->lbr_sel)
+		return !(cpuc->lbr_sel->config & LBR_NO_INFO);
+
+	return false;
+}
+
  static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
  {
-	intel_pmu_store_lbr(cpuc, NULL);
+	intel_pmu_store_lbr(cpuc, NULL, lbr_need_info(cpuc));
  }

  static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
@@ -974,12 +986,12 @@ static void intel_pmu_arch_lbr_read_xsave(struct 
cpu_hw_events *cpuc)
  	struct x86_perf_task_context_arch_lbr_xsave *xsave = cpuc->lbr_xsave;

  	if (!xsave) {
-		intel_pmu_store_lbr(cpuc, NULL);
+		intel_pmu_store_lbr(cpuc, NULL, lbr_need_info(cpuc));
  		return;
  	}
  	copy_dynamic_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);

-	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
+	intel_pmu_store_lbr(cpuc, xsave->lbr.entries, lbr_need_info(cpuc));
  }

  void intel_pmu_lbr_read(void)
@@ -1460,7 +1472,7 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr)
  	else
  		cpuc->lbr_stack.hw_idx = intel_pmu_lbr_tos();

-	intel_pmu_store_lbr(cpuc, lbr->lbr);
+	intel_pmu_store_lbr(cpuc, lbr->lbr, lbr_need_info(cpuc));

  	intel_pmu_lbr_filter(cpuc);
  }

Thanks,
Kan

> 
> Then we can delete that section from read_64...
> 
> Index: linux-2.6/arch/x86/events/intel/core.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/events/intel/core.c
> +++ linux-2.6/arch/x86/events/intel/core.c
> @@ -4664,6 +4664,9 @@ __init int intel_pmu_init(void)
>   		x86_pmu.lbr_read = intel_pmu_lbr_read_32;
>   	}
>   
> +	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
> +		x86_pmu.lbr_read = intel_pmu_arch_lbr_read;
> +
>   	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
>   		intel_pmu_arch_lbr_init();
>
