Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E30C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 00:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB3D20738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 00:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgG0A0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 20:26:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:24844 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgG0A0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 20:26:31 -0400
IronPort-SDR: aXNxlDRhgzZvlvETaAY0Zy/dJIer17clw70YXl/rmE3/Su0R/oxPxOauEJNzBhqe3lc9GwZ6xX
 EPKzjVoD6M1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="138446967"
X-IronPort-AV: E=Sophos;i="5.75,400,1589266800"; 
   d="scan'208";a="138446967"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 17:26:31 -0700
IronPort-SDR: ruCzwV8wfiVUS1iQhquK5wWU1uWCE4bxre3lUeTum1cZsdrDT6w0OrBXM/8rWVWRqvkaQNuggw
 8isKvTsgDLRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,400,1589266800"; 
   d="scan'208";a="289605446"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2020 17:26:28 -0700
Subject: Re: [PATCHv2 2/2] perf tools: Fix term parsing for raw syntax
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
References: <20200726075244.1191481-1-jolsa@kernel.org>
 <20200726075244.1191481-2-jolsa@kernel.org>
 <4d30edad-8df1-ac9d-c70d-9019935c4d4c@linux.intel.com>
Message-ID: <003c9419-4396-6ad6-b934-ec04bf9f8a63@linux.intel.com>
Date:   Mon, 27 Jul 2020 08:26:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4d30edad-8df1-ac9d-c70d-9019935c4d4c@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/2020 8:21 AM, Jin, Yao wrote:
> 
> 
> On 7/26/2020 3:52 PM, Jiri Olsa wrote:
>> Jin Yao reported issue with possible conflict between raw
>> events and term values in pmu event syntax.
>>
>> Currently following syntax is resolved as raw event with
>> 0xead value:
>>    uncore_imc_free_running/read/
>>
>> instead of using 'read' term from uncore_imc_free_running pmu,
>> because 'read' is correct raw event syntax with 0xead value.
>>
>> To solve this issue we do following:
>>    - check existing terms during rXXXX syntax processing
>>      and make them priority in case of conflict
>>    - allow pmu/r0x1234/ syntax to be able to specify conflicting
>>      raw event (implemented in previous patch)
>>
>> Also adding automated tests for this and perf_pmu__parse_cleanup
>> call to parse_events_terms, so the test gets properly cleaned up.
>>
>> Reported-by: Jin Yao<yao.jin@linux.intel.com>
>> Signed-off-by: Jiri Olsa<jolsa@kernel.org>
>> ---
>> v2 changes:
>>   - added comment to perf_pmu__test_parse_init
> 
> Acked-by: Jin Yao <yao.jin@linux.intel.com>
> 
> Thanks
> Jin Yao

Also added with:
Fixes: 3a6c51e4d66c ("perf parser: Add support to specify rXXX event with pmu")?

Thanks
Jin Yao
