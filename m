Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF97C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD27206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgHJWhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:37:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:13676 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgHJWhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:37:12 -0400
IronPort-SDR: AceMMsjUXLeO317Nl5OV6ev5SJK6p9jN1iC/Seyo5m4/L18o+/Mz0IwJ+1CYMdYSgzljlgwJ4o
 SUHxxIbGCfFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="215146132"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="215146132"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 15:37:11 -0700
IronPort-SDR: 9LK8gXSB52smKO7JHoXNyLrAdMmD23DxxTfR+m5ny18Vz3V2XLR8a+/fcob0zWYXcekg2oRQXX
 e6VIWXGjsDbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="494477392"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 10 Aug 2020 15:37:11 -0700
Received: from [10.254.81.180] (kliang2-MOBL.ccr.corp.intel.com [10.254.81.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0D836580223;
        Mon, 10 Aug 2020 15:37:09 -0700 (PDT)
Subject: Re: [PATCH V6 03/16] perf/core: Add support for
 PERF_SAMPLE_CODE_PAGE_SIZE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
 <20200810212436.8026-4-kan.liang@linux.intel.com>
 <20200810214100.GL3982@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <3313128b-04f3-e5b5-9918-aaed7ede43de@linux.intel.com>
Date:   Mon, 10 Aug 2020 18:37:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810214100.GL3982@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2020 5:41 PM, Peter Zijlstra wrote:
> On Mon, Aug 10, 2020 at 02:24:23PM -0700, Kan Liang wrote:
>> From: Stephane Eranian <eranian@google.com>
>>
>> When studying code layout, it is useful to capture the page size of the
>> sampled code address.
>>
>> Add a new sample type for code page size.
>> The new sample type requires collecting the ip. The code page size can
>> be calculated from the IRQ-safe perf_get_page_size().
>>
>> Only the generic support is covered. The large PEBS will be disabled
>> with this sample type.
> 
> -ENOREASON

I think the reason is similar to PERF_SAMPLE_DATA_PAGE_SIZE. For large 
PEBS, the mapping could be gone for the earlier PEBS records. Invalid 
page size may be retrieved. I will update the commit message.

Thanks,
Kan
