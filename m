Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FFFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CBC2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHTCPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:15:35 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:35534 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbgHTCPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 22:15:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U6GzjvK_1597889732;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U6GzjvK_1597889732)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 20 Aug 2020 10:15:32 +0800
Date:   Thu, 20 Aug 2020 10:15:31 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/mmap: rename __vma_unlink_common() to
 __vma_unlink()
Message-ID: <20200820021531.GA51743@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200809232057.23477-1-richard.weiyang@linux.alibaba.com>
 <20200819131210.dc5c045a626d1bf4475214d1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819131210.dc5c045a626d1bf4475214d1@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 01:12:10PM -0700, Andrew Morton wrote:
>On Mon, 10 Aug 2020 07:20:56 +0800 Wei Yang <richard.weiyang@linux.alibaba.com> wrote:
>
>> __vma_unlink_common() and __vma_unlink() are counterparts. Since there is
>
>I assume you meant "__vma_link()" here?
>

Oops, my fault. You are right.

Do you prefer a v2, or you would like to fix it online?

>> not function named __vma_unlink(), let's rename it to __vma_unlink() to
>> make the code more self-explain and easy for audience to understand.
>> 
>> Otherwise we may expect there are several variants of vma_unlink and
>> __vma_unlink_common() is used by them.

-- 
Wei Yang
Help you, Help me
