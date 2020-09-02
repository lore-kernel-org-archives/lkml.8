Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53BEC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7430F2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgIBIQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:16:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:32868 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgIBIQi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:16:38 -0400
IronPort-SDR: DY5HX/HTcZm+fI9WkCCQCjeGgJR5pGbYEJXrmTiwsZgPtLZ6BFxyPt8/qe+7i2aKwFQZzwaTDM
 qPA2ibGNvOBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="175396498"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="175396498"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 01:16:35 -0700
IronPort-SDR: IIlqs/v6PqqVFitMyFBmf/xu0UN4uc6GVbAfxWWzKibDDr1iq/bVDtrsMu8qhTFjXStImqeqAl
 1NGoW8cQHwBA==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="477542604"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 01:16:32 -0700
Subject: Re: [PATCH v4 1/7] perf util: Create streams
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200824233513.16930-1-yao.jin@linux.intel.com>
 <20200824233513.16930-2-yao.jin@linux.intel.com>
 <20200831135609.GE406859@krava>
 <4cef1f08-e1c1-3227-24f2-be3108ea4d99@linux.intel.com>
 <20200901200912.GD470123@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <2334220f-22b5-c7eb-f9ec-ee70f41e96cb@linux.intel.com>
Date:   Wed, 2 Sep 2020 16:16:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901200912.GD470123@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 9/2/2020 4:09 AM, Jiri Olsa wrote:
> On Tue, Sep 01, 2020 at 10:26:25AM +0800, Jin, Yao wrote:
>> Hi Jiri,
>>
>> On 8/31/2020 9:56 PM, Jiri Olsa wrote:
>>> On Tue, Aug 25, 2020 at 07:35:07AM +0800, Jin Yao wrote:
>>>
>>> SNIP
>>>
>>>> +						  int nr_streams_max,
>>>> +						  enum stream_type type)
>>>> +{
>>>> +	struct evsel_streams *es;
>>>> +	int nr_evsel = evlist->core.nr_entries, ret = -1;
>>>> +
>>>> +	es = create_evsel_streams(nr_evsel, nr_streams_max);
>>>> +	if (!es)
>>>> +		return NULL;
>>>> +
>>>> +	if (type == STREAM_CALLCHAIN)
>>>> +		ret = evlist_init_callchain_streams(evlist, es, nr_evsel);
>>>> +
>>>> +	if (ret) {
>>>> +		free_evsel_streams(es, nr_evsel);
>>>> +		return NULL;
>>>> +	}
>>>> +
>>>> +	return es;
>>>> +}
>>>> diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
>>>> new file mode 100644
>>>> index 000000000000..a8a0172b4d13
>>>> --- /dev/null
>>>> +++ b/tools/perf/util/stream.h
>>>> @@ -0,0 +1,30 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +#ifndef __PERF_STREAM_H
>>>> +#define __PERF_STREAM_H
>>>> +
>>>> +#include "callchain.h"
>>>> +
>>>> +enum stream_type {
>>>> +	STREAM_NONE = 0,
>>>> +	STREAM_CALLCHAIN
>>>
>>> do you plan to add more types?
>>>
>>> jirka
>>>
>>
>> Thanks for looking at this patch series.
>>
>> So far, no more types in plan. :)
> 
> I was wondering what's the enum for then, it could
> be hardcoded and ease up the code maybe? but it's
> jus a thought, I don't follow the change deeply
> 
> jirka
> 

Hmm, I've ever thought to add a new type such as stream_block in the future. But in order to let the 
patchset be simple and clear, I'm OK to remove this enum.

Thanks
Jin Yao



