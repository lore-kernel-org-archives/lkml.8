Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0D2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD7B206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbgF3NgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:36:14 -0400
Received: from verein.lst.de ([213.95.11.211]:36002 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbgF3NgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:36:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 019CF68B05; Tue, 30 Jun 2020 15:36:09 +0200 (CEST)
Date:   Tue, 30 Jun 2020 15:36:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     Amit Shah <aams@amazon.de>, stable@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: validate cntlid's only for nvme >= 1.1.0
Message-ID: <20200630133609.GA20809@lst.de>
References: <20200630122923.70282-1-mheyne@amazon.de> <20200630133358.GA20602@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630133358.GA20602@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 03:33:58PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 30, 2020 at 12:29:23PM +0000, Maximilian Heyne wrote:
> > Controller ID's (cntlid) for NVMe devices were introduced in version
> > 1.1.0 of the specification. Controllers that follow the older 1.0.0 spec
> > don't set this field so it doesn't make sense to validate it. On the
> > contrary, when using SR-IOV this check breaks VFs as they are all part
> > of the same NVMe subsystem.
> > 
> > Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> > Cc: <stable@vger.kernel.org> # 5.4+
> 
> The first hunk looks ok, the second doesn't make sense as fabrics
> was only added with NVMe 1.2.2.  I can fix it up when applying if you
> are ok with that.
> 
> But you guys really shouldn't be doing SR-IOV with 1.0 controllers
> independent of this..

And actually - 1.0 did not have the concept of a subsystem.  So having
a duplicate serial number for a 1.0 controller actually is a pretty
nasty bug.  Can you point me to this broken controller?  Do you think
the OEM could fix it up to report a proper version number and controller
ID?
