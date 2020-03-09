Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D805C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C02621927
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgCINmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:42:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:17848 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgCINmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:42:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 06:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,533,1574150400"; 
   d="scan'208";a="276520286"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2020 06:42:09 -0700
Received: from [10.251.21.146] (kliang2-mobl.ccr.corp.intel.com [10.251.21.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 527205802A3;
        Mon,  9 Mar 2020 06:42:08 -0700 (PDT)
Subject: Re: [PATCH 00/12] Stitch LBR call stack (Perf Tools)
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com
References: <20200228163011.19358-1-kan.liang@linux.intel.com>
 <20200306093940.GD281906@krava>
 <243484a9-5d64-707e-4abb-dd8813a8755e@linux.intel.com>
 <20200309132710.GA477@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <4b484d13-427e-1faa-a553-86a8cc3e5a30@linux.intel.com>
Date:   Mon, 9 Mar 2020 09:42:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309132710.GA477@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/2020 9:27 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 06, 2020 at 02:13:15PM -0500, Liang, Kan escreveu:
>>
>>
>> On 3/6/2020 4:39 AM, Jiri Olsa wrote:
>>> On Fri, Feb 28, 2020 at 08:29:59AM -0800, kan.liang@linux.intel.com wrote:
>>>
>>> SNIP
>>>
>>>> Kan Liang (12):
>>>>     perf tools: Add hw_idx in struct branch_stack
>>>>     perf tools: Support PERF_SAMPLE_BRANCH_HW_INDEX
>>>>     perf header: Add check for event attr
>>>>     perf pmu: Add support for PMU capabilities
>>>
>>> hi,
>>> I'm getting compile error:
>>>
>>> 	util/pmu.c: In function ‘perf_pmu__caps_parse’:
>>> 	util/pmu.c:1620:32: error: ‘%s’ directive output may be truncated writing up to 255 bytes into a region of size between 0 and 4095 [-Werror=format-truncation=]
>>> 	 1620 |   snprintf(path, PATH_MAX, "%s/%s", caps_path, name);
>>> 	      |                                ^~
>>> 	In file included from /usr/include/stdio.h:867,
>>> 			 from util/pmu.c:12:
>>> 	/usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output between 2 and 4352 bytes into a destination of size 4096
>>> 	   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>>> 	      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> 	   68 |        __bos (__s), __fmt, __va_arg_pack ());
>>> 	      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> 	cc1: all warnings being treated as errors
>>>
>>> 	[jolsa@krava perf]$ gcc --version
>>> 	gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1)
>>
>> My GCC version is too old. I will send V2 later to fix the error.
> 
> So I stopped at the patch just before the one introducing this problem,
> i.e. now I have:
> 
> [acme@seventh perf]$ git log --oneline -10
> 5100c2b77049 (HEAD -> perf/core, five/perf/core, acme/perf/core) perf header: Add check for unexpected use of reserved membrs in event attr
> 1d2fc2bd7c1c perf evsel: Support PERF_SAMPLE_BRANCH_HW_INDEX
> 1fa65c5092da perf tools: Add hw_idx in struct branch_stack
> 6339998d22ec tools headers UAPI: Update tools's copy of linux/perf_event.h
> 401d61cbd4d4 tools lib traceevent: Remove extra '\n' in print_event_time()
> 76ce02651dab libperf: Add counting example
> dabce16bd292 perf annotate: Get rid of annotation->nr_jumps
> 357a5d24c471 perf llvm: Add debug hint message about missing kernel-devel package
> 1af62ce61cd8 perf stat: Show percore counts in per CPU output
> 7982a8985150 tools lib api fs: Move cgroupsfs_find_mountpoint()
> [acme@seventh perf]$
> 
> Please continue from there, I'll process some other patchsets,
> 

Sure. I will re-base my patchset on top of it.

Thanks,
Kan
