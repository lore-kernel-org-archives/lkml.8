Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F240207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFLILR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:11:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:62064 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgFLILR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:11:17 -0400
IronPort-SDR: 0VrjcI8RchfQG0MvgjQ9iOIFCVfVXM6zVVfwX3t5Q3TPxOs0Jsh59PiVzo4hVBfITg7krsiGX0
 Rh+KfKoOsHOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 01:11:17 -0700
IronPort-SDR: WPgTk23d3CEmUaBpcbTjannm6eiL/gNRXu1N5ekMsIm9rCp4Dck56hZiqaw4qSCwY02gmKmoGa
 avV/yRfh8fSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,502,1583222400"; 
   d="scan'208";a="380640438"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.6.47]) ([10.238.6.47])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2020 01:11:14 -0700
Subject: Re: [LKP] [x86, sched] 1567c3e346: vm-scalability.median -15.8%
 regression
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
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <fdcab17c-91aa-fba0-65d1-c08af6f50842@linux.intel.com>
Date:   Fri, 12 Jun 2020 16:11:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1587018059.32139.22.camel@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Giovanni,

    I test the regression, it still existed in v5.7.  Do you have time 
to take a look at this? Thanks.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/debug-setup/size/test/cpufreq_governor/ucode:
 
lkp-hsw-4ex1/vm-scalability/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/test/8T/anon-cow-seq/performance/0x16

commit:
   2a4b03ffc69f2dedc6388e9a6438b5f4c133a40d
   1567c3e3467cddeb019a7b53ec632f834b6a9239
   v5.7-rc1
   v5.7

2a4b03ffc69f2ded 1567c3e3467cddeb019a7b53ec6                    v5.7-rc1 
                        v5.7
---------------- --------------------------- --------------------------- 
---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev
              \          |                \          |                \ 
         |                \
     211462           -16.0%     177702           -15.0%     179809 
      -15.1%     179510        vm-scalability.median
       5.34 ±  9%      -3.1        2.23 ± 11%      -2.9        2.49 ± 
5%      -2.7        2.61 ± 11%  vm-scalability.median_stddev%
   30430671           -16.3%   25461360           -15.5%   25707029 
      -15.5%   25701713        vm-scalability.throughput
  7.967e+09           -11.1%  7.082e+09           -11.1%  7.082e+09 
      -11.1%  7.082e+09        vm-scalability.workload



On 4/16/2020 2:20 PM, Giovanni Gherdovich wrote:
> On Thu, 2020-04-16 at 14:10 +0800, Xing Zhengjun wrote:
>> Hi Giovanni,
>>
>>     1567c3e346("x86, sched: Add support for frequency invariance") has
>> been merged into Linux mainline v5.7-rc1 now. Do you have time to take a
>> look at this? Thanks.
>>
> 
> Apologies, this slipped under my radar. I'm on it, thanks.
> 
> 
> Giovanni Gherdovich
> 

-- 
Zhengjun Xing
