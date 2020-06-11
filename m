Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E0CC207D5
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgFKHKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:10:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:31060 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgFKHKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:10:23 -0400
IronPort-SDR: 0cDxCXLmeeVk30JWnTaEoNwlZ+PtFf9Q/u6Jc79V2YhytLD2DCDUHpP33zQeipTpb//hlLS3GQ
 PQhgAXfWbwiQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 00:10:22 -0700
IronPort-SDR: B/nu7lFbnKQMd9Mf6/N/cpqYcToipKynhidO9k45sJghBYwAweT6BX7ZnvU5aKeNhDpeKa2Met
 C4gG8OqgSISg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="419015731"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.6.47]) ([10.238.6.47])
  by orsmga004.jf.intel.com with ESMTP; 11 Jun 2020 00:10:21 -0700
Subject: Re: [LKP] [ima] 8eb613c0b8: stress-ng.icache.ops_per_sec -84.2%
 regression
To:     Mimi Zohar <zohar@linux.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200603091150.GH12456@shao2-debian>
 <099cfe59-1601-a0fc-3849-13eee8754130@linux.intel.com>
 <1591797185.5140.2.camel@linux.ibm.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <cb6a244c-5bab-1ccc-4386-e1b1caf48eb3@linux.intel.com>
Date:   Thu, 11 Jun 2020 15:10:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1591797185.5140.2.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/2020 9:53 PM, Mimi Zohar wrote:
> Hi Xing,
> 
> On Wed, 2020-06-10 at 11:21 +0800, Xing Zhengjun wrote:
>> Hi Mimi,
>>
>>       Do you have time to take a look at this? we noticed a 3.7%
>> regression of boot-time.dhcp and a 84.2% regression of
>> stress-ng.icache.ops_per_sec. Thanks.
>>
>> On 6/3/2020 5:11 PM, kernel test robot wrote:
>>> Greeting,
>>>
>>> FYI, we noticed a 3.7% regression of boot-time.dhcp due to commit:
>>>
>>>
>>> commit: 8eb613c0b8f19627ba1846dcf78bb2c85edbe8dd ("ima: verify mprotect change is consistent with mmap policy")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>
>>> in testcase: stress-ng
>>> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
>>> with following parameters:
>>>
>>> 	nr_threads: 100%
>>> 	disk: 1HDD
>>> 	testtime: 30s
>>> 	class: cpu-cache
>>> 	cpufreq_governor: performance
>>> 	ucode: 0x500002c
> 
> Does the following change resolve it?
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index c44414a7f82e..78e1dfc8a3f2 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -426,7 +426,8 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
>   	int pcr;
>   
>   	/* Is mprotect making an mmap'ed file executable? */
> -	if (!vma->vm_file || !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
> +	if (!(ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
> +	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
>   		return 0;
>   
>   	security_task_getsecid(current, &secid);
> 
Thanks. I test the change, it can resolve the regression.
=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/debug-setup/nr_threads/disk/testtime/class/cpufreq_governor/ucode:
 
lkp-csl-2sp5/stress-ng/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-9/test/100%/1HDD/30s/cpu-cache/performance/0x500002c

commit:
   0c4395fb2aa77341269ea619c5419ea48171883f
   8eb613c0b8f19627ba1846dcf78bb2c85edbe8dd
   8745d6eb3a493b1d324eeb9edefec5d23c16cba9 (fix for the regression)

0c4395fb2aa77341 8eb613c0b8f19627ba1846dcf78 8745d6eb3a493b1d324eeb9edef
---------------- --------------------------- ---------------------------
          %stddev     %change         %stddev     %change         %stddev
              \          |                \          |                \
     884.33 ±  4%      +4.6%     924.67           +45.1%       1283 ± 
3%  stress-ng.cache.ops
      29.47 ±  4%      +4.6%      30.82           +45.1%      42.76 ± 
3%  stress-ng.cache.ops_per_sec
    1245720           -84.3%     195648            -0.8%    1235416 
   stress-ng.icache.ops
      41522           -84.3%       6520            -0.8%      41179 
   stress-ng.icache.ops_per_sec



-- 
Zhengjun Xing
