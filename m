Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D4DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA37720823
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgFLAjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 20:39:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:48138 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgFLAjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 20:39:13 -0400
IronPort-SDR: CSLwh9Mg7/B7kfiNeDc1qkvsDS35SJ2dEHUVTEwJlOWKjB4D/YTMmqZGLJOuh3a8YjkfY7gWgn
 gY72cWlkBChQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 17:39:10 -0700
IronPort-SDR: wshLOBkxm7VTi24nZCKMAnZmolS6pcJEKl4T15eV9XISp/VfYclrA6qWTOz8yg7uwPrVG5UBI+
 t8hd8Bzw2Z1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; 
   d="scan'208";a="307134811"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.6.47]) ([10.238.6.47])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2020 17:39:09 -0700
Subject: Re: [LKP] [ima] 8eb613c0b8: stress-ng.icache.ops_per_sec -84.2%
 regression
To:     Mimi Zohar <zohar@linux.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200603091150.GH12456@shao2-debian>
 <099cfe59-1601-a0fc-3849-13eee8754130@linux.intel.com>
 <1591797185.5140.2.camel@linux.ibm.com>
 <cb6a244c-5bab-1ccc-4386-e1b1caf48eb3@linux.intel.com>
 <1591872811.5140.41.camel@linux.ibm.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <d5b6a48b-005c-e5cb-a82f-5f7225741100@linux.intel.com>
Date:   Fri, 12 Jun 2020 08:39:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1591872811.5140.41.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/2020 6:53 PM, Mimi Zohar wrote:
> On Thu, 2020-06-11 at 15:10 +0800, Xing Zhengjun wrote:
>> On 6/10/2020 9:53 PM, Mimi Zohar wrote:
>>   	ucode: 0x500002c
>>>
>>> Does the following change resolve it?
>>>
>>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>>> index c44414a7f82e..78e1dfc8a3f2 100644
>>> --- a/security/integrity/ima/ima_main.c
>>> +++ b/security/integrity/ima/ima_main.c
>>> @@ -426,7 +426,8 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
>>>    	int pcr;
>>>    
>>>    	/* Is mprotect making an mmap'ed file executable? */
>>> -	if (!vma->vm_file || !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
>>> +	if (!(ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
>>> +	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
>>>    		return 0;
>>>    
>>>    	security_task_getsecid(current, &secid);
>>>
>> Thanks. I test the change, it can resolve the regression.
> 
> Thanks!  Can I get your "Tested-by" tag?
> 
> Mimi
> 

Sure.

-- 
Zhengjun Xing
