Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CABFC11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4322068F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgBTOmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:42:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:55065 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgBTOmQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:42:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 06:42:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,464,1574150400"; 
   d="scan'208";a="228921229"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.215.155]) ([10.254.215.155])
  by fmsmga007.fm.intel.com with ESMTP; 20 Feb 2020 06:42:12 -0800
Subject: Re: [PATCH v1 0/2] perf report: Support annotation of code without
 symbols
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200220005902.8952-1-yao.jin@linux.intel.com>
 <20200220115629.GC565976@krava>
 <ca3fa091-f407-51e2-d617-90a842b36295@linux.intel.com>
 <20200220120655.GA586895@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1fc1c4f5-ca94-ebd7-fae0-28765070662f@linux.intel.com>
Date:   Thu, 20 Feb 2020 22:42:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220120655.GA586895@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/2020 8:06 PM, Jiri Olsa wrote:
> On Thu, Feb 20, 2020 at 08:03:18PM +0800, Jin, Yao wrote:
>>
>>
>> On 2/20/2020 7:56 PM, Jiri Olsa wrote:
>>> On Thu, Feb 20, 2020 at 08:59:00AM +0800, Jin Yao wrote:
>>>> For perf report on stripped binaries it is currently impossible to do
>>>> annotation. The annotation state is all tied to symbols, but there are
>>>> either no symbols, or symbols are not covering all the code.
>>>>
>>>> We should support the annotation functionality even without symbols.
>>>>
>>>> The first patch uses al_addr to print because it's easy to dump
>>>> the instructions from this address in binary for branch mode.
>>>>
>>>> The second patch supports the annotation on stripped binary.
>>>>
>>>> Jin Yao (2):
>>>>     perf util: Print al_addr when symbol is not found
>>>>     perf annotate: Support interactive annotation of code without symbols
>>>
>>> looks good, but I'm getting crash when annotating unresolved kernel address:
>>>
>>> jirka
>>>
>>>
>>
>> Thanks for reporting the issue.
>>
>> I guess you are trying the "0xffffffff81c00ae7", let me try to reproduce
>> this issue.
> 
> yes, I also checked and it did not happen before
> 
> jirka
> 

Hi Jiri,

Can you try this fix?

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index ff5711899234..5144528b2931 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2497,7 +2497,7 @@ add_annotate_opt(struct hist_browser *browser,
                  struct map_symbol *ms,
                  u64 addr)
  {
-       if (ms->map->dso->annotate_warned)
+       if (!ms->map || !ms->map->dso || ms->map->dso->annotate_warned)
                 return 0;

         if (!ms->sym) {

It's tested OK at my side.

Thanks
Jin Yao

