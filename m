Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEF6C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415BA20722
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QNI5HP0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgICRbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:31:48 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8183 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICRbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:31:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5128740001>; Thu, 03 Sep 2020 10:31:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 10:31:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 03 Sep 2020 10:31:46 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 17:31:45 +0000
Subject: Re: [PATCH 1/2] arm64/mm: Change THP helpers to comply with generic
 MM semantics
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
CC:     <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <will@kernel.org>, <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        <linux-kernel@vger.kernel.org>
References: <1597655984-15428-1-git-send-email-anshuman.khandual@arm.com>
 <1597655984-15428-2-git-send-email-anshuman.khandual@arm.com>
 <20200903165631.GC31409@gaia>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <5e148194-58c2-89c2-2cd8-9f2086f1e090@nvidia.com>
Date:   Thu, 3 Sep 2020 10:31:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200903165631.GC31409@gaia>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599154292; bh=f2fM2vwocWZ3kjufXMQxbdqVic6XFgHZzhjDyCnkunM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QNI5HP0mnE11hwdtt//Zo7KAtHH9mutFkC4v29SLNtD3RB0sKvljOyjJnoPg+nCNM
         g+qnLvvVo8HmZ/lXWGqm0dCvXsip0qT67hm2Pi5MyMMb9CeerPM3SMY1oBZWFU+GLi
         iDyu+m1RiBar/mNEX68xxKokJtsOiKYauiJaX5OpW5taL58vgmY+vUh/oPN/eVXnZr
         r2yFhkOEOz1gESPASBuELH47vVnksoAmeTIpU8qRKYseB7Ky2Jj9MQZDLq/lb7VWla
         m5aCR0YsGQSuBd26pUDXoM3Ji2XbK+mMbD797bTL+BujGtVTSA4uXS6c5OA64PUjX/
         0nR2261UeRJRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/3/20 9:56 AM, Catalin Marinas wrote:
> On Mon, Aug 17, 2020 at 02:49:43PM +0530, Anshuman Khandual wrote:
>> pmd_present() and pmd_trans_huge() are expected to behave in the following
>> manner during various phases of a given PMD. It is derived from a previous
>> detailed discussion on this topic [1] and present THP documentation [2].
>>
>> pmd_present(pmd):
>>
>> - Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
>> - Returns false if pmd does not refer to system RAM - Invalid pmd_page(pmd)
> 
> The second bullet doesn't make much sense. If you have a pmd mapping of
> some I/O memory, pmd_present() still returns true (as does
> pte_present()).
> 
>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>> index 4d867c6446c4..28792fdd9627 100644
>> --- a/arch/arm64/include/asm/pgtable-prot.h
>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>> @@ -19,6 +19,13 @@
>>   #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
>>   #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
>>   
>> +/*
>> + * This help indicate that the entry is present i.e pmd_page()
> 
> Nit: add another . after i.e

Another nit: "This help indicate" => "This helper indicates"

Maybe I should look at the series more. :-)
