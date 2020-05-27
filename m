Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719B2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F47A20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390688AbgE0Pzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:55:32 -0400
Received: from foss.arm.com ([217.140.110.172]:40716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390665AbgE0Pza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:55:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EFE430E;
        Wed, 27 May 2020 08:55:29 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E51693F52E;
        Wed, 27 May 2020 08:55:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] x86: mm: ptdump: Calculate effective permissions
 correctly
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20200521152308.33096-1-steven.price@arm.com>
 <20200521152308.33096-2-steven.price@arm.com>
 <5a7fc0d5-14c5-d263-daf1-bf81da30d91e@suse.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <9aafccf1-0995-bea5-c814-c8cd9d719d12@arm.com>
Date:   Wed, 27 May 2020 16:55:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5a7fc0d5-14c5-d263-daf1-bf81da30d91e@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2020 16:15, Jan Beulich wrote:
> On 21.05.2020 17:23, Steven Price wrote:
>> By switching the x86 page table dump code to use the generic code the
>> effective permissions are no longer calculated correctly because the
>> note_page() function is only called for *leaf* entries. To calculate the
>> actual effective permissions it is necessary to observe the full
>> hierarchy of the page tree.
>>
>> Introduce a new callback for ptdump which is called for every entry and
>> can therefore update the prot_levels array correctly. note_page() can
>> then simply access the appropriate element in the array.
>>
>> Reported-by: Jan Beulich <jbeulich@suse.com>
>> Fixes: 2ae27137b2db ("x86: mm: convert dump_pagetables to use walk_page_range")
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> This (with the later correction) and the 2nd patch
> Tested-by: Jan Beulich <jbeulich@suse.com>
> 
> It allowed me to go and finally find why under Xen there was still
> a single W+X mapping left - another bug, another patch.
> 
> Thanks, Jan
> 

Thanks for testing (and sorry for breaking it in the first place)!

Steve
