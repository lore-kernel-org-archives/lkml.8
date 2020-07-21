Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E73FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C68022B4E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595289994;
	bh=EW7oIpJ+y8HgxhGR+cTjQSN8iQFBZEoFBFJqo6VkJc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WYliFS4iXvAXAetHKoUhLI70A95gVPJEs4bgBg9+be9vW8rv4R6PoCfi8GviGU23A
	 pEoMJGz9Did65FVx9cY0zWmxZWOpAJxYN54OH4IiwrIPBSa8LfFiT3v+kd0/b5gPpF
	 BfD816ECX9tX7ZS/DHqvgrZiyUJ+nyjIy2G3H5+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgGUAGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgGUAGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:06:32 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D02942080D;
        Tue, 21 Jul 2020 00:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595289992;
        bh=EW7oIpJ+y8HgxhGR+cTjQSN8iQFBZEoFBFJqo6VkJc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIbOtN6gdd/KjqUWCOdqHBjmZduwPt6VjjqgUeWDfmwr3OT/dztdvQRfdb9u2prua
         z1xjI/rO/mBSO/m4KtmMZMyke0KkQe+JffTcbd1BMneSvkHn6Xc7k19Zfb+1ZKw2zR
         NJxwZvh1KWAcy6KoW+6JQvIXmqG5lk/3blX6D6nQ=
Date:   Mon, 20 Jul 2020 17:06:30 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
Message-ID: <20200721000630.GA682317@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com>
 <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
 <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
 <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
 <b8fc47a2-0b53-3316-775f-0e9a8eddfdc2@deltatee.com>
 <20200720231701.GA682160@dhcp-10-100-145-180.wdl.wdc.com>
 <d7596065-f33b-5533-7254-153b82e6b88b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7596065-f33b-5533-7254-153b82e6b88b@grimberg.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 04:28:26PM -0700, Sagi Grimberg wrote:
> On 7/20/20 4:17 PM, Keith Busch wrote:
> > On Mon, Jul 20, 2020 at 05:01:19PM -0600, Logan Gunthorpe wrote:
> > > On 2020-07-20 4:35 p.m., Sagi Grimberg wrote:
> > > 
> > > > passthru commands are in essence REQ_OP_DRV_IN/REQ_OP_DRV_OUT, which
> > > > means that the driver shouldn't need the ns at all. So if you have a
> > > > dedicated request queue (mapped to the I/O tagset), you don't need the
> > > > ns->queue and we can lose the ns lookup altogether.
> > 
> > We still need a request_queue to dispatch the command. I guess you could
> > make a generic one for the controller that isn't tied to a namespace,
> > but we lose the fair shared tag allocation.
> 
> What do you mean fair shared tag allocation?

See hctx_may_queue().
