Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3323C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912E8206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbgGVMpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:45:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:14452 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgGVMpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:45:51 -0400
IronPort-SDR: vKcfbB8DomslsmFiGL4cyEBIZ/zBbPJx21GDs4qZ/5C7ojrLgWnPX1SMXsIr8lp6Ae7k7uko7P
 mGHCDk+VQ8JA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="150297447"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="150297447"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 05:45:50 -0700
IronPort-SDR: WJ6Qj/418nndmgvTB7pOtlXgYvSgyd0ICYRCcwjMwtaIgUxGQqn1lG/yysCIb6REj67T+kL8Lv
 LdsUNmnxECkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="432364651"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 22 Jul 2020 05:45:50 -0700
Received: from [10.249.230.82] (abudanko-mobl.ccr.corp.intel.com [10.249.230.82])
        by linux.intel.com (Postfix) with ESMTP id 5A5725802E4;
        Wed, 22 Jul 2020 05:45:44 -0700 (PDT)
Subject: Re: [PATCH v12 05/15] perf evlist: implement control command handling
 functions
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
 <62518ceb-1cc9-2aba-593b-55408d07c1bf@linux.intel.com>
 <20200722122734.GJ77866@kernel.org> <20200722123423.GK77866@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <cc1e7d3d-32ad-693f-6db6-4573ad49cb20@linux.intel.com>
Date:   Wed, 22 Jul 2020 15:45:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722123423.GK77866@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22.07.2020 15:34, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jul 22, 2020 at 09:27:34AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Fri, Jul 17, 2020 at 10:01:33AM +0300, Alexey Budankov escreveu:
>>>
>>> Implement functions of initialization, finalization and processing
>>> of control command messages coming from control file descriptors.
>>> Allocate control file descriptor as descriptor at struct pollfd
>>> object of evsel_list for atomic poll() operation.
>>>
>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>> Acked-by: Jiri Olsa <jolsa@redhat.com>
>>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>>
>> I'm applying locally for testing, but can you answer what is the reason
>> for that newline in the CMD_ACK_TAG? I tried looking at previous
>> discussion but couldn't quickly find any reasoning for that
>>
>> - Arnaldo
>>
>>> +++ b/tools/perf/util/evlist.h
>>> @@ -359,4 +359,22 @@ void perf_evlist__force_leader(struct evlist *evlist);
>>>  struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
>>>  						 struct evsel *evsel,
>>>  						bool close);
>>> +#define EVLIST_CTL_CMD_ENABLE_TAG  "enable"
>>> +#define EVLIST_CTL_CMD_DISABLE_TAG "disable"
>>> +#define EVLIST_CTL_CMD_ACK_TAG     "ack\n"
>>
>> What for? That '\n'?
> 
> Oh, I see, this is not a _command_, it is a _response_, and the sender
> expects a newline, right?

Right. Shell commands can expect strings terminated by \n, e.g. 'read -u'.
See sample bash script in 00/15 for example.

> 
> So I think this needs to be marked clearly as:
> 
> // Commands accepted by 'perf record'
> 
> #define EVLIST_CTL_CMD_ENABLE_TAG  "enable"
> #define EVLIST_CTL_CMD_DISABLE_TAG "disable"
> 
> 
> // Responses sent by 'perf record'
> 
> #define EVLIST_CTL_RSP_ACK     "ack"
> 
> And then make the response add the newline, as conceivably we could have
> something like "nack", "invalid", "enoperm", etc, no?

That above makes sense.

> 
> Anyway, this can be done on top of this series, so I'm continuing
> processing it locally.
> 
> - Arnaldo
> 

Alexei

