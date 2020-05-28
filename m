Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E164C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36945208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590706243;
	bh=DgfUyVWbJRlk4YEf2niNexwxfxn8tRuXFPrjjQrh2JY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=L0jPfSW30RPLUM7L2reSEuKvP4/fYLmLsVFxpDiR2p7C8FghnTSOWn0ajmv/a6ErX
	 Z1UqvgxWDuktJcsa/+/f8368qs1y4EG5SqAAodItspVLp3E0m8LnOCVU+C4Hm/osZq
	 /lx/f56XIePgmqIHL0/eA6HJdbPMotBiyUFBPTQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437360AbgE1Wum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437277AbgE1Wuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:50:39 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C3FC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:50:39 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id v128so771243oia.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=csvE8B9NObrx6Z6u0s31dzfK5G3kL5lknGsNZ4HgzUY=;
        b=f91ZHvUnnUuUyEPs8F+1h7EZTnYqrnj607Y+Teopym8lgL8vPJyuLayeCRdwnWXfdZ
         dphgysRgodNh05q5bMX9hdXqQla3mR8uHNxJFcV2ltRtKlLo+wd4O8lkkUbZoSQz3UMM
         0RcJ2wg9pvQrBw54gGT0yTZ9rNF+7jj7lov3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=csvE8B9NObrx6Z6u0s31dzfK5G3kL5lknGsNZ4HgzUY=;
        b=HnPbogq0krgUev+1aTRMFn8trzraPhdQ0jn0sTVLvSEU107kXuXipmZs1SIPJEHwye
         iaYdJJoi0a2yRTDqTde6DTm+CFHNTKEo0nHj/XDd219JXEdtXPdjbjDfuqhYmXxhCW+c
         E0cw72efqrHvJc8NRQojT4U7nAZFeYW0y1OhA9AYZrGsQUNW7mp4xCIs4HVV2O29gntr
         dNsiolAzKyNLCdlBiZiqj7A5fnvaei75sgDVO0GXUyQhcibMm0IH4fd10G4TaHyr02eO
         lzzDxTRy+IQqHpS+pE/lUTcrzDYvCCROUS+UIRMt4haOalUpPmWs3FQjgP+YN+SAIQp4
         5fqQ==
X-Gm-Message-State: AOAM5332Gp10wxzhCOHVkqxvZ/rwULt5e9L3UsYFXmjf5t50V1ebWfKz
        4A0iCTLoYQ9Xj8TjRzZgs7oWLw==
X-Google-Smtp-Source: ABdhPJxRChsgcY0pJfdxAbM0G8c9t7bFLwwgX5Mh8OtIGV5PP90XtzFfQu8QSJhF2Pi5TyiXzr9J3A==
X-Received: by 2002:a05:6808:1c8:: with SMTP id x8mr3742504oic.30.1590706238485;
        Thu, 28 May 2020 15:50:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a64sm43393oib.43.2020.05.28.15.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 15:50:37 -0700 (PDT)
Subject: Re: [RFC, WIP, v6 01/10] media: vidtv: add Kconfig entry
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        mchehab+huawei@kernel.org, sean@mess.org,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        tglx@linutronix.de
Cc:     linux-media@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200520070334.1778751-1-dwlsalmeida@gmail.com>
 <20200520070334.1778751-2-dwlsalmeida@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5fa52855-7f99-1e35-9116-6e165a92e23c@linuxfoundation.org>
Date:   Thu, 28 May 2020 16:50:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520070334.1778751-2-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 1:03 AM, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Add the necessary Kconfig entries and a dummy Makefile to compile the new
> virtual DVB test driver (vidtv).
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>   drivers/media/test-drivers/Kconfig        | 10 ++++++++++
>   drivers/media/test-drivers/Makefile       |  1 +
>   drivers/media/test-drivers/vidtv/Kconfig  | 11 +++++++++++
>   drivers/media/test-drivers/vidtv/Makefile |  2 ++
>   4 files changed, 24 insertions(+)
>   create mode 100644 drivers/media/test-drivers/vidtv/Kconfig
>   create mode 100644 drivers/media/test-drivers/vidtv/Makefile
> 
> diff --git a/drivers/media/test-drivers/Kconfig b/drivers/media/test-drivers/Kconfig
> index 188381c855939..7d273a8a7acc2 100644
> --- a/drivers/media/test-drivers/Kconfig
> +++ b/drivers/media/test-drivers/Kconfig
> @@ -4,6 +4,10 @@ menuconfig V4L_TEST_DRIVERS
>   	bool "V4L test drivers"
>   	depends on VIDEO_DEV
>   
> +menuconfig DVB_TEST_DRIVERS
> +	bool "DVB test drivers"
> +	depends on DVB_CORE && MEDIA_SUPPORT && I2C
> +
>   if V4L_TEST_DRIVERS
>   
>   source "drivers/media/test-drivers/vimc/Kconfig"
> @@ -24,3 +28,9 @@ config VIDEO_VIM2M
>   source "drivers/media/test-drivers/vicodec/Kconfig"
>   
>   endif #V4L_TEST_DRIVERS
> +
> +if DVB_TEST_DRIVERS
> +
> +source "drivers/media/test-drivers/vidtv/Kconfig"
> +
> +endif #DVB_TEST_DRIVERS
> diff --git a/drivers/media/test-drivers/Makefile b/drivers/media/test-drivers/Makefile
> index 74410d3a9f2d2..9f0e4ebb2efe7 100644
> --- a/drivers/media/test-drivers/Makefile
> +++ b/drivers/media/test-drivers/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_VIDEO_VIMC)		+= vimc/
>   obj-$(CONFIG_VIDEO_VIVID)		+= vivid/
>   obj-$(CONFIG_VIDEO_VIM2M)		+= vim2m.o
>   obj-$(CONFIG_VIDEO_VICODEC)		+= vicodec/
> +obj-$(CONFIG_DVB_VIDTV)			+= vidtv/
> diff --git a/drivers/media/test-drivers/vidtv/Kconfig b/drivers/media/test-drivers/vidtv/Kconfig
> new file mode 100644
> index 0000000000000..22c4fd39461f1
> --- /dev/null
> +++ b/drivers/media/test-drivers/vidtv/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config DVB_VIDTV
> +	tristate "Virtual DVB Driver (vidtv)"
> +	depends on DVB_CORE && MEDIA_SUPPORT && I2C
> +	help

Add one line summary/name for the driver "Virtual DVB test driver" is
a good description.

> +	  The virtual DVB test driver serves as a reference DVB driver and helps
> +	  validate the existing APIs in the media subsystem. It can also aid developers
> +	  working on userspace applications.
> +

Wrapped lines. Split this to read better.

Take a look at others e.g: drivers/media/test-drivers/vimc/Kconfig
for reference.

> +
> +	  When in doubt, say N.
> diff --git a/drivers/media/test-drivers/vidtv/Makefile b/drivers/media/test-drivers/vidtv/Makefile
> new file mode 100644
> index 0000000000000..d1558d84eeaed
> --- /dev/null
> +++ b/drivers/media/test-drivers/vidtv/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> 

btw. Did you test it with just this patch?

thanks,
-- Shuah
