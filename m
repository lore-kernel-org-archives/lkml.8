Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2EBC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A895620661
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDUPjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:39:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:53404 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgDUPji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:39:38 -0400
IronPort-SDR: GCZKQb2iR8AilPm+dqBU38rVkCc0kNLVqX1NUWgvLULYVrFXHYB1lqzJffmJ7UfOC4N4fvLyDK
 cAPdA/U/oXCA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 08:39:37 -0700
IronPort-SDR: YUlXkbNHkWiRJEDd42DJfbgb7BX5x6FAotZwMIsWofBSlRwwWCzCHn5SbNYPrt4wDIuDMr1OIU
 t7eAoDP+tG5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="scan'208";a="245711021"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2020 08:39:33 -0700
Subject: Re: [PATCH V6 13/15] perf intel-pt: Add support for text poke events
From:   Adrian Hunter <adrian.hunter@intel.com>
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
 <4308a61d-cbed-e0ed-d8a9-c7306a933e7b@intel.com>
 <20200421130613.GH809467@krava>
 <65e3e544-62cc-1d0c-4daa-9425f06d903e@intel.com>
 <20200421133540.GJ809467@krava>
 <bed2b368-920b-59a6-36a4-7d3c5d62212a@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <359849fb-8636-be38-6dc7-df6af0145163@intel.com>
