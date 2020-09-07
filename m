Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4A3C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483942078B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599482682;
	bh=i45Q5Y7+UcDsp9NgOV3maOrvpDqRRVJRZKVEtzcg+3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GceiRpS9Lpt472+VdIstKImmujCR9y54SRpux5L63KtTafPFYHAxikGIlK+cTx9js
	 uF37GJRh+7TIwkDK5UMQsdyLC5DI4nqqvJEYBTEt9w1krUQxqB6vMGKStWh3/hnTv0
	 zG3if3TF1KIrmAwzHJjgZC/JBSl8Y4zj/yEzDB0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgIGMoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729183AbgIGMfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:35:32 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A796206E6;
        Mon,  7 Sep 2020 12:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599482131;
        bh=i45Q5Y7+UcDsp9NgOV3maOrvpDqRRVJRZKVEtzcg+3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGLJO6yS5MeiLg9qHAMBDR4xg9ulG8Rc4cQz94VRQflH1iulltX+by7nLGRVy+ZeO
         j/iG3sJFj6V3cNe1YufvOB9++O6Ri2wiW7kF8GwHjCaEJ+vT8wpAQPuf+JWl4rqJ1D
         CUiI//HVxqlXtCpNUTyGdNG0puVFA8u4LlmlzVgI=
Date:   Mon, 7 Sep 2020 14:35:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 1/3] bcm-vk: add bcm_vk UAPI
Message-ID: <20200907123546.GB2371705@kroah.com>
References: <20200825194400.28960-1-scott.branden@broadcom.com>
 <20200825194400.28960-2-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825194400.28960-2-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 12:43:58PM -0700, Scott Branden wrote:
> Add user space api for bcm-vk driver.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  include/uapi/linux/misc/bcm_vk.h | 99 ++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 include/uapi/linux/misc/bcm_vk.h
> 
> diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
> new file mode 100644
> index 000000000000..da7848e7c438
> --- /dev/null
> +++ b/include/uapi/linux/misc/bcm_vk.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
> +/*
> + * Copyright 2018-2020 Broadcom.
> + */
> +
> +#ifndef __UAPI_LINUX_MISC_BCM_VK_H
> +#define __UAPI_LINUX_MISC_BCM_VK_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +#define BCM_VK_MAX_FILENAME 64
> +
> +struct vk_image {
> +	__u32 type; /* Type of image */
> +#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
> +#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
> +	char filename[BCM_VK_MAX_FILENAME]; /* Filename of image */

nit, but this should really be __u8 filename[...
right?



> +};
> +
> +struct vk_reset {
> +	__u32 arg1;
> +	__u32 arg2;
> +};
> +
> +#define VK_MAGIC		0x5e
> +
> +/* Load image to Valkyrie */
> +#define VK_IOCTL_LOAD_IMAGE	_IOW(VK_MAGIC, 0x2, struct vk_image)
> +
> +/* Send Reset to Valkyrie */
> +#define VK_IOCTL_RESET		_IOW(VK_MAGIC, 0x4, struct vk_reset)
> +
> +/*
> + * message block - basic unit in the message where a message's size is always
> + *		   N x sizeof(basic_block)
> + */
> +struct vk_msg_blk {
> +	__u8 function_id;
> +#define VK_FID_TRANS_BUF	5
> +#define VK_FID_SHUTDOWN		8
> +	__u8 size;

Size of what?

> +	__u16 trans_id; /* transport id, queue & msg_id */
> +	__u32 context_id;
> +	__u32 args[2];
> +#define VK_CMD_PLANES_MASK	0x000f /* number of planes to up/download */
> +#define VK_CMD_UPLOAD		0x0400 /* memory transfer to vk */
> +#define VK_CMD_DOWNLOAD		0x0500 /* memory transfer from vk */
> +#define VK_CMD_MASK		0x0f00 /* command mask */
> +};

What are these defines for?  The args?  Something else?  It's not really
obvious here...

thanks,

greg k-h
