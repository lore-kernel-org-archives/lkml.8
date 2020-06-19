Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA1EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154522065F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbgFSTPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:15:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:41572 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbgFSTPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:15:14 -0400
IronPort-SDR: gC6aSqz/6svo4eNL9qnxui/ud1t8ghx/W2gRLgb1kl6b/FZqTqGsH5W8bhQ3RmQIIr9hnWJCKU
 U+9lNcvsZkVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="131480697"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="131480697"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 12:15:13 -0700
IronPort-SDR: iZkW24Zpy/mrBoR1m4f38gZVTdGTzKBX4jctPt+l5Tpjm0UzJ+3F9Aed8FoIG/nQUOef1IEt+e
 dBtcF+nTIdfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="477715513"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jun 2020 12:15:13 -0700
Received: from [10.251.1.53] (kliang2-mobl.ccr.corp.intel.com [10.251.1.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CF25B580515;
        Fri, 19 Jun 2020 12:15:10 -0700 (PDT)
Subject: Re: [PATCH 11/21] perf/x86/intel/lbr: Support LBR_CTL
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-12-git-send-email-kan.liang@linux.intel.com>
 <20200619184025.GF576888@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <42ec1526-470d-014d-f3eb-2430848856af@linux.intel.com>
Date:   Fri, 19 Jun 2020 15:15:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619184025.GF576888@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2020 2:40 PM, Peter Zijlstra wrote:
> On Fri, Jun 19, 2020 at 07:03:59AM -0700, kan.liang@linux.intel.com wrote:
>> -	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
>> +	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map || x86_pmu.lbr_ctl_map) {
> 
>> +	union {
>> +		u64		lbr_sel_mask;		   /* LBR_SELECT valid bits */
>> +		u64		lbr_ctl_mask;		   /* LBR_CTL valid bits */
>> +	};
> 
> This makes absolutely no sense. There is hoping the compiler realizes
> how stupid that is and fixes it for you, but shees.
> 

The lbr_ctl_map and the lbr_ctl_mask are two different things.

The lbr_ctl_map stores the mapping from PERF_SAMPLE_BRANCH_* to the 
corresponding filtering bits in LBR_CTL MSR. It is used to replace the 
old lbr_sel_map. The mapping information in the old lbr_sel_map is hard 
coded, and has a const type. But for arch LBR, the LBR filtering 
capabilities are enumerated from CPUID. We should not hard code the 
mapping. So I add a new variable lbr_ctl_map.

  	const int	*lbr_sel_map;		   /* lbr_select mappings */
+	int		*lbr_ctl_map;		   /* LBR_CTL mappings */


I think we cannot reuse the old lbr_sel_map for the lbr_ctl_map.

Thanks,
Kan

> Please, just keep the old name.
> 
