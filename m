Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696ABC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 407BD2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbgGUPuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:50:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:26151 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgGUPuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:50:54 -0400
IronPort-SDR: BOf9CFe584nXIWoc6rLLnGG6wtbu1UH7wvvJZE662lmmJWXd7iRS3L5UvhUprTcY3xPz+4swup
 ZSB/2LEWHTow==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="137655004"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="137655004"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 08:50:54 -0700
IronPort-SDR: tmWePrX5hy4Kaid55JWDoJLvTsGoycmX2AjTKagX4RBRNm0XSGKcOL7qnW6TPf0e+lDwc6v65z
 3xNQ50q02UlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="326409174"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2020 08:50:53 -0700
Received: from [10.254.76.99] (kliang2-mobl.ccr.corp.intel.com [10.254.76.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EE541580299;
        Tue, 21 Jul 2020 08:50:51 -0700 (PDT)
Subject: Re: [PATCH V6 09/14] perf/x86/intel: Support TopDown metrics on Ice
 Lake
To:     peterz@infradead.org
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-10-kan.liang@linux.intel.com>
 <20200721124042.GX10769@hirez.programming.kicks-ass.net>
 <e9f855ad-e4bd-8766-29b6-d251c859d58f@linux.intel.com>
 <20200721143110.GL119549@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <59795cbd-a95c-8fdd-522d-199fbb047b8a@linux.intel.com>
Date:   Tue, 21 Jul 2020 11:50:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721143110.GL119549@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2020 10:31 AM, peterz@infradead.org wrote:
> On Tue, Jul 21, 2020 at 10:23:36AM -0400, Liang, Kan wrote:
> 
>> Patch 13 forces the slots event to be part of a metric group. In patch 7,
>> for a metric group, we only update the values once with slots event.
>> I think the normal case mentioned above should not happen.
>>
>> +	/* Only need to call update_topdown_event() once for group read. */
>> +	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
>> +	    !is_slots_event(event))
>> +		return;
>> +
>> +	perf_pmu_disable(event->pmu);
>> +	x86_pmu.update_topdown_event(event);
>> +	perf_pmu_enable(event->pmu);
> 
> Ah, I missed that.
> 
> That also requires SLOTS to be the leader so that it will be the first
> read. Did we enforce that somewhere?

I think it's missed in the current patch set. The suggested code in 
patch 11 forces SLOTS to be the leader. I will apply it in V7.

Thanks,
Kan
