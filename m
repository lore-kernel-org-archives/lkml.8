Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D38FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBE82067D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592501804;
	bh=D8qTugg236Uw2hIurARpgyiSXWPaEXRNTLcF1pqY1a4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=QliCerGJGTx+D9CPr0Uxamaptk5qlRqL991ThcAHRyNoOvCEpfJkNLUQC7iG2eh89
	 qimUNxZx4rq6MB0BqeF1Rue6xNZQHShx9mQecoRbhwDwj31mOCMggHyuRk9tk8PKgC
	 l6hgTp6wlT6HzTlK3nwo1LiR0Jp+nA7shF7RFbm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbgFRRgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbgFRRgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:36:41 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BA2C0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:36:41 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id s13so5185522otd.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vSAKdupfjUnpQv7PVZTpVtSwPY/+63YsbAN25Eh8aLo=;
        b=GMzprk/8y3cOitItK+SVkpqGg8A/ZMra8JaEKJFMANat5jvqSWFNlHq5Q5MRgpHKQk
         0nSqR41phZ4I+diI+SxDrGcHhAow3Igrv7jhP81S/JVMxmO/6ID6oGlfkwg4t4JLVp8j
         yBBBe6KVTIshDSBdeEoT9bhloJCCd7B5/UiE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vSAKdupfjUnpQv7PVZTpVtSwPY/+63YsbAN25Eh8aLo=;
        b=f3ssUkXmtWw2jE6/X5afotck8Xf8wZbp0mm28EpcHPJBOj28uuSWaqrxtwwzqB8WPZ
         +Ikbyxedc8QtYzuG9TWPi7Xd2q+lf7745TeR7XrLGhNwF+Lr5UxyRzmfLGYPuSF+b2/J
         nBeORtYaDouC0d9YJ3kxq1jnibTAtl6IuBCY7bi8yOy7Dd+r4cQhOcrlj2sFlyjA2g4E
         SQWhuCnrriiEvitMx/8BIVhaO1JtxJU9zWY8SF/BGlVhZ25YGNCYmoRcKn6N+u0k9lKY
         tepQ/lWoYD7HH5S0sNaMftkqEMvirHgYX0Y+SC0vv2uLt1T9HRz51gBQXGFuR8xzGpci
         lw/w==
X-Gm-Message-State: AOAM5336Y+xPbaP0VkKDesIUDvK0tOKX+M/wVs2cTKnibznjg4mEUcIV
        LNEGE9Nrq2kc0gtYl9Ng6HHmtQ==
X-Google-Smtp-Source: ABdhPJxbnv0wQeMddQlluY9O5pcY5u8TzvKuN4bf2b8PgHIYjZMViNvEKuwVnYxLt+tcNRzw9nnyYw==
X-Received: by 2002:a9d:7b41:: with SMTP id f1mr4658243oto.363.1592501801252;
        Thu, 18 Jun 2020 10:36:41 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g10sm836752otn.34.2020.06.18.10.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 10:36:40 -0700 (PDT)
Subject: Re: [PATCH] usbip: tools: fix build error for multiple definition
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hewenliang <hewenliang4@huawei.com>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20200618000844.1048309-1-borneo.antonio@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f914d6a1-20d6-2e00-bcf5-658848ad95a1@linuxfoundation.org>
Date:   Thu, 18 Jun 2020 11:36:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618000844.1048309-1-borneo.antonio@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 6:08 PM, Antonio Borneo wrote:
> With GCC 10, building usbip triggers error for multiple definition
> of 'udev_context', in:
> - libsrc/vhci_driver.c:18 and
> - libsrc/usbip_host_common.c:27.
> 
> Declare as extern the definition in libsrc/usbip_host_common.c.
> 
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> ---
>   tools/usb/usbip/libsrc/usbip_host_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/usb/usbip/libsrc/usbip_host_common.c b/tools/usb/usbip/libsrc/usbip_host_common.c
> index d1d8ba2a4a40..ca78aa368476 100644
> --- a/tools/usb/usbip/libsrc/usbip_host_common.c
> +++ b/tools/usb/usbip/libsrc/usbip_host_common.c
> @@ -23,7 +23,7 @@
>   #include "list.h"
>   #include "sysfs_utils.h"
>   
> -struct udev *udev_context;
> +extern struct udev *udev_context;
>   
>   static int32_t read_attr_usbip_status(struct usbip_usb_device *udev)
>   {
> 

Looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
