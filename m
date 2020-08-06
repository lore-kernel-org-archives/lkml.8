Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7552DC433EB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19DE22CE3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgHFJ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:59:31 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47241 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbgHFJ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:59:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U4udH-7_1596707952;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U4udH-7_1596707952)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Aug 2020 17:59:12 +0800
Date:   Thu, 6 Aug 2020 17:59:12 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] mm/sparse: only sub-section aligned range would be
 populated
Message-ID: <20200806095912.GA97074@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200703031828.14645-1-richard.weiyang@linux.alibaba.com>
 <20200805214955.ds7y3nwjoz2ms37h@master>
 <1c817ced-8ad9-ce91-2992-94092bc065b3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c817ced-8ad9-ce91-2992-94092bc065b3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 09:29:36AM +0200, David Hildenbrand wrote:
>On 05.08.20 23:49, Wei Yang wrote:
>> On Fri, Jul 03, 2020 at 11:18:28AM +0800, Wei Yang wrote:
>>> There are two code path which invoke __populate_section_memmap()
>>>
>>>  * sparse_init_nid()
>>>  * sparse_add_section()
>>>
>>> For both case, we are sure the memory range is sub-section aligned.
>>>
>>>  * we pass PAGES_PER_SECTION to sparse_init_nid()
>>>  * we check range by check_pfn_span() before calling
>>>    sparse_add_section()
>>>
>>> Also, the counterpart of __populate_section_memmap(), we don't do such
>>> calculation and check since the range is checked by check_pfn_span() in
>>> __remove_pages().
>>>
>>> Clear the calculation and check to keep it simple and comply with its
>>> counterpart.
>>>
>>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>>
>> 
>> Hi, Andrew,
>> 
>> Is this one picked up?
>
>I can spot it in -next via the -mm tree:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=68ad9becb23be14622e39ed36e5b0621a90a41d9
>

Thanks ;-)

Next time I would refer to this repo first.

>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
