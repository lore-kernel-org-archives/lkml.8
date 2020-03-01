Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26563C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 10:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E777521775
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 10:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="WFURwnTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgCAKEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 05:04:14 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45162 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgCAKEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 05:04:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id e18so8407212ljn.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 02:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gQOIXTEcnm6Zvy+v64CfP+Ch3mLFqBCQbXn3Tlz+cv4=;
        b=WFURwnTZQb7t133i6Ra+Rtg1WBZedlcLlLHCZn4uC75JNmyONO8Bj0u4Tbnk83la/Z
         qwMSzQBjsRNhGPCXMXUAlfenimSZGTMwJbTHXDTHnEHcUAb9hhWXtz8ELtd/1ktdMWHz
         q9PsTs1FbNVOH++uTHZStEGLEkHWtJG6yvJcHUzPqY/HyLX3uYPY2X09CaaI9Kj9CfOy
         Abw/ZiBYHclQfm2cpwWyKvV1NQNW35y+KW807sdzw0ylxlMrEH+nFUP++FVD/5RlJCfx
         X3MUBzk4HezPioiqEd+JdKaHp+aXd8MCs36eJxwm01Fl/u6hPoy4TTpONB0X3aB6KwbC
         oqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gQOIXTEcnm6Zvy+v64CfP+Ch3mLFqBCQbXn3Tlz+cv4=;
        b=Ko9NWDc64qUd0yl6RjpJUSiTtv41xtEnO469hQ3cTvosIaEi+HQ3RAKKtRCL3QpDBe
         ST2Qe1+vgtRIBOz4zhpvOMsIXz6YLT5RcaQ5dbxmuPjUnqU5Qt1R1YJUol7KECWXJh4h
         lJMTpD+fjSWLoGKSBCzU9r5O1h0xWy6xm4bCD0xUS4FcHsm2FvRGgh4GgLuvAPNgzeaV
         odrnSbBBZzLdg3iYtyr0GEAdV4kgWbUoFSWO3Nk25j0kJTeXUxrG9kn7BrSEWyEEGrmP
         jnbj3gxlGU5y6UxK7rHUr6iO0LR1DaI3sO0ODaijx29jkNTBRc/WJuhEPuoPbvBPYBpk
         niTQ==
X-Gm-Message-State: ANhLgQ3aQepphyaGGnVJNFvBHyMP58utEkiqe9W3HzNwCD8FkOpklL4y
        AxiUtaTdTCu27+dh+5WxdDrTqw==
X-Google-Smtp-Source: ADFU+vvqjg4oqW6Uft9xNiaGvdKNChYfA3uFUApT5e92F7fDueZjTaYxnnQS6pWe+xILajfzC2Bmmg==
X-Received: by 2002:a2e:884c:: with SMTP id z12mr8320982ljj.55.1583057050588;
        Sun, 01 Mar 2020 02:04:10 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:631:be36:41f9:a0d4:22df:3c65? ([2a00:1fa0:631:be36:41f9:a0d4:22df:3c65])
        by smtp.gmail.com with ESMTPSA id i1sm9597287lji.71.2020.03.01.02.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 02:04:09 -0800 (PST)
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device
 buswidth
To:     John Garry <john.garry@huawei.com>, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        andriy.shevchenko@linux.intel.com
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-2-git-send-email-john.garry@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <52ecb988-d842-c04b-a0e8-93e8850009c4@cogentembedded.com>
Date:   Sun, 1 Mar 2020 13:04:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582903131-160033-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 28.02.2020 18:18, John Garry wrote:

> Currently ACPI firmware description for a SPI device does not have any
> method to describe the data buswidth on the board.
> 
> So even through the controller and device may support higher modes than
           ^^^^^^^
    Though?

> standard SPI, it cannot be assumed that the board does - as such, that
> device is limited to standard SPI in such a circumstance.
> 
> As a workaround, allow the controller driver supply buswidth override bits,
> which are used inform the core code that the controller driver knows the
> buswidth supported on that board for that device.
> 
> A host controller driver might know this info from DMI tables, for example.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/spi/spi.c       | 4 +++-
>   include/linux/spi/spi.h | 3 +++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 38b4c78df506..292f26807b41 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -510,6 +510,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
>   	spi->dev.bus = &spi_bus_type;
>   	spi->dev.release = spidev_release;
>   	spi->cs_gpio = -ENOENT;
> +	spi->mode = ctlr->buswidth_override_bits;
>   
>   	spin_lock_init(&spi->statistics.lock);
>   
> @@ -2181,9 +2182,10 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
>   		return AE_NO_MEMORY;
>   	}
>   
> +

    What for?

>   	ACPI_COMPANION_SET(&spi->dev, adev);
>   	spi->max_speed_hz	= lookup.max_speed_hz;
> -	spi->mode		= lookup.mode;
> +	spi->mode		|= lookup.mode;
>   	spi->irq		= lookup.irq;
>   	spi->bits_per_word	= lookup.bits_per_word;
>   	spi->chip_select	= lookup.chip_select;
[...]

MBR, Sergei
