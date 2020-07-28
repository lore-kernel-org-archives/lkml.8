Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B90C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D097C2065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqqVBJtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgG1GnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgG1GnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:43:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C637C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:43:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r4so14139054wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PEyyokjjuIzOHJWToJ1uYDFOw2ElGPDs1QjI31k7aZU=;
        b=aqqVBJtHEPmeTQzyQPzuQVXHHoQ/pNis//A6zal8T2xtUi7xxxqnfU5nNtf4ke4PRi
         QvDnYrEvKYr2f/Is8c4qbGMPgH1ZrtOQckOLMMq2fhTb49RRkeu7aY0HxKZey/tgJhLC
         9tVcwNBtxaay1c2W41OeoLzmG8jptIJ8O6IUpg+u54rnVP71N3Tw09pWAxjVJFjefPmW
         a0LHf22hKKUWn7tRVyZHwwjhNCDL4eAMiHsxO/GF8LY3b06VW28+2Esol7/LmCtJGBrf
         HIDBN4cMbPgyePRzFdqr4naUQY5mdQrjBXFyzkTQIcTyJlEtZx5J8JRIl81jHCK/nnbI
         Oi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PEyyokjjuIzOHJWToJ1uYDFOw2ElGPDs1QjI31k7aZU=;
        b=fmlvrqDvunCbnh2ZrH+pGPKIFvsSh9BJdyqLoRSj5x4bwFEnWq403wHlDQMb8IDF/E
         5dpjmzCaJJRTQnZ4w+3Wt8L2kN8ELVreLNFHz6B9JC0sDrG+2WismKbH2m3fAKE6QiX1
         jP+04IvlYfiwqrTDwc4hPiO5nFeDQqnqb0b9u7X5+b6WjOLfX6JGoOVjb2GKTVm01tiz
         MTEHNSnuTG4l2WeqSLQtOWKU3LafKe7oObT0aUU/9pRqW+WDpnvZsDofzDPw9Ge9VWT+
         wlpe50ZwplluFXD9vsfLWFth1r/467ZhRm4SxPHvWYrKtX9Tlw2Onw3Ks607IldustET
         z1Lg==
X-Gm-Message-State: AOAM53253Ob3Hspee1EN9+6RJHX15baIOr9MHREdcnZXeHR2k4/PnKoI
        M2FRwUP1kBvQZhclPi/D0SIiVg==
X-Google-Smtp-Source: ABdhPJwVXoe0UeXSn+WViV0QpvvtjaE0lw5j1emPz6pC149EibUoc72LkGlOlwSQmhQzUMbw+5N9lQ==
X-Received: by 2002:a5d:664e:: with SMTP id f14mr23509500wrw.6.1595918582237;
        Mon, 27 Jul 2020 23:43:02 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id g7sm15800842wrv.82.2020.07.27.23.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 23:43:01 -0700 (PDT)
Date:   Tue, 28 Jul 2020 07:42:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Subject: Re: [PATCH 4/8] mfd: Add support for the MediaTek MT6359 PMIC
Message-ID: <20200728064259.GA1850026@dell>
References: <1595509133-5358-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1595509133-5358-5-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595509133-5358-5-git-send-email-hsin-hsiung.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020, Hsin-Hsiung Wang wrote:

> This adds support for the MediaTek MT6359 PMIC. This is a
> multifunction device with the following sub modules:
> 
> - Regulator
> - Codec
> - Interrupt
> 
> It is interfaced to the host controller using SPI interface
> by a proprietary hardware called PMIC wrapper or pwrap.
> MT6359 MFD is a child device of the pwrap.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/mt6358-irq.c             |  24 ++
>  drivers/mfd/mt6397-core.c            |  23 ++
>  include/linux/mfd/mt6359/core.h      | 133 +++++++++
>  include/linux/mfd/mt6359/registers.h | 529 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h      |   1 +
>  5 files changed, 710 insertions(+)
>  create mode 100644 include/linux/mfd/mt6359/core.h
>  create mode 100644 include/linux/mfd/mt6359/registers.h

Looks okay, in general.

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
