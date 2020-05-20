Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57155C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8C9207D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgETOrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:47:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:50501 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgETOrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:47:00 -0400
IronPort-SDR: w11a6iwJ1Py6Vv9EsuceJ8Xdm6qVBZ88lkkBm9wkB8smePCIokYRkLwduXxhynn6gbYq2X0HtX
 po7F/alY5o0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 07:47:00 -0700
IronPort-SDR: oKRv2y8SWDLopxIJN3wcCg5nqdIpcC5a2TlDCfDxonjS+9W+K7wxWfryHtxJRI1weBt/51C1Rs
 dc65wiMds2sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="289377938"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2020 07:46:59 -0700
Received: from [10.249.231.6] (abudanko-mobl.ccr.corp.intel.com [10.249.231.6])
        by linux.intel.com (Postfix) with ESMTP id A7543580100;
        Wed, 20 May 2020 07:46:57 -0700 (PDT)
Subject: Re: [PATCH v3 1/9] perf evlist: introduce control file descriptors
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
 <3a1ed73d-6d11-eeb1-0897-476c5367369d@linux.intel.com>
 <20200520123826.GF157452@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f79350b6-995f-49b1-fee7-800774fb24cd@linux.intel.com>
Date:   Wed, 20 May 2020 17:46:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520123826.GF157452@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20.05.2020 15:38, Jiri Olsa wrote:
> On Wed, May 13, 2020 at 10:59:00AM +0300, Alexey Budankov wrote:
>>
>> Define and initialize control file descriptors.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/util/evlist.c | 3 +++
>>  tools/perf/util/evlist.h | 3 +++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 2a9de6491700..aa61619fa304 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -63,6 +63,9 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
>>  	perf_evlist__set_maps(&evlist->core, cpus, threads);
>>  	evlist->workload.pid = -1;
>>  	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
>> +	evlist->ctl_fd = -1;
>> +	evlist->ctl_fd_ack = -1;
>> +	evlist->ctl_fd_pos = -1;
>>  }
>>  
>>  struct evlist *evlist__new(void)
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index b6f325dfb4d2..62f259d89b41 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -74,6 +74,9 @@ struct evlist {
>>  		pthread_t		th;
>>  		volatile int		done;
>>  	} thread;
>> +	int		ctl_fd;
>> +	int		ctl_fd_ack;
>> +	int		ctl_fd_pos;
> 
> we are using the anonymous structs to keep related
> parts together like for workload and thread
> 
> could you use it in there as well?

Accepted in v4.

~Alexey

> 
> jirka
> 
>>  };
>>  
>>  struct evsel_str_handler {
>> -- 
>> 2.24.1
>>
> 
