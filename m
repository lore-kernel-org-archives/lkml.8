Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AFAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBC822B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbgGTSL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:11:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:43566 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgGTSL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:11:56 -0400
IronPort-SDR: u7sYJoWp2O7QGiQwMLAZKOnQ+5ykIWM0VY5xt4VxHeooygyj+g6SgT2G2FWccEv2129IGSGiMG
 /ESKN0lANMTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="168125131"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="168125131"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 11:11:56 -0700
IronPort-SDR: /fmlAY/iMfOEmHME3kfN5aV2UTzJmnU3t0dOXwf453J0OwODoOVpLilOEqCiqe0xWv1hu005GJ
 e36h0EfmZBNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="362102923"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 20 Jul 2020 11:11:56 -0700
Received: from [10.255.230.139] (kliang2-mobl.ccr.corp.intel.com [10.255.230.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 87F91580299;
        Mon, 20 Jul 2020 11:11:55 -0700 (PDT)
Subject: Re: [PATCH V6 07/14] perf/x86/intel: Generic support for hardware
 TopDown metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-8-kan.liang@linux.intel.com>
 <20200720174103.GV10769@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c814c39a-3cd2-f4d3-0b89-fbe4993e1fcc@linux.intel.com>
Date:   Mon, 20 Jul 2020 14:11:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720174103.GV10769@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2020 1:41 PM, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 07:05:47AM -0700, kan.liang@linux.intel.com wrote:
> 
>> For the event mapping, a special 0x00 event code is used, which is
>> reserved for fake events. The metric events start from umask 0x10.
> 
>> +#define INTEL_PMC_IDX_METRIC_BASE		(INTEL_PMC_IDX_FIXED + 16)
>> +#define INTEL_PMC_IDX_TD_RETIRING		(INTEL_PMC_IDX_METRIC_BASE + 0)
>> +#define INTEL_PMC_IDX_TD_BAD_SPEC		(INTEL_PMC_IDX_METRIC_BASE + 1)
>> +#define INTEL_PMC_IDX_TD_FE_BOUND		(INTEL_PMC_IDX_METRIC_BASE + 2)
>> +#define INTEL_PMC_IDX_TD_BE_BOUND		(INTEL_PMC_IDX_METRIC_BASE + 3)
> 
> So this is internal and we can change it around if/when needed, right?
> 

Yes

>> +#define INTEL_PMC_IDX_METRIC_END		INTEL_PMC_IDX_TD_BE_BOUND
>> +#define INTEL_PMC_MSK_TOPDOWN			((0xfull << INTEL_PMC_IDX_METRIC_BASE) | \
>> +						INTEL_PMC_MSK_FIXED_SLOTS)
>> +
>> +/*
>> + * There is no event-code assigned to the TopDown events.
>> + *
>> + * For the slots event, use the pseudo code of the fixed counter 3.
>> + *
>> + * For the metric events, the pseudo event-code is 0x00.
>> + * The pseudo umask-code starts from 0x10.
>> + */
>> +#define INTEL_TD_SLOTS				0x0400	/* TOPDOWN.SLOTS */
>> +/* Level 1 metrics */
>> +#define INTEL_TD_METRIC_RETIRING		0x1000	/* Retiring metric */
>> +#define INTEL_TD_METRIC_BAD_SPEC		0x1100	/* Bad speculation metric */
>> +#define INTEL_TD_METRIC_FE_BOUND		0x1200	/* FE bound metric */
>> +#define INTEL_TD_METRIC_BE_BOUND		0x1300	/* BE bound metric */
>> +#define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_BE_BOUND
>> +#define INTEL_TD_METRIC_NUM			4
> 
> But this is ABI, once we merge this, it's stuck.
> 
> Also, per how Fixed2 is 0x0300, should not Fixed16 (aka
> METRICS_RETIRING) be 0x1100 ?
> 
> But aside of that, are we sure the hardware will never grow a Fixed16?
> Or do we want to be paranoid and move the metrics events up in the
> pseudo event space?
> 

Right, we cannot guarantee that the number of fixed counters is always 
less than 16.

I will move the metrics events to the middle of the pseudo event space.

+#define INTEL_TD_METRIC_RETIRING	0x8000	/* Retiring metric */
+#define INTEL_TD_METRIC_BAD_SPEC	0x8100	/* Bad speculation metric */
+#define INTEL_TD_METRIC_FE_BOUND	0x8200	/* FE bound metric */
+#define INTEL_TD_METRIC_BE_BOUND	0x8300	/* BE bound metric */

Thanks,
Kan

