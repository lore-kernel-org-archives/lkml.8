Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8521C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01002053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgD1I3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:29:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:50933 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbgD1I3e (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:29:34 -0400
IronPort-SDR: SHUTatjnUEVVDMKzGfvQMmtth2gh05c3ZRKpcNcRfb6H4k8yR7vj+V30oUame3ejDYcIYUeoKa
 WraRvb0d5tXw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 01:29:31 -0700
IronPort-SDR: IMA0oz+aqGO7ufxtp+AktWrS9PafZJjOSL1NRpYTUVTF9whekMhjHJQtLnY5stlgDLKxfL5l4G
 rKImzXLvNMTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,327,1583222400"; 
   d="scan'208";a="367432784"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2020 01:29:29 -0700
Subject: Re: [PATCH v3 0/7] perf: Stream comparison
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200420010451.24405-1-yao.jin@linux.intel.com>
 <20200427102954.GD1457790@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <f18c3b1e-ec2d-cfbc-6677-904d3f28f89c@linux.intel.com>
Date:   Tue, 28 Apr 2020 16:29:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427102954.GD1457790@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/27/2020 6:29 PM, Jiri Olsa wrote:
> On Mon, Apr 20, 2020 at 09:04:44AM +0800, Jin Yao wrote:
>> Sometimes, a small change in a hot function reducing the cycles of
>> this function, but the overall workload doesn't get faster. It is
>> interesting where the cycles are moved to.
>>
>> What it would like is to diff before/after streams. A stream we think
>> is a callchain which is aggregated by the branch records from perf
>> samples.
> 
> I wonder we could use this on intel_pt trace.. like compare streams
> for given function call.. not sure that would be feasible, but might
> be good idea to write this in a generic way and not callchain specific
> 
> jirka
> 

Yes, that's a good idea. We should try to write the code in a generic way.

Thanks
Jin Yao

>>
>> By browsing the hot streams, we can understand the hot code path.
>> By comparing the cycles variation of same streams between old perf
>> data and new perf data, we can understand if the cycles are moved
>> to other codes.
>>
>> The before stream is the stream in perf.data.old. The after stream
>> is the stream in perf.data.
>>
>> Diffing before/after streams compares top N hottest streams between
>> two perf data files.
>>
>> If all entries of one stream in perf.data.old are fully matched with
>> all entries of another stream in perf.data, we think two streams
>> are matched, otherwise the streams are not matched.
>>
>> For example,
>>
>>     cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
>> --------------------------              --------------------------
>>               main div.c:39                           main div.c:39
>>               main div.c:44                           main div.c:44
>>
>> The above streams are matched and we can see for the same streams the
>> cycles (1) are equal and the callchain hit percents are slightly changed
>> (26.80% vs. 27.30%). That's expected.
>>
>> But that's not always true if source code is changed in perf.data
>> (e.g. div.c:39 is changed). If div.c:39 is changed, they are different
>> streams, we can't compare them. We will think the stream in perf.data
>> is a new stream.
>>
>> The challenge is how to identify the changed source lines. The basic
>> idea is to use linux command "diff" to compare the source file A and
>> source file A* line by line (assume file A is used in perf.data.old
>> and file A* is used in perf.data). According to "diff" output,
>> we can generate a source line mapping table.
>>
>> For example,
>>
>>    Execute 'diff ./before/div.c ./after/div.c'
>>
>>    25c25
>>    <       i = rand() % 2;
>>    ---
>>    >       i = rand() % 4;
>>    39c39
>>    <       for (i = 0; i < 2000000000; i++) {
>>    ---
>>    >       for (i = 0; i < 20000000001; i++) {
>>
>>    div.c (after -> before) lines mapping:
>>    0 -> 0
>>    1 -> 1
>>    2 -> 2
>>    3 -> 3
>>    4 -> 4
>>    5 -> 5
>>    6 -> 6
>>    7 -> 7
>>    8 -> 8
>>    9 -> 9
>>    ...
>>    24 -> 24
>>    25 -> -1
>>    26 -> 26
>>    27 -> 27
>>    28 -> 28
>>    29 -> 29
>>    30 -> 30
>>    31 -> 31
>>    32 -> 32
>>    33 -> 33
>>    34 -> 34
>>    35 -> 35
>>    36 -> 36
>>    37 -> 37
>>    38 -> 38
>>    39 -> -1
>>    40 -> 40
>>    ...
>>
>>  From the table, we can easily know div.c:39 is source line changed.
>> (it's mapped to -1). So following two streams are not matched.
>>
>>     cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
>> --------------------------              --------------------------
>>               main div.c:39                           main div.c:39
>>               main div.c:44                           main div.c:44
>>
>> Now let's see examples.
>>
>> perf record -b ...      Generate perf.data.old with branch data
>> perf record -b ...      Generate perf.data with branch data
>> perf diff --stream
>>
>> [ Matched hot chains between old perf data and new perf data) ]
>>
>> hot chain pair 1:
>>              cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
>>          ---------------------------              --------------------------
>>                        main div.c:39                           main div.c:39
>>                        main div.c:44                           main div.c:44
>>
>> hot chain pair 2:
>>             cycles: 35, hits: 21.43%                cycles: 33, hits: 19.37%
>>          ---------------------------              --------------------------
>>            __random_r random_r.c:360               __random_r random_r.c:360
>>            __random_r random_r.c:388               __random_r random_r.c:388
>>            __random_r random_r.c:388               __random_r random_r.c:388
>>            __random_r random_r.c:380               __random_r random_r.c:380
>>            __random_r random_r.c:357               __random_r random_r.c:357
>>                __random random.c:293                   __random random.c:293
>>                __random random.c:293                   __random random.c:293
>>                __random random.c:291                   __random random.c:291
>>                __random random.c:291                   __random random.c:291
>>                __random random.c:291                   __random random.c:291
>>                __random random.c:288                   __random random.c:288
>>                       rand rand.c:27                          rand rand.c:27
>>                       rand rand.c:26                          rand rand.c:26
>>                             rand@plt                                rand@plt
>>                             rand@plt                                rand@plt
>>                compute_flag div.c:25                   compute_flag div.c:25
>>                compute_flag div.c:22                   compute_flag div.c:22
>>                        main div.c:40                           main div.c:40
>>                        main div.c:40                           main div.c:40
>>                        main div.c:39                           main div.c:39
>>
>> hot chain pair 3:
>>              cycles: 18, hits: 6.10%                 cycles: 19, hits: 6.51%
>>          ---------------------------              --------------------------
>>            __random_r random_r.c:360               __random_r random_r.c:360
>>            __random_r random_r.c:388               __random_r random_r.c:388
>>            __random_r random_r.c:388               __random_r random_r.c:388
>>            __random_r random_r.c:380               __random_r random_r.c:380
>>            __random_r random_r.c:357               __random_r random_r.c:357
>>                __random random.c:293                   __random random.c:293
>>                __random random.c:293                   __random random.c:293
>>                __random random.c:291                   __random random.c:291
>>                __random random.c:291                   __random random.c:291
>>                __random random.c:291                   __random random.c:291
>>                __random random.c:288                   __random random.c:288
>>                       rand rand.c:27                          rand rand.c:27
>>                       rand rand.c:26                          rand rand.c:26
>>                             rand@plt                                rand@plt
>>                             rand@plt                                rand@plt
>>                compute_flag div.c:25                   compute_flag div.c:25
>>                compute_flag div.c:22                   compute_flag div.c:22
>>                        main div.c:40                           main div.c:40
>>
>> hot chain pair 4:
>>               cycles: 9, hits: 5.95%                  cycles: 8, hits: 5.03%
>>          ---------------------------              --------------------------
>>            __random_r random_r.c:360               __random_r random_r.c:360
>>            __random_r random_r.c:388               __random_r random_r.c:388
>>            __random_r random_r.c:388               __random_r random_r.c:388
>>            __random_r random_r.c:380               __random_r random_r.c:380
>>
>> [ Hot chains in old perf data but source line changed (*) in new perf data ]
>>
>> [ Hot chains in old perf data only ]
>>
>> hot chain 1:
>>               cycles: 2, hits: 4.08%
>>           --------------------------
>>                        main div.c:42
>>                compute_flag div.c:28
>>
>> [ Hot chains in new perf data only ]
>>
>> hot chain 1:
>>                                                      cycles: 36, hits: 3.36%
>>                                                   --------------------------
>>                                                    __random_r random_r.c:357
>>                                                        __random random.c:293
>>                                                        __random random.c:293
>>                                                        __random random.c:291
>>                                                        __random random.c:291
>>                                                        __random random.c:291
>>                                                        __random random.c:288
>>                                                               rand rand.c:27
>>                                                               rand rand.c:26
>>                                                                     rand@plt
>>                                                                     rand@plt
>>                                                        compute_flag div.c:25
>>                                                        compute_flag div.c:22
>>                                                                main div.c:40
>>                                                                main div.c:40
>>
>> If we enable the source line comparison option, the output may be different.
>>
>> perf record -b ...      Generate perf.data.old with branch data
>> perf record -b ...      Generate perf.data with branch data
>> perf diff --stream --before ./before --after ./after
>>
>> [ Matched hot chains between old perf data and new perf data) ]
>>
>> hot chain pair 1:
>>              cycles: 18, hits: 6.10%                 cycles: 19, hits: 6.51%
>>          ---------------------------              --------------------------
>>            __random_r random_r.c:360               __random_r random_r.c:360
>>            __random_r random_r.c:388               __random_r random_r.c:388
>>            __random_r random_r.c:388               __random_r random_r.c:388
>>            __random_r random_r.c:380               __random_r random_r.c:380
>>            __random_r random_r.c:357               __random_r random_r.c:357
>>                __random random.c:293                   __random random.c:293
>>                __random random.c:293                   __random random.c:293
>>                __random random.c:291                   __random random.c:291
>>                __random random.c:291                   __random random.c:291
>>                __random random.c:291                   __random random.c:291
>>                __random random.c:288                   __random random.c:288
>>                       rand rand.c:27                          rand rand.c:27
>>                       rand rand.c:26                          rand rand.c:26
>>                             rand@plt                                rand@plt
>>                             rand@plt                                rand@plt
>>                compute_flag div.c:25                   compute_flag div.c:25
>>                compute_flag div.c:22                   compute_flag div.c:22
>>                        main div.c:40                           main div.c:40
>>
>> hot chain pair 2:
>>               cycles: 9, hits: 5.95%                  cycles: 8, hits: 5.03%
>>          ---------------------------              --------------------------
>>            __random_r random_r.c:360               __random_r random_r.c:360
>>            __random_r random_r.c:388               __random_r random_r.c:388
>>            __random_r random_r.c:388               __random_r random_r.c:388
>>            __random_r random_r.c:380               __random_r random_r.c:380
>>
>> [ Hot chains in old perf data but source line changed (*) in new perf data ]
>>
>> hot chain pair 1:
>>              cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
>>          ---------------------------              --------------------------
>>                        main div.c:39                           main div.c:39*
>>                        main div.c:44                           main div.c:44
>>
>> hot chain pair 2:
>>             cycles: 35, hits: 21.43%                cycles: 33, hits: 19.37%
>>          ---------------------------              --------------------------
>>            __random_r random_r.c:360               __random_r random_r.c:360
>>            __random_r random_r.c:388               __random_r random_r.c:388
>>            __random_r random_r.c:388               __random_r random_r.c:388
>>            __random_r random_r.c:380               __random_r random_r.c:380
>>            __random_r random_r.c:357               __random_r random_r.c:357
>>                __random random.c:293                   __random random.c:293
>>                __random random.c:293                   __random random.c:293
>>                __random random.c:291                   __random random.c:291
>>                __random random.c:291                   __random random.c:291
>>                __random random.c:291                   __random random.c:291
>>                __random random.c:288                   __random random.c:288
>>                       rand rand.c:27                          rand rand.c:27
>>                       rand rand.c:26                          rand rand.c:26
>>                             rand@plt                                rand@plt
>>                             rand@plt                                rand@plt
>>                compute_flag div.c:25                   compute_flag div.c:25
>>                compute_flag div.c:22                   compute_flag div.c:22
>>                        main div.c:40                           main div.c:40
>>                        main div.c:40                           main div.c:40
>>                        main div.c:39                           main div.c:39*
>>
>> [ Hot chains in old perf data only ]
>>
>> hot chain 1:
>>               cycles: 2, hits: 4.08%
>>           --------------------------
>>                        main div.c:42
>>                compute_flag div.c:28
>>
>> [ Hot chains in new perf data only ]
>>
>> hot chain 1:
>>                                                      cycles: 36, hits: 3.36%
>>                                                   --------------------------
>>                                                    __random_r random_r.c:357
>>                                                        __random random.c:293
>>                                                        __random random.c:293
>>                                                        __random random.c:291
>>                                                        __random random.c:291
>>                                                        __random random.c:291
>>                                                        __random random.c:288
>>                                                               rand rand.c:27
>>                                                               rand rand.c:26
>>                                                                     rand@plt
>>                                                                     rand@plt
>>                                                        compute_flag div.c:25
>>                                                        compute_flag div.c:22
>>                                                                main div.c:40
>>                                                                main div.c:40
>>
>> Now we can see, following streams pair is moved to another section
>> "[ Hot chains in old perf data but source line changed (*) in new perf data ]"
>>
>>              cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
>>          ---------------------------              --------------------------
>>                        main div.c:39                           main div.c:39*
>>                        main div.c:44                           main div.c:44
>>
>> v3:
>> ---
>> v2 has 14 patches, it's hard to review.
>> v3 is only 7 patches for basic stream comparison.
>>
>> Jin Yao (7):
>>    perf util: Create source line mapping table
>>    perf util: Create streams for managing top N hottest callchains
>>    perf util: Return per-event callchain streams
>>    perf util: Compare two streams
>>    perf util: Calculate the sum of all streams hits
>>    perf util: Report hot streams
>>    perf diff: Support hot streams comparison
>>
>>   tools/perf/Documentation/perf-diff.txt |  14 +
>>   tools/perf/builtin-diff.c              | 170 +++++++-
>>   tools/perf/util/Build                  |   1 +
>>   tools/perf/util/callchain.c            | 495 ++++++++++++++++++++++
>>   tools/perf/util/callchain.h            |  32 ++
>>   tools/perf/util/srclist.c              | 555 +++++++++++++++++++++++++
>>   tools/perf/util/srclist.h              |  65 +++
>>   7 files changed, 1319 insertions(+), 13 deletions(-)
>>   create mode 100644 tools/perf/util/srclist.c
>>   create mode 100644 tools/perf/util/srclist.h
>>
>> -- 
>> 2.17.1
>>
> 
