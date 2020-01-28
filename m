Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1539BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD1F24683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIAeCkFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgA1P7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:59:55 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:35307 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgA1P7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:59:55 -0500
Received: by mail-il1-f194.google.com with SMTP id g12so11072436ild.2;
        Tue, 28 Jan 2020 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w4ohonp6++tc7WV/sPZwKkfZN7aW1XO2ASROEv1nRiU=;
        b=lIAeCkFhXtKcaKTzDLsiXbW2Ul2ROk9tb5PwiMDl/qJCGJ+ZSMAIZoTnpN8/KjHmuX
         SxlWPSts47s3FdhN9qe/baojNFdM5XSVtWYqE36fQmaZ25sLCxCD3MZbBrRjSaI+iQWK
         PlR/1AkzKpzTO4qNV7w57wm3961oum3bDHlO5GyL25C09Ec+87//WpH+YDxd80rhkqXr
         6I4Hm3J2nwoHXsQODKt+oEjzDYJJcVkKYNBeG/Q4nl/Qd/MFXh9ia5l6qmfIRqYWr/7s
         Q5SxKAzQ/giBRAgiB8iPG8CiaU57GF9fu98xJknuguPQs9aWZVc7+D6RGo7hieBAeDDH
         +LnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w4ohonp6++tc7WV/sPZwKkfZN7aW1XO2ASROEv1nRiU=;
        b=Te/GqH4Z4l1KApq1vIzGF+aH5pHvcUXNa7aA9XSnxUSBL1fPbblopC66BiSahb9mc3
         M49see/2mZzONBh51bcMhzEsgN5Y7/MHTNtQlM1MkyXYnYwNh+s42U04qq/gJq+4uMuh
         v2xcy9EjMUd01cUu21NMUUZJsZHd+5OH5Ec77724L5jmLEv/tZTUgR1vi/Sc6t5Yj/F8
         HqGG90BGm/cECGxm2yPCvyliaT7hfh05PSWJzVHvHJ6A+n17DPOHyxUPDQzLzoTn0z9I
         7Tiu+QWFM3L8QpBP7AJ3SEeRPj/YwhC61ZWM1N6otrI6qXKC6vTzNER/aGxE1EtqYpx8
         +cKQ==
X-Gm-Message-State: APjAAAWkfmp7ZRdKVrjEJ8teSeLvgKYFL/bfGgNunDz1gVTxkNQjHnY9
        6pc7xG5SRbAGzBGK9OqaqHE=
X-Google-Smtp-Source: APXvYqwEH+xXx7KfDR76ROthSQWmNYsqJe8W5aR8XGWqgGAr0ee4xhb+Ck7XnHVGnn3Ly4TJztRBFg==
X-Received: by 2002:a92:3cc3:: with SMTP id j64mr12118361ilf.160.1580227194744;
        Tue, 28 Jan 2020 07:59:54 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e23sm1828838ild.37.2020.01.28.07.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 07:59:54 -0800 (PST)
Subject: Re: [PATCH 3/5] mm/mremap: use pmd_addr_end to calculate next in
 move_page_tables()
To:     Wei Yang <richardw.yang@linux.intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, kirill@shutemov.name,
        yang.shi@linux.alibaba.com, thellstrom@vmware.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200117232254.2792-1-richardw.yang@linux.intel.com>
 <20200117232254.2792-4-richardw.yang@linux.intel.com>
 <7147774a-14e9-4ff3-1548-4565f0d214d5@gmail.com>
 <20200128004301.GD20624@richard>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d66bb20e-c0e7-caef-cbbc-aa216c2be7d6@gmail.com>
Date:   Tue, 28 Jan 2020 18:59:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200128004301.GD20624@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.01.2020 03:43, Wei Yang пишет:
> On Sun, Jan 26, 2020 at 05:47:57PM +0300, Dmitry Osipenko wrote:
>> 18.01.2020 02:22, Wei Yang пишет:
>>> Use the general helper instead of do it by hand.
>>>
>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>> ---
>>>  mm/mremap.c | 7 ++-----
>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/mm/mremap.c b/mm/mremap.c
>>> index c2af8ba4ba43..a258914f3ee1 100644
>>> --- a/mm/mremap.c
>>> +++ b/mm/mremap.c
>>> @@ -253,11 +253,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>>>  
>>>  	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
>>>  		cond_resched();
>>> -		next = (old_addr + PMD_SIZE) & PMD_MASK;
>>> -		/* even if next overflowed, extent below will be ok */
>>> +		next = pmd_addr_end(old_addr, old_end);
>>>  		extent = next - old_addr;
>>> -		if (extent > old_end - old_addr)
>>> -			extent = old_end - old_addr;
>>>  		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
>>>  		if (!old_pmd)
>>>  			continue;
>>> @@ -301,7 +298,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>>>  
>>>  		if (pte_alloc(new_vma->vm_mm, new_pmd))
>>>  			break;
>>> -		next = (new_addr + PMD_SIZE) & PMD_MASK;
>>> +		next = pmd_addr_end(new_addr, new_addr + len);
>>>  		if (extent > next - new_addr)
>>>  			extent = next - new_addr;
>>>  		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
>>>
>>
>> Hello Wei,
>>
>> Starting with next-20200122, I'm seeing the following in KMSG on NVIDIA
>> Tegra (ARM32):
>>
>>  BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:190
>>
> 
> Thanks.
> 
> Would you mind letting me know which case you are testing?

Nothing special, systemd starts to fall apart during boot.

> Or the special thing is 32-bit platform?
I have a limited knowledge about mm/, so can't provide detailed explanation.

Please take a look at this:

[1]
https://elixir.bootlin.com/linux/v5.5/source/arch/arm/include/asm/pgtable-2level.h#L210

[2]
https://elixir.bootlin.com/linux/v5.5/source/include/asm-generic/pgtable.h#L549

[3]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c0ba10b512eb2e2a3888b6e6cc0e089f5e7a191b
