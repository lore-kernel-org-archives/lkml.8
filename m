Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E6DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C03D20738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbgFXCHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 22:07:20 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:58738 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730898AbgFXCHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:07:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U0YisOY_1592964436;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U0YisOY_1592964436)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Jun 2020 10:07:16 +0800
Date:   Wed, 24 Jun 2020 10:07:16 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nvme-pci: Add controller memory buffer supported
 macro
Message-ID: <20200624020716.GB40094@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <eab18c7696ea0e34a6ab0371d7d17ad45d1566ce.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200623162751.GA4846@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623162751.GA4846@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 06:27:51PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 23, 2020 at 09:24:33PM +0800, Baolin Wang wrote:
> > Introduce a new capability macro to indicate if the controller
> > supports the memory buffer or not, instead of reading the
> > NVME_REG_CMBSZ register.
> 
> This is a complex issue.  The CMBS bit was only added in NVMe 1.4 as
> a backwards incompatible change, as the CMB addressing scheme can lead

Ah, right, I think I should add another version condition:
if ((ctrl->vs >= NVME_VS(1, 4, 0) && !NVME_CAP_CMBS(dev->ctrl.cap)) ||
    dev->cmb_size)
    return;

> to data corruption.  The CMBS was added as part of the horribe hack
> that also involves the CBA field, which we'll need to see before
> using it to work around the addressing issue.  At the same time we
> should also continue supporting the legacy pre-1.4 CMB with a warning
> (and may reject it if we know we run in a VM).

Thanks for your explanation. I saw we've added an CMB sysfs attribute
to get the CMB location and size if we enabled CMB, so should we still
add some information in nvme_map_cmb() let user know explicitly?

dev_info(dev->ctrl.device, "Registered the CMB, bar=0x%x, size=%lld\n", bar,
size);

