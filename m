Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199D4C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC87B2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgCSBtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:49:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:43430 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgCSBtB (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:49:01 -0400
IronPort-SDR: AMf0luTHTamsjyS2d3T+Y6LN1F8r15hm+azEra5eIRNhnYl5C4yNH0IKoRHegsn+r3B7CPF1lX
 JQXh2esGKAFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 18:49:01 -0700
IronPort-SDR: 7f2KcNiqvaL1CzV3Z/AlGEcOt/UTohRAd3nYnBZ8ejaUtn8SmPmJzY+1Vi3w1hvBDIGqKTt8S+
 fJRG5oR7AZQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,569,1574150400"; 
   d="scan'208";a="236803405"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 Mar 2020 18:48:57 -0700
Subject: Re: [PATCH v2 00/14] perf: Stream comparison
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200313071118.11983-1-yao.jin@linux.intel.com>
 <20200318101915.GB821557@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <e78c6329-0d0c-e949-2604-27ef2024d165@linux.intel.com>
Date:   Thu, 19 Mar 2020 09:48:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318101915.GB821557@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2020 6:19 PM, Jiri Olsa wrote:
> On Fri, Mar 13, 2020 at 03:11:04PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>
>>   v2:
>>   ---
>>   Refine the codes for following patches:
>>    perf util: Create source line mapping table
>>    perf util: Create streams for managing top N hottest callchains
>>    perf util: Calculate the sum of all streams hits
>>    perf util: Add new block info functions for top N hot blocks comparison
>>
>> Jin Yao (14):
>>    perf util: Create source line mapping table
>>    perf util: Create streams for managing top N hottest callchains
>>    perf util: Return per-event callchain streams
>>    perf util: Compare two streams
>>    perf util: Calculate the sum of all streams hits
>>    perf util: Report hot streams
>>    perf diff: Support hot streams comparison
>>    perf util: Add new block info functions for top N hot blocks
>>      comparison
>>    perf util: Add new block info fmts for showing hot blocks comparison
>>    perf util: Enable block source line comparison
>>    perf diff: support hot blocks comparison
>>    perf util: Filter out streams by name of changed functions
>>    perf util: Filter out blocks by name of changed functions
>>    perf diff: Filter out streams by changed functions
> 
> I can't apply this on latest perf/core, do you have it in git tree branch?
> 
> thanks,
> jirka
> 

Not having a git tree branch. :(

Anyway let me rebase to perf/core

Thanks
Jin Yao

>>
>>   tools/perf/Documentation/perf-diff.txt |  19 +
>>   tools/perf/builtin-diff.c              | 324 ++++++++++++---
>>   tools/perf/util/Build                  |   1 +
>>   tools/perf/util/block-info.c           | 433 ++++++++++++++++++-
>>   tools/perf/util/block-info.h           |  38 +-
>>   tools/perf/util/callchain.c            | 517 +++++++++++++++++++++++
>>   tools/perf/util/callchain.h            |  34 ++
>>   tools/perf/util/srclist.c              | 555 +++++++++++++++++++++++++
>>   tools/perf/util/srclist.h              |  74 ++++
>>   9 files changed, 1935 insertions(+), 60 deletions(-)
>>   create mode 100644 tools/perf/util/srclist.c
>>   create mode 100644 tools/perf/util/srclist.h
>>
>> -- 
>> 2.17.1
>>
> 
