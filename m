Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6B2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8069420738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgFCMwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:52:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:10553 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgFCMwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:52:41 -0400
IronPort-SDR: irxi7yCc99vDTKUOxMIOBvcxH5VN+uHdJ/6qcaqutJ4WJT9grQSRAnLe3J2C/KSgcrUdR/Xmgc
 sYpcQwpvhj3w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 05:52:40 -0700
IronPort-SDR: n508GLROkb2f5DO81n+WQ12yzA4hWL7jUjsBE+j0nm+38Qi1Tw3YeolIXKfQ93rzfF+3cLegSg
 KOLpfzZnrnuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="304595107"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 03 Jun 2020 05:52:39 -0700
Received: from [10.249.225.188] (abudanko-mobl.ccr.corp.intel.com [10.249.225.188])
        by linux.intel.com (Postfix) with ESMTP id EBD785800E3;
        Wed,  3 Jun 2020 05:52:36 -0700 (PDT)
Subject: Re: [PATCH v4 10/10] perf record: introduce --ctl-fd[-ack] options
To:     Adrian Hunter <adrian.hunter@intel.com>,
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
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <17506256-ef3d-e3a2-a655-a9059b652785@linux.intel.com>
Date:   Wed, 3 Jun 2020 15:52:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <b4b2ddb9-296b-c260-32ef-fee17e04a29d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.06.2020 15:05, Adrian Hunter wrote:
> On 25/05/20 5:23 pm, Alexey Budankov wrote:
>>
>> Introduce --ctl-fd[-ack] options to pass open file descriptors numbers
>> from command line. Extend perf-record.txt file with --ctl-fd[-ack]
>> options description. Document possible usage model introduced by
>> --ctl-fd[-ack] options by providing example bash shell script.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/Documentation/perf-record.txt | 39 ++++++++++++++++++++++++
>>  tools/perf/builtin-record.c              | 10 ++++++
>>  tools/perf/util/record.h                 |  2 ++
>>  3 files changed, 51 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index c2c4ce7ccee2..5c012cfe68a4 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -614,6 +614,45 @@ appended unit character - B/K/M/G
>>  	The number of threads to run when synthesizing events for existing processes.
>>  	By default, the number of threads equals 1.
>>  
>> +--ctl-fd::
>> +--ctl-fd-ack::
>> +Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
>> +'disable': disable events. Optionally send control command completion ('ack') to fd-ack
>> +descriptor to synchronize with the controlling process. 
> 
> You should also explain the use of --delay=-1 here.

Well, possibly like this:

"Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
 'disable': disable events). Measurements can be started paused using --delay=-1 option.
 Optionally send control command completion ('ack') to fd-ack descriptor to synchronize
 with the controlling process. Example of bash shell script to enable and disable events
 during measurements:"
