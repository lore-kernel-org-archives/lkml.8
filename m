Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30081C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06FDB206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgFHIEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:04:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:47149 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgFHIEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:04:41 -0400
IronPort-SDR: krh8tP65GcUuA9Nhzcoq3uazQ9un14SvNF5To2DCZK7c4ifrYg7HLjJbmlC8T3xPB9NFUSB4D0
 bOwEoV/U5G7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 01:04:41 -0700
IronPort-SDR: wpnez4Os47MvksAfNNutsKSgONBghE1WGy9Ul6ckkIztx0M0swVHsn1BlBuhp/fNJ2HrBYl196
 62dd/GkLCjog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="305746769"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2020 01:04:41 -0700
Received: from [10.249.230.149] (abudanko-mobl.ccr.corp.intel.com [10.249.230.149])
        by linux.intel.com (Postfix) with ESMTP id 2571D5805B5;
        Mon,  8 Jun 2020 01:04:36 -0700 (PDT)
Subject: Re: [PATCH v5 13/13] perf record: introduce --ctl-fd[-ack] options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
 <8ffc9f9f-af58-deea-428b-f8a69004e3cb@linux.intel.com>
 <923c40c7-7c0b-9fad-314d-69e7acbee201@intel.com>
 <937c8cc1-b4c2-8531-3fa4-d0ad9df6a65f@linux.intel.com>
 <20200601233732.GA691017@tassilo.jf.intel.com>
 <1bc7c72b-9d78-5184-a27c-8025beadaaf0@linux.intel.com>
 <d7924d7c-e2e5-c067-b9e0-cfea919e7780@linux.intel.com>
 <935187e8-6fc8-5f47-b88d-6e8c92a27286@intel.com>
 <20200605105108.GB1404794@krava>
 <3ac6d0b8-5fae-348f-8556-4bf7a66285f6@linux.intel.com>
 <20200605135743.GD1404794@krava>
 <c4f3fc64-0ea1-8a5a-ee9d-7d581510c70b@linux.intel.com>
 <0d1d9c45-a880-9a5d-e35d-c80fb3b71eab@linux.intel.com>
Organization: Intel Corp.
Message-ID: <0a2695a1-06e4-678f-736c-1560222826de@linux.intel.com>
Date:   Mon, 8 Jun 2020 11:04:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <0d1d9c45-a880-9a5d-e35d-c80fb3b71eab@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.06.2020 18:23, Alexey Budankov wrote:
> 
> On 05.06.2020 17:47, Alexey Budankov wrote:
>>
>> On 05.06.2020 16:57, Jiri Olsa wrote:
>>> On Fri, Jun 05, 2020 at 04:15:52PM +0300, Alexey Budankov wrote:
>>>>
>>>> On 05.06.2020 13:51, Jiri Olsa wrote:
>>>>> On Tue, Jun 02, 2020 at 04:43:58PM +0300, Adrian Hunter wrote:
>>>>>> On 2/06/20 12:12 pm, Alexey Budankov wrote:
>>>>>>>
>>>>>>> On 02.06.2020 11:32, Alexey Budankov wrote:
>>>>>>>>
>>>>>>>> On 02.06.2020 2:37, Andi Kleen wrote:
>>>>>>>>>>> or a pathname, or including also the event default of "disabled".
>>>>>>>>>>
>>>>>>>>>> For my cases conversion of pathnames into open fds belongs to external
>>>>>>>>>> controlling process e.g. like in the examples provided in the patch set.
>>>>>>>>>> Not sure about "event default of 'disabled'"
>>>>>>>>>
>>>>>>>>> It would be nicer for manual use cases if perf supported the path names
>>>>>>>>> directly like in Adrian's example, not needing a complex wrapper script.
>>>>>>>>
>>>>>>>> fds interface is required for VTune integration since VTune wants control
>>>>>>>> over files creation aside of Perf tool process. The script demonstrates
>>>>>>>> just one possible use case.
>>>>>>>>
>>>>>>>> Control files could easily be implemented on top of fds making open operations
>>>>>>>> for paths and then initializing fds. Interface below is vague and with explicit
>>>>>>>> options like below it could be more explicit:
>>>>>>>> --ctl-file /tmp/my-perf.fifo --ctl-file-ack /tmp/my-perf-ack.fifo
>>>>>>>
>>>>>>> Or even clearer:
>>>>>>>
>>>>>>> --ctl-fifo /tmp/my-perf --ctl-fifo-ack /tmp/my-perf-ack
>>>>>>
>>>>>> If people are OK with having so many options, then that is fine by me.
>>>>>
>>>>> the single option Adrian suggested seems better to me:
>>>>>
>>>>>  --control
>>>>>  --control 11
>>>>>  --control 11,15
>>>>
>>>> What if a user specifies fifos named like this above, not fds?
>>>>
>>>>>  --control 11,15,disabled
>>>>>  --control 11,,disabled
>>>>>  --control /tmp/my-perf.fifo
>>>>>  --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo
>>>>
>>>> What if a user wants not fifos but other type of comm channels?
>>>>
>>>>>  --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo,disabled
>>>>>  --control /tmp/my-perf.fifo,,disabled
>>>>>
>>>>> we already support this kind of options arguments, like for --call-graph
>>>>>
>>>>> jirka
>>>>>
>>>>
>>>> IMHO,
>>>> this interface, of course, looks more compact (in amount of options) however
>>>> the other side it is less user friendly. One simple option for one simple
>>>> purpose is more convenient as for users as for developers. Also complex
>>>> option syntax tends to have limitations and there are probably more
>>>> non-obvious ones.
>>>>
>>>> Please speak up. I might have missed something meaningful.
>>>
>>> how about specify the type like:
>>>
>>> --control fd:1,2,...
>>
>> What do these ... mean?
> 
> After all,
> if you want it this way and it now also fits my needs I could convert
> --ctl-fd[-ack] to --control fd:<ctl-fd>,<ack-fd> with use cases like
> --control fd:<ctl-fd> and --control fd:<ctl-fd>,<ack-fd>. Accepted?

So, do we implement fds options like this?

~Alexey
