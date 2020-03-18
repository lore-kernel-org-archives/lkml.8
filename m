Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A04C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985A520773
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgCROUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:20:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:26396 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgCROUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:20:20 -0400
IronPort-SDR: UHy4UND/uY0pFva4Ek2kYgmXmUQWyWlrqSRQOqp58RhajyP9R+l9v3luy8ecj12MWGYR3mu/4d
 sfEOWdkmNiRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 07:20:19 -0700
IronPort-SDR: ABpu7r4aLa6cAfEyTjR/I792xN/wh8HmEzwBiyWBSp8KDEk8UzQ2FQe3leuEhllLyE3+lrbRnG
 fETvX09q4grw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,567,1574150400"; 
   d="scan'208";a="445883346"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 18 Mar 2020 07:20:18 -0700
Received: from [10.254.69.88] (kliang2-mobl.ccr.corp.intel.com [10.254.69.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D7980580270;
        Wed, 18 Mar 2020 07:20:16 -0700 (PDT)
Subject: Re: [PATCH V3 10/17] perf tools: Save previous sample for LBR
 stitching approach
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
References: <20200313183319.17739-1-kan.liang@linux.intel.com>
 <20200313183319.17739-11-kan.liang@linux.intel.com>
 <20200318121417.GB849721@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <122b2312-c4d2-3b3a-b08a-6a3356f827ea@linux.intel.com>
Date:   Wed, 18 Mar 2020 10:20:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318121417.GB849721@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2020 8:14 AM, Jiri Olsa wrote:
> On Fri, Mar 13, 2020 at 11:33:12AM -0700, kan.liang@linux.intel.com wrote:
> 
> SNIP
> 
>> +	struct lbr_stitch	*lbr_stitch;
>>   };
>>   
>>   struct machine;
>> @@ -145,4 +151,14 @@ static inline bool thread__is_filtered(struct thread *thread)
>>   	return false;
>>   }
>>   
>> +static inline void thread__free_stitch_list(struct thread *thread)
>> +{
>> +	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
>> +
>> +	if (!lbr_stitch)
>> +		return;
>> +
>> +	free(thread->lbr_stitch);
>> +}
> 
> free(thread->lbr_stitch) should be enough
> 

Sure. Will change it in V4.

Thanks,
Kan

> jirka
> 
>> +
>>   #endif	/* __PERF_THREAD_H */
>> -- 
>> 2.17.1
>>
> 
