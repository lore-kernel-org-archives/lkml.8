Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13D9C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73D620714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgGZPlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 11:41:08 -0400
Received: from verein.lst.de ([213.95.11.211]:40734 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgGZPlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:41:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BDBB068B05; Sun, 26 Jul 2020 17:41:04 +0200 (CEST)
Date:   Sun, 26 Jul 2020 17:41:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v16 6/9] nvmet-passthru: Add passthru code to process
 commands
Message-ID: <20200726154104.GA23930@lst.de>
References: <20200724172520.16318-1-logang@deltatee.com> <20200724172520.16318-7-logang@deltatee.com> <20200724193351.GA2857771@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724193351.GA2857771@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 12:33:51PM -0700, Keith Busch wrote:
> On Fri, Jul 24, 2020 at 11:25:17AM -0600, Logan Gunthorpe wrote:
> > +	/*
> > +	 * The passthru NVMe driver may have a limit on the number of segments
> > +	 * which depends on the host's memory fragementation. To solve this,
> > +	 * ensure mdts is limitted to the pages equal to the number of
> 
>                           limited

I've fixed this when applying.

> > +	/* don't support fuse commands */
> > +	id->fuses = 0;
> 
> If a host were to set a fuse, the target should return an Invalid Field
> error. Just to future-proof, rejecting commands with any flags set
> (other than SGL, which you handled in patch 1/9) is probably what should
> happen, like:
> 
> > +u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req)
> > +{
> 
> 	if (req->cmd->common.flags & ~NVME_CMD_SGL_ALL)
> 		return NVME_SC_INVALID_FIELD;
> 
> Or maybe we could obviate the need for 1/9 with something like:
> 
> 	req->cmd->common.flags &= ~NVME_CMD_SGL_ALL;
> 	if (req->cmd->common.flags)
> 		return NVME_SC_INVALID_FIELD;

We'll also need this for the admin commands, but otherwise this sounds
like a good idea.  For now I've applied the series as-is, but an
incremental patch for this would be nice.
