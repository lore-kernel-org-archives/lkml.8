Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14CBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 872E52080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgHRPvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:51:08 -0400
Received: from verein.lst.de ([213.95.11.211]:34034 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgHRPuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:50:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C273F68AFE; Tue, 18 Aug 2020 17:50:04 +0200 (CEST)
Date:   Tue, 18 Aug 2020 17:50:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Javier Gonzalez <javier@javigon.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
        Damien.LeMoal@wdc.com, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        johannes.thumshirn@wdc.com, Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818155004.GA26688@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com> <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de> <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:50:33AM +0200, Javier Gonzalez wrote:
> I understand that the NVMe process was agitated and that the current ZNS
> implementation in Linux relies in append support from the device
> perspective. However, the current TP does allow for not implementing
> append, and a number of customers are requiring the use of normal
> writes, which we want to support.

The NVMe TPs allow for lots of things, but that doesn't mean we have
to support it.

> Do you have any early suggestion on how you this patch should look like
> to be upstreamable?

My position is that at this point in time we should not consider it.
Zone Append is the major feature in ZNS that solves the issue in ZAC/ZBC.
I want to see broad industry support for it instead of having to add more
code just for zone append emulation than actual current ZNS support.  If
in a few years the market place has decided and has lots of drives
available in the consuer market or OEM channels we'll have to reconsider
and potentially merge Zone Append emulation.  But my deep hope is that
this does not happen, as it sets us back 10 years in the standards of
zoned storage support again.
