Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D97C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA3A20738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHSHkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:40:39 -0400
Received: from verein.lst.de ([213.95.11.211]:36564 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgHSHkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:40:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 910686736F; Wed, 19 Aug 2020 09:40:35 +0200 (CEST)
Date:   Wed, 19 Aug 2020 09:40:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Javier Gonzalez <javier@javigon.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
        Damien.LeMoal@wdc.com, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        johannes.thumshirn@wdc.com, Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200819074035.GA21991@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com> <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de> <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local> <20200818155004.GA26688@lst.de> <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 08:04:28PM +0200, Javier Gonzalez wrote:
> I understand that you want vendor alignment in the NVMe driver and I
> agree. We are not pushing for a non-append model - you can see that we
> are investing effort in implementing the append path in thee block layer
> and io_uring and we will continue doing so as patches get merged.
>
> This said, we do have some OEM models that do not implement append and I
> would like them to be supported in Linux. As you know, new TPs are being
> standardized now and the append emulation is the based for adding
> support for this. I do not believe it is unreasonable to find a way to
> add support for this SSDs.

I do not think we should support anything but Zone Append, especially not
the new TP, which is going to add even more horrible code for absolutely
no good reason.

> If you completely close the door this approach, the alternative is
> carrying off-tree patches to the several OEMs that use these devices.
> This is not good for the zoned ecosystem nor for the future of Zone
> Append.

I really don't have a problem with that.  If these OEMs want to use
an inferior access model only, they have to pay the price for it.
I also don't think that proxy arguments are very useful.  If you OEMs
are troubled by carrying patches becomes they decided to buy inferior
drivers they are perfectly happy to argue their cause here on the list.

> Are you open to us doing some characterization and if the impact
> to the fast path is not significant, moving ahead to a Zone Append
> emulation like in SCSI? I will promise that we will remove this path if
> requests for these devices terminate.

As said I do not think implementing zone append emulation or the TP that
shall not be named are a good idea for Linux.
