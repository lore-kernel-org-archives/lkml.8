Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54547C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357E920663
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgGHBZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 21:25:27 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:15597 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728208AbgGHBZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 21:25:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U243BBC_1594171524;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U243BBC_1594171524)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Jul 2020 09:25:25 +0800
Date:   Wed, 8 Jul 2020 09:25:24 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] nvme-pci: Use standard block status macro
Message-ID: <20200708012524.GA117160@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <a14bca482584d912d72209c6edab6b77b1a924f2.1593743937.git.baolin.wang@linux.alibaba.com>
 <20200707190123.GB1997220@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707190123.GB1997220@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 12:01:23PM -0700, Keith Busch wrote:
> On Fri, Jul 03, 2020 at 10:49:24AM +0800, Baolin Wang wrote:
> >  static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
> > @@ -844,7 +844,7 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
> >  	if (dma_mapping_error(dev->dev, iod->meta_dma))
> >  		return BLK_STS_IOERR;
> >  	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
> > -	return 0;
> > +	return BLK_STS_OK;
> >  }
> 
> This is fine, though it takes knowing that this value is 0 for the
> subsequent 'if (!ret)' check to make sense. Maybe those should change to
> 'if (ret != BLK_STS_OK)' so the check uses the same symbol as the
> return, and will always work in the unlikely event that the defines
> are reordered.

Okay, I will send another patch to convert to 'if (ret != BLK_STS_OK)'
validation. Thanks.

