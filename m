Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CA2C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E592073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgEGIc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:32:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:46973 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgEGIc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:32:58 -0400
IronPort-SDR: kr+vj8wqEQtNiiZRqNujLQ+WG+BvhMB9XE6vh3Z9oQsmpS9zwx4gYwUn7JKo4BNXEua7fQ2sGM
 dPMRVEr0/o2w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 01:32:57 -0700
IronPort-SDR: n7WR5DiXcGuDVdqqZXn7K79PXZUc3T1CFRWEMEzb66O02KwXDUXLBZlM0pDbff8LQA5sqdrrc1
 G//pWyXTOcgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="249210275"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 07 May 2020 01:32:57 -0700
Received: from [10.249.225.10] (abudanko-mobl.ccr.corp.intel.com [10.249.225.10])
        by linux.intel.com (Postfix) with ESMTP id B027D58048A;
        Thu,  7 May 2020 01:32:54 -0700 (PDT)
Subject: Re: [PATCH v2 02/11] perf evlist: implement control command handling
 functions
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
 <142da58d-7ff1-ea73-89e0-30342a710aab@linux.intel.com>
 <20200506202138.GF9893@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <68696671-50f7-7602-fc64-7802a8eab29a@linux.intel.com>
Date:   Thu, 7 May 2020 11:32:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506202138.GF9893@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.05.2020 23:21, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 06, 2020 at 09:19:22PM +0300, Alexey Budankov escreveu:
>>
>> Implement functions of initialization, finalization and processing
>> of control commands coming from control file descriptors.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/util/evlist.c | 100 +++++++++++++++++++++++++++++++++++++++
>>  tools/perf/util/evlist.h |  12 +++++
>>  2 files changed, 112 insertions(+)

<SNIP>

>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index 62f259d89b41..84386850c290 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -358,4 +358,16 @@ void perf_evlist__force_leader(struct evlist *evlist);
>>  struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
>>  						 struct evsel *evsel,
>>  						bool close);
>> +
>> +enum evlist_ctl_cmd {
>> +	CTL_CMD_UNSUPPORTED = 0,
>> +	CTL_CMD_ENABLE = 'e',
>> +	CTL_CMD_DISABLE = 'd',
>> +	CTL_CMD_ACK = 'a'
>> +};
> 
> Can we make this a string, I think we'll eventually ask for lots more

Like this?

#define EVLIST__CTL_CMD_ENABLE	"enable"
#define EVLIST__CTL_CMD_DISABLE	"disable"
#define EVLIST__CTL_CMD_ACK	"ack"

> stuff, like asking for a --switch-output snapshot with --overwrite,
> reconfiguring events to increase/decrease frequency, etc, interfacing
> with PERF_EVENT_IOC_MODIFY_ATTRIBUTES, PERF_EVENT_IOC_SET_FILTER, etc.
> 
> This will also allow us to have parameters, etc, wdyt?

Being a part of this patch the extension will implement configurability
that potentially could never be used.

Switch from int to string commands of variable length belongs to
the patches also implementing usage of that string commands.

> 
> Also please since these are events that deal with 'struct evlist', name
> them with the evlist__ prefix, not the perf_evlist__ one, as those
> should be used with 'struct perf_evlist', i.e. the one in libperf
> (tools/lib/perf/).

Accepted in v3.

> 
> Right now this is inconsistent, we did it that way to minimize
> disruption of the codebase when moving things from tools/perf/ to
> tools/lib/perf/, but this confuses things and I just did a
> s/perf_evsel__/evsel__) for things dealing with 'struct evsel', so lets
> not add new ones with the wrong prefix, eventually we'll have perf_ only
> for things in libperf.
> 
>> +
>> +int perf_evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
>> +int perf_evlist__finalize_ctlfd(struct evlist *evlist);
>> +int perf_evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
>> +
>>  #endif /* __PERF_EVLIST_H */
>> -- 
>> 2.24.1
>>
>>
> 
