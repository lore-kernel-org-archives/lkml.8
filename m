Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D594C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262A32098B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgIAC0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:26:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:14968 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgIAC0h (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:26:37 -0400
IronPort-SDR: rCxMbNQSKXAYSO6A8y0VWI8xbxZF9IcB99nfpyYObpkfObFkBfdUU67mZua9z7FAw57I/uzZls
 AtshgANks/2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="144781558"
X-IronPort-AV: E=Sophos;i="5.76,377,1592895600"; 
   d="scan'208";a="144781558"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 19:26:36 -0700
IronPort-SDR: qRLDdz7C3t/RrFrPYeGs77BpNajKE8YmXvKlHIqFfXgwP68IvAjfdLNI/2xzAaGDf7k4vHzAyD
 HWOBmLI40p5Q==
X-IronPort-AV: E=Sophos;i="5.76,377,1592895600"; 
   d="scan'208";a="476999946"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 19:26:31 -0700
Subject: Re: [PATCH v4 1/7] perf util: Create streams
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200824233513.16930-1-yao.jin@linux.intel.com>
 <20200824233513.16930-2-yao.jin@linux.intel.com>
 <20200831135609.GE406859@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <4cef1f08-e1c1-3227-24f2-be3108ea4d99@linux.intel.com>
Date:   Tue, 1 Sep 2020 10:26:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831135609.GE406859@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 8/31/2020 9:56 PM, Jiri Olsa wrote:
> On Tue, Aug 25, 2020 at 07:35:07AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +						  int nr_streams_max,
>> +						  enum stream_type type)
>> +{
>> +	struct evsel_streams *es;
>> +	int nr_evsel = evlist->core.nr_entries, ret = -1;
>> +
>> +	es = create_evsel_streams(nr_evsel, nr_streams_max);
>> +	if (!es)
>> +		return NULL;
>> +
>> +	if (type == STREAM_CALLCHAIN)
>> +		ret = evlist_init_callchain_streams(evlist, es, nr_evsel);
>> +
>> +	if (ret) {
>> +		free_evsel_streams(es, nr_evsel);
>> +		return NULL;
>> +	}
>> +
>> +	return es;
>> +}
>> diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
>> new file mode 100644
>> index 000000000000..a8a0172b4d13
>> --- /dev/null
>> +++ b/tools/perf/util/stream.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __PERF_STREAM_H
>> +#define __PERF_STREAM_H
>> +
>> +#include "callchain.h"
>> +
>> +enum stream_type {
>> +	STREAM_NONE = 0,
>> +	STREAM_CALLCHAIN
> 
> do you plan to add more types?
> 
> jirka
> 

Thanks for looking at this patch series.

So far, no more types in plan. :)

Thanks
Jin Yao

