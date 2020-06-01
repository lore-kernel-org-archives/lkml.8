Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D93C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F1B2077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591030301;
	bh=nJRuAd1pece1wo82cDE56vHZNiXsecu7U8d2KjpOa6U=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Z6qq8vPIXr4C2SGYPQVr5TH1qQc3RKlmP457KWq2KNWQmXA8iSwfCyAopkVvmiYtg
	 wwmbBjUuXQs9YBKYlRqf3S8ODG7d+Ifj7kg5EPy6+bwVQri/65pHKEv7pSPtxgiivM
	 KsL/6NEsQjrUTnlxJ+vID229Um9kA8+zGXjp2at4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgFAQvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgFAQvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:51:38 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08662C03E97C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:51:37 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id 7so1543331oof.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T7w7j4yQwplmXQxxnc/dAqR0xCmeWec60t3EIHBSr/c=;
        b=JaPe6H9A/OWTCRY9H5QuCuNhjT4T6J4+XtVy7aU5HUXhaR5LkOr1czyxIYmF6D7lDf
         EWOcnaDeVZYPoPmxuv/1kjqIseUe0OS8nNvkBEY9+6qinMQarEQc8zWsUx9shc6yPDbg
         omwwhEDhV5ilKLyWvYOMMKTScvHprq7LR3lLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T7w7j4yQwplmXQxxnc/dAqR0xCmeWec60t3EIHBSr/c=;
        b=jNI92sBRMU00sHXaUNUVJ7b1ZkNMsKSljEk8P4F1hjq1k56kKQy/cTfnntO3EetJFN
         rcwtDij7R9p1aXJH3esHCEXPAKYorgPonOEi2kwnIe/vqMaGEiHrbluDXxn13Hil7PU+
         hOXL4mU+QIa1MiJSpwzBOIekOKcnNcG/P+Axdd3AgwJxSZyQgh/62lCxUdY4WVqTjPp5
         /7/7Jrq49tN0zmQQlcRBeQuAT3zCkhk91jkIQHN0uaSSj/wIH4jFm/v8Em29gdAIcK+q
         ytMnPGvVyvohUTYUp2ZS3bIWp5AVfHbZ819WWhogKzN4IXdik/+pxDJOWDLHwkvgrIoy
         SCVA==
X-Gm-Message-State: AOAM533islftQBfIoetJivewAgKqepFrFsymy+YWDmWEQMG+gj+Y4trC
        WlzGSp0eFf3Zn/BgX1TtQRMKmQ==
X-Google-Smtp-Source: ABdhPJyeVfnGsjB7FHe6WfKM3RmmWvuRQH99VnMLxtmhXrtfmi5Cw9fJvC5C7Qov1rzbjhrALU9CgA==
X-Received: by 2002:a4a:2c88:: with SMTP id o130mr17528761ooo.81.1591030297092;
        Mon, 01 Jun 2020 09:51:37 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c184sm5388325oif.3.2020.06.01.09.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 09:51:36 -0700 (PDT)
Subject: Re: [RFC, WIP, v6 05/10] media: vidtv: add wrappers for memcpy and
 memset
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        mchehab+huawei@kernel.org, sean@mess.org,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        tglx@linutronix.de
Cc:     linux-media@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200520070334.1778751-1-dwlsalmeida@gmail.com>
 <20200520070334.1778751-6-dwlsalmeida@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2b00fc7a-8818-b0be-7e42-a2df9787876b@linuxfoundation.org>
Date:   Mon, 1 Jun 2020 10:51:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520070334.1778751-6-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 5/20/20 1:03 AM, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> A lot of code in this driver is for serializing structures. This is
> error prone.
> 
> Therefore, prevent buffer overflows by wrapping memcpy and memset,
> comparing the requested length against the buffer size.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>   .../media/test-drivers/vidtv/vidtv_common.c   | 86 +++++++++++++++++++
>   .../media/test-drivers/vidtv/vidtv_common.h   | 27 ++++++
>   2 files changed, 113 insertions(+)
>   create mode 100644 drivers/media/test-drivers/vidtv/vidtv_common.c
>   create mode 100644 drivers/media/test-drivers/vidtv/vidtv_common.h
> 

I don't see these added to Makefile. Building the driver with the patch
has no effect.

In any case I don't see any value in adding the wrappers here. They
really do nothing other than doing range checks. It adda a layer of
indirection that is unnecessary.

