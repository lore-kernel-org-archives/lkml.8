Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF85DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9FC207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgA1X25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:28:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:47301 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgA1X25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:28:57 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 15:28:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,375,1574150400"; 
   d="scan'208";a="261613284"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2020 15:28:54 -0800
Date:   Wed, 29 Jan 2020 07:29:07 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, kirill@shutemov.name,
        yang.shi@linux.alibaba.com, thellstrom@vmware.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] mm/mremap: use pmd_addr_end to calculate next in
 move_page_tables()
Message-ID: <20200128232907.GA11467@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200117232254.2792-1-richardw.yang@linux.intel.com>
 <20200117232254.2792-4-richardw.yang@linux.intel.com>
 <7147774a-14e9-4ff3-1548-4565f0d214d5@gmail.com>
 <20200128004301.GD20624@richard>
 <d66bb20e-c0e7-caef-cbbc-aa216c2be7d6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d66bb20e-c0e7-caef-cbbc-aa216c2be7d6@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 06:59:48PM +0300, Dmitry Osipenko wrote:
>28.01.2020 03:43, Wei Yang пишет:
>> On Sun, Jan 26, 2020 at 05:47:57PM +0300, Dmitry Osipenko wrote:
>>> 18.01.2020 02:22, Wei Yang пишет:
>>>> Use the general helper instead of do it by hand.
>>>>
>>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>>> ---
>>>>  mm/mremap.c | 7 ++-----
>>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/mm/mremap.c b/mm/mremap.c
>>>> index c2af8ba4ba43..a258914f3ee1 100644
>>>> --- a/mm/mremap.c
>>>> +++ b/mm/mremap.c
>>>> @@ -253,11 +253,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>>>>  
>>>>  	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
>>>>  		cond_resched();
>>>> -		next = (old_addr + PMD_SIZE) & PMD_MASK;
>>>> -		/* even if next overflowed, extent below will be ok */
>>>> +		next = pmd_addr_end(old_addr, old_end);
>>>>  		extent = next - old_addr;
>>>> -		if (extent > old_end - old_addr)
>>>> -			extent = old_end - old_addr;
>>>>  		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
>>>>  		if (!old_pmd)
>>>>  			continue;
>>>> @@ -301,7 +298,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>>>>  
>>>>  		if (pte_alloc(new_vma->vm_mm, new_pmd))
>>>>  			break;
>>>> -		next = (new_addr + PMD_SIZE) & PMD_MASK;
>>>> +		next = pmd_addr_end(new_addr, new_addr + len);
>>>>  		if (extent > next - new_addr)
>>>>  			extent = next - new_addr;
>>>>  		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
>>>>
>>>
>>> Hello Wei,
>>>
>>> Starting with next-20200122, I'm seeing the following in KMSG on NVIDIA
>>> Tegra (ARM32):
>>>
>>>  BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:190
>>>
>> 
>> Thanks.
>> 
>> Would you mind letting me know which case you are testing?
>
>Nothing special, systemd starts to fall apart during boot.
>
>> Or the special thing is 32-bit platform?
>I have a limited knowledge about mm/, so can't provide detailed explanation.
>
>Please take a look at this:
>
>[1]
>https://elixir.bootlin.com/linux/v5.5/source/arch/arm/include/asm/pgtable-2level.h#L210
>
>[2]
>https://elixir.bootlin.com/linux/v5.5/source/include/asm-generic/pgtable.h#L549
>
>[3]
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c0ba10b512eb2e2a3888b6e6cc0e089f5e7a191b

Thanks, I see the difference here.

If this is the case, we can't use pmd_addr_end() to simplify the calculation.
This changes the behavior.

I would prepare another patch set to fix this. Would you mind helping me
verify on your platform?

-- 
Wei Yang
Help you, Help me
