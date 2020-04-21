Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4818AC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C14C2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgDUNDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:03:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:43405 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgDUNDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:03:11 -0400
IronPort-SDR: Jt6rsowIyqIwOFYeuv80kosWp8HLukfIbzk5MIz2sy6tF9tParaALlalAVCU/fRRb/79mylVv5
 VnxgcYv1SNOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 06:03:09 -0700
IronPort-SDR: i1J4aaLMaDI7G9No0WlY7W5f1pTEHPrZi4bHOMU8eXEPwMtHsqab0C7xq4G3PIdqQmo0ivDjcS
 4FKpBCNv/r1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="scan'208";a="300601741"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2020 06:03:05 -0700
Subject: Re: [PATCH V6 13/15] perf intel-pt: Add support for text poke events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200405201327.7332-1-adrian.hunter@intel.com>
 <20200405201327.7332-14-adrian.hunter@intel.com>
 <20200421125050.GG809467@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4308a61d-cbed-e0ed-d8a9-c7306a933e7b@intel.com>
Date:   Tue, 21 Apr 2020 16:02:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421125050.GG809467@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/20 3:50 pm, Jiri Olsa wrote:
> On Sun, Apr 05, 2020 at 11:13:25PM +0300, Adrian Hunter wrote:
>> Select text poke events when available and the kernel is being traced.
>> Process text poke events to invalidate entries in Intel PT's instruction
>> cache.
>>
>> Example:
>>
>>   The example requires kernel config:
>>     CONFIG_PROC_SYSCTL=y
>>     CONFIG_SCHED_DEBUG=y
>>     CONFIG_SCHEDSTATS=y
>>
>>   Before:
>>
>>     # perf record -o perf.data.before --kcore -a -e intel_pt//k -m,64M &
>>     # cat /proc/sys/kernel/sched_schedstats
>>     0
>>     # echo 1 > /proc/sys/kernel/sched_schedstats
>>     # cat /proc/sys/kernel/sched_schedstats
>>     1
>>     # echo 0 > /proc/sys/kernel/sched_schedstats
>>     # cat /proc/sys/kernel/sched_schedstats
>>     0
>>     # kill %1
>>     [ perf record: Woken up 1 times to write data ]
>>     [ perf record: Captured and wrote 3.341 MB perf.data.before ]
>>     [1]+  Terminated                 perf record -o perf.data.before --kcore -a -e intel_pt//k -m,64M
>>     # perf script -i perf.data.before --itrace=e >/dev/null
>>     Warning:
>>     474 instruction trace errors
>>
>>   After:
>>
>>     # perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M &
>>     # cat /proc/sys/kernel/sched_schedstats
>>     0
>>     # echo 1 > /proc/sys/kernel/sched_schedstats
>>     # cat /proc/sys/kernel/sched_schedstats
>>     1
>>     # echo 0 > /proc/sys/kernel/sched_schedstats
>>     # cat /proc/sys/kernel/sched_schedstats
>>     0
>>     # kill %1
>>     [ perf record: Woken up 1 times to write data ]
>>     [ perf record: Captured and wrote 2.646 MB perf.data.after ]
>>     [1]+  Terminated                 perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M
>>     # perf script -i perf.data.after --itrace=e >/dev/null
> 
> 
> I'm still seeing some, probably I'm missing some CONFIG, will check
> 
> 	# ./perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M &
> 	[1] 5880
> 	# cat /proc/sys/kernel/sched_schedstats
> 	0
> 	# echo 1 > /proc/sys/kernel/sched_schedstats
> 	# cat /proc/sys/kernel/sched_schedstats
> 	1
> 	# echo 0 > /proc/sys/kernel/sched_schedstats
> 	# kill %1
> 	# [ perf record: Woken up 1 times to write data ]
> 	[ perf record: Captured and wrote 6.181 MB perf.data.after ]
> 	[1]+  Terminated              ./perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M
> 	# ./perf script --itrace=e -i perf.data.after > /dev/null
> 	Warning:
> 	18837 instruction trace errors
> 
> 	# ./perf script --itrace=e -i perf.data.after | head
> 	instruction trace error type 1 time 9274.420582345 cpu 9 pid 845 tid 845 ip 0xffffffff814e6cf2 code 6: Trace doesn't match instruction
> 	instruction trace error type 1 time 9274.422229726 cpu 39 pid 5880 tid 5880 ip 0xffffffffa030a320 code 6: Trace doesn't match instruction
> 	instruction trace error type 1 time 9274.422231972 cpu 39 pid 5880 tid 5880 ip 0xffffffffa0315c1c code 6: Trace doesn't match instruction
> 	instruction trace error type 1 time 9274.422236141 cpu 39 pid 5880 tid 5880 ip 0xffffffff81143263 code 6: Trace doesn't match instruction
> 	instruction trace error type 1 time 9274.422237424 cpu 39 pid 5880 tid 5880 ip 0xffffffff8115c388 code 6: Trace doesn't match instruction
> 	instruction trace error type 1 time 9274.422239028 cpu 39 pid 5880 tid 5880 ip 0xffffffff811428c9 code 6: Trace doesn't match instruction
> 	instruction trace error type 1 time 9274.422239028 cpu 39 pid 5880 tid 5880 ip 0xffffffffa13279fb code 5: Failed to get instruction
> 	instruction trace error type 1 time 9274.422242556 cpu 39 pid 5880 tid 5880 ip 0xffffffff814e9c73 code 6: Trace doesn't match instruction
> 	instruction trace error type 1 time 9274.422258915 cpu 39 pid 5880 tid 5880 ip 0xffffffff810d7da2 code 6: Trace doesn't match instruction
> 	instruction trace error type 1 time 9274.422258915 cpu 39 pid 5880 tid 5880 ip 0xffffffffa030a0b2 code 6: Trace doesn't match instruction

I don't think it can be CONFIG.  Can you share the branch you are using?
Then I can test it.


