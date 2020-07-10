Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B20CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A4120708
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGJBOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:14:15 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:60272 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726311AbgGJBOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:14:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U2F61Zf_1594343650;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U2F61Zf_1594343650)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jul 2020 09:14:10 +0800
Date:   Fri, 10 Jul 2020 09:14:10 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, yang.shi@linux.alibaba.com, thomas_os@shipmail.org,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        peterx@redhat.com, aneesh.kumar@linux.ibm.com, willy@infradead.org,
        thellstrom@vmware.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Patch v4 0/4] mm/mremap: cleanup move_page_tables() a little
Message-ID: <20200710011410.GC51939@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200708095028.41706-1-richard.weiyang@linux.alibaba.com>
 <3cab86b0-586e-781b-1620-f28b00c57d44@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cab86b0-586e-781b-1620-f28b00c57d44@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 10:38:58PM +0300, Dmitry Osipenko wrote:
>08.07.2020 12:50, Wei Yang пишет:
>> move_page_tables() tries to move page table by PMD or PTE.
>> 
>> The root reason is if it tries to move PMD, both old and new range should be
>> PMD aligned. But current code calculate old range and new range separately.
>> This leads to some redundant check and calculation.
>> 
>> This cleanup tries to consolidate the range check in one place to reduce some
>> extra range handling.
>> 
>> v4:
>>   * remove a redundant parentheses pointed by Kirill
>> 
>> v3:
>>   * merge patch 1 with 2 as suggested by Kirill
>
>>   * add patch 4 to simplify the logic to calculate next and extent
>
>Hello, Wei!
>
>Unfortunately you re-introduced the offending change that was fixed in
>v2 and today's next-20200709 on ARM32 is broken once again:
>
>BUG: Bad rss-counter state mm:db85ec46 type:MM_ANONPAGES val:190
>

Ah, my bad, I forget the error we met last time. It is the different format of
pmd_addr_end.

Sorry for that.

@ Kirill

If you agree, I would leave the extent/next calculation as it is in patch 3.

>Please don't do it ;)
>
>> v2:
>>   * remove 3rd patch which doesn't work on ARM platform. Thanks report and
>>     test from Dmitry Osipenko
>> 
>> Wei Yang (4):
>>   mm/mremap: it is sure to have enough space when extent meets
>>     requirement
>>   mm/mremap: calculate extent in one place
>>   mm/mremap: start addresses are properly aligned
>>   mm/mremap: use pmd_addr_end to simplify the calculate of extent
>> 
>>  include/linux/huge_mm.h |  2 +-
>>  mm/huge_memory.c        |  8 +-------
>>  mm/mremap.c             | 27 ++++++++++-----------------
>>  3 files changed, 12 insertions(+), 25 deletions(-)
>> 

-- 
Wei Yang
Help you, Help me
