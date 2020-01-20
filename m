Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50672C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C80B22314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgATOus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:50:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:17747 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATOus (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:50:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 06:50:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="275553386"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.209.167]) ([10.254.209.167])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2020 06:50:45 -0800
Subject: Re: [PATCH v4 3/4] perf util: Flexible to set block info output
 formats
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200115192904.16798-1-yao.jin@linux.intel.com>
 <20200115192904.16798-3-yao.jin@linux.intel.com>
 <20200120094729.GE608405@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <3b8ee45c-eba2-bc24-ae71-9f98a246d5f1@linux.intel.com>
Date:   Mon, 20 Jan 2020 22:50:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120094729.GE608405@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2020 5:47 PM, Jiri Olsa wrote:
> On Thu, Jan 16, 2020 at 03:29:03AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>   }
>>   
>> +void block_info__free_report(struct block_report *reps, int nr_reps)
>> +{
>> +	for (int i = 0; i < nr_reps; i++)
>> +		hists__delete_entries(&reps[i].hist.block_hists);
>> +
>> +	free(reps);
>> +}
>> +
>>   int report__browse_block_hists(struct block_hist *bh, float min_percent,
>>   			       struct evsel *evsel, struct perf_env *env,
>> -			       struct annotation_options *annotation_opts)
>> +			       struct annotation_options *annotation_opts,
>> +			       bool release)
>>   {
>>   	int ret;
>>   
>> @@ -451,13 +473,17 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
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
> 
> I don't understand this change.. why do you relase it in here?
> there's release call in block_info__free_report you just added...
> 
> jirka
> 

Yes, I have released the hists entries in block_info__free_report(). I 
don't need to keep the release code here. Thanks so much for pointing 
this out.

Thanks
Jin Yao
