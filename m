Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9314C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30E3206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595619235;
	bh=s5Pq4+FkzTO2HXeCm8z0SJMPOsSTRJlA1F4DZgLYN/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vOCC9MTsAe2rl3KyF2+6jFrR0wpa4tUUEvvjUYQ7Kf1A3EERtlrnDTJllJIi/BNH4
	 Jfu8ZuK2i6E1PoQcaRDoXbBUuRyVKHI7KtPHF87hbFDdwN7TuYXQ+dhxtbXubLrKaB
	 YgxlyRetUcfrZILYkx/nJ1Os3jCtIijegXYhs344=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgGXTdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgGXTdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:33:54 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3247E206F6;
        Fri, 24 Jul 2020 19:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595619233;
        bh=s5Pq4+FkzTO2HXeCm8z0SJMPOsSTRJlA1F4DZgLYN/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yIvtZ+7quaXQuQVKxcGyfJkgORWLVgyZEvgUt3L9Qy6wPKcv5JXSv9CJw8mX6rpPo
         ln7POMC62kiPDLQSOifNTEOSknHkwS89tW83OQrFMKfdPVVs/3Xxeqvl4VH6cpYRMX
         wIocWzdrKGQGThstNc0JvAKZYZ+QSpQZMf0R1L8w=
Date:   Fri, 24 Jul 2020 12:33:51 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v16 6/9] nvmet-passthru: Add passthru code to process
 commands
Message-ID: <20200724193351.GA2857771@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200724172520.16318-1-logang@deltatee.com>
 <20200724172520.16318-7-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724172520.16318-7-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:25:17AM -0600, Logan Gunthorpe wrote:
> +	/*
> +	 * The passthru NVMe driver may have a limit on the number of segments
> +	 * which depends on the host's memory fragementation. To solve this,
> +	 * ensure mdts is limitted to the pages equal to the number of

                          limited

> +	/* don't support fuse commands */
> +	id->fuses = 0;

If a host were to set a fuse, the target should return an Invalid Field
error. Just to future-proof, rejecting commands with any flags set
(other than SGL, which you handled in patch 1/9) is probably what should
happen, like:

> +u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req)
> +{

	if (req->cmd->common.flags & ~NVME_CMD_SGL_ALL)
		return NVME_SC_INVALID_FIELD;

Or maybe we could obviate the need for 1/9 with something like:

	req->cmd->common.flags &= ~NVME_CMD_SGL_ALL;
	if (req->cmd->common.flags)
		return NVME_SC_INVALID_FIELD;
