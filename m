Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05810C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC51207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHTF3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:29:25 -0400
Received: from verein.lst.de ([213.95.11.211]:40608 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgHTF3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:29:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BC97B68BEB; Thu, 20 Aug 2020 07:29:21 +0200 (CEST)
Date:   Thu, 20 Aug 2020 07:29:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Fugate <david.fugate@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200820052921.GA5391@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com> <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de> <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 01:11:58PM -0600, David Fugate wrote:
> On Tue, 2020-08-18 at 07:12 +0000, Christoph Hellwig wrote:
> > On Tue, Aug 18, 2020 at 10:59:36AM +0530, Kanchan Joshi wrote:
> > > If drive does not support zone-append natively, enable emulation
> > > using
> > > regular write.
> > > Make emulated zone-append cmd write-lock the zone, preventing
> > > concurrent append/write on the same zone.
> > 
> > I really don't think we should add this.  ZNS and the Linux support
> > were all designed with Zone Append in mind, and then your company did
> > the nastiest possible move violating the normal NVMe procedures to
> > make
> > it optional.  But that doesn't change the fact the Linux should keep
> > requiring it, especially with the amount of code added here and how
> > it
> > hooks in the fast path.
> 
> Intel does not support making *optional* NVMe spec features *required*
> by the NVMe driver. 

That is a great demand, but please stop talking of companies here,
because companies simply don't matter for Linux development.  People
and use cases do, companies don't and your mail talking about companies
really can't be taken serious.

And I'm not sure why you think Linux is different from any other NVMe
host OS.  If random NVMe host A decided they need feature X they are
going to require it, because why not.  Especially if the developers of
host A helped to drive the development of feature X.  I'm pretty sure
with a little background in storage standards you've seen that play out
a lot before.  And it is no different here.
