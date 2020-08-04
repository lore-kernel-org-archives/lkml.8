Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73D6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F6920842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw3bXyot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgHDV1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgHDV1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:27:41 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B28C06174A;
        Tue,  4 Aug 2020 14:27:41 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i92so2127977pje.0;
        Tue, 04 Aug 2020 14:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TlZPG/7/Hcy0XpMuv6WWnygJ4Kd+cRDvXfcwELgJ9co=;
        b=Lw3bXyotIG4kR/5OtETzRwfdzUObiA6cJOcX5K/iciQqhBZujt6cVupZCKPlMl+r1A
         2l6qoOTX15ui9ueiUfGTgPpV1oLU/5W7VeSD+zLmYwTK5Yh9cgGZIAuEesQgVTYLNlGU
         M3Jx58PlGWYspQSpbYCryddfm/mGLC7AHnIdjLINmY7qANFw9vhQdygQUAuOH/MK/L5e
         9AGfIcZplYVgWY9q+GnAapJVvwh58rQTVRwiYVkYq7Ul+YzdKJZrozWUUih5gf2YeakD
         BnIZN72C7BiBOqc31wgIvtFTBJglj5JE57D2gxA1QDUi8ua+jc+VK7P6jj9nn1IHDKRZ
         j+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TlZPG/7/Hcy0XpMuv6WWnygJ4Kd+cRDvXfcwELgJ9co=;
        b=H90vGegUc0MZDs2k8WEWRYJdX4XdgbYKV6cedGlCub5seOxBoWzkUewkmQaookYSpy
         ZWffNXprvGuycqw5FWXScWg2mJgxxGuC5o1CifoiqJHfkDCaO5sbYr39+2WVPCD1SS69
         B1kSKKllcTak7xW6eD+gGGWAL5L8WDZzapHojJRCmaLAHUu09sPLQWL2QrZnwOKLFsrV
         onuCOntESo/AV1xyQNRhCwqoI/rpOMywfgun9WQJ2oILwiulOvCdPGyFoa/kYKAp52O0
         +R7L1Aw8iD++k/41nPe8UR+akpyOLCzxm7q8L2ysOqZ1wUpjd71Hvr//zhBErNusQf+y
         eB4A==
X-Gm-Message-State: AOAM533Ua4+G0HvPxae0oUdhJyrb6lg7IfzdpcL1mt9eLA7MIGg151Tb
        JbPFu2w+oJjESlHLZRUTTGg=
X-Google-Smtp-Source: ABdhPJzg/DGrENEBIYBsb3BwepNHOakfxU+E6nXd5DkqkF7hUMmxOgDVKGq7MakHGJNNuu1YTXkHHQ==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr199226pls.285.1596576460689;
        Tue, 04 Aug 2020 14:27:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l21sm35861pgb.35.2020.08.04.14.27.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Aug 2020 14:27:40 -0700 (PDT)
Date:   Tue, 4 Aug 2020 14:27:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, nuno.sa@analog.com
Subject: Re: [PATCH] hwmon: axi-fan-control: remove duplicate macros
Message-ID: <20200804212739.GA218807@roeck-us.net>
References: <20200803054311.98174-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803054311.98174-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 08:43:11AM +0300, Alexandru Ardelean wrote:
> These macros are also present in the "include/linux/fpga/adi-axi-common.h"
> file which is included in this driver.
> 
> This patch removes them from the AXI Fan Control driver. No sense in having
> them in 2 places.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/axi-fan-control.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
> index 38d9cdb3db1a..e3f6b03e6764 100644
> --- a/drivers/hwmon/axi-fan-control.c
> +++ b/drivers/hwmon/axi-fan-control.c
> @@ -15,10 +15,6 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  
> -#define ADI_AXI_PCORE_VER_MAJOR(version)	(((version) >> 16) & 0xff)
> -#define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
> -#define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
> -
>  /* register map */
>  #define ADI_REG_RSTN		0x0080
>  #define ADI_REG_PWM_WIDTH	0x0084
