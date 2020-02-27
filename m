Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA17C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA6D24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgB0Orl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:47:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:34053 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbgB0Orh (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:47:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 06:47:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="350700301"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.255.28.152]) ([10.255.28.152])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2020 06:47:34 -0800
Subject: Re: [PATCH v3 0/2] perf report: Support annotation of code without
 symbols
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200224022225.30264-1-yao.jin@linux.intel.com>
 <20200227135023.GD10761@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <75e68b18-1a84-ec76-7672-f386dbe51a3e@linux.intel.com>
Date:   Thu, 27 Feb 2020 22:47:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227135023.GD10761@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/2020 9:50 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 24, 2020 at 10:22:23AM +0800, Jin Yao escreveu:
>> For perf report on stripped binaries it is currently impossible to do
>> annotation. The annotation state is all tied to symbols, but there are
>> either no symbols, or symbols are not covering all the code.
>>
>> We should support the annotation functionality even without symbols.
>>
>> The first patch uses al_addr to print because it's easy to dump
>> the instructions from this address in binary for branch mode.
>>
>> The second patch supports the annotation on stripped binary.
> 
> I'm considering this a new feature, so I'll leave this for perf/core,
> i.e. for the next release, ok?
> 

Yes, it's a new feature, so perf/core branch is OK. Thanks! :)

BTW, v3 is old, I just post v5 according to Jiri's comments.

> I'm now going thru the pure fixes that should go to perf/urgent, please
> holler if something you think should go in now is not in my perf/urgent
> branch.
>  > - Arnaldo
>

In summary, I have some patch series waiting but I think they can be in 
perf/core.

https://lkml.org/lkml/2020/2/2/83
https://lkml.org/lkml/2020/2/14/136
https://lkml.org/lkml/2020/2/19/1274
https://lkml.org/lkml/2020/2/26/1348

Following is a fix, maybe it can be in perf/urgent.

"perf stat: Align the output for interval aggregation mode"
https://lkml.org/lkml/2020/2/20/321

Thanks
Jin Yao

>>   v3:
>>   ---
>>   Keep just the ANNOTATION_DUMMY_LEN, and remove the
>>   opts->annotate_dummy_len since it's the "maybe in future
>>   we will provide" feature.
>>
>>   v2:
>>   ---
>>   Fix a crash issue when annotating an address in "unknown" object.
>>
>> Jin Yao (2):
>>    perf util: Print al_addr when symbol is not found
>>    Support interactive annotation of code without symbols
>>
>>   tools/perf/ui/browsers/hists.c | 43 +++++++++++++++++++++++++++++-----
>>   tools/perf/util/annotate.h     |  1 +
>>   tools/perf/util/sort.c         |  6 +++--
>>   3 files changed, 42 insertions(+), 8 deletions(-)
>>
>> -- 
>> 2.17.1
>>
> 
