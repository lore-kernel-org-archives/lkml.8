Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53018C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAAA20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgAaLwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 06:52:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:5624 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbgAaLwi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:52:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2020 03:52:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; 
   d="scan'208";a="247706525"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.213.203]) ([10.254.213.203])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2020 03:52:34 -0800
Subject: Re: [PATCH v5 1/4] perf util: Move block_pair_cmp to block-info
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200128125556.25498-1-yao.jin@linux.intel.com>
 <20200128125556.25498-2-yao.jin@linux.intel.com>
 <20200131083223.GF3841@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ce3758ac-e00b-ffa0-847e-010b359884e5@linux.intel.com>
Date:   Fri, 31 Jan 2020 19:52:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200131083223.GF3841@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/2020 4:32 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 28, 2020 at 08:55:53PM +0800, Jin Yao escreveu:
>> block_pair_cmp() is a function which is used to compare
>> two blocks. Moving it from builtin-diff.c to block-info.c
>> to let it can be used by other builtins.
>>
>>   v4/v5:
>>   ------
>>   No change.
>>
>>   v3:
>>   ---
>>   Separate it from original patch for good tracking.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-diff.c    | 17 -----------------
>>   tools/perf/util/block-info.c | 17 +++++++++++++++++
>>   tools/perf/util/block-info.h |  2 ++
>>   3 files changed, 19 insertions(+), 17 deletions(-)
>>
>> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
>> index f8b6ae557d8b..5ff1e21082cb 100644
>> --- a/tools/perf/builtin-diff.c
>> +++ b/tools/perf/builtin-diff.c
>> @@ -572,23 +572,6 @@ static void init_block_hist(struct block_hist *bh)
>>   	bh->valid = true;
>>   }
>>   
>> -static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
>> -{
>> -	struct block_info *bi_a = a->block_info;
>> -	struct block_info *bi_b = b->block_info;
>> -	int cmp;
>> -
>> -	if (!bi_a->sym || !bi_b->sym)
>> -		return -1;
>> -
>> -	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
>> -
>> -	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
>> -		return 0;
>> -
>> -	return -1;
>> -}
>> -
>>   static struct hist_entry *get_block_pair(struct hist_entry *he,
>>   					 struct hists *hists_pair)
>>   {
>> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
>> index c4b030bf6ec2..f0f38bdd496a 100644
>> --- a/tools/perf/util/block-info.c
>> +++ b/tools/perf/util/block-info.c
>> @@ -475,3 +475,20 @@ float block_info__total_cycles_percent(struct hist_entry *he)
>>   
>>   	return 0.0;
>>   }
>> +
>> +int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
> 
> First thing that came to mind was that hist_entry comparision functions
> had been changed to return int64_t recently, when I went to look at it I
> found this:
> 
> tools/perf/util/block-info.c
> 
> int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
>                          struct hist_entry *left, struct hist_entry *right)
> {
>          struct block_info *bi_l = left->block_info;
>          struct block_info *bi_r = right->block_info;
>          int cmp;
> .
> .
> .
> 
> Which look a bit more complete, can you check if that can be used
> instead or explain why my quick analysis of this is b0rken?
> 
> Perhaps we can have a __block_info__cmp() that doesn't receive the
> perf_hpp_fmt (that isn't even used above) so that the previous use of
> block_pair_cmp() can be replaced with __block_info__cmp() instead?
> 
> Thanks,
> 
> - Arnaldo
> 

Hi Arnaldo,

I think it's a good idea to use __block_info__cmp() to replace the 
block_pair_cmp(). The block_info__cmp() is more comprehensive than 
block_pair_cmp() and we only need a bit change such as,

--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -74,7 +74,7 @@ int64_t block_info__cmp(struct perf_hpp_fmt *fmt 
__maybe_unused,

         if (!bi_l->sym || !bi_r->sym) {
                 if (!bi_l->sym && !bi_r->sym)
-                       return 0;
+                       return -1;
                 else if (!bi_l->sym)
                         return -1;
                 else

It returns -1 if both syms are NULL.

I will update the patchset.

Thanks
Jin Yao

>> +{
>> +	struct block_info *bi_a = a->block_info;
>> +	struct block_info *bi_b = b->block_info;
>> +	int cmp;
>> +
>> +	if (!bi_a->sym || !bi_b->sym)
>> +		return -1;
>> +
>> +	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
>> +
>> +	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
>> +		return 0;
>> +
>> +	return -1;
>> +}
>> diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
>> index bef0d75e9819..4fa91eeae92e 100644
>> --- a/tools/perf/util/block-info.h
>> +++ b/tools/perf/util/block-info.h
>> @@ -76,4 +76,6 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
>>   
>>   float block_info__total_cycles_percent(struct hist_entry *he);
>>   
>> +int block_pair_cmp(struct hist_entry *a, struct hist_entry *b);
>> +
>>   #endif /* __PERF_BLOCK_H */
>> -- 
>> 2.17.1
>>
> 
