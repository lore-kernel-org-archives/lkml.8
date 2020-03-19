Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FF6C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C7620767
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCSBLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:11:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:27255 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCSBLy (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:11:54 -0400
IronPort-SDR: DnmcFwTDOp7Iq4LRCUGFEXSJf1bC2U7W6HNXDB8xLNn2m3HFJdrSKz9nCeQfWwZiAM23DCxO36
 Gl7e2SXou1pw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 18:11:54 -0700
IronPort-SDR: ztMcsKJBA38s6wjMa3oUBeF5xZ26ZGq7hVMB2CwrpKIojRR4bRdDwlniRlcZVzI8Gq5zHKCWMJ
 zmOkmTTmeI/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,569,1574150400"; 
   d="scan'208";a="236796077"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 Mar 2020 18:11:52 -0700
Subject: Re: [PATCH v5 2/3] perf report: Support interactive annotation of
 code without symbols
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200227043939.4403-1-yao.jin@linux.intel.com>
 <20200227043939.4403-3-yao.jin@linux.intel.com>
 <20200318154206.GG11531@kernel.org> <20200318154358.GH11531@kernel.org>
 <20200318154656.GI11531@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <57c99254-7764-0e69-82be-8d84b3072729@linux.intel.com>
Date:   Thu, 19 Mar 2020 09:11:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318154656.GI11531@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2020 11:46 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 18, 2020 at 12:43:58PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Mar 18, 2020 at 12:42:06PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Thu, Feb 27, 2020 at 12:39:38PM +0800, Jin Yao escreveu:
>>>> Now we can see the dump of object starting from 0x628.
> 
>>> Testing this I noticed this discrepancy when using 'o' in the annotate
>>> view to see the address columns:
> 
>>> Samples: 10K of event 'cycles', 4000 Hz, Event count (approx.): 7738221585
>>> 0x0000000000ea8b97  /usr/libexec/gcc/x86_64-redhat-linux/9/cc1 [Percent: local period]
>>> Percent│
>>>         │        Disassembly of section .text:
>>>         │
>>>         │        00000000012a8b97 <linemap_get_expansion_line@@Base+0x227>:
>>>         │12a8b97:   cmp     %rax,(%rdi)
>>>         │12a8b9a: ↓ je      12a8ba0 <linemap_get_expansion_line@@Base+0x230>
>>>         │12a8b9c:   xor     %eax,%eax
>>>         │12a8b9e: ← retq
>>>         │12a8b9f:   nop
>>>         │12a8ba0:   mov     0x8(%rsi),%edx
> 
>>>   See that 0x0000000000ea8b97 != 12a8b97
> 
>>> How can we explain that?
> 
>> On another machine, in 'perf top', its ok, the same address appears on
>> the second line and in the first line in the disassembled code.
> 
>> I'm applying the patch,
> 
> With this adjustments, ok?
> 
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index 2f07680559c4..c2556901f7b6 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2465,10 +2465,10 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
>   	return 0;
>   }
>   
> -static struct symbol *new_annotate_sym(u64 addr, struct map *map)
> +static struct symbol *symbol__new_unresolved(u64 addr, struct map *map)
>   {
> -	struct symbol *sym;
>   	struct annotated_source *src;
> +	struct symbol *sym;
>   	char name[64];
>   
>   	snprintf(name, sizeof(name), "%-#.*lx", BITS_PER_LONG / 4, addr);
> @@ -2497,7 +2497,7 @@ add_annotate_opt(struct hist_browser *browser __maybe_unused,
>   		return 0;
>   
>   	if (!ms->sym)
> -		ms->sym = new_annotate_sym(addr, ms->map);
> +		ms->sym = symbol__new_unresolved(addr, ms->map);
>   
>   	if (ms->sym == NULL || symbol__annotation(ms->sym)->src == NULL)
>   		return 0;
> 

Sure, that's OK, thanks! The name "symbol__new_unresolved" is much 
better than "new_annotate_sym".

Thanks
Jin Yao
