Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC229C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4F922BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgGTOBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:01:55 -0400
Received: from verein.lst.de ([213.95.11.211]:47092 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTOBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:01:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8993568BFE; Mon, 20 Jul 2020 16:01:51 +0200 (CEST)
Date:   Mon, 20 Jul 2020 16:01:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v15 1/9] nvme-core: Clear any SGL flags in passthru
 commands
Message-ID: <20200720140151.GA4627@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com> <20200716203319.16022-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716203319.16022-2-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 02:33:11PM -0600, Logan Gunthorpe wrote:
> The host driver should decide whether to use SGLs or PRPs and they
> currently assume the flags are cleared after the call to
> nvme_setup_cmd(). However, passed-through commands may erroneously
> set these bits; so clear them for all cases.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f49085bcaa42..63a59186e68b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -759,6 +759,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>  	case REQ_OP_DRV_IN:
>  	case REQ_OP_DRV_OUT:
>  		memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
> +		/* passthru commands should let the driver set the SGL flags */
> +		cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>  		break;

This probably wants to be split into a little helper like the
other cases.
