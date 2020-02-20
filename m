Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9737C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FFB208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgBTNuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:50:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:51148 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgBTNuq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:50:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 05:50:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,464,1574150400"; 
   d="scan'208";a="228910710"
Received: from jding10-desk2.ccr.corp.intel.com (HELO [10.254.215.155]) ([10.254.215.155])
  by fmsmga007.fm.intel.com with ESMTP; 20 Feb 2020 05:50:43 -0800
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
Message-ID: <3a0a66ad-e266-b37d-d7ec-e194f2191c2d@linux.intel.com>
Date:   Thu, 20 Feb 2020 21:50:42 +0800
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


I can reproduce it now.

perf record -e cycles:u ls
perf report --stdio

     75.29%  ls       ld-2.27.so        [.] do_lookup_x
     23.64%  ls       ld-2.27.so        [.] __GI___tunables_init
      1.04%  ls       [unknown]         [k] 0xffffffff85c01210
      0.03%  ls       ld-2.27.so        [.] _start

Looks it's caused by skid.

Thanks
Jin Yao

