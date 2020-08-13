Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB20C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7825920768
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgHMFKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:10:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:29664 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgHMFKC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:10:02 -0400
IronPort-SDR: xsCJkt/aB6L36/8H9GSRVmhT+64sAFXOlGYoPds4G34A4lTVhFEHE9O0OWmWcifr7tf+8jIauT
 vaI0mTrS1Y6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="153382616"
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="153382616"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 22:10:01 -0700
IronPort-SDR: piAiiNtZ08YVQ9/zVmG4fdTu9qJTNw2tgwLmbSDi1eOQtOuVESiP2QBqNveViVCSGTbwrH3fac
 ZxXCbulBF+Kg==
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="470088631"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 22:09:59 -0700
Subject: Re: [PATCH] perf parse-events: Set exclude_guest for user-space
 counting
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        like.xu@linux.intel.com
References: <20200812065953.22143-1-yao.jin@linux.intel.com>
 <20200812121504.GE13995@kernel.org> <20200812125526.GM13995@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <c4d7bdd9-5869-d2ff-16be-548fbc8da6a5@linux.intel.com>
Date:   Thu, 13 Aug 2020 13:09:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812125526.GM13995@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 8/12/2020 8:55 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 12, 2020 at 09:15:04AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Aug 12, 2020 at 02:59:53PM +0800, Jin Yao escreveu:
>>> Currently if we run 'perf record -e cycles:u', exclude_guest is 0.
>>>
>>> But it doesn't make sense that we request for user-space counting
>>> but we also get the guest report.
>>>
>>> To keep perf semantics consistent and clear, this patch sets
>>> exclude_guest for user-space counting.
>>
>> Applied, and also added this, that you should consider doing in the
>> future (modulo the "Committer testing:" header :) ):
>>
>> Committer testing:
>>
>> Before:
>>
>>    # perf record -e cycles:u
>>    ^C[ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 1.231 MB perf.data (91 samples) ]
>>    #
>>    # perf evlist -v
>>    cycles:u: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, freq: 1, sample_id_all: 1
>>    <SNIP>
>>    #
>>
>> After:
>>
>>    # perf record -e cycles:u
>>    ^C[ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 1.263 MB perf.data (403 samples) ]
>>    #
>>    # perf evlist -v
>>    cycles:u: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, freq: 1, sample_id_all: 1, exclude_guest: 1
>>    #
> 
> Also, please run 'perf test', as this will require changes to some
> expected perf_event_attr setups:
> 
> [root@quaco ~]# perf test "event definition"
>   6: Parse event definition strings                        : FAILED!
> [root@quaco ~]#
> 
> - Arnaldo
> 

Sorry for the perf test failure! I will post v2 to fix this issue.

Thanks
Jin Yao
