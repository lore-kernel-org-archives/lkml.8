Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE61C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 00:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C5D20767
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 00:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCSA4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:56:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:30099 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCSA4U (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 20:56:20 -0400
IronPort-SDR: GgbrBRuE+vz/CuEhifu5vUeq0YIU2vy3s9Nftr5EBULKd9rZuhC76Wngdio/iPktv1K6fq5T7G
 qHEtdoAieLHA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 17:56:19 -0700
IronPort-SDR: gDiNcnweLMZCSqcUv8gOFhFgcTXgsF9Vc3lXNEPDmxSObR5Yyr/1GI9z/rOHJeTyOlBY8jLd2D
 gyipaQ9vUGiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,569,1574150400"; 
   d="scan'208";a="236793448"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 Mar 2020 17:56:17 -0700
Subject: Re: [PATCH v5 2/3] perf report: Support interactive annotation of
 code without symbols
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200227043939.4403-1-yao.jin@linux.intel.com>
 <20200227043939.4403-3-yao.jin@linux.intel.com>
 <20200318154206.GG11531@kernel.org> <20200318154358.GH11531@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <400348ef-14d2-e27c-d073-2b2fb42837f2@linux.intel.com>
Date:   Thu, 19 Mar 2020 08:56:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318154358.GH11531@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2020 11:43 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 18, 2020 at 12:42:06PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Feb 27, 2020 at 12:39:38PM +0800, Jin Yao escreveu:
>>> For perf report on stripped binaries it is currently impossible to do
>>> annotation. The annotation state is all tied to symbols, but there are
>>> either no symbols, or symbols are not covering all the code.
>>>
>>> We should support the annotation functionality even without symbols.
>>>
>>> This patch fakes a symbol and the symbol name is the string of address.
>>> After that, we just follow current annotation working flow.
>>>
>>> For example,
>>>
>>> 1. perf report
>>>
>>> Overhead  Command  Shared Object     Symbol
>>>    20.67%  div      libc-2.27.so      [.] __random_r
>>>    17.29%  div      libc-2.27.so      [.] __random
>>>    10.59%  div      div               [.] 0x0000000000000628
>>>     9.25%  div      div               [.] 0x0000000000000612
>>>     6.11%  div      div               [.] 0x0000000000000645
>>>
>>> 2. Select the line of "10.59%  div      div               [.] 0x0000000000000628" and ENTER.
>>>
>>> Annotate 0x0000000000000628
>>> Zoom into div thread
>>> Zoom into div DSO (use the 'k' hotkey to zoom directly into the kernel)
>>> Browse map details
>>> Run scripts for samples of symbol [0x0000000000000628]
>>> Run scripts for all samples
>>> Switch to another data file in PWD
>>> Exit
>>>
>>> 3. Select the "Annotate 0x0000000000000628" and ENTER.
>>>
>>> Percent│
>>>         │
>>>         │
>>>         │     Disassembly of section .text:
>>>         │
>>>         │     0000000000000628 <.text+0x68>:
>>>         │       divsd %xmm4,%xmm0
>>>         │       divsd %xmm3,%xmm1
>>>         │       movsd (%rsp),%xmm2
>>>         │       addsd %xmm1,%xmm0
>>>         │       addsd %xmm2,%xmm0
>>>         │       movsd %xmm0,(%rsp)
>>>
>>> Now we can see the dump of object starting from 0x628.
>>
>> Testing this I noticed this discrepancy when using 'o' in the annotate
>> view to see the address columns:
>>
>> Samples: 10K of event 'cycles', 4000 Hz, Event count (approx.): 7738221585
>> 0x0000000000ea8b97  /usr/libexec/gcc/x86_64-redhat-linux/9/cc1 [Percent: local period]
>> Percent│                                                                                                                                                                                                                                                  ▒
>>         │                                                                                                                                                                                                                                                  ▒
>>         │                                                                                                                                                                                                                                                  ▒
>>         │        Disassembly of section .text:                                                                                                                                                                                                             ▒
>>         │                                                                                                                                                                                                                                                  ◆
>>         │        00000000012a8b97 <linemap_get_expansion_line@@Base+0x227>:                                                                                                                                                                                ▒
>>         │12a8b97:   cmp     %rax,(%rdi)                                                                                                                                                                                                                    ▒
>>         │12a8b9a: ↓ je      12a8ba0 <linemap_get_expansion_line@@Base+0x230>                                                                                                                                                                               ▒
>>         │12a8b9c:   xor     %eax,%eax                                                                                                                                                                                                                      ▒
>>         │12a8b9e: ← retq                                                                                                                                                                                                                                   ▒
>>         │12a8b9f:   nop                                                                                                                                                                                                                                    ▒
>>         │12a8ba0:   mov     0x8(%rsi),%edx
>>
>>
>>
>>   See that 0x0000000000ea8b97 != 12a8b97
>>
>> How can we explain that?
> 
> On another machine, in 'perf top', its ok, the same address appears on
> the second line and in the first line in the disassembled code.
> 
> I'm applying the patch,
> 
> - Arnaldo
> 

Yes, it looks strange. On my test machines, perf report and perf top 
both work fine. I'm using ubuntu 18.04.

Thanks
Jin Yao

