Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD60EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0F5206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgGFNcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:32:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:57159 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729021AbgGFNcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:32:41 -0400
IronPort-SDR: bMzbqTD7KTEXhLlxIA1xJT3CJ2SdiwfDvbsegvOg6I5AxTUq1ecYWvPgf7lRDGh9exOBL0PvX9
 jfc3MQG+lilA==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="146492056"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="146492056"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 06:32:26 -0700
IronPort-SDR: iCjkQR/pcCWzVjt/BsBw1afyhLeW9RvhofsXU8hz5EsDiLUaTwaUY8ask9sFCxH2Q5kJwx363s
 fuk7PV0b02JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="283037878"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2020 06:32:25 -0700
Received: from [10.255.228.102] (kliang2-mobl.ccr.corp.intel.com [10.255.228.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E89D15805A3;
        Mon,  6 Jul 2020 06:32:23 -0700 (PDT)
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
 <bf63dee4-d25f-89d8-1893-572d84cfa667@linux.intel.com>
 <20200706102557.GA597537@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <f721f7ec-01bd-b2f6-81ea-cee77f425c7a@linux.intel.com>
Date:   Mon, 6 Jul 2020 09:32:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706102557.GA597537@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/2020 6:25 AM, Peter Zijlstra wrote:
> On Fri, Jul 03, 2020 at 04:59:49PM -0400, Liang, Kan wrote:
>> On 7/3/2020 3:50 PM, Peter Zijlstra wrote:
> 
>>> If I'm not mistaken, this correctly deals with LBR_FORMAT_INFO, so can't
>>> we also use the intel_pmu_arch_lbr_read() function for that case?
>>
>> But the intel_pmu_arch_lbr_read() doesn't have the optimization
>> (LBR_NO_INFO) for the LBR_FORMAT_INFO.
>> https://lkml.kernel.org/r/tip-b16a5b52eb90d92b597257778e51e1fdc6423e64@git.kernel.org
>>
>> To apply the optimization, we need extra codes as below.
> 
> Right, I saw that, but shouldn't we support that for anything with this
> format anyway? That is, it's weird and inconsistent to not support
> PERF_SAMPLE_BRANCH_NO_{CYCLES,FLAGS} for PEBS/ARCH-LBR output.
> 

OK. I will support NO_{CYCLES,FLAGS} for PEBS/ARCH-LBR to make the 
output consistent.

> Arguably, we should even support NO_CYCLES for FORMAT_TIME. Yes it's
> daft, but that's what you get for adding the ABI.
> 

I will add another patch to support NO_{CYCLES,FLAGS} for FORMAT_TIME.

The two patches will be on top of the "Support Architectural LBR" 
series. Can I send the two patches in a separate thread?


Thanks,
Kan
