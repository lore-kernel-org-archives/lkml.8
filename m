Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD56C55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4917C20857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587421616;
	bh=EWVzh88DNd4xeWlsexuidhZpIDlePK+hTSyEl1GX/8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=giCv0Tdcf34LqmA01EuGMktgIKLPg48SNhdsE/lueENROQq8CLW8Ai4pvGT60cGhw
	 NKke0yuHuDf+T42TlAY1eCmTznPOQO6/vNLDdXROMTcbdYV1SS7volKQ0OKrnSKzIa
	 UdQy/n/ayKW4wQRW61GfvtlOCdY4n9I/YOycIX7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgDTW0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgDTW0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:26:55 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ABAA2078C;
        Mon, 20 Apr 2020 22:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587421614;
        bh=EWVzh88DNd4xeWlsexuidhZpIDlePK+hTSyEl1GX/8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s8rq4igMfXXijc389ELBl5dQwloilfDDQMohpJXxaRWtdIKgyDc07+5kh8co+PUup
         r+6Z54NwOW5xZFGmhIX/9UUU37s4Z7yGbgpCmN8isJapDDS3+dQdMBqGLYl1Dfqq65
         pk9gQ+cFF7aXKSpcYIsxq7I56fqA6ULGH895zwsI=
Date:   Tue, 21 Apr 2020 07:26:46 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v12 1/9] nvme-core: Clear any SGL flags in passthru
 commands
Message-ID: <20200420222646.GA11115@redsun51.ssa.fujisawa.hgst.com>
References: <20200420164700.21620-1-logang@deltatee.com>
 <20200420164700.21620-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420164700.21620-2-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 10:46:52AM -0600, Logan Gunthorpe wrote:
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
> index 91c1bd659947..f5283b300e87 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -756,6 +756,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>  	case REQ_OP_DRV_IN:
>  	case REQ_OP_DRV_OUT:
>  		memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
> +		/* passthru commands should let the driver set the SGL flags */
> +		cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>  		break;

Is this really necessary? The passthrough handler currently rejects user
commands that set command flags:

static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
			struct nvme_passthru_cmd __user *ucmd)
{
	...
	if (cmd.flags)
		return -EINVAL;
