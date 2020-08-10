Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A708FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807C9206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgHJWgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:36:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:13629 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgHJWgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:36:43 -0400
IronPort-SDR: uJx8ZlThsEzcPAaYgIAm2Wpi3dmvcF+lHOEQYOJ1a6qFCIaa9OI58OqvVDwVY4WR1WQJ0CqCFl
 x4tMqZU6qxRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="215146009"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="215146009"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 15:36:41 -0700
IronPort-SDR: WipaTiTAMFRovvQWfTcVKIux+d7V6FJblDotnu/Sp9DCXXfBQ89YESNeEvtB15loIqlseTBhrv
 9AxhlyWlseSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="494477293"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 10 Aug 2020 15:36:41 -0700
Received: from [10.254.81.180] (kliang2-MOBL.ccr.corp.intel.com [10.254.81.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EBC70580785;
        Mon, 10 Aug 2020 15:36:39 -0700 (PDT)
Subject: Re: [PATCH V6 02/16] perf/x86/intel: Support
 PERF_SAMPLE_DATA_PAGE_SIZE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
 <20200810212436.8026-3-kan.liang@linux.intel.com>
 <20200810214040.GK3982@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <2dc7c2c2-4f5f-09a9-8c1b-baf294da08b1@linux.intel.com>
Date:   Mon, 10 Aug 2020 18:36:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810214040.GK3982@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2020 5:40 PM, Peter Zijlstra wrote:
> On Mon, Aug 10, 2020 at 02:24:22PM -0700, Kan Liang wrote:
>> The new sample type, PERF_SAMPLE_DATA_PAGE_SIZE, requires the virtual
>> address. Update the data->addr if the sample type is set.
>>
>> The large PEBS is disabled with the sample type, because perf doesn't
>> support munmap tracking yet. The PEBS buffer for large PEBS cannot be
>> flushed for each munmap. Wrong page size may be calculated. The large
>> PEBS can be enabled later separately when munmap tracking is supported.
> 
> 
> You also get to fix up Power.
> 
> arch/powerpc/perf/core-book3s.c:                    (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR))

Sure. I will add one patch for Power.

Thanks,
Kan

