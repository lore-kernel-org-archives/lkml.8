Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2A0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C18120760
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389445AbgF3P35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:29:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:60276 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgF3P35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:29:57 -0400
IronPort-SDR: LFo+Emt92YEk5Jlw3ZRwWKqBVHG0h8hIhVBgjGiFEUaIbPfAh3n+1B4wv2VI3s2d4CsADnUTnz
 gXn3f92XdyOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="126378846"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="126378846"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 08:29:56 -0700
IronPort-SDR: qHyG6YP6HB2/cz7ba7jjgxM4PwfaAqL+XPGRO9LT1uxKBDWdimnGzf4td4JkWGZIT7/wcKpUmE
 dEWlQuG5pV4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="313435960"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2020 08:29:55 -0700
Received: from [10.252.132.55] (kliang2-mobl.ccr.corp.intel.com [10.252.132.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D50A7580107;
        Tue, 30 Jun 2020 08:29:31 -0700 (PDT)
Subject: Re: [PATCH V2 09/23] perf/x86/intel: Check Arch LBR MSRs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
 <1593195620-116988-10-git-send-email-kan.liang@linux.intel.com>
 <20200630145721.GR4781@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <cd6c4a1a-73e9-78c0-8db0-8f11272c9e8f@linux.intel.com>
Date:   Tue, 30 Jun 2020 11:29:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630145721.GR4781@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2020 10:57 AM, Peter Zijlstra wrote:
> On Fri, Jun 26, 2020 at 11:20:06AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The KVM may not support the MSRs of Architecture LBR. Accessing the
>> MSRs may cause #GP and crash the guest.
>>
>> The MSRs have to be checked at guest boot time.
>>
>> Only using the max number of Architecture LBR depth to check the
>> MSR_ARCH_LBR_DEPTH should be good enough. The max number can be
>> calculated by 8 * the position of the last set bit of LBR_DEPTH value
>> in CPUID enumeration.
> 
> But But But, this is architectural, it's in CPUID. If KVM lies to us, it
> gets to keep the pices.
> 
> This was different when it was not enumerated and all we had was poking
> the MSRs, but here KVM can simply mask the CPUID bits if it doesn't
> support the MSRs.
> 
> If KVM gives us the CPUID bits, we should let it crash and burn if it
> then doesn't provide the MSRs.
> 

Agree.
If the CPUID bits are not set by KVM, the x86_pmu.lbr_nr should be 0.
The check will be ignored.

I think we just need to simply drop this patch.


Thanks,
Kan
