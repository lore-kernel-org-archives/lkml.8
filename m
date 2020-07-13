Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B15C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05578206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgGMIQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:16:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:44345 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgGMIQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:16:12 -0400
IronPort-SDR: ECD8d+6VRERVz1NexPRZLAD16cqy0DLQfBe3yBgY8lt1YIdTHViZQs3MDURNGkXxKe684enxaR
 QyJ+hk5S46YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="213412198"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="213412198"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 01:16:11 -0700
IronPort-SDR: W0/N1s0QOrFeETf1Nu+GSGKpwp7WPsF7Kg8kkCMvvHqU/8uN4iZ6YsxgiZY1oeB8A8vM2KRCSC
 uWVo3KQ3dYfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="325431342"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2020 01:16:11 -0700
Received: from [10.249.229.49] (abudanko-mobl.ccr.corp.intel.com [10.249.229.49])
        by linux.intel.com (Postfix) with ESMTP id 981DE580810;
        Mon, 13 Jul 2020 01:16:08 -0700 (PDT)
Subject: Re: [PATCH v10 04/15] perf evlist: introduce control file descriptors
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
 <92aa73c7-4148-a45d-6964-983fe1654d1e@linux.intel.com>
 <CAM9d7cj86U7xcmAdiKjEKNp+qS_YAP72xKusAjLWGo2frxpL_A@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <823145dc-f293-166e-290b-076c1254fe17@linux.intel.com>
Date:   Mon, 13 Jul 2020 11:16:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7cj86U7xcmAdiKjEKNp+qS_YAP72xKusAjLWGo2frxpL_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13.07.2020 6:13, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Jul 8, 2020 at 4:47 PM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
>>
>> Define and initialize control file descriptors.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/util/evlist.c | 3 +++
>>  tools/perf/util/evlist.h | 5 +++++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index bcbe0cb8482e..36eb50aba1f5 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -63,6 +63,9 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
>>         perf_evlist__set_maps(&evlist->core, cpus, threads);
>>         evlist->workload.pid = -1;
>>         evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
>> +       evlist->ctl_fd.fd = -1;
>> +       evlist->ctl_fd.ack = -1;
>> +       evlist->ctl_fd.pos = -1;
>>  }
>>
>>  struct evlist *evlist__new(void)
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index 38901c0d1599..2caf19fb87a8 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -74,6 +74,11 @@ struct evlist {
>>                 pthread_t               th;
>>                 volatile int            done;
>>         } thread;
>> +       struct {
>> +               int     fd;
>> +               int     ack;
>> +               int     pos;
>> +       } ctl_fd;
> 
> Could you please add brief descriptions for each field
> in the comment?  It's not obvious to me other than fd.

Ok. In v11.

Alexei
