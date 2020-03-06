Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D296C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D1320656
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCFTN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:13:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:21925 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFTN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:13:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 11:13:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="440211593"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 06 Mar 2020 11:13:19 -0800
Received: from [10.251.20.182] (kliang2-mobl.ccr.corp.intel.com [10.251.20.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id AA3FF5802C8;
        Fri,  6 Mar 2020 11:13:17 -0800 (PST)
Subject: Re: [PATCH 00/12] Stitch LBR call stack (Perf Tools)
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
References: <20200228163011.19358-1-kan.liang@linux.intel.com>
 <20200306093940.GD281906@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <243484a9-5d64-707e-4abb-dd8813a8755e@linux.intel.com>
Date:   Fri, 6 Mar 2020 14:13:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306093940.GD281906@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/2020 4:39 AM, Jiri Olsa wrote:
> On Fri, Feb 28, 2020 at 08:29:59AM -0800, kan.liang@linux.intel.com wrote:
> 
> SNIP
> 
>> Kan Liang (12):
>>    perf tools: Add hw_idx in struct branch_stack
>>    perf tools: Support PERF_SAMPLE_BRANCH_HW_INDEX
>>    perf header: Add check for event attr
>>    perf pmu: Add support for PMU capabilities
> 
> hi,
> I'm getting compile error:
> 
> 	util/pmu.c: In function ‘perf_pmu__caps_parse’:
> 	util/pmu.c:1620:32: error: ‘%s’ directive output may be truncated writing up to 255 bytes into a region of size between 0 and 4095 [-Werror=format-truncation=]
> 	 1620 |   snprintf(path, PATH_MAX, "%s/%s", caps_path, name);
> 	      |                                ^~
> 	In file included from /usr/include/stdio.h:867,
> 			 from util/pmu.c:12:
> 	/usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output between 2 and 4352 bytes into a destination of size 4096
> 	   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
> 	      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 	   68 |        __bos (__s), __fmt, __va_arg_pack ());
> 	      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 	cc1: all warnings being treated as errors
> 
> 	[jolsa@krava perf]$ gcc --version
> 	gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1)

My GCC version is too old. I will send V2 later to fix the error.

Thanks,
Kan

> 
> jirka
> 
