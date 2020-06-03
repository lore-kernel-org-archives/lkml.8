Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815B4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFAC20679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgFCPoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:44:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:3010 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgFCPoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:44:37 -0400
IronPort-SDR: poczeskezI0Ksl1pJ/M9Vd1DcP1pGjpnQoiXwRwS2mMJtW4rMTfhhibBIec1G1JHW0NDKx+Ag5
 PGKz8JPrrxUQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 08:44:36 -0700
IronPort-SDR: lRxlOZEQ0zx8cZPhKwTlSQlm/Nj/wGVU2/uC3Q9WhGe/ZtuKNSqjc5D1eY0zCbi9p/5OjJyorm
 skJXxWuOczqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,468,1583222400"; 
   d="scan'208";a="269113140"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2020 08:44:34 -0700
Subject: Re: [PATCH v4 10/10] perf record: introduce --ctl-fd[-ack] options
To:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
 <cd791bc8-2609-a136-a833-1dab6df68ff2@linux.intel.com>
 <b4b2ddb9-296b-c260-32ef-fee17e04a29d@intel.com>
 <17506256-ef3d-e3a2-a655-a9059b652785@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3efb178e-19b9-2fca-e1c8-9dcfd4a3ac2c@intel.com>
Date:   Wed, 3 Jun 2020 18:44:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <17506256-ef3d-e3a2-a655-a9059b652785@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/06/20 3:52 pm, Alexey Budankov wrote:
> 
> On 03.06.2020 15:05, Adrian Hunter wrote:
>> On 25/05/20 5:23 pm, Alexey Budankov wrote:
>>>
>>> Introduce --ctl-fd[-ack] options to pass open file descriptors numbers
>>> from command line. Extend perf-record.txt file with --ctl-fd[-ack]
>>> options description. Document possible usage model introduced by
>>> --ctl-fd[-ack] options by providing example bash shell script.
>>>
>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>> ---
>>>  tools/perf/Documentation/perf-record.txt | 39 ++++++++++++++++++++++++
>>>  tools/perf/builtin-record.c              | 10 ++++++
>>>  tools/perf/util/record.h                 |  2 ++
>>>  3 files changed, 51 insertions(+)
>>>
>>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>>> index c2c4ce7ccee2..5c012cfe68a4 100644
>>> --- a/tools/perf/Documentation/perf-record.txt
>>> +++ b/tools/perf/Documentation/perf-record.txt
>>> @@ -614,6 +614,45 @@ appended unit character - B/K/M/G
>>>  	The number of threads to run when synthesizing events for existing processes.
>>>  	By default, the number of threads equals 1.
>>>  
>>> +--ctl-fd::
>>> +--ctl-fd-ack::
>>> +Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
>>> +'disable': disable events. Optionally send control command completion ('ack') to fd-ack
>>> +descriptor to synchronize with the controlling process. 
>>
>> You should also explain the use of --delay=-1 here.
> 
> Well, possibly like this:
> 
> "Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
>  'disable': disable events). Measurements can be started paused using --delay=-1 option.

Instead of:

"Measurements can be started paused using --delay=-1 option."

perhaps:

"To start with events disabled, the --delay=-1 option can be used."

>  Optionally send control command completion ('ack') to fd-ack descriptor to synchronize
>  with the controlling process. Example of bash shell script to enable and disable events
>  during measurements:"
> 

