Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0409EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77F5206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgGFWaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 18:30:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:5062 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgGFWaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 18:30:04 -0400
IronPort-SDR: 0K+xbGIte3HzqJ68ohcWgX0uNspWtxYs6U4HDbAjkibXQ9o9pMGSID3CioBds1Ox5v7xwVigdS
 XMijHmDj9z/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="145011714"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="145011714"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 15:30:03 -0700
IronPort-SDR: JvBtqbNfsadnBJ1G18xTrRWA5ZRALGJLZnZTA7ScmWAZM/rLGGFolY4xXE5Zb3SMeJLQVYipzH
 rlZv3KwCww6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="283185138"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2020 15:30:02 -0700
Received: from [10.255.228.102] (kliang2-mobl.ccr.corp.intel.com [10.255.228.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 07A84580428;
        Mon,  6 Jul 2020 15:29:59 -0700 (PDT)
Subject: Re: [PATCH V3 13/23] perf/x86/intel/lbr: Factor out
 intel_pmu_store_lbr
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
 <1593780569-62993-14-git-send-email-kan.liang@linux.intel.com>
 <20200703195024.GI2483@worktop.programming.kicks-ass.net>
 <bf63dee4-d25f-89d8-1893-572d84cfa667@linux.intel.com>
Message-ID: <ddfcd90f-ca77-edf4-09b8-183efb2ae2f2@linux.intel.com>
Date:   Mon, 6 Jul 2020 18:29:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bf63dee4-d25f-89d8-1893-572d84cfa667@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/2020 4:59 PM, Liang, Kan wrote:
> 
> 
> On 7/3/2020 3:50 PM, Peter Zijlstra wrote:
>> On Fri, Jul 03, 2020 at 05:49:19AM -0700, kan.liang@linux.intel.com 
>> wrote:
>>> +static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
>>> +                struct lbr_entry *entries)
>>> +{
>>> +    struct perf_branch_entry *e;
>>> +    struct lbr_entry *lbr;
>>> +    u64 from, to, info;
>>> +    int i;
>>> +
>>> +    for (i = 0; i < x86_pmu.lbr_nr; i++) {
>>> +        lbr = entries ? &entries[i] : NULL;
>>> +        e = &cpuc->lbr_entries[i];
>>> +
>>> +        from = rdlbr_from(i, lbr);
>>> +        /*
>>> +         * Read LBR entries until invalid entry (0s) is detected.
>>> +         */
>>> +        if (!from)
>>> +            break;
>>> +
>>> +        to = rdlbr_to(i, lbr);
>>> +        info = rdlbr_info(i, lbr);
>>> +
>>> +        e->from        = from;
>>> +        e->to        = to;
>>> +        e->mispred    = !!(info & LBR_INFO_MISPRED);
>>> +        e->predicted    = !(info & LBR_INFO_MISPRED);
>>> +        e->in_tx    = !!(info & LBR_INFO_IN_TX);
>>> +        e->abort    = !!(info & LBR_INFO_ABORT);
>>> +        e->cycles    = info & LBR_INFO_CYCLES;
>>> +        e->type        = 0;
>>> +        e->reserved    = 0;
>>> +    }
>>> +
>>> +    cpuc->lbr_stack.nr = i;
>>> +}
>>
>> If I'm not mistaken, this correctly deals with LBR_FORMAT_INFO, so can't
>> we also use the intel_pmu_arch_lbr_read() function for that case?
> 

There is another more severe issue which prevents sharing the read of 
Arch LBR with LBR_FORMAT_INFO. Sorry I missed it.

For the legacy LBR, the youngest branch is stored in TOS MSR. The next 
youngest is in (TOS - 1)...

For Arch LBR and LBR PEBS, the youngest branch is always in entry 0. The 
next youngest is in entry 1...

The growth of the legacy LBR is in a reversed order of Arch LBR and LBR 
PEBS. The legacy LBR also relies on TOS. I'm afraid we cannot use the 
intel_pmu_arch_lbr_read() function for LBR_FORMAT_INFO.

I think I will only send a patch to support NO_{CYCLES,FLAGS} for all 
LBR formats.

Thanks,
Kan
