Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FB7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190AE208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgGTSWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:22:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:14583 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGTSWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:22:30 -0400
IronPort-SDR: DtF6HfjvTVhHH8JeSiALDcbEKbl5CLxt/ri2DNfTZsI0vfrQ9rpHwYlspGbjMAWMrgYUmlBWDN
 A5s79CnszPXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="130064290"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="130064290"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 11:22:30 -0700
IronPort-SDR: X84hHlpj1r0oBN7evSFEINY094cRPdzBDUPAKI5Qpy4BMWas2U9HnwUqS0ZCnLFzcb4r8bw30/
 xh8qmud4WO1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="327617059"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 20 Jul 2020 11:22:29 -0700
Received: from [10.255.230.139] (kliang2-mobl.ccr.corp.intel.com [10.255.230.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DF8CF580299;
        Mon, 20 Jul 2020 11:22:28 -0700 (PDT)
Subject: Re: [PATCH V6 03/14] perf/x86/intel: Introduce the fourth fixed
 counter
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-4-kan.liang@linux.intel.com>
 <20200720162024.GT10769@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <fbf09b63-4b6d-ebdf-33fc-f93695b3f94a@linux.intel.com>
Date:   Mon, 20 Jul 2020 14:22:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720162024.GT10769@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2020 12:20 PM, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 07:05:43AM -0700, kan.liang@linux.intel.com wrote:
>>   /*
>> + * There is no event-code assigned to the fixed-mode PMCs.
>> + *
>> + * For a fixed-mode PMC, which has an equivalent event on a general-purpose
>> + * PMC, the event-code of the equivalent event is used for the fixed-mode PMC,
>> + * e.g., Instr_Retired.Any and CPU_CLK_Unhalted.Core.
>> + *
>> + * For a fixed-mode PMC, which doesn't have an equivalent event, a
>> + * pseudo-encoding is used, e.g., CPU_CLK_Unhalted.Ref and TOPDOWN.SLOTS.
>> + * The pseudo event-code for a fixed-mode PMC must be 0x00.
>> + * The pseudo umask-code is 0x0X. The X indicates the index of the fixed
>> + * counter.
> 
> Isn't it X+1 ? Such that 0x0000 is an invalid event? After all, the
> pseudo event for Fixed2 is 0x0300.

I will fix the inaccurate description as below in V7.

+ * The pseudo umask-code is 0xX. The X equals the index of the fixed
+ * counter + 1, e.g., the fixed counter 2 has the pseudo-encoding 0x0300.

Thanks,
Kan
