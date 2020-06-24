Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E700FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7EEB2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405352AbgFXRCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:02:18 -0400
Received: from verein.lst.de ([213.95.11.211]:45238 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404959AbgFXRCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:02:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 65A5768BFE; Wed, 24 Jun 2020 19:02:11 +0200 (CEST)
Date:   Wed, 24 Jun 2020 19:02:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed
 fields in initializers
Message-ID: <20200624170211.GA25230@lst.de>
References: <20200618200235.1104587-1-niklas.cassel@wdc.com> <20200624164441.GA24816@lst.de> <20200624165746.GA394355@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624165746.GA394355@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 04:57:48PM +0000, Niklas Cassel wrote:
> On Wed, Jun 24, 2020 at 06:44:41PM +0200, Christoph Hellwig wrote:
> > This looks good to me, but I'd rather wait a few releases to
> > avoid too mush backporting pain.
> 
> Chaitanya made me realize that about half of the nvme functions
> are using "struct nvme_command c" on the stack, and then memsets
> it, and half of the nvme functions are using an initializer.
> 
> IMHO, using an initializer is more clear.
> 
> memset has to be used if the function needs to reset an
> existing struct, but in none of the functions that I've seen,
> are we given an existing nvme_command that we need to reset.
> All the functions that I've seen declares a new nvme_command
> on the stack (so an initializer makes more sense).
> 
> What do you think about me unifying this later on?

I like the initializers a lot.  But as I said I'd rather wait a
bit for now.
