Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBEBC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A9E206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582296879;
	bh=G4uoI6dvX3xr+aBRpwhQPxpuOp02TZ5SCzvj3XzCwZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WkzBb4iXpIP1rqCHlDJXsd4Kv3O17Vw37bpZScmAemwRLyFkIAXH06QhS03PjAb4I
	 x2MNG9ov270H7b9Y4cXWefN9cqlUxiYVafXlkPIATkpvoqzBNYg0DKlI64JZaB30ZF
	 DZ5FsXYwypsAMGBwYO82hCCuJFhE4yJ0M4vxpb/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgBUOyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:54:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbgBUOyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:54:37 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FE35206DB;
        Fri, 21 Feb 2020 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582296877;
        bh=G4uoI6dvX3xr+aBRpwhQPxpuOp02TZ5SCzvj3XzCwZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0ZPFoKEsKBEwzyW1yri/0CS2t8tN6h7EZSAQy7RFM2kbaMeF7S/IT83/3OHSXvmk
         d1w51tCR6xvOb4bYU1nfJFvIItt65sXdriyQKwptPV4Ut5RAzmSFU840PPTX7e9xD/
         E6IdwtgBspNF2e5awD6kI6hUGJTrDGTvEhItwjhk=
Date:   Fri, 21 Feb 2020 23:54:32 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-multipath: Fix memory leak with ana_log_buf
Message-ID: <20200221145432.GA15144@redsun51.ssa.fujisawa.hgst.com>
References: <20200220202953.26139-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220202953.26139-1-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 01:29:53PM -0700, Logan Gunthorpe wrote:
> kmemleak reports a memory leak with the ana_log_buf allocated by
> nvme_mpath_init():
> 
> unreferenced object 0xffff888120e94000 (size 8208):
>   comm "nvme", pid 6884, jiffies 4295020435 (age 78786.312s)
>     hex dump (first 32 bytes):
>       00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
>       01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>     backtrace:
>       [<00000000e2360188>] kmalloc_order+0x97/0xc0
>       [<0000000079b18dd4>] kmalloc_order_trace+0x24/0x100
>       [<00000000f50c0406>] __kmalloc+0x24c/0x2d0
>       [<00000000f31a10b9>] nvme_mpath_init+0x23c/0x2b0
>       [<000000005802589e>] nvme_init_identify+0x75f/0x1600
>       [<0000000058ef911b>] nvme_loop_configure_admin_queue+0x26d/0x280
>       [<00000000673774b9>] nvme_loop_create_ctrl+0x2a7/0x710
>       [<00000000f1c7a233>] nvmf_dev_write+0xc66/0x10b9
>       [<000000004199f8d0>] __vfs_write+0x50/0xa0
>       [<0000000065466fef>] vfs_write+0xf3/0x280
>       [<00000000b0db9a8b>] ksys_write+0xc6/0x160
>       [<0000000082156b91>] __x64_sys_write+0x43/0x50
>       [<00000000c34fbb6d>] do_syscall_64+0x77/0x2f0
>       [<00000000bbc574c9>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> nvme_mpath_init() is called by nvme_init_identify() which is called in
> multiple places (nvme_reset_work(), nvme_passthru_end(), etc). This
> means nvme_mpath_init() may be called multiple times before
> nvme_mpath_uninit() (which is only called on nvme_free_ctrl()).
> 
> When nvme_mpath_init() is called multiple times, it overwrites the
> ana_log_buf pointer with a new allocation, thus leaking the previous
> allocation.
> 
> To fix this, free ana_log_buf before allocating a new one.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Thanks, applied to 5.6-rc3 with the reviews and the fixes tag.
