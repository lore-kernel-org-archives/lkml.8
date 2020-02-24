Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE62C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B6B20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBXPoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:44:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:52920 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbgBXPoM (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:44:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 07:44:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="349941053"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.211.36]) ([10.254.211.36])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2020 07:44:08 -0800
Subject: Re: [PATCH v3 2/2] Support interactive annotation of code without
 symbols
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        alexander.shishkin@linux.intel.com
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200224022225.30264-1-yao.jin@linux.intel.com>
 <20200224022225.30264-3-yao.jin@linux.intel.com>
 <6d8858e7-01a7-70fd-5c22-7b79b308fb95@linux.ibm.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <40c77ce0-5984-6b7b-1013-732efb89e2d7@linux.intel.com>
Date:   Mon, 24 Feb 2020 23:44:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6d8858e7-01a7-70fd-5c22-7b79b308fb95@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2020 9:25 PM, Ravi Bangoria wrote:
> Hi Jin,
> 
> On 2/24/20 7:52 AM, Jin Yao wrote:
>> For perf report on stripped binaries it is currently impossible to do
>> annotation. The annotation state is all tied to symbols, but there are
>> either no symbols, or symbols are not covering all the code.
>>
>> We should support the annotation functionality even without symbols.
>>
>> This patch fakes a symbol and the symbol name is the string of address.
>> After that, we just follow current annotation working flow.
>>
>> For example,
>>
>> 1. perf report
>>
>> Overhead  Command  Shared Object     Symbol
>>    20.67%  div      libc-2.27.so      [.] __random_r
>>    17.29%  div      libc-2.27.so      [.] __random
>>    10.59%  div      div               [.] 0x0000000000000628
>>     9.25%  div      div               [.] 0x0000000000000612
>>     6.11%  div      div               [.] 0x0000000000000645
>>
>> 2. Select the line of "10.59%  div      div               [.] 
>> 0x0000000000000628" and ENTER.
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
>>         │
>>         │
>>         │     Disassembly of section .text:
>>         │
>>         │     0000000000000628 <.text+0x68>:
>>         │       divsd %xmm4,%xmm0
>>         │       divsd %xmm3,%xmm1
>>         │       movsd (%rsp),%xmm2
>>         │       addsd %xmm1,%xmm0
>>         │       addsd %xmm2,%xmm0
>>         │       movsd %xmm0,(%rsp)
>>
>> Now we can see the dump of object starting from 0x628.
> 
> If I press 'a' on address, it's not annotating. But if I annotate
> by pressing enter, like you explained, it works. Is it intentional?
> 
> Ravi
> 

Oh, I often use the ENTER, I forget the hotkey 'a'. :(

Sorry about that...

