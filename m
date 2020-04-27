Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DB6C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1014206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="D3ohtw03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgD0PMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:12:00 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12072 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0PMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:12:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea6f5c60000>; Mon, 27 Apr 2020 08:09:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 27 Apr 2020 08:11:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 27 Apr 2020 08:11:59 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Apr
 2020 15:11:59 +0000
Received: from [10.40.165.118] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Apr
 2020 15:11:55 +0000
Subject: Re: [PATCH] x86/mm: fix compilation error for unknown type name
 pgprot_t
From:   Abhishek Sahu <abhsahu@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <20200420082231.4202-1-abhsahu@nvidia.com>
 <02c40a96-b9dd-14d8-57f4-426322b76bf2@deltatee.com>
 <24e4100d-f59b-daa6-801b-28c9d062f262@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <7cdc44e5-4de4-7dea-13c1-536708f12fa2@nvidia.com>
Date:   Mon, 27 Apr 2020 20:41:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <24e4100d-f59b-daa6-801b-28c9d062f262@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588000199; bh=1zJ634WJl65wUobAvZKhTYesbDEBXQz1nO4NE66/EAg=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=D3ohtw03aLIN6UGW7qdWLQ2v112wbX/SOBUvcGlO79BX/nGv6P1NIQfYbNz6iOQK3
         hCnvNTt+ODWSqRtyv7/yeScmQ6y+hjYNpy7HBm7WTwfB4if7L40/pC8OEoQrL+lgzx
         P+VtbOnZqZF8DojLSqYwIMnZywmobgRto8rS3Djdpg8ceWKeCGCV/CP5RuIsnPebor
         JIIprjlLjDE1Tic4VWLuay7lfygXqlZdD+cPEK6UNYh3zkxMNP7siwcRw2INfulFRx
         p6w3BVp51fGKhbn6DT/wt6YDoxlnV2T9p1qHSTa8wY4P5Nkpa34OAg3PhtCIRjGJBR
         CWvEoedz83z4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/2020 11:18 AM, Abhishek Sahu wrote:
> On 4/20/2020 10:14 PM, Logan Gunthorpe wrote:
>> On 2020-04-20 2:22 a.m., Abhishek Sahu wrote:
>>> commit 30796e18c299 ("x86/mm: introduce __set_memory_prot()")
>>> added the function __set_memory_prot() which uses pgprot_t in
>>> function prototype. The currently included header files in
>>> <arch/x86/include/asm/set_memory.h> do not include type name
>>> pgprot_t. The pgprot_t is defined in <asm/pgtable_types.h>.
>>>
>>> Fixes: 30796e18c299 ("x86/mm: introduce __set_memory_prot()")
>>> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
>>
>> I assume this is only hit with a specific driver or something that
>> includes set_memory.h without including pgtable_types.h before hand.
>>
>> It certainly compiles fine for me and the kbuild robot has had lots of
>> time to test it with random configs.
>>
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
>   Thanks Logan.
> 
>   Yes. The mainline is compiling fine with default config.
>   This problem is coming while compiling Out of tree NVIDIA driver.
>   But this problem can happen for the drivers which don't include
>   <pgtable_types.h>. I am not sure if this problem will come with
>   some other configs. Normally, the header files should not be
>   dependent upon the callers.
> 

 Is it possible to get this patch merged for next rc of 5.7.
 This issue started coming from 5.7-rc1.

 Thanks,
 Abhishek  
