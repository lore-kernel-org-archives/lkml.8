Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE663C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54BC22482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgGTTCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:02:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:30271 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgGTTCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:02:54 -0400
IronPort-SDR: 2ZpN6OTaCMM8tQ+CKZBaVMIhfC1VQ2/ifZkuaKJNXEZFUJfBp/mD5IrJlk4UWi8rZx//qZfhoi
 KaNrvplFrSOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="151337478"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="151337478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 12:02:53 -0700
IronPort-SDR: CqcdSqdzBE48X13xHT08Le1SiJa9oSrPGw/UWMKkGmAAZrt953WTZBHj4glxQHHYKOefE9QZKC
 funQyprRdaig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="327627634"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 20 Jul 2020 12:02:53 -0700
Received: from [10.255.230.139] (kliang2-mobl.ccr.corp.intel.com [10.255.230.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C507E580824;
        Mon, 20 Jul 2020 12:02:52 -0700 (PDT)
Subject: Re: [PATCH V6 06/14] perf/x86/intel: Use switch in
 intel_pmu_disable/enable_event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-7-kan.liang@linux.intel.com>
 <20200720162241.GU10769@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <f6be644e-5ec8-edd8-a451-0e0cbd0943eb@linux.intel.com>
Date:   Mon, 20 Jul 2020 15:02:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720162241.GU10769@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2020 12:22 PM, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 07:05:46AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Many items are checked in the intel_pmu_disable/enable_event. More items
>> will be added later, e.g. perf metrics events.
>>
>> Use switch, which is more efficient, to replace the if-else.
> 
> Perhaps explain how; does this actually generate a jump-table?

As my understanding, some optimizing compilers may compile a switch 
statement into a jump-table. So it depends.

Another advantage of switch statement is to improve the readability of 
the code. I think I missed it in the commit message.

I will change the commit message as below in V7.

"Currently, the if-else is used in the intel_pmu_disable/enable_event to 
check the type of an event. It works well, but with more and more types 
added later, e.g., perf metrics, compared to the switch statement, the 
if-else may impair the readability of the code.

Also, some optimizing compilers may compile a switch statement into a 
jump-table which is more efficient than if-else.

Use switch to replace the if-else in the intel_pmu_disable/enable_event()."


Thanks,
Kan
