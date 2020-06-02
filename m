Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD488C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5131206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgFBIcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:32:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:46485 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgFBIcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:32:51 -0400
IronPort-SDR: 3bI2UUee2k86+R5kY+fnWEdfM6e7sGvFig/urilSDE0wBwg3U2qjUrOUEvfWdX2hp+sgC0pENW
 ivl22ijdnTDA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 01:32:51 -0700
IronPort-SDR: QGLK+NJxmE+S3aUODh9790b2ovJai3DW6vmGTkGlAZlbLpevL6JSbIIBRjkSn/CiuZXt7fUx1I
 uyB71eYdoxyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="257554921"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 02 Jun 2020 01:32:50 -0700
Received: from [10.249.224.186] (abudanko-mobl.ccr.corp.intel.com [10.249.224.186])
        by linux.intel.com (Postfix) with ESMTP id 72E8258027C;
        Tue,  2 Jun 2020 01:32:48 -0700 (PDT)
Subject: Re: [PATCH v5 13/13] perf record: introduce --ctl-fd[-ack] options
To:     Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
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
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1bc7c72b-9d78-5184-a27c-8025beadaaf0@linux.intel.com>
Date:   Tue, 2 Jun 2020 11:32:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200601233732.GA691017@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.06.2020 2:37, Andi Kleen wrote:
>>> or a pathname, or including also the event default of "disabled".
>>
>> For my cases conversion of pathnames into open fds belongs to external
>> controlling process e.g. like in the examples provided in the patch set.
>> Not sure about "event default of 'disabled'"
> 
> It would be nicer for manual use cases if perf supported the path names
> directly like in Adrian's example, not needing a complex wrapper script.

fds interface is required for VTune integration since VTune wants control
over files creation aside of Perf tool process. The script demonstrates
just one possible use case.

Control files could easily be implemented on top of fds making open operations
for paths and then initializing fds. Interface below is vague and with explicit
options like below it could be more explicit:
--ctl-file /tmp/my-perf.fifo --ctl-file-ack /tmp/my-perf-ack.fifo

Make either fds and or files provided on the command line. Implement file
options handling callbacks that would open paths and setting fds. Close fds
if they were opened by Perf tool process.

Adrian, please share your mind and use case.

~Alexey

> 
> -Andi
>>
>>>
>>> e.g. add "--control" and support all of:
>>>
>>> --control
>>> --control 11
>>> --control 11,15
>>> --control 11,15,disabled
>>> --control 11,,disabled
>>> --control /tmp/my-perf.fifo
>>> --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo
>>> --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo,disabled
>>> --control /tmp/my-perf.fifo,,disabled
>>>
>>> Regards
>>> Adrian
>>>
>>
>> Regards,
>> Alexey
>>
