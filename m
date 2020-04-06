Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F810C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1AF206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDFIDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:03:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:60480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgDFIDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:03:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 67FFCAE0A;
        Mon,  6 Apr 2020 08:03:10 +0000 (UTC)
Date:   Mon, 6 Apr 2020 10:03:05 +0200
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: add revalidation support to bdev and file backed
 namespaces
Message-ID: <20200406080305.GA1329@technoir>
References: <20200402193052.19935-1-ailiop@suse.com>
 <20200403064331.GA23270@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403064331.GA23270@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 08:43:31AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 02, 2020 at 09:30:52PM +0200, Anthony Iliopoulos wrote:
> > Add support for detecting capacity changes on nvmet blockdev and file
> > backed namespaces. This allows for emulating and testing online resizing
> > of nvme devices and filesystems on top.
> > 
> > Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> 
> I vaguely remember seeing a very similar patch before, is this a repost?

Not a repost, but you're right, apparently there was a similar patch
posted before: 20191008122904.20438-1-m.malygin@yadro.com, which instead
triggers revalidation via configfs.

> > +void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
> > +{
> > +	loff_t size;
> > +
> > +	size = i_size_read(ns->bdev->bd_inode);
> > +
> > +	if (ns->size != size)
> > +		ns->size = size;
> 
> This can be:
> 
> 	ns->size = i_size_read(ns->bdev->bd_inode);

Fixed.

> > +void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
> > +{
> > +	struct kstat stat;
> > +
> > +	if (!ns->file)
> > +		return;
> 
> Shouldn't this always be non-NULL?

Right, this would be unset only during nvmet_ns_disable, and by that
time the ns is off the list, so identify should never see this being
non-NULL. Removed.

> > +
> > +	if (vfs_getattr(&ns->file->f_path,
> > +			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC))
> > +		return;
> 
> Use up the full line:
> 
> 	if (vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
> 			AT_STATX_FORCE_SYNC))

Fixed.

> Also shouldn't there be error handling?  If we can't stat the file
> the namespace is toast.

Indeed, I think it makes sense to fail identify at that point with
NVME_SC_INVALID_NS.

If you'd rather go with this patch instead of the configfs approach,
I'll post a v2 with the fixes, and some associated blktests that
Chaitanya requested.

Thank you all for the reviews!
