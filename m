Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9128C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8BF2078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OG1w4BWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgH1KN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgH1KN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:13:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FC2C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:13:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x7so772239wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=h1Z8yKolwImpBZm4vZoh56lMtH1TA77Qyt7l6P6U/eU=;
        b=OG1w4BWn9/mHkTCU/pdvp5aB/I6aCQXuHdeLIlWpfqZHTvMTF/z8I1Il8SLyfPc1B/
         cnWOpmrN6ZzX0khvczpQlZNh/aOxpRKL1V0cDaI+Mn6HEifROUoGTjxHjvVIJ3ykQcxi
         V1pUWUhfB2pKjxPrrO7aLImW7dOGVAEMxnnYyvXdLppSUf7V7J4bpJoA6mY72w3BbzrU
         BQKi8r3GLolgGp6XHyG4K3XRFCKnOBRKjnR2kv+ziiZVA3ccY8TxN6uHfG3i7NPGHgwB
         OMLjN0wcfwYubu1NQVGL2WFISnF6+fk5awmW2dBcMf4xY82D88UToVsOGxTygDdzU2ZC
         TYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=h1Z8yKolwImpBZm4vZoh56lMtH1TA77Qyt7l6P6U/eU=;
        b=IY/6lRmVQuaQd5yXI6Ojv71VrLK8zOVyxJf4/awyS6+4HA5bPxu+R8AKz/HtptWe6n
         WePptmk1IciJdwc8kcHWrqS1kWICBJgRHPBdIxGWFvsghOXwe6SozRq0E+Oe/eo9q33S
         BxkbDGR7mBF7zBj4blAiACPlr40+6YbE4esoyJlsmnX0qbqEGjJNq2Z2miOlwrum8vjE
         CDcW8LP2YBKBqoVZ4d9gPxSqs8A2S+AmVDDhWuaHqFDQ+X0j3K3wdxmE7xOOB2ERtEui
         zNM8/VCiJshGq5y2Ph6p0p1+xyNnyMP/Xg7zM2RgeUWbtYEj3O93vAUKxnuVu2ajOJyW
         8KuQ==
X-Gm-Message-State: AOAM532u4B5AFLpWsS0cJ0IbnDvwXUS5aGFsjtZ4o6ipWHCZRJq4hnIe
        VKLAqHEr6Q9Z8bNc/4JNFf2sZw==
X-Google-Smtp-Source: ABdhPJwO3pB7agtO7zGGl8nx+0MCselqiJliucfcqBvORbTlQ1UsgZtj/ZpMZRgbSBgmUf5NPSuOsQ==
X-Received: by 2002:a5d:42cc:: with SMTP id t12mr822722wrr.214.1598609635277;
        Fri, 28 Aug 2020 03:13:55 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id v29sm1178001wrv.51.2020.08.28.03.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:13:54 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:13:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v4 8/9] mfd: mt6360: Fix flow which is used to check ic
 exist
Message-ID: <20200828101352.GL1826686@dell>
References: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597661277-27862-9-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597661277-27862-9-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Fix flow which is used to check ic exist.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
