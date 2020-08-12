Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFE8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6142207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgHLNj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:39:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:65459 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbgHLNjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:39:55 -0400
IronPort-SDR: TZFPz+x+ptwHZ6fquSuSQblBRMd8EwagJmI/9Saz4Nx2hic757o79/yjYyXumvgWAChG4Jjk/H
 KQpvuKlynSyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="171994987"
X-IronPort-AV: E=Sophos;i="5.76,304,1592895600"; 
   d="scan'208";a="171994987"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 06:39:54 -0700
IronPort-SDR: QPiH1V24z0fuzWIVrZGjYY4uC+YYAHjfPBeUMnRPegfUrb+nS6W52ZDqcCCmc0NdxaW0hFNSo8
 YdXubpbG6fbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,304,1592895600"; 
   d="scan'208";a="325072278"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 12 Aug 2020 06:39:54 -0700
Received: from [10.251.5.39] (kliang2-MOBL.ccr.corp.intel.com [10.251.5.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8DD1A580785;
        Wed, 12 Aug 2020 06:39:53 -0700 (PDT)
Subject: Re: [PATCH V6 01/16] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        kirill.shutemov@linux.intel.com
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
 <20200810212436.8026-2-kan.liang@linux.intel.com>
 <b5422d70-f5d3-f2eb-0b39-4efd050d8828@intel.com>
 <298cfc4d-4a9b-7886-1006-09f2bc24d789@linux.intel.com>
 <20200810224734.GO3982@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <7a37a83a-fd30-3387-98b2-e3d23d36f69c@linux.intel.com>
Date:   Wed, 12 Aug 2020 09:39:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810224734.GO3982@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2020 6:47 PM, Peter Zijlstra wrote:
> On Mon, Aug 10, 2020 at 06:38:35PM -0400, Liang, Kan wrote:
>> On 8/10/2020 5:47 PM, Dave Hansen wrote:
> 
>>> It's probably best if we very carefully define up front what is getting
>>> reported here.  For instance, I believe we already have some fun cases
>>> with huge tmpfs where a compound page is mapped with 4k PTEs.  Kirill
>>> also found a few drivers doing this as well.  I think there were also
>>> some weird cases for ARM hugetlbfs where there were multiple hardware
>>> page table entries mapping a single hugetlbfs page.  These would be
>>> cases where compound_head() size would be greater than the size of the
>>> leaf paging structure entry.
>>>
>>> This is also why we have KerelPageSize and MMUPageSize in /proc/$pid/smaps.
>>>
>>> So, is this returning the kernel software page size or the MMU size?
>>>
>>
>> This tries to return the kernel software page size. I will add a commit to
>> the function. For the above cases, I think they can be detected by
>> PageCompound(page). The current code should already cover them. Is my
>> understanding correct?
> 
> But the rationale for the whole feature was to measure and possibly
> drive large page promotion/demotion, which requires the mmu page-size.

Yes, the MMU page-size is better here.

I still have some questions regarding MMUPageSize VS. KerelPageSize.
Could you please clarify?

I checked the show_smap code in fs/proc/task_mmu.c. We defined a __weak 
function for vma_mmu_pagesize(), which invokes vma_kernel_pagesize(). 
The comments also say that "In the majority of cases, the page size used 
by the kernel matches the MMU size. On architectures where it differs, 
an architecture-specific 'strong' version of this symbol is required."
I searched the vma_mmu_pagesize(). It seems that PowerPC is the only one 
that defines a 'strong' function. In other words, the MMUPageSize and 
KerelPageSize are the same for X86. However, it seems not true for the 
above compound page cases. Is it a bug for smaps? Or am I missed anything?

Thanks,
Kan
