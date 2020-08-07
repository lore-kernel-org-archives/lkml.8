Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C7DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D26022CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgHGG0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 02:26:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:32443 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHGG0j (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 02:26:39 -0400
IronPort-SDR: KdwZh2uuv0YnCKX/lj7j6BdvJxsnCi4W2A3sThQ31vHuABu8sOTr7OgfjA+zcVzzY12TISiv9J
 uXEw9MptarTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="132571096"
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; 
   d="scan'208";a="132571096"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 23:26:38 -0700
IronPort-SDR: e9ohWup2ow4qO29FdVaQPZTv+DAF86/1fTPjO6KTnqR4Tk+b6ozHfYMHt06+Ornu4pbr5Jwc6R
 zBhHR5MzXrMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; 
   d="scan'208";a="323672087"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2020 23:26:35 -0700
Subject: Re: [PATCH] perf record: Skip side-band event setup if
 HAVE_LIBBPF_SUPPORT is not set
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200805022937.29184-1-yao.jin@linux.intel.com>
 <20200806194357.GA539212@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <40e2749a-9939-9862-05c8-fb7d41de0abd@linux.intel.com>
Date:   Fri, 7 Aug 2020 14:26:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806194357.GA539212@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 8/7/2020 3:43 AM, Jiri Olsa wrote:
> On Wed, Aug 05, 2020 at 10:29:37AM +0800, Jin Yao wrote:
>> We received an error report that perf-record caused 'Segmentation fault'
>> on a newly system (e.g. on the new installed ubuntu).
>>
>>   (gdb) backtrace
>>   #0  __read_once_size (size=4, res=<synthetic pointer>, p=0x14) at /root/0-jinyao/acme/tools/include/linux/compiler.h:139
>>   #1  atomic_read (v=0x14) at /root/0-jinyao/acme/tools/include/asm/../../arch/x86/include/asm/atomic.h:28
>>   #2  refcount_read (r=0x14) at /root/0-jinyao/acme/tools/include/linux/refcount.h:65
>>   #3  perf_mmap__read_init (map=map@entry=0x0) at mmap.c:177
>>   #4  0x0000561ce5c0de39 in perf_evlist__poll_thread (arg=0x561ce68584d0) at util/sideband_evlist.c:62
>>   #5  0x00007fad78491609 in start_thread (arg=<optimized out>) at pthread_create.c:477
>>   #6  0x00007fad7823c103 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> hum, I recall discussing the same issue,
> I thought it was already fixed :-\ in any case:
> 

Is it possible some patches have been posted but we missed? :)

> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 

Thanks!

Thanks
Jin Yao

> thanks,
> jirka
> 
>>
>> The root cause is, evlist__add_bpf_sb_event() just returns 0 if
>> HAVE_LIBBPF_SUPPORT is not defined (inline function path). So it will
>> not create a valid evsel for side-band event.
>>
>> But perf-record still creates BPF side band thread to process the
>> side-band event, then the error happpens.
>>
>> We can reproduce this issue by removing the libelf-dev. e.g.
>> 1. apt-get remove libelf-dev
>> 2. perf record -a -- sleep 1
>>
>> root@test:~# ./perf record -a -- sleep 1
>> perf: Segmentation fault
>> Obtained 6 stack frames.
>> ./perf(+0x28eee8) [0x5562d6ef6ee8]
>> /lib/x86_64-linux-gnu/libc.so.6(+0x46210) [0x7fbfdc65f210]
>> ./perf(+0x342e74) [0x5562d6faae74]
>> ./perf(+0x257e39) [0x5562d6ebfe39]
>> /lib/x86_64-linux-gnu/libpthread.so.0(+0x9609) [0x7fbfdc990609]
>> /lib/x86_64-linux-gnu/libc.so.6(clone+0x43) [0x7fbfdc73b103]
>> Segmentation fault (core dumped)
>>
>> To fix this issue,
>>
>> 1. We either install the missing libraries to let HAVE_LIBBPF_SUPPORT
>>     be defined.
>>     e.g. apt-get install libelf-dev and install other related libraries.
>>
>> 2. Use this patch to skip the side-band event setup if HAVE_LIBBPF_SUPPORT
>>     is not set.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-record.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index b6bdccd875bc..ae97f98e2753 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -1506,6 +1506,7 @@ static int record__synthesize(struct record *rec, bool tail)
>>   	return err;
>>   }
>>   
>> +#ifdef HAVE_LIBBPF_SUPPORT
>>   static int record__process_signal_event(union perf_event *event __maybe_unused, void *data)
>>   {
>>   	struct record *rec = data;
>> @@ -1550,6 +1551,12 @@ static int record__setup_sb_evlist(struct record *rec)
>>   
>>   	return 0;
>>   }
>> +#else
>> +static int record__setup_sb_evlist(struct record *rec __maybe_unused)
>> +{
>> +	return 0;
>> +}
>> +#endif
>>   
>>   static int __cmd_record(struct record *rec, int argc, const char **argv)
>>   {
>> -- 
>> 2.17.1
>>
> 
