Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1225BC47256
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 02:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7B320857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 02:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgEBCSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 22:18:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:30978 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgEBCSG (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 22:18:06 -0400
IronPort-SDR: cC3pPELAUWJUuMnspo/uwnvK0gIpzooZQ9DBOOldvjHzPy/0rsyxhBcpadSMrMumVP22G322Ja
 03XYwytRwqvQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 19:18:06 -0700
IronPort-SDR: fN2CRbuBRh/U5fUSvxhC8uROTf2Vu9xEBy0trIsH/rJtjQFT1Yawk4RkT+2wOQ+07KGXAAEmbw
 gspluRxPinFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,342,1583222400"; 
   d="scan'208";a="368596037"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.249.169.62]) ([10.249.169.62])
  by fmsmga001.fm.intel.com with ESMTP; 01 May 2020 19:18:03 -0700
Subject: Re: [PATCH 0/2] perf stat: Support overall statistics for interval
 mode
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200430030740.27156-1-yao.jin@linux.intel.com>
 <20200501113641.GA1808514@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <b82b6e09-0e28-4799-564f-25689b778ea1@linux.intel.com>
Date:   Sat, 2 May 2020 10:18:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501113641.GA1808514@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/2020 7:36 PM, Jiri Olsa wrote:
> On Thu, Apr 30, 2020 at 11:07:38AM +0800, Jin Yao wrote:
>> Currently perf-stat supports to print counts at regular interval (-I),
>> but it's not very easy for user to get the overall statistics.
>>
>> With this patchset, it supports to report the summary at the end of
>> interval output.
>>
>> For example,
>>
>>   root@kbl-ppc:~# perf stat -e cycles -I1000 --interval-count 2
>>   #           time             counts unit events
>>        1.000412064          2,281,114      cycles
>>        2.001383658          2,547,880      cycles
>>
>>    Performance counter stats for 'system wide':
>>
>>            4,828,994      cycles
>>
>>          2.002860349 seconds time elapsed
>>
>>   root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
>>   #           time             counts unit events
>>        1.000389902          1,536,093      cycles
>>        1.000389902            420,226      instructions              #    0.27  insn per cycle
>>        2.001433453          2,213,952      cycles
>>        2.001433453            735,465      instructions              #    0.33  insn per cycle
>>
>>    Performance counter stats for 'system wide':
>>
>>            3,750,045      cycles
>>            1,155,691      instructions              #    0.31  insn per cycle
>>
>>          2.003023361 seconds time elapsed
>>
>>   root@kbl-ppc:~# perf stat -M CPI,IPC -I1000 --interval-count 2
>>   #           time             counts unit events
>>        1.000435121            905,303      inst_retired.any          #      2.9 CPI
>>        1.000435121          2,663,333      cycles
>>        1.000435121            914,702      inst_retired.any          #      0.3 IPC
>>        1.000435121          2,676,559      cpu_clk_unhalted.thread
>>        2.001615941          1,951,092      inst_retired.any          #      1.8 CPI
>>        2.001615941          3,551,357      cycles
>>        2.001615941          1,950,837      inst_retired.any          #      0.5 IPC
>>        2.001615941          3,551,044      cpu_clk_unhalted.thread
>>
>>    Performance counter stats for 'system wide':
>>
>>            2,856,395      inst_retired.any          #      2.2 CPI
>>            6,214,690      cycles
>>            2,865,539      inst_retired.any          #      0.5 IPC
>>            6,227,603      cpu_clk_unhalted.thread
>>
>>          2.003403078 seconds time elapsed
>>
>> Jin Yao (2):
>>    perf evsel: Create counts for collecting summary data
>>    perf stat: Report summary for interval mode
> 
> good idea, but I can't apply this on latest Arnaldo's perf/core,
> could you please rebase?
> 
> thanks,
> jirka
> 

Oh, yes, it couldn't be applied on perf/core. I've rebased it.

Thanks
Jin Yao

>>
>>   tools/perf/builtin-stat.c | 14 ++++++-
>>   tools/perf/util/evsel.c   | 10 ++++-
>>   tools/perf/util/evsel.h   |  1 +
>>   tools/perf/util/stat.c    | 77 +++++++++++++++++++++++++++++++++++++++
>>   tools/perf/util/stat.h    |  5 +++
>>   5 files changed, 103 insertions(+), 4 deletions(-)
>>
>> -- 
>> 2.17.1
>>
> 
