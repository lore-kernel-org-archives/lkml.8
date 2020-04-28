Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF90C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDD80206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgD1IMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:12:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:37322 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgD1IMH (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:12:07 -0400
IronPort-SDR: 0poBhdi0rYNzEaBvQvnJqCYVFKlSZ/Ts+fSLr+3tSBXd+LSPzZo79Qt7vW7AsaDVkevY6YUi1c
 melUb7mZ8pDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 01:12:07 -0700
IronPort-SDR: p6uL65FR6K2pBsp4oSQqb134PAzW4lmTvjQIr2lhUAMVCvwW+liwaxlbqufGpI3TEx0RMMwdty
 LyahBMuVwX1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,327,1583222400"; 
   d="scan'208";a="367427673"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2020 01:12:05 -0700
Subject: Re: [PATCH v3 2/7] perf util: Create streams for managing top N
 hottest callchains
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200420010451.24405-1-yao.jin@linux.intel.com>
 <20200420010451.24405-3-yao.jin@linux.intel.com>
 <20200427101052.GB1457790@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <3ecf60b3-1304-4a33-1bec-52eb580c0a00@linux.intel.com>
Date:   Tue, 28 Apr 2020 16:12:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427101052.GB1457790@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/27/2020 6:10 PM, Jiri Olsa wrote:
> On Mon, Apr 20, 2020 at 09:04:46AM +0800, Jin Yao wrote:
>> We think the stream is a callchain which is aggregated by the LBR
>> records from samples. By browsing the stream, we can understand
>> the code flow.
>>
>> The struct callchain_node represents one callchain and we use the
>> callchain_node->hit to measure the hot level of this callchain.
>> Higher is hotter.
>>
>> Since in perf data file, there may be many callchains so we just
>> need to focus on the top N hottest callchains. N is a user defined
>> parameter or just a predefined default value.
>>
>> This patch saves the top N hottest callchains in 'struct stream_node'
>> type array, which is defined in a per event 'struct callchain_streams'.
>>
>> So now we can get the per-event top N hottest callchains.
>>
>>   v2:
>>   ---
>>   Use zfree in free_evsel_streams().
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/callchain.c | 122 ++++++++++++++++++++++++++++++++++++
>>   tools/perf/util/callchain.h |  16 +++++
>>   2 files changed, 138 insertions(+)
> 
> SNIP
> 
> could this and all the other related code moved to separated object
> like streams.c or such.. I think also the stuff from patch 1 could
> go there, as it's specific only to this streams code
> 
> jirka
> 

That's fine. I will move the related codes to a new streams.c/streams.h.

Thanks
Jin Yao
