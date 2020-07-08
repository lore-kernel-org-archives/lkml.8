Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAD2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1176120786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgGHGRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:17:24 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:50124 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbgGHGRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:17:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U25UIeZ_1594189040;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U25UIeZ_1594189040)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Jul 2020 14:17:20 +0800
Date:   Wed, 8 Jul 2020 14:17:20 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: use standard block status symbolic names to
 check return value
Message-ID: <20200708061720.GB69823@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <e993c13466075f6dbae1285e4db55fd16276ff14.1594174565.git.baolin.wang@linux.alibaba.com>
 <20200708050900.GA3831@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708050900.GA3831@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 07:09:00AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 08, 2020 at 10:18:01AM +0800, Baolin Wang wrote:
> > It's better to use the same symbol as the return to check return value,
> > and will always work in the unlikely event that the defines are reordered.
> > 
> > Suggested-by: Keith Busch <kbusch@kernel.org>
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> I'm really not sure this is worth it.  When designing the blk_status_t
> type keeping 0 as was a deliberate design decision.

OK. But there are some places use the BLK_STS_OK to validate, and some
places not in this driver, so I think we should keep code consistent?

