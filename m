Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF2DC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B5220737
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgICGrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 02:47:25 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:37941 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgICGrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 02:47:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U7nVAgx_1599115640;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7nVAgx_1599115640)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Sep 2020 14:47:21 +0800
Subject: Re: [PATCH v3 3/3] mm/armv6: work around armv6 cmpxchg support issue
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Russell King <linux@armlinux.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1598928612-68996-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598928612-68996-3-git-send-email-alex.shi@linux.alibaba.com>
 <ffa89b09-995a-77d8-03c6-2c1234a5474a@linux.alibaba.com>
 <20200901131749.GL14765@casper.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <5c6020c8-2fdd-13ef-0e83-bea3b32364af@linux.alibaba.com>
Date:   Thu, 3 Sep 2020 14:47:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200901131749.GL14765@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/9/1 ÏÂÎç9:17, Matthew Wilcox Ð´µÀ:
> On Tue, Sep 01, 2020 at 02:30:51PM +0800, Alex Shi wrote:
>> seems there are couples archs can not do cmpxchg1
>> So update the patch here. And it's easy to fix if more arch issue find here.
> 
>> +/*
>> + * cmpxchg only support 32-bits operands on the following archs ARMv6, SPARC32
>> + * sh2, XTENSA.
>> + */
>> +#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_SH2) || \
>> +	defined(CONFIG_SPARC32) || defined(CONFIG_XTENSA)
> 
> Looks like we need a HAVE_CMPXCHG_BYTE in Kconfig to parallel
> HAVE_CMPXCHG_DOUBLE.
> 

Thanks for reminder! Compare the HAVE_CMPXCHG_BYTE, NO_CMPXCHG_BYTE would be
better for less code change. 

I will send the v4 for a bit more change on patch 2.

Thanks!
Alex
