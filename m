Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BA5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBD120720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgFVOEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:04:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:2595 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbgFVOEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:04:41 -0400
IronPort-SDR: iqa4QpTOgI2HCOfD0GqlnNRGY65hTJqx4cZGOBpjKOZ0c8sPZ5slJYCeKTA0JPC7dQ9MeKAVoN
 MMqEGAQba7yQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="143722055"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="143722055"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 07:04:27 -0700
IronPort-SDR: aXrCfGK+5ji+k8fktbTwquET9TEeawxHkrJoSAAYaTmAlcpw/eH40IQh+/CgITwIeIVaKXC9X8
 jLEl1oUF/Syw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="278768409"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2020 07:04:27 -0700
Received: from [10.249.226.81] (abudanko-mobl.ccr.corp.intel.com [10.249.226.81])
        by linux.intel.com (Postfix) with ESMTP id 9933E580342;
        Mon, 22 Jun 2020 07:04:23 -0700 (PDT)
Subject: Re: [PATCH v7 01/13] tools/libperf: introduce notion of static polled
 file descriptors
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200608084344.GA1520715@krava>
 <2d80a43a-54cf-3d12-92fd-066217c95d76@linux.intel.com>
 <20200608160758.GD1558310@krava>
 <bde9bcc3-9ec0-6e37-26f6-139b038ad3de@linux.intel.com>
 <20200615123048.GB2088119@krava>
 <8b29e324-eb8d-2266-562b-ca46aec76a3e@linux.intel.com>
 <20200615165802.GD2088119@krava>
 <8351b3ee-d345-a394-d687-443f2d2f7ec4@linux.intel.com>
 <20200622102142.GA2583819@krava>
 <cad3d9a6-da28-c627-de73-17169a7c36a1@linux.intel.com>
 <20200622121120.GA2584593@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <99674766-0cb6-7790-3ef6-90cfaf377822@linux.intel.com>
Date:   Mon, 22 Jun 2020 17:04:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622121120.GA2584593@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.2020 15:11, Jiri Olsa wrote:
> On Mon, Jun 22, 2020 at 01:50:03PM +0300, Alexey Budankov wrote:
>>
>> On 22.06.2020 13:21, Jiri Olsa wrote:
>>> On Mon, Jun 22, 2020 at 12:47:19PM +0300, Alexey Budankov wrote:
>>>
>>> SNIP
>>>
>>>>>>>>>> fdarray__del(array, fdkey);
>>>>>>>>>
>>>>>>>>> I think there's solution without having filterable type,
>>>>>>>>> I'm not sure why you think this is needed
>>>>>>>>>
>>>>>>>>> I'm busy with other things this week, but I think I can
>>>>>>>>> come up with some patch early next week if needed
>>>>>>>>
>>>>>>>> Friendly reminder.
>>>>>>>
>>>>>>> hm? I believe we discussed this in here:
>>>>>>>   https://lore.kernel.org/lkml/20200609145611.GI1558310@krava/
>>>>>>
>>>>>> Do you want it to be implemented like in the patch posted by the link?
>>>>>
>>>>> no idea.. looking for good solution ;-)
>>>>>
>>>>> how about switching completely to epoll? I tried and it
>>>>> does not look that bad
>>>>
>>>> Well, epoll() is perhaps possible but why does it want switching to epoll()?
>>>> What are the benefits and/or specific task being solved by this switch? 
>>>
>>> epoll change fixes the same issues as the patch you took in v8
>>>
>>> on top of it it's not a hack and wil make polling more user
>>> friendly because of the clear interface
>>
>> Clear. The opposite thing is /proc/sys/fs/epoll/max_user_watches limit that
>> will affect Perf tool usage additionally to the current process limit on 
>> a number of simultaneously open file descriptors (ulimit -n). So move to 
>> epoll() will impose one limit what can affect Perf tool scalability.
> 
> hum, I dont think this will be a problem:
> 
>     Allowing top 4% of low memory (per user) to be allocated in epoll watches,
>     we have:
> 
>     LOMEM    MAX_WATCHES (per user)
>     512MB    ~178000
>     1GB      ~356000
>     2GB      ~712000
> 
> my laptop has 19841945 allowed watches per user
> 
>>
>>>
>>>>
>>>>>
>>>>> there might be some loose ends (interface change), but
>>>>> I think this would solve our problems with fdarray
>>>>
>>>> Your first patch accomodated in v8 actually avoids fds typing
>>>> and solves pos (=fdarray__add()) staleness issue with fdarray.
>>>
>>> yea, it was a change meant for discussion (which never happened),
>>> and I considered it to be more a hack than a solution
>>>
>>> I suppose we can live with that for a while, but I'd like to
>>> have clean solution for polling as well
>>
>> I wouldn't treat it as a hack but more as a fix because returned
>> pos is now a part of interface that can be safely used in callers.
>> Can we go with this fix for the patch set?
> 
> apart from this one I still have a problem with that stat factoring
> having 1 complicated function deal with both fork and no fork processing,
> which I already commented on, but you ignored ;-)

Not an issue at all, lets split that func, dispatch_events() I suppose,
as you see it.

> 
> I'll try to go through that once more, and post some comments
> 
> jirka
> 

Thanks,
Alexey

