Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21CFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 06:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE97B20757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 06:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388749AbgDCGne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 02:43:34 -0400
Received: from verein.lst.de ([213.95.11.211]:51275 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbgDCGne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 02:43:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E9AE468B05; Fri,  3 Apr 2020 08:43:31 +0200 (CEST)
Date:   Fri, 3 Apr 2020 08:43:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: add revalidation support to bdev and file
 backed namespaces
Message-ID: <20200403064331.GA23270@lst.de>
References: <20200402193052.19935-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402193052.19935-1-ailiop@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 09:30:52PM +0200, Anthony Iliopoulos wrote:
> Add support for detecting capacity changes on nvmet blockdev and file
> backed namespaces. This allows for emulating and testing online resizing
> of nvme devices and filesystems on top.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

I vaguely remember seeing a very similar patch before, is this a repost?

> +void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
> +{
> +	loff_t size;
> +
> +	size = i_size_read(ns->bdev->bd_inode);
> +
> +	if (ns->size != size)
> +		ns->size = size;

This can be:

	ns->size = i_size_read(ns->bdev->bd_inode);

> +void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
> +{
> +	struct kstat stat;
> +
> +	if (!ns->file)
> +		return;

Shouldn't this always be non-NULL?

> +
> +	if (vfs_getattr(&ns->file->f_path,
> +			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC))
> +		return;

Use up the full line:

	if (vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
			AT_STATX_FORCE_SYNC))

Also shouldn't there be error handling?  If we can't stat the file
the namespace is toast.
