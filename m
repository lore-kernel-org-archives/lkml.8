Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0CBC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FCD2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgBXPjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:39:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:6066 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbgBXPjs (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:39:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 07:39:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="349940530"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.211.36]) ([10.254.211.36])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2020 07:39:45 -0800
Subject: Re: [PATCH v3 2/2] Support interactive annotation of code without
 symbols
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200224022225.30264-1-yao.jin@linux.intel.com>
 <20200224022225.30264-3-yao.jin@linux.intel.com>
 <20200224123526.GF16664@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ed9fea55-1568-ab55-cf4a-52fef7c429bf@linux.intel.com>
Date:   Mon, 24 Feb 2020 23:39:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224123526.GF16664@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2020 8:35 PM, Jiri Olsa wrote:
> On Mon, Feb 24, 2020 at 10:22:25AM +0800, Jin Yao wrote:
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
>>   v3:
>>   ---
>>   Keep just the ANNOTATION_DUMMY_LEN, and remove the
>>   opts->annotate_dummy_len since it's the "maybe in future
>>   we will provide" feature.
>>
>>   v2:
>>   ---
>>   Fix a crash issue when annotating an address in "unknown" object.
>>
>>   The steps to reproduce this issue:
>>
>>   perf record -e cycles:u ls
>>   perf report
>>
>>      75.29%  ls       ld-2.27.so        [.] do_lookup_x
>>      23.64%  ls       ld-2.27.so        [.] __GI___tunables_init
>>       1.04%  ls       [unknown]         [k] 0xffffffff85c01210
>>       0.03%  ls       ld-2.27.so        [.] _start
>>
>>   When annotating 0xffffffff85c01210, the crash happens.
>>
>>   v2 adds checking for ms->map in add_annotate_opt(). If the object is
>>   "unknown", ms->map is NULL.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/ui/browsers/hists.c | 43 +++++++++++++++++++++++++++++-----
>>   tools/perf/util/annotate.h     |  1 +
>>   2 files changed, 38 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
>> index f36dee499320..2f07680559c4 100644
>> --- a/tools/perf/ui/browsers/hists.c
>> +++ b/tools/perf/ui/browsers/hists.c
>> @@ -2465,13 +2465,41 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
>>   	return 0;
>>   }
>>   
>> +static struct symbol *new_annotate_sym(u64 addr, struct map *map)
>> +{
>> +	struct symbol *sym;
>> +	struct annotated_source *src;
>> +	char name[64];
>> +
>> +	snprintf(name, sizeof(name), "%-#.*lx", BITS_PER_LONG / 4, addr);
>> +
>> +	sym = symbol__new(addr, ANNOTATION_DUMMY_LEN, 0, 0, name);
>> +	if (sym) {
>> +		src = symbol__hists(sym, 1);
>> +		if (!src) {
>> +			symbol__delete(sym);
>> +			return NULL;
>> +		}
> 
> hi,
> I like the patchset:
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> could you please also check if we can do this earlier,
> so the dummy symbol is actualy collecting all the hits?
> 
> like within the symbol__inc_addr_samples function,
> but I mght be missing something..
> 
> thanks,
> jirka
> 

Thanks so much for like and ack this patchset!

For your suggestion, I had thought about the similar idea before. Maybe 
we can, but we need to process some cases.

Say the first address is 0x1000 and the dummy symbol size is 256. We 
create a new dummy symbol for this address (start address is 0x1000 and 
end address is 0x1100).

If the second address is 0x1010, we can't create a new dummy symbol for 
this address directly. On the contrary, we need to search the dummy 
symbol list by the address first. If the dummy symbol is found then 
reuse this symbol.

This idea is a bit more complicated than current patchset in 
implementation but it can collect the hits for the dummy symbols, that's 
the advantage. The advantage of current patchset is it's very simple. :)

Accept current patchset or rewrite for the new idea, both OK for me. :)

Thanks
Jin Yao









