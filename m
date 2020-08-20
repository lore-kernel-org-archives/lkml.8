Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DE4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C372054F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NtPHvi10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgHTQh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbgHTQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:37:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DF4C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:37:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so1173617plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=j2sbZKOunUPIGK510Ugi3zbe+NKV7WregpDvTrZZO3M=;
        b=NtPHvi10EOcyYIgrMLzQKtYZHfhYnX0kv7C1qjMsiWY7LO4GGRn2nvySgtSGevrgk/
         S5c6Ev2gtYc8YfHMg4Uox928yUxIIbmFHum2B8DBWk3TfuqyuIrRYc+HMF/HiEtSOBAT
         o8CRbM0AOR30tIzu3uWz2wM6nURVSMpR5Fr1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=j2sbZKOunUPIGK510Ugi3zbe+NKV7WregpDvTrZZO3M=;
        b=qPLpnnhTkFu/K66QAAUhUK6TTahMZAdr4mhkTd2v5K8kcjZb6WHnzWhnX6As+qstX3
         cIXUgfXzFR7OCPG1BeOAYirgAmUcntGTCCb/8xCCbxuXAINfmaRlr9Vwq3UZwvYaBrIV
         CfF14GaU5eGv32BLUqfwBZt2dhO8La9XbKjig5nZVUtciJ381DBjfKExkhls5l7qifX1
         IXYtHF5MZ3T0jy8hpWGkohhsQ+m4RRrmhslYJYybeUauh+ATERMOvUO3BPCSS1w9E9rf
         +36d+2ASMkEwmOcS+8sCEISlQ3JybRQClyuWfZ8gkrZxPYfFzDrfNfympiQ4Mi28tv+z
         pSQQ==
X-Gm-Message-State: AOAM532sYKeDGLPXhYd+n/oleAn0H92tA+9hSaY0HaSw92ZmlydDFQ9Z
        lMQIRCTHDhObG6QuC2W7zlimwU+mRhcVavq7
X-Google-Smtp-Source: ABdhPJwBUFRJHDaiJTeIfbOcXiJStO7WcAzgyrbSctsBiBcYV2vC12oTNzAL2jL5rPa0l9qO8VuT3w==
X-Received: by 2002:a17:902:bd8d:: with SMTP id q13mr3134756pls.142.1597941472847;
        Thu, 20 Aug 2020 09:37:52 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id bj18sm2619461pjb.5.2020.08.20.09.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 09:37:52 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] bcm-vk: add bcm_vk UAPI
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20200806004631.8102-1-scott.branden@broadcom.com>
 <20200806004631.8102-2-scott.branden@broadcom.com>
 <20200818135313.GB495837@kroah.com>
 <8894c3c4-4d5c-cb94-bc90-a26833ebf268@broadcom.com>
 <20200818174451.GA749919@kroah.com>
 <4adbd70e-c49b-c2d4-84c7-5e910f05e449@broadcom.com>
 <20200819070044.GA1004396@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <fdbb7404-03c3-22b1-d409-5b6d8745ff2b@broadcom.com>
