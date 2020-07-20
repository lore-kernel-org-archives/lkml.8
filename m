Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06838C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC82722C9C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgGTOJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:09:11 -0400
Received: from verein.lst.de ([213.95.11.211]:47155 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTOJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:09:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 94C3F68BFE; Mon, 20 Jul 2020 16:09:08 +0200 (CEST)
Date:   Mon, 20 Jul 2020 16:09:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v15 5/9] nvme-core: Introduce nvme_ctrl_get_by_path()
Message-ID: <20200720140908.GE4627@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com> <20200716203319.16022-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716203319.16022-6-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 02:33:15PM -0600, Logan Gunthorpe wrote:
> nvme_ctrl_get_by_path() is analagous to blkdev_get_by_path() except it
> gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
> It makes use of filp_open() to open the file and uses the private
> data to obtain a pointer to the struct nvme_ctrl. If the fops of the
> file do not match, -EINVAL is returned.
> 
> The purpose of this function is to support NVMe-OF target passthru.

This looks generally good.  However since the early days of this
patchset we've grown symbol namespaces, and the EXPORT_SYMBOL_NS_GPL
macro, which are what we really should use here and for the other
exports.
