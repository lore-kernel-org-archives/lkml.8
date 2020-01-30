Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596ECC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCD3206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QihyZz42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgA3PFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:05:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbgA3PFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bQEJBFQw335rEzA4uS/QUHbV64L/lyYtO517e1wYh9o=; b=QihyZz42wL6NVhC6iKzAvkyCB
        N+xBHkklMR5IA4AhNDYjwm/QgeCpq9+C6Vzvpwzb8tmKV98dpgizP8usQ803AcXVGKgvA+cITWEcy
        Wk0kNPcGoAzl6NzOBnzrCr5+bASO/9H3PBHcoG6cYwxCNMVF8h6VZwJ5jfksJaY4hvIPweH1Jj4hI
        pGilzWuALP2Rlh8pRGj7xW1r+OOrc/POCcSviLpRM2Eo/HDjiZhrVFsiE/Yz7CP0wu8hjDMYzI3OP
        S2/QRVCH8t/Mz1wTJUT3TcFNwse/gQawbh5onWflVfJsdrl+2eljaAjgomaE/cVy6iT16wUaruUSv
        F2eVHdftQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixBND-0006yN-V3; Thu, 30 Jan 2020 15:04:51 +0000
Date:   Thu, 30 Jan 2020 07:04:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: fix uninitialized-variable warning
Message-ID: <20200130150451.GA25427@infradead.org>
References: <20200107214215.935781-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107214215.935781-1-arnd@arndb.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:42:08PM +0100, Arnd Bergmann wrote:
> Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/nvme/host/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 667f18f465be..6f0991e8c5cc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -825,14 +825,15 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>  	int ret;
>  
>  	req = nvme_alloc_request(q, cmd, flags, qid);
> -	if (IS_ERR(req))
> -		return PTR_ERR(req);
> +	ret = PTR_ERR_OR_ZERO(req);
> +	if (ret < 0)
> +		return ret;

This one is just gross.  I think we'll need to find some other fix
that doesn't obsfucate the code as much.

>  
>  	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
>  
>  	if (buffer && bufflen) {
>  		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
> -		if (ret)
> +		if (ret < 0)

OTOH if this shuts up a compiler warning I'd be perfectly fine with it.
