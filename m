Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B861C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE272080D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgANA5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:57:39 -0500
Received: from mga01.intel.com ([192.55.52.88]:45175 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgANA5j (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:57:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 16:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,431,1571727600"; 
   d="scan'208";a="304999196"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.238.4.71]) ([10.238.4.71])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2020 16:57:36 -0800
Subject: Re: [PATCH v3 3/4] perf util: Flexible to set block info output
 formats
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200107230354.30132-1-yao.jin@linux.intel.com>
 <20200107230354.30132-3-yao.jin@linux.intel.com>
 <20200113101037.GF35080@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <6b42909a-5c3a-42b4-a67f-5c10f97b9e0d@linux.intel.com>
Date:   Tue, 14 Jan 2020 08:57:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200113101037.GF35080@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2020 6:10 PM, Jiri Olsa wrote:
> On Wed, Jan 08, 2020 at 07:03:53AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>   int report__browse_block_hists(struct block_hist *bh, float min_percent,
>>   			       struct evsel *evsel, struct perf_env *env,
>> -			       struct annotation_options *annotation_opts)
>> +			       struct annotation_options *annotation_opts,
>> +			       bool release)
>>   {
>>   	int ret;
>>   
>> @@ -451,13 +477,17 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
>>   		symbol_conf.report_individual_block = true;
>>   		hists__fprintf(&bh->block_hists, true, 0, 0, min_percent,
>>   			       stdout, true);
>> -		hists__delete_entries(&bh->block_hists);
>> +		if (release)
>> +			hists__delete_entries(&bh->block_hists);
>> +
>>   		return 0;
>>   	case 1:
>>   		symbol_conf.report_individual_block = true;
>>   		ret = block_hists_tui_browse(bh, evsel, min_percent,
>>   					     env, annotation_opts);
>> -		hists__delete_entries(&bh->block_hists);
>> +		if (release)
>> +			hists__delete_entries(&bh->block_hists);
>> +
>>   		return ret;
>>   	default:
>>   		return -1;
>> diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
>> index bfa22c59195d..0bf01e3a423d 100644
>> --- a/tools/perf/util/block-info.h
>> +++ b/tools/perf/util/block-info.h
>> @@ -44,7 +44,8 @@ enum {
>>   struct block_report {
>>   	struct block_hist	hist;
>>   	u64			cycles;
>> -	struct block_fmt	fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX];
>> +	struct block_fmt	*fmts;
> 
> hum, couldn't you just keep the array and use it instead of allocating it?
> it will never be bigger than PERF_HPP_REPORT__BLOCK_MAX_INDEX, no?
> 
> we could get rid of that release code
> 

Yes, that makes sense. I will keep the array.

Thanks
Jin Yao

> 
> jirka
> 
