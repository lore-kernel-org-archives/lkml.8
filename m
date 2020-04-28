Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDCDC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235E4206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XK+3/aOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgD1HJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgD1HJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:09:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9733FC03C1AA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:09:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so23261236wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lMEa6R/eYAIqk1WFDzSBGM7+C3iUTrOyPMrRdGdHxQI=;
        b=XK+3/aOKMdWUeiVuCoBZONtKCMfLLzYajSsCKOXfvsR6utqJUQhr+6FIry9ABFD6g1
         HFBeJpmo1mf3rvsdRFrXS8PXKlhAuKWiCd9I6K7lZfGYcZJ79v1T5YimjffH0G9yj87q
         aLSE8hWboyqXwcsegUE2bW4HB/6ZE6+LDN9X1l6E91g1+1xWVoCwP/OTOeOQUY/bk+IP
         ZYMbzeihgHkWc2ALWXiCsvcM6w3y3gNigL8hdyGqEsu+u9b0PIBuG+nKgpYIEUEBlD65
         LRvndNI/a7Stuwyeb/MaYykxFCyRuZKjpvL/mlSn+6riTQ/VGOs0cZMmhJ1yKIhho5/C
         9frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lMEa6R/eYAIqk1WFDzSBGM7+C3iUTrOyPMrRdGdHxQI=;
        b=QzEmaq8UDm/wP4T4bdzbtB04XptoBm3QbRs7L4lsJlnMCO36IeH5BtlrCgzuNAEcUH
         2zL5XwLwSv6qViGI30TmqtUJCTH5+kcPf9VFtqapK5chGZFjk2qpMENbUnRTqXdwuBkm
         iKHIx5tht3NteADHKtskh8ULytNwzdUFGHAjdVpX0O4SzXcLw7j4ICZ+PPSMVf/Ofwrh
         lQyaZ5EIwBlssboszk+NsWe52PGFsy5XCanu9LbRL9FQor7Rc8bd08KN0tZZKty0Y1A2
         BkHXVLvxbwDgQMmPfA8GZnCWTc/PssWRCCSYt5zEUBILUz/lQ2azv8fUwGiT0SIKhWKC
         5EIQ==
X-Gm-Message-State: AGi0PuaeJ5DiY4e4Qpk78PlpZgKYB6w6XSqt2Zf1DyHYtOxwlNrZ0q/3
        fwo3w1s6d6LSB+Xi30PKvVlesGT9vcc=
X-Google-Smtp-Source: APiQypK0KOM5V4C2Z5llck0w8pFFM5So+4+1Ay4saK2Pj2qjCPKB3yWrM321BmZUfw8SL8WDLVr+bw==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr31406670wrv.314.1588057796054;
        Tue, 28 Apr 2020 00:09:56 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id j4sm23732081wrm.85.2020.04.28.00.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 00:09:55 -0700 (PDT)
Date:   Tue, 28 Apr 2020 08:09:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Milo Kim <milo.kim@ti.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] backlight: lp855x: Ensure regulators are disabled on
 probe failure
Message-ID: <20200428070953.GI3559@dell>
References: <20200224140748.2182-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224140748.2182-1-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020, Jon Hunter wrote:

> If probing the LP885x backlight fails after the regulators have been
> enabled, then the following warning is seen when releasing the
> regulators ...
> 
>  WARNING: CPU: 1 PID: 289 at drivers/regulator/core.c:2051 _regulator_put.part.28+0x158/0x160
>  Modules linked in: tegra_xudc lp855x_bl(+) host1x pwm_tegra ip_tables x_tables ipv6 nf_defrag_ipv6
>  CPU: 1 PID: 289 Comm: systemd-udevd Not tainted 5.6.0-rc2-next-20200224 #1
>  Hardware name: NVIDIA Jetson TX1 Developer Kit (DT)
> 
>  ...
> 
>  Call trace:
>   _regulator_put.part.28+0x158/0x160
>   regulator_put+0x34/0x50
>   devm_regulator_release+0x10/0x18
>   release_nodes+0x12c/0x230
>   devres_release_all+0x34/0x50
>   really_probe+0x1c0/0x370
>   driver_probe_device+0x58/0x100
>   device_driver_attach+0x6c/0x78
>   __driver_attach+0xb0/0xf0
>   bus_for_each_dev+0x68/0xc8
>   driver_attach+0x20/0x28
>   bus_add_driver+0x160/0x1f0
>   driver_register+0x60/0x110
>   i2c_register_driver+0x40/0x80
>   lp855x_driver_init+0x20/0x1000 [lp855x_bl]
>   do_one_initcall+0x58/0x1a0
>   do_init_module+0x54/0x1d0
>   load_module+0x1d80/0x21c8
>   __do_sys_finit_module+0xe8/0x100
>   __arm64_sys_finit_module+0x18/0x20
>   el0_svc_common.constprop.3+0xb0/0x168
>   do_el0_svc+0x20/0x98
>   el0_sync_handler+0xf4/0x1b0
>   el0_sync+0x140/0x180
> 
> Fix this by ensuring that the regulators are disabled, if enabled, on
> probe failure.
> 
> Finally, ensure that the vddio regulator is disabled in the driver
> remove handler.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/video/backlight/lp855x_bl.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
