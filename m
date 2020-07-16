Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BB7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D552063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BgFL/rRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgGPPHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgGPPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:07:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE65C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:07:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so7457772wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rNCyo+FFvnC2UZxdcU8QTtjyFaSsGriTs2dXP21Pe/s=;
        b=BgFL/rRACcwmJHy/Ykn32bZV51U691kT1riDuQ4/klt2XViDGzFm3d6NL3u7LGTKvH
         kxFW6lsz316Us9RzCLYf4cJDXmGv16thKBul//CwCF6zj0MQ02BEl8YVwwU4jqKzOdGu
         /1Te4dEr0+U1umNhxGKd9azT2bTmxdLL6eX8j/L0cG0RxTg2govFZ5SafQI4xWufenvJ
         LorKAjGZ6UqPb27rDCIdw5NFGZ9isFkXLg3MukPzjGRrp1YhSONe+SP//F1T2pxC+PKv
         GKSP1yiAi1PqldNZ6ALC2CVxjEqb1luMVHA1lX2RoXbyLok4/WXETRuzcxblqjBp/Mb3
         r5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rNCyo+FFvnC2UZxdcU8QTtjyFaSsGriTs2dXP21Pe/s=;
        b=pAsTtLgdgvj9vOL/FdX/ZmXTewIvanFdo6kSluSblkwUVmK5yJWr5sgOARnZzZs2nN
         iOZhQqNMoPbYhMOHRXH4GJR2xrt2dZqWtyxrFVJeGNwzrZPUzHMYXf0AzHQ8LXFalWFO
         Dm35AEhkoP6W++gR3oOudMDHegwM0nc/YYxD/tqNAHKGMytqFnw1TNHaKnw8IeMdND6W
         XmVk5v7M5g9CZ9PUsVq/ARIXa+6zaTXV0+XHpTFO0smj4Pkrjx3C0g/IQN3hqnOW9nDU
         9MCx14HenzILwzNwoz8kExm1kbIKP1VcfHQD9XjyoOkyly6ED6NYMjIt1sCXax3YBFAJ
         ZFIA==
X-Gm-Message-State: AOAM530l81ND4HFVfaPL4gIlGzAqr6h+vp71lkgHadoL0dDcB2E9gFwW
        esE6WV5+9ZnpUpko80gtTOm0Vw==
X-Google-Smtp-Source: ABdhPJwCHUshKglLAc+ay11y2IYjTrNpXOqMIwK/Y2ZQFSA3ISESVOTAOpfJiOlxJjN4dq7onvAXIA==
X-Received: by 2002:adf:f784:: with SMTP id q4mr5433074wrp.397.1594912068298;
        Thu, 16 Jul 2020 08:07:48 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9637592wrq.13.2020.07.16.08.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:07:47 -0700 (PDT)
Date:   Thu, 16 Jul 2020 16:07:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [RESEND PATCH v3 2/2] mfd: da9063: Add support for latest DA
 silicon revision
Message-ID: <20200716150745.GX3165313@dell>
References: <cover.1594632559.git.Adam.Thomson.Opensource@diasemi.com>
 <9d9f9609125d5af7fc0bee024c76049cbfeeb287.1594632559.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d9f9609125d5af7fc0bee024c76049cbfeeb287.1594632559.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020, Adam Thomson wrote:

> This update adds new regmap tables to support the latest DA silicon
> which will automatically be selected based on the chip and variant
> information read from the device.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> v3:
>  - No change
> 
> v2:
>  - No change
> 
>  drivers/mfd/da9063-i2c.c        | 91 ++++++++++++++++++++++++++++++++++++-----
>  include/linux/mfd/da9063/core.h |  1 +
>  2 files changed, 82 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