> diff --git a/drivers/media/test-drivers/vidtv/vidtv_common.c b/drivers/media/test-drivers/vidtv/vidtv_common.c
> new file mode 100644
> index 0000000000000..6810212087c17
> --- /dev/null
> +++ b/drivers/media/test-drivers/vidtv/vidtv_common.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The Virtual DVB test driver serves as a reference DVB driver and helps
> + * validate the existing APIs in the media subsystem. It can also aid
> + * developers working on userspace applications.
> + *
> + * Written by Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ":%s, %d: " fmt, __func__, __LINE__
> +
> +#include <linux/printk.h>
> +#include <linux/ratelimit.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include "vidtv_common.h"
> +
> +/**
> + * vidtv_memcpy() - wrapper routine to be used by MPEG-TS
> + *	generator, in order to avoid going past the
> + *	output buffer.
> + * @to:	Starting element to where a MPEG-TS packet will
> + *	be copied.
> + * @to_offset:	Starting position of the @to buffer to be filled.
> + * @to_size:	Size of the @to buffer.
> + * @from:	Starting element of the buffer to be copied.
> + * @len:	Number of elements to be copy from @from buffer
> + *	into @to+ @to_offset buffer.
> + *
> + * Note:
> + *	Real digital TV demod drivers should not have memcpy
> + *	wrappers. We use it here because emulating MPEG-TS
> + *	generation at kernelspace requires some extra care.
> + *
> + * Return:
> + *	Returns the number of bytes written
> + */
> +u32 vidtv_memcpy(void *to,
> +		 size_t to_offset,
> +		 size_t to_size,
> +		 const void *from,
> +		 size_t len)
> +{
> +	if (unlikely(to_offset + len > to_size)) {

Use of unlikely isn't necessarily beneficial in all cases.

> +		pr_err_ratelimited("overflow detected, skipping. Try increasing the buffer size\n");
> +		return 0;
> +	}
> +
> +	memcpy(to + to_offset, from, len);
> +	return len;
> +}
> +
> +/**
> + * vidtv_memset() - wrapper routine to be used by MPEG-TS
> + *	generator, in order to avoid going past the
> + *	output buffer.
> + * @to:	Starting element to set
> + * @to_offset:	Starting position of the @to buffer to be filled.
> + * @to_size:	Size of the @to buffer.
> + * @from:	Starting element of the buffer to be copied.
> + * @ten:	Number of elements to be copy from @from buffer
> + *	into @to+ @to_offset buffer.
> + *
> + * Note:
> + *	Real digital TV demod drivers should not have memset
> + *	wrappers. We use it here because emulating MPEG-TS
> + *	generation at kernelspace requires some extra care.
> + *
> + * Return:
> + *	Returns the number of bytes written
> + */
> +u32 vidtv_memset(void *to,
> +		 size_t to_offset,
> +		 size_t to_size,
> +		 const int c,
> +		 size_t len)
> +{
> +	if (unlikely(to_offset + len > to_size)) {
> +		pr_err_ratelimited("overflow detected, skipping. Try increasing the buffer size\n");
> +		return 0;
> +	}
> +
> +	memset(to + to_offset, c, len);
> +	return len;
> +}
> diff --git a/drivers/media/test-drivers/vidtv/vidtv_common.h b/drivers/media/test-drivers/vidtv/vidtv_common.h
> new file mode 100644
> index 0000000000000..a3cb303cc7423
> --- /dev/null
> +++ b/drivers/media/test-drivers/vidtv/vidtv_common.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * The Virtual DVB test driver serves as a reference DVB driver and helps
> + * validate the existing APIs in the media subsystem. It can also aid
> + * developers working on userspace applications.
> + *
> + * Written by Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> + */
> +
> +#ifndef VIDTV_COMMON_H
> +#define VIDTV_COMMON_H
> +
> +#include <linux/types.h>
> +
> +u32 vidtv_memcpy(void *to,
> +		 size_t to_offset,
> +		 size_t to_size,
> +		 const void *from,
> +		 size_t len);
> +
> +u32 vidtv_memset(void *to,
> +		 size_t to_offset,
> +		 size_t to_size,
> +		 int c,
> +		 size_t len);
> +
> +#endif // VIDTV_COMMON_H
> 

thanks,
-- Shuah
