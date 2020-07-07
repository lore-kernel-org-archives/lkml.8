Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC27CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A552320723
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgGGC6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:58:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:28240 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgGGC6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 22:58:51 -0400
IronPort-SDR: UOm8xvynWn5G3eQAGxe84qd2pAaa3wZNADUuDT8YxvanhebbaeZZmPMLLkC7cZEuBoR4Onem04
 6ZyroDGXYCIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="145031398"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="145031398"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:58:50 -0700
IronPort-SDR: Wbuws6KtAJ2FM5ntGD5gG81OGOw57tT/gRnzf/9OXTVI13xqM4o/577POvgZIJeyK78BEoA2y0
 ohYHxM7BZLYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="314143078"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.4.18]) ([10.238.4.18])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2020 19:58:46 -0700
Subject: Re: [LKP] [x86, sched] 1567c3e346: vm-scalability.median -15.8%
 regression
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@lists.01.org
References: <20200306051916.GA23395@xsang-OptiPlex-9020>
 <a5b0b58d-54a9-0f06-c822-3087346a0ae8@linux.intel.com>
 <1587018059.32139.22.camel@suse.cz>
 <fdcab17c-91aa-fba0-65d1-c08af6f50842@linux.intel.com>
Message-ID: <f8fc9530-432f-0b5d-0109-916a01c65bda@linux.intel.com>
Date:   Tue, 7 Jul 2020 10:58:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fdcab17c-91aa-fba0-65d1-c08af6f50842@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2020 4:11 PM, Xing Zhengjun wrote:
> Hi Giovanni,
> 
>     I test the regression, it still existed in v5.7.  Do you have time 
> to take a look at this? Thanks.
> 

Ping...

> ========================================================================================= 
> 
> tbox_group/testcase/rootfs/kconfig/compiler/runtime/debug-setup/size/test/cpufreq_governor/ucode: 
> 
> 
> lkp-hsw-4ex1/vm-scalability/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/test/8T/anon-cow-seq/performance/0x16 
> 
> 
> commit:
>    2a4b03ffc69f2dedc6388e9a6438b5f4c133a40d
>    1567c3e3467cddeb019a7b53ec632f834b6a9239
>    v5.7-rc1
>    v5.7
> 
> 2a4b03ffc69f2ded 1567c3e3467cddeb019a7b53ec6                    v5.7-rc1 
>                         v5.7
> ---------------- --------------------------- --------------------------- 
> ---------------------------
>           %stddev     %change         %stddev     %change %stddev     
> %change         %stddev
>               \          |                \          |                \ 
>          |                \
>      211462           -16.0%     177702           -15.0%     179809      
> -15.1%     179510        vm-scalability.median
>        5.34 ±  9%      -3.1        2.23 ± 11%      -2.9        2.49 ± 
> 5%      -2.7        2.61 ± 11%  vm-scalability.median_stddev%
>    30430671           -16.3%   25461360           -15.5%   25707029      
> -15.5%   25701713        vm-scalability.throughput
>   7.967e+09           -11.1%  7.082e+09           -11.1%  7.082e+09      
> -11.1%  7.082e+09        vm-scalability.workload
> 
> 
> 
> On 4/16/2020 2:20 PM, Giovanni Gherdovich wrote:
>> On Thu, 2020-04-16 at 14:10 +0800, Xing Zhengjun wrote:
>>> Hi Giovanni,
>>>
>>>     1567c3e346("x86, sched: Add support for frequency invariance") has
>>> been merged into Linux mainline v5.7-rc1 now. Do you have time to take a
>>> look at this? Thanks.
>>>
>>
>> Apologies, this slipped under my radar. I'm on it, thanks.
>>
>>
>> Giovanni Gherdovich
>>
> 

-- 
Zhengjun Xing
