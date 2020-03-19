Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468EEC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2137D20767
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCSBmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:42:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:3848 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgCSBmq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:42:46 -0400
IronPort-SDR: n0sL0HdfpCMafN+I9/Bl49rwoIxmH5kpcOdrPTFmKiXcgbvEjU4IBbdww/fnlQjJuzWOGyrIaz
 ogPr3F0+mbZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 18:42:46 -0700
IronPort-SDR: UN6RHGBb1b3St3YGszOh6jlx8OX319qjPFbAGrVjaB0rAWLetTTaTvjJGNB2HcYKa67p+S5oHs
 +X00BqbMeCLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,569,1574150400"; 
   d="scan'208";a="236801917"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 Mar 2020 18:42:43 -0700
Subject: Re: [PATCH v7 0/3] perf report: Support sorting by a given event in
 group
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200220013616.19916-1-yao.jin@linux.intel.com>
 <20200318190116.GN11531@kernel.org> <20200318190325.GO11531@kernel.org>
 <20200318190832.GP11531@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ea98a653-03ae-d04b-95da-b1ded59d03f6@linux.intel.com>
Date:   Thu, 19 Mar 2020 09:42:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318190832.GP11531@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/2020 3:08 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 18, 2020 at 04:03:25PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Mar 18, 2020 at 04:01:16PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Thu, Feb 20, 2020 at 09:36:13AM +0800, Jin Yao escreveu:
>>>> When performing "perf report --group", it shows the event group information
>>>> together. By default, the output is sorted by the first event in group.
>>>> It would be nice for user to select any event for sorting.
>>>>
>>>> The patch 1/3 introduces a new option "--group-sort-idx" to sort the
>>>> output by the event at the index n in event group.
>>>>
>>>> The patch 2/3 creates a new key K_RELOAD to reload the browser.
>>>>
>>>> The patch 3/3 supports hotkeys in browser to select a event to
>>>> sort.
>>>
>>> Thanks, applied.
>>
>> Doesn't work with 'perf top', should, investigating,
> 
> So needs a bit of work, but is doable and would be a great addition,
> since we do support:
> 
>    # perf top --group -e instructions,cycles,cache-misses
> 
> And we should strive to make 'perf top' to be a perf.data-less, dynamic
> version of 'perf record + perf report'.
> 
> Can you please take a look at supporting this? And that --group-sort-idx
> too,
> 
> I'll push my perf/core branch after a few tests,
> 
> Thanks,
> 
> - Arnaldo
> 

I will check that.

Thanks
Jin Yao
