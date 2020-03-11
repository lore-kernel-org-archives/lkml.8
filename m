Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B289CC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3557020736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgCKRX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:23:26 -0400
Received: from verein.lst.de ([213.95.11.211]:60541 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730195AbgCKRX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:23:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 41D1068B05; Wed, 11 Mar 2020 18:23:24 +0100 (CET)
Date:   Wed, 11 Mar 2020 18:23:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org,
        aros@gmx.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] device core: fix dma_mask handling in
 platform_device_register_full
Message-ID: <20200311172324.GA26483@lst.de>
References: <20200311160710.376090-1-hch@lst.de> <20200311161423.GA3941932@kroah.com> <20200311161551.GA24878@lst.de> <20200311171802.GA3952198@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311171802.GA3952198@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 06:18:02PM +0100, Greg KH wrote:
> > Sorry, here it is:
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Is this still needed with the patch that Linus just committed to his
> tree?

No.
