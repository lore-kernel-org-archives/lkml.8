Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABDCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 680622054F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597821051;
	bh=FfnxurrWWt3Rhmrb33mRsWVhDiDOqME/C5W843zPch0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OkSzny9vRuM9KpjX4HOyVlycEB55eFqOlwGcUA5Hy4nI7VxIWS5ip2AfXs4/bPPt6
	 O5GGcPPEBQaHLNQr7eF3nXb9x+W8Wk9DpAB7GraUj75bD9Kd/MjOCsdaZ0fHazLTzq
	 jf5XGz/OzFNi2F9rRd1DLZsrmMLmwXsOw2ODVBAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgHSHKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbgHSHK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:10:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60F0F20738;
        Wed, 19 Aug 2020 07:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597820422;
        bh=FfnxurrWWt3Rhmrb33mRsWVhDiDOqME/C5W843zPch0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DdBPcQQlRBI14p91MSa70NzK6YvRg+tYF8pul0kQikyVuNdcPpyEJYDofFS/gpp8E
         +PSV/Oz8+WVuNBpWlV+GpvNMsql97D1HrIY+/nvKz5LoY3+1fuNZvrqfXSvuQHOKjH
         wSlufqOe4RXAv/mRAE2LXXTjeUrkv3t35zeWuaac=
Date:   Wed, 19 Aug 2020 09:00:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 1/3] bcm-vk: add bcm_vk UAPI
Message-ID: <20200819070044.GA1004396@kroah.com>
References: <20200806004631.8102-1-scott.branden@broadcom.com>
 <20200806004631.8102-2-scott.branden@broadcom.com>
 <20200818135313.GB495837@kroah.com>
 <8894c3c4-4d5c-cb94-bc90-a26833ebf268@broadcom.com>
 <20200818174451.GA749919@kroah.com>
 <4adbd70e-c49b-c2d4-84c7-5e910f05e449@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4adbd70e-c49b-c2d4-84c7-5e910f05e449@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 05:35:04PM -0700, Scott Branden wrote:
> 
> 
> On 2020-08-18 10:44 a.m., Greg Kroah-Hartman wrote:
> > On Tue, Aug 18, 2020 at 10:23:42AM -0700, Scott Branden wrote:
> >> Hi Greg,
> >>
> >> On 2020-08-18 6:53 a.m., Greg Kroah-Hartman wrote:
> >>> On Wed, Aug 05, 2020 at 05:46:29PM -0700, Scott Branden wrote:
> >>>> Add user space api for bcm-vk driver.
> >>>>
> >>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> >>>> ---
> >>>>  include/uapi/linux/misc/bcm_vk.h | 99 ++++++++++++++++++++++++++++++++
> >>>>  1 file changed, 99 insertions(+)
> >>>>  create mode 100644 include/uapi/linux/misc/bcm_vk.h
> >>>>
> >>>> diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
> >>>> new file mode 100644
> >>>> index 000000000000..783087b7c31f
> >>>> --- /dev/null
> >>>> +++ b/include/uapi/linux/misc/bcm_vk.h
> >>>> @@ -0,0 +1,99 @@
> >>>> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
> >>>> +/*
> >>>> + * Copyright 2018-2020 Broadcom.
> >>>> + */
> >>>> +
> >>>> +#ifndef __UAPI_LINUX_MISC_BCM_VK_H
> >>>> +#define __UAPI_LINUX_MISC_BCM_VK_H
> >>>> +
> >>>> +#include <linux/ioctl.h>
> >>>> +#include <linux/types.h>
> >>>> +
> >>>> +#define BCM_VK_MAX_FILENAME 64
> >>>> +
> >>>> +struct vk_image {
> >>>> +	__u32 type; /* Type of image */
> >>>> +#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
> >>>> +#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
> >>>> +	char filename[BCM_VK_MAX_FILENAME]; /* Filename of image */
> >>>> +};
> >>>> +
> >>>> +struct vk_reset {
> >>>> +	__u32 arg1;
> >>>> +	__u32 arg2;
> >>>> +};
> >>>> +
> >>>> +#define VK_MAGIC		0x5e
> >>>> +
> >>>> +/* Load image to Valkyrie */
> >>>> +#define VK_IOCTL_LOAD_IMAGE	_IOW(VK_MAGIC, 0x2, struct vk_image)
> >>>> +
> >>>> +/* Send Reset to Valkyrie */
> >>>> +#define VK_IOCTL_RESET		_IOW(VK_MAGIC, 0x4, struct vk_reset)
> >>>> +
> >>>> +/*
> >>>> + * message block - basic unit in the message where a message's size is always
> >>>> + *		   N x sizeof(basic_block)
> >>>> + */
> >>>> +struct vk_msg_blk {
> >>>> +	__u8 function_id;
> >>>> +#define VK_FID_TRANS_BUF	5
> >>>> +#define VK_FID_SHUTDOWN		8
> >>>> +	__u8 size;
> >>>> +	__u16 trans_id; /* transport id, queue & msg_id */
> >>>> +	__u32 context_id;
> >>>> +	__u32 args[2];
> >>>> +#define VK_CMD_PLANES_MASK	0x000f /* number of planes to up/download */
> >>>> +#define VK_CMD_UPLOAD		0x0400 /* memory transfer to vk */
> >>>> +#define VK_CMD_DOWNLOAD		0x0500 /* memory transfer from vk */
> >>>> +#define VK_CMD_MASK		0x0f00 /* command mask */
> >>>> +};
> >>>> +
> >>>> +#define VK_BAR_FWSTS			0x41c
> >>>> +#define VK_BAR_COP_FWSTS		0x428
> >>>> +/* VK_FWSTS definitions */
> >>>> +#define VK_FWSTS_RELOCATION_ENTRY	BIT(0)
> >>> <snip>
> >>>
> >>> I thought BIT() was not allowed in uapi .h files, this really works
> >>> properly???
> >> I did some investigation and it looks like a few other header files in include/uapi also use the BIT() macro:
> >> include/uapi/misc/uacce/uacce.h
> >> include/uapi/linux/psci.h
> >> include/uapi/linux/v4l2-subdev.h
> > Does the header install test target now fail for these?
> I do not understand the question above.  make headers_install works.
> But I guess the above headers would have similar issue with the BIT macro.

Try enabling CONFIG_UAPI_HEADER_TEST and see what happens :)

> >> tools/include/uapi/linux/pkt_sched.h
> > That doesn't count :)
> >
> >> It does look like we end up defining the BIT() macro in our user space app that includes the header file.
> >>
> >> So, what is the proper thing to be done?
> >> 1) Move the BIT() macro somewhere in include/uapi and include it in the necessary header files
> >> 2) Use the _BITUL macro in include/uapi/linux/const.h instead?
> >> 3) something else?
> > open-code it for now please, that's the best way as I am pretty sure we
> > can not contaminate the global C namespace with out BIT() macro, no
> > matter how much we would like to...
> OK, I will open-code it instead.

Great!

greg k-h
