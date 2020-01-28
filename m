Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB31C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B5020661
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgA1K1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:27:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:17156 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgA1K1J (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:27:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 02:27:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,373,1574150400"; 
   d="scan'208";a="223502235"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.213.218]) ([10.254.213.218])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jan 2020 02:27:06 -0800
Subject: Re: [PATCH v4 3/4] perf util: Flexible to set block info output
 formats
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200115192904.16798-1-yao.jin@linux.intel.com>
 <20200115192904.16798-3-yao.jin@linux.intel.com>
 <20200120094737.GF608405@krava>
 <6c35864b-e396-6865-12a9-2fd001b0f567@linux.intel.com>
 <23bec83b-b55d-8e9f-5b74-f58f0cd4a618@linux.intel.com>
 <20200128092151.GA1209308@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <073a0561-0e16-b4af-4678-fb211f81d9e5@linux.intel.com>
Date:   Tue, 28 Jan 2020 18:27:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128092151.GA1209308@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/2020 5:21 PM, Jiri Olsa wrote:
> On Mon, Jan 27, 2020 at 08:31:23PM +0800, Jin, Yao wrote:
>>
>>
>> On 1/20/2020 11:00 PM, Jin, Yao wrote:
>>>
>>>
>>> On 1/20/2020 5:47 PM, Jiri Olsa wrote:
>>>> On Thu, Jan 16, 2020 at 03:29:03AM +0800, Jin Yao wrote:
>>>>
>>>> SNIP
>>>>
>>>>> +                   block_hpps, nr_hpps);
>>>>> -    perf_hpp_list__register_sort_field(&bh->block_list,
>>>>> -        &block_fmts[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT].fmt);
>>>>> +    /* Sort by the first fmt */
>>>>> +    perf_hpp_list__register_sort_field(&bh->block_list,
>>>>> &block_fmts[0].fmt);
>>>>>    }
>>>>> -static void process_block_report(struct hists *hists,
>>>>> -                 struct block_report *block_report,
>>>>> -                 u64 total_cycles)
>>>>> +static int process_block_report(struct hists *hists,
>>>>> +                struct block_report *block_report,
>>>>> +                u64 total_cycles, int *block_hpps,
>>>>> +                int nr_hpps)
>>>>>    {
>>>>>        struct rb_node *next = rb_first_cached(&hists->entries);
>>>>>        struct block_hist *bh = &block_report->hist;
>>>>>        struct hist_entry *he;
>>>>> -    init_block_hist(bh, block_report->fmts);
>>>>> +    if (nr_hpps > PERF_HPP_REPORT__BLOCK_MAX_INDEX)
>>>>
>>>> hum, should be '>=' above.. ?
>>>>
>>>> jirka
>>>>
>>>
>>> '=' should be OK.
>>>
>>> enum {
>>>       PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
>>>       PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
>>>       PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
>>>       PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
>>>       PERF_HPP_REPORT__BLOCK_RANGE,
>>>       PERF_HPP_REPORT__BLOCK_DSO,
>>>       PERF_HPP_REPORT__BLOCK_MAX_INDEX
>>> };
>>>
>>> PERF_HPP_REPORT__BLOCK_MAX_INDEX is 6.
>>>
>>> If nr_hpps is 6, for example, block_hpps[] is,
>>>
>>>           int block_hpps[6] = {
>>>               PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
>>>               PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
>>>               PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
>>>               PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
>>>               PERF_HPP_REPORT__BLOCK_RANGE,
>>>               PERF_HPP_REPORT__BLOCK_DSO,
>>>           };
>>>
>>>           block_info__create_report(session->evlist,
>>>                         rep->total_cycles,
>>>                                             block_hpps, 6,
>>>                                             &rep->nr_block_reports);
>>>
>>> That should be legal.
>>>
>>> Thanks
>>> Jin Yao
>>
>> Hi Jiri,
>>
>> Does this explanation make sense?
> 
> ok, make sense
> 
> thanks,
> jirka
> 

Thanks Jiri!

I will post v5 which only contains the change of dropping the 
unnecessary release code.

Thanks
Jin Yao

