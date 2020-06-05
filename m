Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C84C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D454206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgFEOre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:47:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:22528 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgFEOrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:47:33 -0400
IronPort-SDR: emjq8j6Uf7Hvui7rJhK1Yyy7mYqm0WP+TecBACIKER1Fb2oBl0T9IKx9U6FMX03Qc2DCDX0Omc
 czZ/Doa7AHKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 07:47:32 -0700
IronPort-SDR: 1r8QDFTlHGj0Gbr3R32FmKCmc+dxYSVnMCZqyuSz8efxxc/l7322tU5jKcbejJTq9Zs9ajAOJC
 DJXjOEGCGH9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="scan'208";a="294712837"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jun 2020 07:47:31 -0700
Received: from [10.249.226.228] (abudanko-mobl.ccr.corp.intel.com [10.249.226.228])
        by linux.intel.com (Postfix) with ESMTP id 45C5F580569;
        Fri,  5 Jun 2020 07:47:29 -0700 (PDT)
Subject: Re: [PATCH v5 13/13] perf record: introduce --ctl-fd[-ack] options
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
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <c4f3fc64-0ea1-8a5a-ee9d-7d581510c70b@linux.intel.com>
Date:   Fri, 5 Jun 2020 17:47:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605135743.GD1404794@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.06.2020 16:57, Jiri Olsa wrote:
> On Fri, Jun 05, 2020 at 04:15:52PM +0300, Alexey Budankov wrote:
>>
>> On 05.06.2020 13:51, Jiri Olsa wrote:
>>> On Tue, Jun 02, 2020 at 04:43:58PM +0300, Adrian Hunter wrote:
>>>> On 2/06/20 12:12 pm, Alexey Budankov wrote:
>>>>>
>>>>> On 02.06.2020 11:32, Alexey Budankov wrote:
>>>>>>
>>>>>> On 02.06.2020 2:37, Andi Kleen wrote:
>>>>>>>>> or a pathname, or including also the event default of "disabled".
>>>>>>>>
>>>>>>>> For my cases conversion of pathnames into open fds belongs to external
>>>>>>>> controlling process e.g. like in the examples provided in the patch set.
>>>>>>>> Not sure about "event default of 'disabled'"
>>>>>>>
>>>>>>> It would be nicer for manual use cases if perf supported the path names
>>>>>>> directly like in Adrian's example, not needing a complex wrapper script.
>>>>>>
>>>>>> fds interface is required for VTune integration since VTune wants control
>>>>>> over files creation aside of Perf tool process. The script demonstrates
>>>>>> just one possible use case.
>>>>>>
>>>>>> Control files could easily be implemented on top of fds making open operations
>>>>>> for paths and then initializing fds. Interface below is vague and with explicit
>>>>>> options like below it could be more explicit:
>>>>>> --ctl-file /tmp/my-perf.fifo --ctl-file-ack /tmp/my-perf-ack.fifo
>>>>>
>>>>> Or even clearer:
>>>>>
>>>>> --ctl-fifo /tmp/my-perf --ctl-fifo-ack /tmp/my-perf-ack
>>>>
>>>> If people are OK with having so many options, then that is fine by me.
>>>
>>> the single option Adrian suggested seems better to me:
>>>
>>>  --control
>>>  --control 11
>>>  --control 11,15
>>
>> What if a user specifies fifos named like this above, not fds?
>>
>>>  --control 11,15,disabled
>>>  --control 11,,disabled
>>>  --control /tmp/my-perf.fifo
>>>  --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo
>>
>> What if a user wants not fifos but other type of comm channels?
>>
>>>  --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo,disabled
>>>  --control /tmp/my-perf.fifo,,disabled
>>>
>>> we already support this kind of options arguments, like for --call-graph
>>>
>>> jirka
>>>
>>
>> IMHO,
>> this interface, of course, looks more compact (in amount of options) however
>> the other side it is less user friendly. One simple option for one simple
>> purpose is more convenient as for users as for developers. Also complex
>> option syntax tends to have limitations and there are probably more
>> non-obvious ones.
>>
>> Please speak up. I might have missed something meaningful.
> 
> how about specify the type like:
> 
> --control fd:1,2,...

What do these ... mean?

> --control fifo:/tmp/fifo1,/tmp/fifo2
> --control xxx:....
> 
> this way we can extend the functionality in the future
> and stay backward compatible, while keeping single option

Well, it clarifies more. However it still implicitly assumes
and requires proper ordering e.g. 1 is ctl-fd and 2 is ack-fd
and if there are some more positions there will be gaps like
--control fd:10,,something,,something ...

Why is one single option with complex syntax more preferable
than several simple options? Also it would still consume almost
equal amount of command line space in shell.

Thanks,
Alexey

> 
> jirka
> 
