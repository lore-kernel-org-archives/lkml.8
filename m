Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0879CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99DC206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389269AbgDBPeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:34:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:36459 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388744AbgDBPeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:34:23 -0400
IronPort-SDR: LjHVpc44cDPIIbHA/jQKgi5DeTvzER4O8aOaSMo1nPEKjAJ40uDIV1syGZxHq3cCXh/SWg+fA7
 5VeUS1H3jWvQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 08:34:22 -0700
IronPort-SDR: qYBCXvjvLcqu1xTxylYhG0fN/1UhsMkFcaFmOhvpqLp/6bXrSp8UXe/6/Z+gHlesqnhJuR5nSK
 gUfMfrMc7PPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="253037256"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 02 Apr 2020 08:34:21 -0700
Received: from [10.251.7.210] (kliang2-mobl.ccr.corp.intel.com [10.251.7.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 467825802C8;
        Thu,  2 Apr 2020 08:34:20 -0700 (PDT)
Subject: Re: [PATCH V4 00/17] Stitch LBR call stack (Perf Tools)
To:     Jiri Olsa <jolsa@redhat.com>, acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
 <20200323111311.GH1534489@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <e2887d1f-e963-66b4-f0cb-fa23986565a2@linux.intel.com>
Date:   Thu, 2 Apr 2020 11:34:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323111311.GH1534489@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/2020 7:13 AM, Jiri Olsa wrote:
> On Thu, Mar 19, 2020 at 01:25:00PM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Changes since V3:
>> - There is no dependency among the 'capabilities'. If perf fails to read
>>    one, it should not impact others. Continue to parse the rest of caps.
>>    (Patch 1)
>> - Use list_for_each_entry() to replace perf_pmu__scan_caps() (Patch 1 &
>>    2)
>> - Combine the declaration plus assignment when possible (Patch 1 & 2)
>> - Add check for script/report/c2c.. (Patch 13, 14 & 16)
> 
> it's all black magic to me, but looks ok ;-)
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
>

Thanks Jirka.

Hi Arnaldo,

Any comments for the series?

Thanks,
Kan
