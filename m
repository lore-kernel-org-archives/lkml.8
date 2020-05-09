Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EEDC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 07:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F3C217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 07:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgEIHhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 03:37:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:47240 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbgEIHhX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 03:37:23 -0400
IronPort-SDR: ++L/WuaqRgM+WXRnmMHeNHpOEUtlH36nsTOF+rK16BPn5U8yBtZ4YMKe5SVc6Xq3aakk7wx9+2
 eEa8aH0lDGMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2020 00:37:22 -0700
IronPort-SDR: OqQCGHtqoV5Vy9KSd2CsLhID824BMBAcWKikzXpnIUzevYVzm3BlNgTahjuH4xmwfbeO3nI2g6
 RbRQ67L5aTZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,370,1583222400"; 
   d="scan'208";a="370730047"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga001.fm.intel.com with ESMTP; 09 May 2020 00:37:20 -0700
Subject: Re: [PATCH] perf evsel: Get group fd from CPU0 for system wide event
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200430013451.17196-1-yao.jin@linux.intel.com>
 <20200501102337.GA1761222@krava>
 <b799b66a-42aa-6c55-647e-7b718473632a@linux.intel.com>
 <20200505000352.GH1916255@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <3e813227-4954-0d4b-bc7a-ca272b18454a@linux.intel.com>
Date:   Sat, 9 May 2020 15:37:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200505000352.GH1916255@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/5/2020 8:03 AM, Jiri Olsa wrote:
> On Sat, May 02, 2020 at 10:33:59AM +0800, Jin, Yao wrote:
> 
> SNIP
> 
>>>> @@ -1461,6 +1461,9 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
>>>>    	BUG_ON(!leader->core.fd);
>>>>    	fd = FD(leader, cpu, thread);
>>>> +	if (fd == -1 && leader->core.system_wide)
>>>
>>> fd does not need to be -1 in here.. in my setup cstate_pkg/c2-residency/
>>> has cpumask 0, so other cpus never get open and are 0, and the whole thing
>>> ends up with:
>>>
>>> 	sys_perf_event_open: pid -1  cpu 1  group_fd 0  flags 0
>>> 	sys_perf_event_open failed, error -9
>>>
>>> I actualy thought we put -1 to fd array but couldn't find it.. perhaps we should od that
>>>
>>>
>>
>> I have tested on two platforms. On KBL desktop fd is 0 for this case, but on
>> oncascadelakex server, fd is -1, so the BUG_ON(fd == -1) is triggered.
>>
>>>> +		fd = FD(leader, 0, thread);
>>>> +
>>>
>>> so how do we group following events?
>>>
>>>     cstate_pkg/c2-residency/ - cpumask 0
>>>     msr/tsc/                 - all cpus
>>>
>>
>> Not sure if it's enough to only use cpumask 0 because
>> cstate_pkg/c2-residency/ should be per-socket.
>>
>>> cpu 0 is fine.. the rest I have no idea ;-)
>>>
>>
>> Perhaps we directly remove the BUG_ON(fd == -1) assertion?
> 
> I think we need to make clear how to deal with grouping over
> events that comes for different cpus
> 
> 	so how do we group following events?
> 	
> 	   cstate_pkg/c2-residency/ - cpumask 0
> 	   msr/tsc/                 - all cpus
> 
> 
> what's the reason/expected output of groups with above events?
> seems to make sense only if we limit msr/tsc/ to cpumask 0 as well
> 
> jirka
> 

On 2-socket machine (e.g cascadelakex), "cstate_pkg/c2-residency/" is per-socket 
event and the cpumask is 0 and 24.

root@lkp-csl-2sp5 /sys/devices/cstate_pkg# cat cpumask
0,24

We can't limit it to cpumask 0. It should be programmed on CPU0 and CPU24 (the 
first CPU on each socket).

The "msr/tsc" are per-cpu event, it should be programmed on all cpus. So I don't 
think we can limit msr/tsc to cpumask 0.

The issue is how we deal with get_group_fd().

static int get_group_fd(struct evsel *evsel, int cpu, int thread)
{
         struct evsel *leader = evsel->leader;
         int fd;

         if (evsel__is_group_leader(evsel))
                 return -1;

         /*
          * Leader must be already processed/open,
          * if not it's a bug.
          */
         BUG_ON(!leader->core.fd);

         fd = FD(leader, cpu, thread);
         BUG_ON(fd == -1);

         return fd;
}

When evsel is "msr/tsc/",

FD(leader, 0, 0) is 3 (3 is the fd of "cstate_pkg/c2-residency/" on CPU0)
FD(leader, 1, 0) is -1
BUG_ON asserted.

If we just return group_fd(-1) for "msr/tsc", it looks like it's not a problem, 
is it?

Thanks
Jin Yao
