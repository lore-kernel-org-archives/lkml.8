Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0BBC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154972253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAUDkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 22:40:45 -0500
Received: from foss.arm.com ([217.140.110.172]:37984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgAUDko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 22:40:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C9BB31B;
        Mon, 20 Jan 2020 19:40:44 -0800 (PST)
Received: from [10.162.16.78] (p8cg001049571a15.blr.arm.com [10.162.16.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DF413F6C4;
        Mon, 20 Jan 2020 19:40:41 -0800 (PST)
Subject: Re: [PATCH v4] mm/mempolicy,hugetlb: Checking hstate for hugetlbfs
 page in vma_migratable
To:     Michal Hocko <mhocko@kernel.org>,
        Li Xinhai <lixinhai.lxh@gmail.com>
Cc:     n-horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        akpm <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <1579147885-23511-1-git-send-email-lixinhai.lxh@gmail.com>
 <20200116095614.GO19428@dhcp22.suse.cz> <20200116215032206994102@gmail.com>
 <20200116151803.GV19428@dhcp22.suse.cz> <20200116233817972969139@gmail.com>
 <20200117111629898234212@gmail.com> <20200118111121432688303@gmail.com>
 <20200120101202.GU18451@dhcp22.suse.cz> <20200120233723466954346@gmail.com>
 <20200120160500.GM18451@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <3cef881e-8685-4917-1784-286dc3b11bf6@arm.com>
Date:   Tue, 21 Jan 2020 09:12:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200120160500.GM18451@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/20/2020 09:35 PM, Michal Hocko wrote:
> On Mon 20-01-20 23:37:25, Li Xinhai wrote:
> [...]
>> Changelog is updated as below, thanks for comments:
>> ---
>> mm/mempolicy: Checking hugepage migration is supported by arch in vma_migratable
>>
>> vma_migratable() is called to check if pages in vma can be migrated
>> before go ahead to further actions. Currently it is used in below code
>> path:
>> - task_numa_work
>> - mbind
>> - move_pages
>>
>> For hugetlb mapping, whether vma is migratable or not is determined by:
>> - CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>> - arch_hugetlb_migration_supported
>>
>> Issue: current code only checks for CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION,
>> which express less accurate semantics of vma_migratable(). (note that
>> current code in vma_migratable don't cause failure or bug because
>> unmap_and_move_huge_page() will catch unsupported hugepage and handle it
>> properly)
>>
>> This patch checks the two factors for impoveing code logic and
>> robustness. It will enable early bail out of hugepage migration procedure,
>> but because currently all architecture supporting hugepage migration is able
>> to support all page size, we would not see performance gain with this patch
>> applied.
> 
> This looks definitely better than the original one. I hope it is more
> clear to you what I meant by a better description for the justification.
> I would just add that the no code should use
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION directly and use
> arch_hugetlb_migration_supported instead. This will be the case after
> this patch.

As I have mentioned previously on the other thread, there might be an case
to keep the existing code (just added with a comment) which will preserve
the performance. But the proposed method will do it the right way and also
get rid of CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION here. Its OK either way.

> 
> Please keep in mind that changelogs are really important and growing in
> importance as the code gets more complicated over time. It is much more
> easier to see what the patch does because reading diffs and the code is
> easy but the lack of motivation is what people usually fighting with.
> 
