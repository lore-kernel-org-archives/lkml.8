Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E40C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BA1208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JgJ2K1y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDUFss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 01:48:48 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4646 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgDUFss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 01:48:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9e88cc0000>; Mon, 20 Apr 2020 22:46:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 Apr 2020 22:48:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 20 Apr 2020 22:48:47 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Apr
 2020 05:48:47 +0000
Received: from [10.40.165.65] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Apr
 2020 05:48:44 +0000
From:   Abhishek Sahu <abhsahu@nvidia.com>
Subject: Re: [PATCH] x86/mm: fix compilation error for unknown type name
 pgprot_t
To:     Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200420082231.4202-1-abhsahu@nvidia.com>
 <02c40a96-b9dd-14d8-57f4-426322b76bf2@deltatee.com>
X-Nvconfidentiality: public
Message-ID: <24e4100d-f59b-daa6-801b-28c9d062f262@nvidia.com>
Date:   Tue, 21 Apr 2020 11:18:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <02c40a96-b9dd-14d8-57f4-426322b76bf2@deltatee.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587448012; bh=XQ1Fst+62Tz5B163gJQuuOrjam2LBeO0+BsK83fBTrQ=;
        h=X-PGP-Universal:From:Subject:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JgJ2K1y3LY5LX/lo22fhUCm85jKV5jR6BtYESyAhAMbWzT/aHkLZcoktCBGI2pG17
         TPvt0B40uWPG4PuB/W61KWiTgDFv4FArWYotx9GknmEtuTNHDqLxmK5jVPmnc43L1Y
         qgcc1qHpVz6CaVkfFSV2CNJW5rwabycmHVbm5FlvavuzkYWJv26Co3IHNv+D0pflhC
         ItAhzgOU3b/YY5XtrskxkgMDY6aSSGWpp1DdEavVUAzLSCU1YNa5Xymmo7LMjC7BI/
         7faTvwNWQKtlCwy6b1gVSNX57YlfF6NZKTOonJH2NaY5xn5nyK49KSHXKv+sxFQiB3
         8FUwamF4MzC4A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/2020 10:14 PM, Logan Gunthorpe wrote:
> External email: Use caution opening links or attachments
> 
> 	
> On 2020-04-20 2:22 a.m., Abhishek Sahu wrote:
>> commit 30796e18c299 ("x86/mm: introduce __set_memory_prot()")
>> added the function __set_memory_prot() which uses pgprot_t in
>> function prototype. The currently included header files in
>> <arch/x86/include/asm/set_memory.h> do not include type name
>> pgprot_t. The pgprot_t is defined in <asm/pgtable_types.h>.
>>
>> Fixes: 30796e18c299 ("x86/mm: introduce __set_memory_prot()")
>> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
> 
> I assume this is only hit with a specific driver or something that
> includes set_memory.h without including pgtable_types.h before hand.
> 
> It certainly compiles fine for me and the kbuild robot has had lots of
> time to test it with random configs.
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

  Thanks Logan.

  Yes. The mainline is compiling fine with default config.
  This problem is coming while compiling Out of tree NVIDIA driver.
  But this problem can happen for the drivers which don't include
  <pgtable_types.h>. I am not sure if this problem will come with
  some other configs. Normally, the header files should not be
  dependent upon the callers.

  Regards,
  Abhishek 