Date:   Thu, 20 Aug 2020 09:37:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819070044.GA1004396@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2020-08-19 12:00 a.m., Greg Kroah-Hartman wrote:
> On Tue, Aug 18, 2020 at 05:35:04PM -0700, Scott Branden wrote:
>>
>> On 2020-08-18 10:44 a.m., Greg Kroah-Hartman wrote:
>>> On Tue, Aug 18, 2020 at 10:23:42AM -0700, Scott Branden wrote:
>>>> Hi Greg,
>>>>
>>>> On 2020-08-18 6:53 a.m., Greg Kroah-Hartman wrote:
>>>>> On Wed, Aug 05, 2020 at 05:46:29PM -0700, Scott Branden wrote:
>>>>>> Add user space api for bcm-vk driver.
>>>>>>
>>>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>>>> ---
>>>>>>  include/uapi/linux/misc/bcm_vk.h | 99 ++++++++++++++++++++++++++++++++
>>>>>>  1 file changed, 99 insertions(+)
>>>>>>  create mode 100644 include/uapi/linux/misc/bcm_vk.h
>>>>>>
>>>>>> diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..783087b7c31f
>>>>>> --- /dev/null
>>>>>> +++ b/include/uapi/linux/misc/bcm_vk.h
>>>>>> @@ -0,0 +1,99 @@
>>>>>> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
>>>>>> +/*
>>>>>> + * Copyright 2018-2020 Broadcom.
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef __UAPI_LINUX_MISC_BCM_VK_H
>>>>>> +#define __UAPI_LINUX_MISC_BCM_VK_H
>>>>>> +
>>>>>> +#include <linux/ioctl.h>
>>>>>> +#include <linux/types.h>
>>>>>> +
>>>>>> +#define BCM_VK_MAX_FILENAME 64
>>>>>> +
>>>>>> +struct vk_image {
>>>>>> +	__u32 type; /* Type of image */
>>>>>> +#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
>>>>>> +#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
>>>>>> +	char filename[BCM_VK_MAX_FILENAME]; /* Filename of image */
>>>>>> +};
>>>>>> +
>>>>>> +struct vk_reset {
>>>>>> +	__u32 arg1;
>>>>>> +	__u32 arg2;
>>>>>> +};
>>>>>> +
>>>>>> +#define VK_MAGIC		0x5e
>>>>>> +
>>>>>> +/* Load image to Valkyrie */
>>>>>> +#define VK_IOCTL_LOAD_IMAGE	_IOW(VK_MAGIC, 0x2, struct vk_image)
>>>>>> +
>>>>>> +/* Send Reset to Valkyrie */
>>>>>> +#define VK_IOCTL_RESET		_IOW(VK_MAGIC, 0x4, struct vk_reset)
>>>>>> +
>>>>>> +/*
>>>>>> + * message block - basic unit in the message where a message's size is always
>>>>>> + *		   N x sizeof(basic_block)
>>>>>> + */
>>>>>> +struct vk_msg_blk {
>>>>>> +	__u8 function_id;
>>>>>> +#define VK_FID_TRANS_BUF	5
>>>>>> +#define VK_FID_SHUTDOWN		8
>>>>>> +	__u8 size;
>>>>>> +	__u16 trans_id; /* transport id, queue & msg_id */
>>>>>> +	__u32 context_id;
>>>>>> +	__u32 args[2];
>>>>>> +#define VK_CMD_PLANES_MASK	0x000f /* number of planes to up/download */
>>>>>> +#define VK_CMD_UPLOAD		0x0400 /* memory transfer to vk */
>>>>>> +#define VK_CMD_DOWNLOAD		0x0500 /* memory transfer from vk */
>>>>>> +#define VK_CMD_MASK		0x0f00 /* command mask */
>>>>>> +};
>>>>>> +
>>>>>> +#define VK_BAR_FWSTS			0x41c
>>>>>> +#define VK_BAR_COP_FWSTS		0x428
>>>>>> +/* VK_FWSTS definitions */
>>>>>> +#define VK_FWSTS_RELOCATION_ENTRY	BIT(0)
>>>>> <snip>
>>>>>
>>>>> I thought BIT() was not allowed in uapi .h files, this really works
>>>>> properly???
>>>> I did some investigation and it looks like a few other header files in include/uapi also use the BIT() macro:
>>>> include/uapi/misc/uacce/uacce.h
>>>> include/uapi/linux/psci.h
>>>> include/uapi/linux/v4l2-subdev.h
>>> Does the header install test target now fail for these?
>> I do not understand the question above.  make headers_install works.
>> But I guess the above headers would have similar issue with the BIT macro.
> Try enabling CONFIG_UAPI_HEADER_TEST and see what happens :)
I enabled CONFIG_UAPI_HEADER_TEST and then
built using "make" and "make headers_install".

There didn't appear to be any issue with the BIT macro in the headers.
>
>>>> tools/include/uapi/linux/pkt_sched.h
>>> That doesn't count :)
>>>
>>>> It does look like we end up defining the BIT() macro in our user space app that includes the header file.
>>>>
>>>> So, what is the proper thing to be done?
>>>> 1) Move the BIT() macro somewhere in include/uapi and include it in the necessary header files
>>>> 2) Use the _BITUL macro in include/uapi/linux/const.h instead?
>>>> 3) something else?
>>> open-code it for now please, that's the best way as I am pretty sure we
>>> can not contaminate the global C namespace with out BIT() macro, no
>>> matter how much we would like to...
>> OK, I will open-code it instead.
> Great!
>
> greg k-h

