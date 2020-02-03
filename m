Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4078DC3524B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171FE206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgBCBUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 20:20:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgBCBUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 20:20:43 -0500
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9CE820679;
        Mon,  3 Feb 2020 01:20:40 +0000 (UTC)
Subject: Re: [PATCH -v2 00/10] Rewrite Motorola MMU page-table layout
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>
References: <20200131124531.623136425@infradead.org>
 <9fe6925a-52e5-7104-dae6-3ad97c4bbecc@linux-m68k.org>
Message-ID: <d42d698c-afdf-f960-5ca7-0f9911a6c9c3@linux-m68k.org>
Date:   Mon, 3 Feb 2020 11:20:37 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9fe6925a-52e5-7104-dae6-3ad97c4bbecc@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 31/1/20 11:19 pm, Greg Ungerer wrote:
> On 31/1/20 10:45 pm, Peter Zijlstra wrote:
>> In order to faciliate Will's READ_ONCE() patches:
>>
>>    https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org
>>
>> we need to fix m68k/motorola to not have a giant pmd_t. These patches do so and
>> are tested using ARAnyM/68040.
>>
>> Michael tested the previous version on his Atari Falcon/68030.
>>
>> Build tested for sun3/coldfire.
> 
> Thanks for the quick turn around. Build looks good for me too with
> this new series. I will test on real hardware on Monday.

So this tests good for me on real hardware. I had a look over the
ColdFire changes and I have no problems with anything.
So for the ColdFire parts:

Tested-by: Greg Ungerer <gerg@linux-m68k.org>
Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


>> Please consider!
>>
>> Changes since -v1:
>>   - fixed sun3/coldfire build issues
>>   - unified motorola mmu page setup
>>   - added enum to table allocator
>>   - moved pointer table allocator to motorola.c
>>   - converted coldfire pgtable_t
>>   - fixed coldfire pgd_alloc
>>   - fixed coldfire nocache
>>
>> ---
>>   arch/m68k/include/asm/mcf_pgalloc.h      |  31 ++---
>>   arch/m68k/include/asm/motorola_pgalloc.h |  74 ++++------
>>   arch/m68k/include/asm/motorola_pgtable.h |  36 +++--
>>   arch/m68k/include/asm/page.h             |  16 ++-
>>   arch/m68k/include/asm/pgtable_mm.h       |  10 +-
>>   arch/m68k/mm/init.c                      |  34 +++--
>>   arch/m68k/mm/kmap.c                      |  36 +++--
>>   arch/m68k/mm/memory.c                    | 103 --------------
>>   arch/m68k/mm/motorola.c                  | 228 +++++++++++++++++++++++++------
>>   9 files changed, 302 insertions(+), 266 deletions(-)
>>
>>
