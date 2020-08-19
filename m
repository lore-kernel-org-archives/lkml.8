Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6457FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49619206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgHSKnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:43:55 -0400
Received: from verein.lst.de ([213.95.11.211]:37169 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgHSKnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:43:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F273367357; Wed, 19 Aug 2020 12:43:49 +0200 (CEST)
Date:   Wed, 19 Aug 2020 12:43:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Javier Gonzalez <javier@javigon.com>,
        Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200819104349.GA2697@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com> <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de> <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local> <20200818155004.GA26688@lst.de> <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain> <20200819074035.GA21991@lst.de> <20200819083353.rwblagiesocfcq7i@mpHalley.local> <CY4PR04MB3751DE6CEB9C233BF7C9D86AE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751DE6CEB9C233BF7C9D86AE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 09:14:13AM +0000, Damien Le Moal wrote:
> While defining a zone append command for SCSI/ZBC is possible (using sense data
> for returning the written offset), there is no way to define zone append for
> SATA/ZAC without entirely breaking the ATA command model. This is why we went
> after an emulation implementation instead of trying to standardized native
> commands. That implementation does not have any performance impact over regular
> writes *and* zone write locking does not in general degrade HDD write
> performance (only a few corner cases suffer from it). Comparing things equally,
> the same could be said of NVMe drives that do not have zone append native
> support: performance will be essentially the same using regular writes and
> emulated zone append. But mq-deadline and zone write locking will significantly
> lower performance for emulated zone append compared to a native zone append
> support by the drive.

And to summarize the most important point - Zone Append doesn't exist
in ZAC/ABC.  For people that spent the last years trying to make zoned
storage work, the lack of such a primite has been the major pain point.
That's why I came up with the Zone Append design in response to a
request for such an operation from another company that is now heavily
involved in both Linux development and hosting Linux VMs.  For ZAC and
ZBC the best we can do is to emulate the approach in the driver, but
for NVMe we can do it.  ZNS until just before the release had Zone
Append mandatory, and it did so for a very good reason.  While making
it optional allows OEMs to request drives without it, I fundamentally
think we should not support that in Linux and request vendors do
implement writes to zones the right way.

And just as some OEMs can request certain TPs or optional features to
be implemented, so can Linux.  Just to give an example from the zone
world - Linux requires uniform and power of two zone sizes, which in
ZAC and ZBC are not required.
