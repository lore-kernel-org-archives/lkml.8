Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70191C47256
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 02:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514232073E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 02:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgEBCeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 22:34:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:51886 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgEBCeE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 22:34:04 -0400
IronPort-SDR: 9+p19p9ZVpTObSwemzvG5I3duPX6taHZ+9+lmOW5pQmb+wPl4k3wpNa5tqBSKcHil3RsA7v7Gg
 qe/2ZBiN0b0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 19:34:03 -0700
IronPort-SDR: zYreQnD2oby990K0tTL8YxOo9qOa6YDLE6dLYNe0meZliS8VUY1DaLC8Ek1GKpuIRu4oQ3Cje4
 3AW1fPifOjQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,342,1583222400"; 
   d="scan'208";a="368598988"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.249.169.62]) ([10.249.169.62])
  by fmsmga001.fm.intel.com with ESMTP; 01 May 2020 19:34:00 -0700
Subject: Re: [PATCH] perf evsel: Get group fd from CPU0 for system wide event
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200430013451.17196-1-yao.jin@linux.intel.com>
 <20200501102337.GA1761222@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <b799b66a-42aa-6c55-647e-7b718473632a@linux.intel.com>
Date:   Sat, 2 May 2020 10:33:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501102337.GA1761222@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/1/2020 6:23 PM, Jiri Olsa wrote:
> On Thu, Apr 30, 2020 at 09:34:51AM +0800, Jin Yao wrote:
>> A metric may consist of system wide event and non system-wide event.
>> The event group leader may be the system wide event.
>>
>> For example, the metric "C2_Pkg_Residency" consists of
>> "cstate_pkg/c2-residency" and "msr/tsc". The former counts on the first
>> CPU of socket (tagged system-wide) and the latter is per CPU.
>>
>> But "C2_Pkg_Residency" hits assertion failure on cascadelakex.
>>
>>   # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
>>   perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
>>   Aborted
>>
>> get_group_fd(evsel, cpu, thread)
>> {
>> 	leader = evsel->leader;
>> 	fd = FD(leader, cpu, thread);
>> 	BUG_ON(fd == -1);
>> }
>>
>> Considering this case, leader is "cstate_pkg/c2-residency", evsel is
>> "msr/tsc" and cpu is 1. Because "cstate_pkg/c2-residency" is a system-wide
>> event and it's processed on CPU0, so FD(leader, 1, thread) must return an
>> invalid fd, then BUG_ON() may be triggered.
>>
>> This patch gets group fd from CPU0 for system wide event if
>> FD(leader, cpu, thread) returns invalid fd.
>>
>> With this patch,
>>
>>   # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
>>
>>   Performance counter stats for 'system wide':
>>
>>          1000850802      cstate_pkg/c2-residency/  #      0.5 C2_Pkg_Residency
>>        201446161592      msr/tsc/
>>
>>         1.010637051 seconds time elapsed
>>
>> Fixes: 6a4bb04caacc ("perf tools: Enable grouping logic for parsed events")
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/evsel.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 6a571d322bb2..cd6470f63d6f 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1461,6 +1461,9 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
>>   	BUG_ON(!leader->core.fd);
>>   
>>   	fd = FD(leader, cpu, thread);
>> +	if (fd == -1 && leader->core.system_wide)
> 
> fd does not need to be -1 in here.. in my setup cstate_pkg/c2-residency/
> has cpumask 0, so other cpus never get open and are 0, and the whole thing
> ends up with:
> 
> 	sys_perf_event_open: pid -1  cpu 1  group_fd 0  flags 0
> 	sys_perf_event_open failed, error -9
> 
> I actualy thought we put -1 to fd array but couldn't find it.. perhaps we should od that
> 
> 

I have tested on two platforms. On KBL desktop fd is 0 for this case, but on 
oncascadelakex server, fd is -1, so the BUG_ON(fd == -1) is triggered.

>> +		fd = FD(leader, 0, thread);
>> +
> 
> so how do we group following events?
> 
>    cstate_pkg/c2-residency/ - cpumask 0
>    msr/tsc/                 - all cpus
>

Not sure if it's enough to only use cpumask 0 because cstate_pkg/c2-residency/ 
should be per-socket.

> cpu 0 is fine.. the rest I have no idea ;-)
> 

Perhaps we directly remove the BUG_ON(fd == -1) assertion?

Thanks
Jin Yao

> that's why metrics use the :W, that disables grouping on failure
> 
> jirka
> 
>>   	BUG_ON(fd == -1);
>>   
>>   	return fd;
>> -- 
>> 2.17.1
>>
> 
