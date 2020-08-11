Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A5EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D5C20658
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgHKIbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:31:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:4022 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbgHKIbO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:31:14 -0400
IronPort-SDR: EzjumHhA0vfJSzcWhrURY5AzS/N5Y4W+8omHF9qBJuQyM5E8PrtUG1tDZU9WRFCQ7GgtFSNLEy
 AQYITUjakcsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="215208699"
X-IronPort-AV: E=Sophos;i="5.75,460,1589266800"; 
   d="scan'208";a="215208699"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 01:31:13 -0700
IronPort-SDR: 9zq5r3W0sHvV7xfmGV1CvrJkriUqsZ+mqJiUYv5GjpqQgGo5IZJgXzakXfOefWphenHKWQSh0L
 MlFQON98Va6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,460,1589266800"; 
   d="scan'208";a="324699337"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga008.jf.intel.com with ESMTP; 11 Aug 2020 01:31:10 -0700
Subject: Re: [PATCH v1 2/2] perf/core: Fake regs for leaked kernel samples
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, oleg@redhat.com, acme@kernel.org,
        jolsa@kernel.org, Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
References: <20200731025617.16243-1-yao.jin@linux.intel.com>
 <20200731025617.16243-2-yao.jin@linux.intel.com>
 <20200804114900.GI2657@hirez.programming.kicks-ass.net>
 <4c958d61-11a7-9f3e-9e7d-d733270144a1@linux.intel.com>
 <20200805124454.GP2657@hirez.programming.kicks-ass.net>
 <797aa4de-c618-f340-ad7b-cef38c96b035@linux.intel.com>
 <56957a58-6292-e075-8c30-6230450e3518@linux.intel.com>
 <20200811075924.GU3982@worktop.programming.kicks-ass.net>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <dbc68bbf-b1a8-77ab-c89c-2d890a0382cc@linux.intel.com>
Date:   Tue, 11 Aug 2020 16:31:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811075924.GU3982@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/11/2020 3:59 PM, Peter Zijlstra wrote:
> On Tue, Aug 11, 2020 at 03:50:43PM +0800, Jin, Yao wrote:
>> Could I post v2 which basically refers to your patch but removes some
>> conditions since I see some issues in test if we use these conditions.
>>
>>   1. Remove '!event->attr.exclude_hv || !event->attr.exclude_host ||
>>      !event->attr.exclude_guest' at the entry of sanitize_sample_regs().
>>
>>   2. Remove '!attr.exclude_hv || !attr.exclude_host || !attr.exclude_guest'
>>      at the perf_event_open syscall entry.
> 
> exclude_host, maybe -- due to the dodgy semantics of it, but the others
> should definitely be there.
> 

exclude_guest and exclude_hv are tricky too.

If we do 'perf record -e cycles:u' in both host and guest, we can see:

event->attr.exclude_guest = 0

thus sanitize_sample_regs() returns regs directly even if exclude_kernel = 1.

And in guest, exclude_hv = 0, it's out of my expectation too.

Thanks
Jin Yao
