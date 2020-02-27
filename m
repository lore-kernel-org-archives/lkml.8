Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACD7C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 00:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFF024672
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 00:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgB0AFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 19:05:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:61872 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgB0AF3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 19:05:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 16:05:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="230599029"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga007.fm.intel.com with ESMTP; 26 Feb 2020 16:05:26 -0800
Subject: Re: [PATCH v4 2/2] perf report: Support interactive annotation of
 code without symbols
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200225051438.16253-1-yao.jin@linux.intel.com>
 <20200225051438.16253-3-yao.jin@linux.intel.com>
 <20200226153810.GE217283@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <44c538f5-7b39-1aa1-26a6-3862920f8e53@linux.intel.com>
Date:   Thu, 27 Feb 2020 08:05:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226153810.GE217283@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/2020 11:38 PM, Jiri Olsa wrote:
> On Tue, Feb 25, 2020 at 01:14:38PM +0800, Jin Yao wrote:
>> For perf report on stripped binaries it is currently impossible to do
>> annotation. The annotation state is all tied to symbols, but there are
>> either no symbols, or symbols are not covering all the code.
>>
>> We should support the annotation functionality even without symbols.
>>
>> This patch fakes a dummy symbol and the symbol name is the string of
>> address. After that, we just follow current annotation working flow.
>>
>> For example,
>>
>> 1. perf report
>>
>> Overhead  Command  Shared Object     Symbol
>>    20.67%  div      libc-2.27.so      [.] __random_r
>>    17.29%  div      libc-2.27.so      [.] __random
>>    10.59%  div      div               [.] 0x0000000000000628
>>     9.25%  div      div               [.] 0x0000000000000612
>>     6.11%  div      div               [.] 0x0000000000000645
>>
>> 2. Select the line of "10.59%  div      div               [.] 0x0000000000000628" and ENTER.
>>
>> Annotate 0x0000000000000628
>> Zoom into div thread
>> Zoom into div DSO (use the 'k' hotkey to zoom directly into the kernel)
>> Browse map details
>> Run scripts for samples of symbol [0x0000000000000628]
>> Run scripts for all samples
>> Switch to another data file in PWD
>> Exit
>>
>> 3. Select the "Annotate 0x0000000000000628" and ENTER.
>>
>> Percent│
>>         │
>>         │
>>         │     Disassembly of section .text:
>>         │
>>         │     0000000000000628 <.text+0x68>:
>>         │       divsd %xmm4,%xmm0
>>         │       divsd %xmm3,%xmm1
>>         │       movsd (%rsp),%xmm2
>>         │       addsd %xmm1,%xmm0
>>         │       addsd %xmm2,%xmm0
>>         │       movsd %xmm0,(%rsp)
>>
>> Now we can see the dump of object starting from 0x628.
>>
>> We can also press hotkey 'a' on address in report view.
>> For branch mode, we only support the annotation for
>> "branch to" address.
>>
>>   v4:
>>   ---
>>   1. Support the hotkey 'a'. When we press 'a' on address,
>>      now it supports the annotation.
> 
> please move this to separate patch, AFAICS it's separate change
> and was broken before your change
> 
> thanks,
> jirka
> 

OK, I will move it to a separate patch.

Thanks
Jin Yao
