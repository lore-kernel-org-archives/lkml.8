Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87778C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9FB204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHYCLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:11:34 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:53914 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgHYCLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:11:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U6n3GN5_1598321489;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U6n3GN5_1598321489)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Aug 2020 10:11:29 +0800
Date:   Tue, 25 Aug 2020 10:11:29 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v2 02/10] mm/memory_hotplug: enforce section granularity
 when onlining/offlining
Message-ID: <20200825021129.GA78808@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200819175957.28465-1-david@redhat.com>
 <20200819175957.28465-3-david@redhat.com>
 <20200824103917.GB6315@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824103917.GB6315@linux>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 12:39:18PM +0200, Oscar Salvador wrote:
>On Wed, Aug 19, 2020 at 07:59:49PM +0200, David Hildenbrand wrote:
>> Already two people (including me) tried to offline subsections, because
>> the function looks like it can deal with it. But we really can only
>> online/offline full sections that are properly aligned (e.g., we can only
>> mark full sections online/offline via SECTION_IS_ONLINE).
>> 
>> Add a simple safety net to document the restriction now. Current users
>> (core and powernv/memtrace) respect these restrictions.
>
>It's been a while since I looked at sub-section handling stuff so sorry to ask
>this, but was it true that we can hot-{remove,add} sub-section granularity, while
>we can only online /offline on section granularity?
>

Seems you are right.

>> 
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
>
>-- 
>Oscar Salvador
>SUSE L3

-- 
Wei Yang
Help you, Help me
