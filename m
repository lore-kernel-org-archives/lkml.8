Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3400C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B10215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rfNv3rGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgIGWQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 18:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgIGWQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 18:16:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04605C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 15:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=y+jndXsSFHSqkdem4tICzGKtUuWGOW1XPa7G3+KJdlo=; b=rfNv3rGN+fxmp1UzL9RAptIeKY
        H8JJ+Aq2w9k4kpGmAAi0ZBdPgm4sZ6r/aCJzWtz5bG4AYpNDBiznLIqWgt0Y3RuZY/T0F//bbA1iX
        nY42XhJoLePtzqeCA+Pu0PE22oXzgKyj2Nk8uwf7ZT+gfQlzmGyjx7Zxbn0xiUv6QyIr4L0jNzF3R
        Odp7tj2lWjJI+zGQpipKqjtCRfs7zpAfcggfaG4IQgex8Rb5YxWdA2XcixynkdsAzm9xoBYbGE2dQ
        tSxQXNpJCQSZoHw8IDAyXMALKjRUDIosTTymQRi1aaaPyp0pKdmAL3+SWWXmz714iIWvPPFlf3uif
        jYBIqbHw==;
Received: from [2601:1c0:6280:3f0::1fce]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFPQh-0006JG-7l; Mon, 07 Sep 2020 22:16:03 +0000
Subject: Re: [PATCH] <linux/page-isolation.h>: provide stubs for
 MEMORY_ISOLATION not set (for Microblaze)
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Wen Congyang <wency@cn.fujitsu.com>,
        Michal Simek <monstr@monstr.eu>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>
References: <1f6b42e6-b6b5-40e3-92b4-77bd610d3e49@infradead.org>
 <20200907070511.GN424181@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8a1a155a-50ac-170f-13b2-01123bfc396f@infradead.org>
Date:   Mon, 7 Sep 2020 15:15:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907070511.GN424181@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/20 12:05 AM, Mike Rapoport wrote:
> Hi Randy,
> 
> On Sun, Sep 06, 2020 at 12:33:08PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build errors in Microblaze when CONFIG_MEMORY_ISOLATION is not
>> set/enabled by adding stubs for 3 missing functions.
> 
> I've tried to follow Kconfig dependencies to see how could we have both
> CONTIG_ALLOC=y and CONFIG_MEMORY_ISOLATION=n and I could not find how
> was this possible.
> 
> We have 
> 
> config CONTIG_ALLOC
> 	def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
> 
> and
> 
> config CMA
> 	bool "Contiguous Memory Allocator"
> 	depends on MMU
> 	select MIGRATION
> 	select MEMORY_ISOLATION
> 
> and alloc_contig_range() is hidden behind '#ifdef CONFIG_CONTIG_ALLOC'
> 
> In any rate, I think the better fix would be to update Kconfig
> dependencies rather than add stubs for these functions.

OK, working on that. Should have something soon.


>> Fixes these build errors:
>>
>> gcc-9.3.0-nolibc/microblaze-linux/bin/microblaze-linux-ld: mm/page_alloc.o: in function `alloc_contig_range':
>> (.text+0xa0c0): undefined reference to `start_isolate_page_range'
>> gcc-9.3.0-nolibc/microblaze-linux/bin/microblaze-linux-ld: (.text+0xa2bc): undefined reference to `test_pages_isolated'
>> gcc-9.3.0-nolibc/microblaze-linux/bin/microblaze-linux-ld: (.text+0xa378): undefined reference to `undo_isolate_page_range'
>>
>> Fixes: 0815f3d81d76 ("mm: page_isolation: MIGRATE_CMA isolation functions added") # v3.10
>> Fixes: b023f46813cd ("memory-hotplug: skip HWPoisoned page when offlining pages") # v3.10
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Michal Nazarewicz <mina86@mina86.com>
>> Cc: Wen Congyang <wency@cn.fujitsu.com>
>> Cc: Michal Simek <monstr@monstr.eu>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>> Cc: linux-mm@kvack.org
>> ---
>>  include/linux/page-isolation.h |   16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)


-- 
~Randy
