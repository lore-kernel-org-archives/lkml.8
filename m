Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64086C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E7520720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgGHFJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 01:09:04 -0400
Received: from verein.lst.de ([213.95.11.211]:33535 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbgGHFJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 01:09:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 00ABF68AFE; Wed,  8 Jul 2020 07:09:00 +0200 (CEST)
Date:   Wed, 8 Jul 2020 07:09:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: use standard block status symbolic names to
 check return value
Message-ID: <20200708050900.GA3831@lst.de>
References: <e993c13466075f6dbae1285e4db55fd16276ff14.1594174565.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e993c13466075f6dbae1285e4db55fd16276ff14.1594174565.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 10:18:01AM +0800, Baolin Wang wrote:
> It's better to use the same symbol as the return to check return value,
> and will always work in the unlikely event that the defines are reordered.
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

I'm really not sure this is worth it.  When designing the blk_status_t
type keeping 0 as was a deliberate design decision. 
