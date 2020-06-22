Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFFBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A861C20675
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgFVKuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:50:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:8792 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgFVKuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:50:12 -0400
IronPort-SDR: XmpAACf/NJ9SEkMQG3MB7Bzz/DQGnz9QUX+wBRZn5hlIIqTfXs488OylMnKp2WErga/5kMylWo
 yCblGXls5w4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="161804871"
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; 
   d="scan'208";a="161804871"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 03:50:09 -0700
IronPort-SDR: +QctP/WMWVDPHFonorsaeCyL/QQUU1bGcxijVpSxNK/A/KeR2KgCRegkpa/7mSusW3PgBzgVg8
 RK9uS0ItioJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; 
   d="scan'208";a="384452378"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2020 03:50:09 -0700
Received: from [10.249.226.81] (abudanko-mobl.ccr.corp.intel.com [10.249.226.81])
        by linux.intel.com (Postfix) with ESMTP id 72E51580514;
        Mon, 22 Jun 2020 03:50:04 -0700 (PDT)
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
References: <be40edeb-0cb9-5e11-2a22-8392316cdced@linux.intel.com>
 <49eca46e-4d0e-2ae5-d7d9-e37a4d680270@linux.intel.com>
 <20200608084344.GA1520715@krava>
 <2d80a43a-54cf-3d12-92fd-066217c95d76@linux.intel.com>
 <20200608160758.GD1558310@krava>
 <bde9bcc3-9ec0-6e37-26f6-139b038ad3de@linux.intel.com>
 <20200615123048.GB2088119@krava>
 <8b29e324-eb8d-2266-562b-ca46aec76a3e@linux.intel.com>
 <20200615165802.GD2088119@krava>
 <8351b3ee-d345-a394-d687-443f2d2f7ec4@linux.intel.com>
 <20200622102142.GA2583819@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <cad3d9a6-da28-c627-de73-17169a7c36a1@linux.intel.com>
Date:   Mon, 22 Jun 2020 13:50:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622102142.GA2583819@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22.06.2020 13:21, Jiri Olsa wrote:
> On Mon, Jun 22, 2020 at 12:47:19PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>>>>>>> fdarray__del(array, fdkey);
>>>>>>>
>>>>>>> I think there's solution without having filterable type,
>>>>>>> I'm not sure why you think this is needed
>>>>>>>
>>>>>>> I'm busy with other things this week, but I think I can
>>>>>>> come up with some patch early next week if needed
>>>>>>
>>>>>> Friendly reminder.
>>>>>
>>>>> hm? I believe we discussed this in here:
>>>>>   https://lore.kernel.org/lkml/20200609145611.GI1558310@krava/
>>>>
>>>> Do you want it to be implemented like in the patch posted by the link?
>>>
>>> no idea.. looking for good solution ;-)
>>>
>>> how about switching completely to epoll? I tried and it
>>> does not look that bad
>>
>> Well, epoll() is perhaps possible but why does it want switching to epoll()?
>> What are the benefits and/or specific task being solved by this switch? 
> 
> epoll change fixes the same issues as the patch you took in v8
> 
> on top of it it's not a hack and wil make polling more user
> friendly because of the clear interface

Clear. The opposite thing is /proc/sys/fs/epoll/max_user_watches limit that
will affect Perf tool usage additionally to the current process limit on 
a number of simultaneously open file descriptors (ulimit -n). So move to 
epoll() will impose one limit what can affect Perf tool scalability.

> 
>>
>>>
>>> there might be some loose ends (interface change), but
>>> I think this would solve our problems with fdarray
>>
>> Your first patch accomodated in v8 actually avoids fds typing
>> and solves pos (=fdarray__add()) staleness issue with fdarray.
> 
> yea, it was a change meant for discussion (which never happened),
> and I considered it to be more a hack than a solution
> 
> I suppose we can live with that for a while, but I'd like to
> have clean solution for polling as well

I wouldn't treat it as a hack but more as a fix because returned
pos is now a part of interface that can be safely used in callers.
Can we go with this fix for the patch set?

Thanks,
Alexey
