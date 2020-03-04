Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DB3C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E7821739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgCDQNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:13:21 -0500
Received: from verein.lst.de ([213.95.11.211]:55259 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgCDQNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:13:21 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB22768B20; Wed,  4 Mar 2020 17:13:17 +0100 (CET)
Date:   Wed, 4 Mar 2020 17:13:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     masahiro31.yamada@kioxia.com
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: add a compat_ioctl handler for
 NVME_IOCTL_SUBMIT_IO
Message-ID: <20200304161317.GA11268@lst.de>
References: <c0d7091c43154d9ea7a978c42a78b01a@TGXML281.toshiba.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0d7091c43154d9ea7a978c42a78b01a@TGXML281.toshiba.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
> +		unsigned int cmd, unsigned long arg)
> +{
> +	if (cmd == NVME_IOCTL_SUBMIT_IO32)
> +		return nvme_ioctl(bdev, mode, NVME_IOCTL_SUBMIT_IO, arg);

I think this really need a comment explaining what is going on, including
why not translating anything works in this specific case.

> +
> +	return nvme_ioctl(bdev, mode, cmd, arg);
> +}

This function should also be under CONFIG_COMPAT, with a

#define nvme_compat_ioctl	NULL

in the #else branch.

> index d99b5a772698..52699a26b9b3 100644
> --- a/include/uapi/linux/nvme_ioctl.h
> +++ b/include/uapi/linux/nvme_ioctl.h
> @@ -24,6 +24,21 @@ struct nvme_user_io {
>  	__u16	appmask;
>  };
>  
> +struct nvme_user_io32 {
> +	__u8	opcode;
> +	__u8	flags;
> +	__u16	control;
> +	__u16	nblocks;
> +	__u16	rsvd;
> +	__u64	metadata;
> +	__u64	addr;
> +	__u64	slba;
> +	__u32	dsmgmt;
> +	__u32	reftag;
> +	__u16	apptag;
> +	__u16	appmask;
> +} __attribute__((packed));

This should not be exposed in the UAPI header.  I think it should just
go into the #ifdef CONFIG_COMPAT block in core.c near the comment and
the compat_ioctl handler.
