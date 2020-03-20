Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C575BC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 19:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9745320739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 19:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Tel2JQH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCTTuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 15:50:05 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14131 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgCTTuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 15:50:05 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e751e090004>; Fri, 20 Mar 2020 12:48:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 20 Mar 2020 12:50:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 20 Mar 2020 12:50:04 -0700
Received: from [10.2.57.131] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Mar
 2020 19:50:04 +0000
Subject: Re: [PATCH] x86/mm: Make pud_present() check _PAGE_PROTNONE and
 _PAGE_PSE as well
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <linux-mm@kvack.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <1584507679-11976-1-git-send-email-anshuman.khandual@arm.com>
 <c03165c8-6d44-49c2-2dad-a85759200718@arm.com>
 <20200320114741.c62iolt2yzltnscf@box>
 <2e7a04cf-80cb-58c1-7344-2f8422ed7d31@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <082aae4a-b190-7b54-eda9-0bbc28c8a6b3@nvidia.com>
Date:   Fri, 20 Mar 2020 12:50:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2e7a04cf-80cb-58c1-7344-2f8422ed7d31@arm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584733705; bh=eMx7zJHblAy5+YXR6qnBGnBggweRnlFVeODh2DtisrU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Tel2JQH66ScF35HhrWYTgNQPP1AMRuVM4bvqwSSCBmgG15W1HzJ865N1Qi6NhkqsQ
         woGCQZujdfF6ZIip99vvJBaU5dDWbVtk8VH6TrI7rQ9NbZef+wNBXpkIRTVF22NV5O
         DdiyvOMXxmjF10pBRS25AJ0le5iUdr8U4HqAZQ1+mEp9OAH/lpnYZm8jqp0jtIKX8y
         31/DhZyGPocZEe/XRi/zCkNQvP208imeKhlFzHwR1bTNk6xXX8xx/6zjJgtBRpjYV3
         +um0XPIw+9MhAznV0GwYZZG9146hF/ek7V/WsEFcK+FNqBWLrJ3hk7tFHVapD37Wd0
         NJivdmuFNik6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/20 6:22 AM, Anshuman Khandual wrote:
...
>>> +Cc: Kirill A. Shutemov <kirill@shutemov.name>
>>> +Cc: Dan Williams <dan.j.williams@intel.com>
>>
>> Or we can just drop the pud_mknotpresent(). There's no users AFAICS and
>> only x86 provides it.

+1

> 
> Yes that will be an option but IMHO fixing pud_present() here might be
> a better choice because,
> 
> (1) pud_mknotpresent() with fixed pud_present() might be required later


It might. Or it might not. Let's wait until it's actually used, and see.
Dead code is an avoidable expense (adds size, space on the screen, email
traffic and other wasted time), so let's avoid it here.


> (2) PMD & PUD will be exact same (THP is supported on either level)
> 
> Nonetheless, I am happy to go either way.
> 


thanks,
-- 
John Hubbard
NVIDIA
