Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296CCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E7E20786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YaTyjFJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgHRRXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbgHRRXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:23:47 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D598C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 10:23:47 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 62so18977012qkj.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=C7S9XKWg7sMKPyrXwyvRzpUMpwwJ7QJXat4tA/AJCN4=;
        b=YaTyjFJYOBktfqJZagumsAKN0ZNLlv997FVtdmAyU0FZ9kTypf/XvWIqI/cXWSLsz3
         e7VM57ZmeB0P2jnQxxGC+87qUSWewDvkwOTdhM2sD3ebyZ0GdZZE5XXrvmCGZWFlBYPE
         5FVLkyXA3+/Oi8jgg3vA4MSI/JY6D5oGLjUMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=C7S9XKWg7sMKPyrXwyvRzpUMpwwJ7QJXat4tA/AJCN4=;
        b=R8+i5dYgaf/3RysAhjyRh2lVKMSzPWKuKao1I84QR15zdHz4DhYy16a4l707H3ieVl
         GtBuQTUgHyKY/8zXbhc/THfdJ1xas/ZecyZ/gcG+w/gVyNUFEKQe6a/igoEIGjeEZY9u
         FrSqF7wmo2c8UoK4NPYl4RYAP3sZ8iWx9p0JN2j+qb8XJhD6n7VYWWULwUX6gyAp4OO8
         E9OiSslB0ErdEd684ZjDAiEwNVvFqtWES36HHR8fAGpKeRU4ym8JbUb0r5jaTR26BIle
         uq21hmoPNlyG0ZJVb7ngphHTMobo6R7U/CYDE09A5MI9bluPpnRbTwrm/63SCsAT1Fn/
         mqMA==
X-Gm-Message-State: AOAM530QNZtHowGQssLeHA2zOyauYGK/Oje7Qx/ag7rAkUpAglVieXt1
        Lnxc6Q2FE3XFK5cKqpRT7FLiog==
X-Google-Smtp-Source: ABdhPJyUFPj+TKuZ0+Q4HfdS6bKiOroOey+lx18FSdFQSMaVaWIMVfTIvsEZ/ZZiAHGGEoxNZH/W/A==
X-Received: by 2002:a05:620a:4f6:: with SMTP id b22mr17768577qkh.67.1597771426406;
        Tue, 18 Aug 2020 10:23:46 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k134sm21465028qke.60.2020.08.18.10.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 10:23:45 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] bcm-vk: add bcm_vk UAPI
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20200806004631.8102-1-scott.branden@broadcom.com>
 <20200806004631.8102-2-scott.branden@broadcom.com>
 <20200818135313.GB495837@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <8894c3c4-4d5c-cb94-bc90-a26833ebf268@broadcom.com>
Date:   Tue, 18 Aug 2020 10:23:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818135313.GB495837@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2020-08-18 6:53 a.m., Greg Kroah-Hartman wrote:
> On Wed, Aug 05, 2020 at 05:46:29PM -0700, Scott Branden wrote:
>> Add user space api for bcm-vk driver.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  include/uapi/linux/misc/bcm_vk.h | 99 ++++++++++++++++++++++++++++++++
>>  1 file changed, 99 insertions(+)
>>  create mode 100644 include/uapi/linux/misc/bcm_vk.h
>>
>> diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
>> new file mode 100644
>> index 000000000000..783087b7c31f
>> --- /dev/null
>> +++ b/include/uapi/linux/misc/bcm_vk.h
>> @@ -0,0 +1,99 @@
>> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
>> +/*
>> + * Copyright 2018-2020 Broadcom.
>> + */
>> +
>> +#ifndef __UAPI_LINUX_MISC_BCM_VK_H
>> +#define __UAPI_LINUX_MISC_BCM_VK_H
>> +
>> +#include <linux/ioctl.h>
>> +#include <linux/types.h>
>> +
>> +#define BCM_VK_MAX_FILENAME 64
>> +
>> +struct vk_image {
>> +	__u32 type; /* Type of image */
>> +#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
>> +#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
>> +	char filename[BCM_VK_MAX_FILENAME]; /* Filename of image */
>> +};
>> +
>> +struct vk_reset {
>> +	__u32 arg1;
>> +	__u32 arg2;
>> +};
>> +
>> +#define VK_MAGIC		0x5e
>> +
>> +/* Load image to Valkyrie */
>> +#define VK_IOCTL_LOAD_IMAGE	_IOW(VK_MAGIC, 0x2, struct vk_image)
>> +
>> +/* Send Reset to Valkyrie */
>> +#define VK_IOCTL_RESET		_IOW(VK_MAGIC, 0x4, struct vk_reset)
>> +
>> +/*
>> + * message block - basic unit in the message where a message's size is always
>> + *		   N x sizeof(basic_block)
>> + */
>> +struct vk_msg_blk {
>> +	__u8 function_id;
>> +#define VK_FID_TRANS_BUF	5
>> +#define VK_FID_SHUTDOWN		8
>> +	__u8 size;
>> +	__u16 trans_id; /* transport id, queue & msg_id */
>> +	__u32 context_id;
>> +	__u32 args[2];
>> +#define VK_CMD_PLANES_MASK	0x000f /* number of planes to up/download */
>> +#define VK_CMD_UPLOAD		0x0400 /* memory transfer to vk */
>> +#define VK_CMD_DOWNLOAD		0x0500 /* memory transfer from vk */
>> +#define VK_CMD_MASK		0x0f00 /* command mask */
>> +};
>> +
>> +#define VK_BAR_FWSTS			0x41c
>> +#define VK_BAR_COP_FWSTS		0x428
>> +/* VK_FWSTS definitions */
>> +#define VK_FWSTS_RELOCATION_ENTRY	BIT(0)
> <snip>
>
> I thought BIT() was not allowed in uapi .h files, this really works
> properly???
I did some investigation and it looks like a few other header files in include/uapi also use the BIT() macro:
include/uapi/misc/uacce/uacce.h
include/uapi/linux/psci.h
include/uapi/linux/v4l2-subdev.h
tools/include/uapi/linux/pkt_sched.h

It does look like we end up defining the BIT() macro in our user space app that includes the header file.

So, what is the proper thing to be done?
1) Move the BIT() macro somewhere in include/uapi and include it in the necessary header files
2) Use the _BITUL macro in include/uapi/linux/const.h instead?
3) something else?

> thanks,
>
> greg k-h
Regards,
Scott
