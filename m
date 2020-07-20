Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C71C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D815420B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgGTOQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:16:10 -0400
Received: from verein.lst.de ([213.95.11.211]:47199 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgGTOQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:16:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8A90468BFE; Mon, 20 Jul 2020 16:16:06 +0200 (CEST)
Date:   Mon, 20 Jul 2020 16:16:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
Message-ID: <20200720141606.GF4627@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com> <20200716203319.16022-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716203319.16022-8-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 02:33:17PM -0600, Logan Gunthorpe wrote:
> Add passthru command handling capability for the NVMeOF target and
> export passthru APIs which are used to integrate passthru
> code with nvmet-core.
> 
> The new file passthru.c handles passthru cmd parsing and execution.
> In the passthru mode, we create a block layer request from the nvmet
> request and map the data on to the block layer request.
> 
> Admin commands and features are on a white list as there are a number
> of each that don't make too much sense with passthrough. We use a
> white list so that new commands can be considered before being blindly
> passed through. In both cases, vendor specific commands are always
> allowed.
> 
> We also blacklist reservation IO commands as the underlying device
> cannot differentiate between multiple hosts behind a fabric.

I'm still not so happy about having to look up the namespace and still
wonder if we should generalize the connect_q to a passthrough_q.  But
I guess we can do that later and then reduce some of the exports here..

A few more comments below:

> +		struct {
> +			struct request		*rq;
> +			struct work_struct      work;
> +			u16 (*end_req)(struct nvmet_req *req);
> +		} p;

Do we really need the callback for the two identify fixups, or
should we just hardcode them to avoid indirection function calls?

> +++ b/drivers/nvme/target/passthru.c
> @@ -0,0 +1,457 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVMe Over Fabrics Target Passthrough command implementation.
> + *
> + * Copyright (c) 2017-2018 Western Digital Corporation or its
> + * affiliates.
> + */

I think you forgot to add your own copyrights here.

> +static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
> +{
> +	int sg_cnt = req->sg_cnt;
> +	struct scatterlist *sg;
> +	int op_flags = 0;
> +	struct bio *bio;
> +	int i, ret;
> +
> +	if (req->cmd->common.opcode == nvme_cmd_flush)
> +		op_flags = REQ_FUA;
> +	else if (nvme_is_write(req->cmd))
> +		op_flags = REQ_SYNC | REQ_IDLE;
> +
> +

Double empty line here..

> +	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
> +	bio->bi_end_io = bio_put;
> +
> +	for_each_sg(req->sg, sg, req->sg_cnt, i) {
> +		if (bio_add_page(bio, sg_page(sg), sg->length,
> +				 sg->offset) != sg->length) {

bio_add_pages is only for non-passthrough requests, this needs to use
bio_add_pc_page.

> +	if (blk_rq_nr_phys_segments(rq) > queue_max_segments(rq->q)) {
> +		status = NVME_SC_INVALID_FIELD;
> +		goto fail_out;
> +	}
> +
> +	if ((blk_rq_payload_bytes(rq) >> 9) > queue_max_hw_sectors(rq->q)) {
> +		status = NVME_SC_INVALID_FIELD;
> +		goto fail_out;
> +	}

Which should also take care of these checks.

> +static void nvmet_passthru_set_host_behaviour(struct nvmet_req *req)
> +{
> +	struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
> +	struct nvme_feat_host_behavior *host;
> +	u16 status;
> +	int ret;
> +
> +	host = kzalloc(sizeof(*host) * 2, GFP_KERNEL);
> +	ret = nvme_get_features(ctrl, NVME_FEAT_HOST_BEHAVIOR, 0,
> +				host, sizeof(*host), NULL);

Mising kzalloc return check.
