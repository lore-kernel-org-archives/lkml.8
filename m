Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C8FC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E70A2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAQPNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:13:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:60215 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbgAQPNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:13:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 07:13:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="424486520"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jan 2020 07:13:44 -0800
Received: from [10.251.27.134] (kliang2-mobl.ccr.corp.intel.com [10.251.27.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 32719580332;
        Fri, 17 Jan 2020 07:13:44 -0800 (PST)
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix inaccurate period in context
 switch for auto-reload
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com
References: <20200116183154.20880-1-kan.liang@linux.intel.com>
 <20200117085823.GV2827@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <5c228fe8-0cd9-4ee7-c0ef-8b723c5eccaa@linux.intel.com>
Date:   Fri, 17 Jan 2020 10:13:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117085823.GV2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/2020 3:58 AM, Peter Zijlstra wrote:
> On Thu, Jan 16, 2020 at 10:31:54AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Perf doesn't take the left period into account when auto-reload is
>> enabled with fixed period sampling mode in context switch.
>> Here is the ftrace when recording PEBS event with fixed period.
>>
>>      #perf record -e cycles:p -c 2000000 -- ./triad_loop
>>
>>        //Task is scheduled out
>>        triad_loop-17222 [000] d... 861765.878032: write_msr:
>> MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0  //Disable global counter
>>        triad_loop-17222 [000] d... 861765.878033: write_msr:
>> MSR_IA32_PEBS_ENABLE(3f1), value 0       //Disable PEBS
>>        triad_loop-17222 [000] d... 861765.878033: write_msr:
>> MSR_P6_EVNTSEL0(186), value 40003003c    //Disable the counter
>>        triad_loop-17222 [000] d... 861765.878033: rdpmc: 0, value
>> fffffff82840                             //Read value of the counter
>>        triad_loop-17222 [000] d... 861765.878034: write_msr:
>> MSR_CORE_PERF_GLOBAL_CTRL(38f), value 1000f000000ff  //Re-enable global
>> counter
> 
> This is unreadable garbage, please don't wrap trace output.
> 

Sorry for that.
I will make the log clear in V2.

Thanks,
Kan