Date:   Tue, 21 Apr 2020 18:38:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bed2b368-920b-59a6-36a4-7d3c5d62212a@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/20 4:45 pm, Adrian Hunter wrote:
> On 21/04/20 4:35 pm, Jiri Olsa wrote:
>> On Tue, Apr 21, 2020 at 04:10:33PM +0300, Adrian Hunter wrote:
>>
>> SNIP
>>
>>>>>> I'm still seeing some, probably I'm missing some CONFIG, will check
>>>>>>
>>>>>> 	# ./perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M &
>>>>>> 	[1] 5880
>>>>>> 	# cat /proc/sys/kernel/sched_schedstats
>>>>>> 	0
>>>>>> 	# echo 1 > /proc/sys/kernel/sched_schedstats
>>>>>> 	# cat /proc/sys/kernel/sched_schedstats
>>>>>> 	1
>>>>>> 	# echo 0 > /proc/sys/kernel/sched_schedstats
>>>>>> 	# kill %1
>>>>>> 	# [ perf record: Woken up 1 times to write data ]
>>>>>> 	[ perf record: Captured and wrote 6.181 MB perf.data.after ]
>>>>>> 	[1]+  Terminated              ./perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M
>>>>>> 	# ./perf script --itrace=e -i perf.data.after > /dev/null
>>>>>> 	Warning:
>>>>>> 	18837 instruction trace errors
>>>>>>
>>>>>> 	# ./perf script --itrace=e -i perf.data.after | head
>>>>>> 	instruction trace error type 1 time 9274.420582345 cpu 9 pid 845 tid 845 ip 0xffffffff814e6cf2 code 6: Trace doesn't match instruction
>>>>>> 	instruction trace error type 1 time 9274.422229726 cpu 39 pid 5880 tid 5880 ip 0xffffffffa030a320 code 6: Trace doesn't match instruction
>>>>>> 	instruction trace error type 1 time 9274.422231972 cpu 39 pid 5880 tid 5880 ip 0xffffffffa0315c1c code 6: Trace doesn't match instruction
>>>>>> 	instruction trace error type 1 time 9274.422236141 cpu 39 pid 5880 tid 5880 ip 0xffffffff81143263 code 6: Trace doesn't match instruction
>>>>>> 	instruction trace error type 1 time 9274.422237424 cpu 39 pid 5880 tid 5880 ip 0xffffffff8115c388 code 6: Trace doesn't match instruction
>>>>>> 	instruction trace error type 1 time 9274.422239028 cpu 39 pid 5880 tid 5880 ip 0xffffffff811428c9 code 6: Trace doesn't match instruction
>>>>>> 	instruction trace error type 1 time 9274.422239028 cpu 39 pid 5880 tid 5880 ip 0xffffffffa13279fb code 5: Failed to get instruction
>>>>>> 	instruction trace error type 1 time 9274.422242556 cpu 39 pid 5880 tid 5880 ip 0xffffffff814e9c73 code 6: Trace doesn't match instruction
>>>>>> 	instruction trace error type 1 time 9274.422258915 cpu 39 pid 5880 tid 5880 ip 0xffffffff810d7da2 code 6: Trace doesn't match instruction
>>>>>> 	instruction trace error type 1 time 9274.422258915 cpu 39 pid 5880 tid 5880 ip 0xffffffffa030a0b2 code 6: Trace doesn't match instruction
>>>>>
>>>>> I don't think it can be CONFIG.  Can you share the branch you are using?
>>>>> Then I can test it.
>>>>>
>>>>
>>>> I built the one you mentioned in cover email:
>>>>   git://git.infradead.org/users/ahunter/linux-perf.git text_poke
>>>
>>> The tools and the kernel?
>>
>> both from that branch
>>
>>>
>>> Does it successfully decode anything? e.g.
>>> ./perf script --itrace=be -i perf.data.after | head
>>>
>>
>> # ./perf script --itrace=be -i perf.data.after | head
>>             perf  5880 [000]  9274.419884:          1  branches:k:                 0 [unknown] ([unknown]) => ffffffff8106a4a6 native_write_msr+0x6 (/lib/modules/5.6.0-rc6+/build/vmlinux)
>>             perf  5880 [000]  9274.419884:          1  branches:k:  ffffffff8106a4ab native_write_msr+0xb (/lib/modules/5.6.0-rc6+/build/vmlinux) => ffffffff810152f9 pt_config_start+0x59 (/lib/modules/5.6.0-rc6+/build/vmlinux)
>>             perf  5880 [000]  9274.419884:          1  branches:k:  ffffffff81015304 pt_config_start+0x64 (/lib/modules/5.6.0-rc6+/build/vmlinux) => ffffffff81015648 pt_event_add+0x38 (/lib/modules/5.6.0-rc6+/build/vmlinux)
>>             perf  5880 [000]  9274.419884:          1  branches:k:  ffffffff8101565d pt_event_add+0x4d (/lib/modules/5.6.0-rc6+/build/vmlinux) => ffffffff8121d3ca event_sched_in.isra.0+0xea (/lib/modules/5.6.0-rc6+/build/vmlinux)
>>             perf  5880 [000]  9274.419884:          1  branches:k:  ffffffff8121d3dc event_sched_in.isra.0+0xfc (/lib/modules/5.6.0-rc6+/build/vmlinux) => ffffffff8121d3e3 event_sched_in.isra.0+0x103 (/lib/modules/5.6.0-rc6+/build/vmlinux)
>>             perf  5880 [000]  9274.419884:          1  branches:k:  ffffffff8121d3f4 event_sched_in.isra.0+0x114 (/lib/modules/5.6.0-rc6+/build/vmlinux) => ffffffff8121d497 event_sched_in.isra.0+0x1b7 (/lib/modules/5.6.0-rc6+/build/vmlinux)
>>             perf  5880 [000]  9274.419884:          1  branches:k:  ffffffff8121d4c1 event_sched_in.isra.0+0x1e1 (/lib/modules/5.6.0-rc6+/build/vmlinux) => ffffffff814f9560 __list_add_valid+0x0 (/lib/modules/5.6.0-rc6+/build/vmlinux)
>>             perf  5880 [000]  9274.419884:          1  branches:k:  ffffffff814f9593 __list_add_valid+0x33 (/lib/modules/5.6.0-rc6+/build/vmlinux) => ffffffff8121d4c6 event_sched_in.isra.0+0x1e6 (/lib/modules/5.6.0-rc6+/build/vmlinux)
>>             perf  5880 [000]  9274.419884:          1  branches:k:  ffffffff8121d4e2 event_sched_in.isra.0+0x202 (/lib/modules/5.6.0-rc6+/build/vmlinux) => ffffffff8121d3fa event_sched_in.isra.0+0x11a (/lib/modules/5.6.0-rc6+/build/vmlinux)
>>             perf  5880 [000]  9274.419884:          1  branches:k:  ffffffff8121d401 event_sched_in.isra.0+0x121 (/lib/modules/5.6.0-rc6+/build/vmlinux) => ffffffff8121d40d event_sched_in.isra.0+0x12d (/lib/modules/5.6.0-rc6+/build/vmlinux)
>>
>> # ./perf script --call-trace -i perf.data.after | head
>>             perf  5880 [000]  9274.419884188:  cbr:  8 freq:  798 MHz ( 36%)    
>>             perf  5880 [000]  9274.419884389: (/lib/modules/5.6.0-rc6+/build/vmlinux             )          __list_add_valid            
>>             perf  5880 [000]  9274.419884389: (/lib/modules/5.6.0-rc6+/build/vmlinux             )          perf_pmu_enable.part.0      
>>             perf  5880 [000]  9274.419884389: (/lib/modules/5.6.0-rc6+/build/vmlinux             )              __x86_indirect_thunk_rax
>>             perf  5880 [000]  9274.419884389: (/lib/modules/5.6.0-rc6+/build/vmlinux             )          __x86_indirect_thunk_rax    
>>             perf  5880 [000]  9274.419884389: (/lib/modules/5.6.0-rc6+/build/vmlinux             )              __x86_indirect_thunk_rax
>>             perf  5880 [000]  9274.419884709: (/lib/modules/5.6.0-rc6+/build/vmlinux             )          __list_add_valid            
>>             perf  5880 [000]  9274.419884709: (/lib/modules/5.6.0-rc6+/build/vmlinux             )          rb_next                     
>>             perf  5880 [000]  9274.419884709: (/lib/modules/5.6.0-rc6+/build/vmlinux             )          merge_sched_in              
>>             perf  5880 [000]  9274.419884709: (/lib/modules/5.6.0-rc6+/build/vmlinux             )              __x86_indirect_thunk_rax
>>
> 
> perf is not using kcore, which explains the errors.  Not sure why it prefers vmlinux.  It should effectively be doing:
> 
> perf script -i perf.data.after --itrace=e --kallsyms perf.data.after/kcore_dir/kallsyms
> 
> What is in the perf.data.after directory?

I played around but have not yet figured out why perf prefers vmlinux on
your system, but I will investigate more.


