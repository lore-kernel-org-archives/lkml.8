Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6ACC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87538205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="j3vKy6zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbgEMH2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:28:47 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17526 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgEMH2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:28:47 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ebba1260000>; Wed, 13 May 2020 00:26:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 May 2020 00:28:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 May 2020 00:28:46 -0700
Received: from [10.40.167.26] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 May
 2020 07:28:43 +0000
Subject: Re: [PATCH] x86/mm: fix compilation error for unknown type name
 pgprot_t
From:   Abhishek Sahu <abhsahu@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>, <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <20200420082231.4202-1-abhsahu@nvidia.com>
 <02c40a96-b9dd-14d8-57f4-426322b76bf2@deltatee.com>
 <24e4100d-f59b-daa6-801b-28c9d062f262@nvidia.com>
 <7cdc44e5-4de4-7dea-13c1-536708f12fa2@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <d43c80a4-7e2c-fdd0-b34a-20ba07485844@nvidia.com>
Date:   Wed, 13 May 2020 12:58:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7cdc44e5-4de4-7dea-13c1-536708f12fa2@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589354790; bh=efIjqqDseHcH1vD6O3AWpKgWaJ3/GNtR1qm3aKhhfa0=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=j3vKy6zdHJGY0t2cx09VmApg9Websity7UgiExPeWNeBl04nBmCpvxxU8b3Hqp7z+
         jjQsbiRJ691k+uarBdnZDZg15gMx3ZsFmgN0VsZYDxqTYlGQGXHqavZC379HwOpEbb
         p4XmhZRkGMRKPg41A+kj83cK4yoQy0KuQsNtKOKmQJ36CXJ/H3JtXW2yV6BYRCi/Wy
         hbFiCVRMbHBIUIJz5KYex/IfnIESDQ5Ne7ZVucOLocQe3ZiraJWGFgPjw+VHC2a8g7
         PoIrQctu3Z65dc/4YxWbA2MlYtKriJYm+GKXPqN5TqkAT38Hp+79xil3OMK4ca/DGZ
         yh1Da7pSZ77ng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/2020 8:41 PM, Abhishek Sahu wrote:
> On 4/21/2020 11:18 AM, Abhishek Sahu wrote:
>> On 4/20/2020 10:14 PM, Logan Gunthorpe wrote:
>>> On 2020-04-20 2:22 a.m., Abhishek Sahu wrote:
>>>> commit 30796e18c299 ("x86/mm: introduce __set_memory_prot()")
>>>> added the function __set_memory_prot() which uses pgprot_t in
>>>> function prototype. The currently included header files in
>>>> <arch/x86/include/asm/set_memory.h> do not include type name
>>>> pgprot_t. The pgprot_t is defined in <asm/pgtable_types.h>.
>>>>
>>>> Fixes: 30796e18c299 ("x86/mm: introduce __set_memory_prot()")
>>>> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
>>>
>>> I assume this is only hit with a specific driver or something that
>>> includes set_memory.h without including pgtable_types.h before hand.
>>>
>>> It certainly compiles fine for me and the kbuild robot has had lots of
>>> time to test it with random configs.
>>>
>>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>>
>>   Thanks Logan.
>>
>>   Yes. The mainline is compiling fine with default config.
>>   This problem is coming while compiling Out of tree NVIDIA driver.
>>   But this problem can happen for the drivers which don't include
>>   <pgtable_types.h>. I am not sure if this problem will come with
>>   some other configs. Normally, the header files should not be
>>   dependent upon the callers.
>>
> 
>  Is it possible to get this patch merged for next rc of 5.7.
>  This issue started coming from 5.7-rc1.
> 

 Could someone help in reviewing and getting this merged in the
 next rc of 5.7 version. The NVIDIA driver compilation is failing
 from 5.7-rc1. This issue can happen for any other driver also
 which is not including <asm/pgtable_types.h> in the driver.

 Thanks,
 Abhishek


 
