Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D60C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940FA2187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgANNqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:46:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:27860 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgANNqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:46:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 05:46:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,432,1571727600"; 
   d="scan'208";a="225221170"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga003.jf.intel.com with ESMTP; 14 Jan 2020 05:46:48 -0800
Subject: Re: [PATCH] perf tools: intel-pt: fix endless record after being
 terminated
To:     Jiri Olsa <jolsa@redhat.com>, Wei Li <liwei391@huawei.com>
Cc:     acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
References: <20200102074211.19901-1-liwei391@huawei.com>
 <20200106120250.GD207350@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7e01a903-29c3-89c4-360e-bbf4834a3f36@intel.com>
Date:   Tue, 14 Jan 2020 15:45:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106120250.GD207350@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/01/20 2:02 pm, Jiri Olsa wrote:
> On Thu, Jan 02, 2020 at 03:42:11PM +0800, Wei Li wrote:
>> In __cmd_record(), when receiving SIGINT(ctrl + c), a done flag will
>> be set and the event list will be disabled by evlist__disable() once.
>>
>> While in auxtrace_record.read_finish(), the related events will be
>> enabled again, if they are continuous, the recording seems to be endless.
>>
>> If the intel_pt event is disabled, we don't enable it again here.
>>
>> Before the patch:
>> huawei@huawei-2288H-V5:~/linux-5.5-rc4/tools/perf$ ./perf record -e \
>> intel_pt//u -p 46803
>> ^C^C^C^C^C^C
>>
>> After the patch:
>> huawei@huawei-2288H-V5:~/linux-5.5-rc4/tools/perf$ ./perf record -e \
>> intel_pt//u -p 48591
>> ^C[ perf record: Woken up 0 times to write data ]
>> Warning:
>> AUX data lost 504 times out of 4816!
>>
>> [ perf record: Captured and wrote 2024.405 MB perf.data ]
>>
>> Signed-off-by: Wei Li <liwei391@huawei.com>
>> ---
>>  tools/perf/arch/x86/util/intel-pt.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
>> index 20df442fdf36..1e96afcd8646 100644
>> --- a/tools/perf/arch/x86/util/intel-pt.c
>> +++ b/tools/perf/arch/x86/util/intel-pt.c
>> @@ -1173,9 +1173,13 @@ static int intel_pt_read_finish(struct auxtrace_record *itr, int idx)
>>  	struct evsel *evsel;
>>  
>>  	evlist__for_each_entry(ptr->evlist, evsel) {
>> -		if (evsel->core.attr.type == ptr->intel_pt_pmu->type)
>> -			return perf_evlist__enable_event_idx(ptr->evlist, evsel,
>> -							     idx);
>> +		if (evsel->core.attr.type == ptr->intel_pt_pmu->type) {
>> +			if (evsel->disabled)
>> +				return 0;
>> +			else
>> +				return perf_evlist__enable_event_idx(
>> +						ptr->evlist, evsel, idx);
> 
> what's the logic behind enabling the event in here?

Tracing stops when the auxtrace buffer is full and won't start again until
the event is scheduled in (which is never for system-wide events) but
enabling here will start tracing again immediately if possible.
