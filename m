Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78C4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6C6207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHUIji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:39:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:19284 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgHUIjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:39:37 -0400
IronPort-SDR: iDyaWnHUrkAo8yQPYdUPC+jbuV27CL2z3GGRs1IqvF9Nt6SbbtjirkhqLrWHPDkB99w8/hoLEV
 voSBNZKvDa1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="219784504"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="219784504"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 01:39:36 -0700
IronPort-SDR: zmFcrBohW+JG8R86S3YwohkhcQ3wO0XgD/DjX22vbRzGTUGBkhtN8DjTLcT+6x1cm8bn9IsIDT
 Lrmtz//xUydw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="327706468"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.4.18]) ([10.238.4.18])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 01:39:33 -0700
Subject: Re: [LKP] Re: [hugetlbfs] c0d0381ade: vm-scalability.throughput
 -33.4% regression
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200622005551.GK5535@shao2-debian>
 <e140ec78-1fbd-73e2-7a11-7db3b714874d@oracle.com>
 <718e1653-b273-096b-0ee3-f720cf794612@oracle.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <d945497d-0edb-f540-33e1-8b1ba1e20f62@linux.intel.com>
Date:   Fri, 21 Aug 2020 16:39:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <718e1653-b273-096b-0ee3-f720cf794612@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/2020 5:33 AM, Mike Kravetz wrote:
> On 6/22/20 3:01 PM, Mike Kravetz wrote:
>> On 6/21/20 5:55 PM, kernel test robot wrote:
>>> Greeting,
>>>
>>> FYI, we noticed a -33.4% regression of vm-scalability.throughput due to commit:
>>>
>>>
>>> commit: c0d0381ade79885c04a04c303284b040616b116e ("hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>> in testcase: vm-scalability
>>> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
>>> with following parameters:
>>>
>>> 	runtime: 300s
>>> 	size: 8T
>>> 	test: anon-cow-seq-hugetlb
>>> 	cpufreq_governor: performance
>>> 	ucode: 0x11
>>>
>>
>> Some performance regression is not surprising as the change includes acquiring
>> and holding the i_mmap_rwsem (in read mode) during hugetlb page faults.  33.4%
>> seems a bit high.  But, the test is primarily exercising the hugetlb page
>> fault path and little else.
>>
>> The reason for taking the i_mmap_rwsem is to prevent PMD unsharing from
>> invalidating the pmd we are operating on.  This specific test case is operating
>> on anonymous private mappings.  So, PMD sharing is not possible and we can
>> eliminate acquiring the mutex in this case.  In fact, we should check all
>> mappings (even sharable) for the possibly of PMD sharing and only take the
>> mutex if necessary.  It will make the code a bit uglier, but will take care
>> of some of these regressions.  We still need to take the mutex in the case
>> of PMD sharing.  I'm afraid a regression is unavoidable in that case.
>>
>> I'll put together a patch.
> 
> Not acquiring the mutex on faults when sharing is not possible is quite
> straight forward.  We can even use the existing routine vma_shareable()
> to easily check.  However, the next patch in the series 87bf91d39bb5
> "hugetlbfs: Use i_mmap_rwsem to address page fault/truncate race" depends
> on always acquiring the mutex.  If we break this assumption, then the
> code to back out hugetlb reservations needs to be written.  A high level
> view of what needs to be done is in the commit message for 87bf91d39bb5.
> 
> I'm working on the code to back out reservations.
> 

I find that 34ae204f18519f0920bd50a644abd6fefc8dbfcf(hugetlbfs: remove 
call to huge_pte_alloc without i_mmap_rwsem) fixed this regression, I 
test with the patch, the regression reduced to 10.1%, do you have plan 
to continue to improve it? Thanks.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/size/test/cpufreq_governor/ucode:
 
lkp-knm01/vm-scalability/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/8T/anon-cow-seq-hugetlb/performance/0x11

commit:
   49aef7175cc6eb703a9280a7b830e675fe8f2704
   c0d0381ade79885c04a04c303284b040616b116e
   v5.8
   34ae204f18519f0920bd50a644abd6fefc8dbfcf
   v5.9-rc1

49aef7175cc6eb70 c0d0381ade79885c04a04c30328                        v5.8 
34ae204f18519f0920bd50a644a                    v5.9-rc1
---------------- --------------------------- --------------------------- 
--------------------------- ---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev     %change         %stddev
              \          |                \          |                \ 
         |                \          |                \
      38084           -31.1%      26231 ±  2%     -26.6%      27944 ± 
5%      -7.0%      35405            -7.5%      35244 
vm-scalability.median
       9.92 ±  9%     +12.0       21.95 ±  4%      +3.9       13.87 ± 
30%      -5.3        4.66 ±  9%      -6.6        3.36 ±  7% 
vm-scalability.median_stddev%
   12827311           -35.0%    8340256 ±  2%     -30.9%    8865669 ± 
5%     -10.1%   11532087           -10.2%   11513595 ±  2% 
vm-scalability.throughput
  2.507e+09           -22.7%  1.938e+09           -15.3%  2.122e+09 ± 
6%      +8.0%  2.707e+09            +8.0%  2.707e+09 ±  2% 
vm-scalability.workload



-- 
Zhengjun Xing
