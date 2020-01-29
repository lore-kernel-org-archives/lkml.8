Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8528FC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABEE2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T97g40JJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgA2OWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:22:02 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45388 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgA2OWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:22:01 -0500
Received: by mail-lf1-f65.google.com with SMTP id 203so11967401lfa.12;
        Wed, 29 Jan 2020 06:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ngpKtKkRqA4bLgz9hqEAUDGl9vfshEKzWUpmN7kSf5I=;
        b=T97g40JJkCpTxOs4RtOf8TMHdkcMmZpyDUyvKE+M1iCiredbwhZo9f47sRYycRIOaK
         WyRyhVj0F9rXnlB6WwfXq8UStjlYgLbzIx32++G2z5paGl/dAsz2EtaxCr3Y5ZZK8HSw
         V6LFhztzhwtgeFU8H5F7qi5OTfhHx56KqIJlwD38+TRWLoR7E3wSvR2b3KBUsTlREpN1
         y6qnV/iY2W3/UwC4lELDiA8sSWsh81hoVkm/7MgRcBLLKmxtHZS1BMSVzJ3Yz8ECIyS8
         wrymSuYT9ddaYnMPBkLl/4Dx6SEHyjtfp5oxSN2GbwMxMJ7AMvnd30yLnpJ8oaO3x17Z
         AGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ngpKtKkRqA4bLgz9hqEAUDGl9vfshEKzWUpmN7kSf5I=;
        b=cyxniXOqnvtYQcyXuIwKEFlumgxJLxWHc+WSYA3pRQZEdrwEDvHu7opwzS/k8jhe5J
         PjgH7vO/LKMl3bt+ErUP1SN3+gUu1H98Rlqgp/73CXgualD5l5Mw8BV8jPhLIYpaCxjG
         /GCAHa3krPNrumUiSe9DZyaHELEF3KlIhmIWcynUjtYUtiIbPyfkhMuG9PEpDxKCXmZg
         qfbs0eIOhPp0Coi0eIOD1XFliewLX19chtIaxA3FqNTrKS0+Y8vojHoa/TMigvVvEGH/
         pXPVeD+7k8DFEG/FBBGcwdy54VcxkAscEV39j21azakfK/keJcMfjA78zB40hirLFzfw
         b1NA==
X-Gm-Message-State: APjAAAWkaL2mUGV8xUoQ/yjM4ha+LlYRgESoJu/TPxs+3Qc1Sm8t/mj/
        Tgu1VEIYx675quTwxpzJx9c=
X-Google-Smtp-Source: APXvYqzYvUkcSlNuXDwv7XdX0nVLb/c5ZJ/5O8HRyToU75dsf2h82fIfm+1f6ytmKF9sY990bRaQeg==
X-Received: by 2002:a19:cb95:: with SMTP id b143mr5622613lfg.158.1580307719408;
        Wed, 29 Jan 2020 06:21:59 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 21sm1055977ljv.19.2020.01.29.06.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 06:21:58 -0800 (PST)
Subject: Re: [PATCH 3/5] mm/mremap: use pmd_addr_end to calculate next in
 move_page_tables()
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
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
 <20200129094738.GE25745@shell.armlinux.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2791a187-ec3e-6b78-515f-25e7559a3749@gmail.com>
Date:   Wed, 29 Jan 2020 17:21:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200129094738.GE25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.01.2020 12:47, Russell King - ARM Linux admin пишет:
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
>>   BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:190
>>
>> and eventually kernel hangs.
>>
>> Git's bisection points to this patch and reverting it helps. Please fix,
>> thanks in advance.
> 
> The above is definitely wrong - pXX_addr_end() are designed to be used
> with an address index within the pXX table table and the address index
> of either the last entry in the same pXX table or the beginning of the
> _next_ pXX table.  Arbitary end address indicies are not allowed.
> 
> When page tables are "rolled up" when levels don't exist, it is common
> practice for these macros to just return their end address index.
> Hence, if they are used with arbitary end address indicies, then the
> iteration will fail.
> 
> The only way to do this is:
> 
> 	next = pmd_addr_end(old_addr,
> 			pud_addr_end(old_addr,
> 				p4d_addr_end(old_addr,
> 					pgd_addr_end(old_addr, old_end))));
> 
> which gives pmd_addr_end() (and each of the intermediate pXX_addr_end())
> the correct end argument.  However, that's a more complex and verbose,
> and likely less efficient than the current code.
> 
> I'd suggest that there's nothing to "fix" in the v5.5 code wrt this,
> and trying to "clean it up" will just result in less efficient or
> broken code.
> 

Hello Russell,

Thank you very much for the extra clarification!
