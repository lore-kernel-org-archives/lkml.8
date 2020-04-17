Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A94C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F180B214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hp61XEm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgDQIGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729495AbgDQIGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:06:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F15C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 01:06:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so1971867wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 01:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zdfOAuP7fyaW1ZeVyULlmT33DOYYP23f5Q8B9QajRJM=;
        b=hp61XEm/FGok8REvT3T074Wd8aZs0iWy57mOLbwQwMZJ4fXWTGHB/uBLrS8uABZB3z
         Ge7AjEe0ea/LPcRsyDaoj/3SfsO+9XJcvLBt2V2lO7eTmMbrwX4gbP8tTy4OGWFKZkI2
         el7svo/333VhxnyuleH4Bapz6a8oBvZ/lg3gRvR2n6JYFcwRzqo3/emiEUzSEVoO+QiB
         qrM9tDaFGqLxLgCp8DOxZU14nAeEJEXQTsWlxOfhVbYbvjpZu5h6KD9pVAviyer7rwGK
         K/uKTz/NJFf5MyvXRJ0d40YR+HD+RuwPDysK0i9kmNDFGi0SVvEW3NF/wRwSEm099Cxj
         YIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zdfOAuP7fyaW1ZeVyULlmT33DOYYP23f5Q8B9QajRJM=;
        b=sHGbaiuvVJxSap08CicaxF/0YPGq6502KjK0CtIqr2AUouyk+5PUruW/fIVHwSVyNm
         1ZIJAOsqp3i4Knyy40b0h+Vta/HZpMadQpAW5F1b60toYevVN+JrSO+4Aq0d7+P8U0U0
         Cq8sBOrtEHyiuoG9at1ktZdrya4yNsgO1Hw7c1yo7H4YLef730b3ywtZ1SXG0tRhPs92
         QN9UmCnaX9AqtmoCOaLiJC7O3jBYl6l8LR5DDZpGO9YVbqCzrcUiI4F7HvCqvT8itl5e
         KqEMloCCY4B0+Z9T7RTjG6mETBj7sBtslTsPAM1Zvjv3SQzhP2RaeCR8HzzEq3axk6wH
         0IRg==
X-Gm-Message-State: AGi0PubBszEyLvcSi9Vae1Z1dXKRDA4jgna2HJdUMsR83cEnkPVWTyrN
        YVQMHYI3OWOl3wk9FY6sElj1uQ==
X-Google-Smtp-Source: APiQypIr5rhPvU7gLyvcYwjnpws074PfDg+NI0F7JmZjX82UBiLQKJtlQDYychc2ykdFgdc5xHfxmQ==
X-Received: by 2002:a7b:ca54:: with SMTP id m20mr701534wml.45.1587110807651;
        Fri, 17 Apr 2020 01:06:47 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id u7sm7245869wmg.41.2020.04.17.01.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 01:06:46 -0700 (PDT)
Date:   Fri, 17 Apr 2020 09:07:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 01/13] mfd: Add i.MX generic mix support
Message-ID: <20200417080747.GE2167633@dell>
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
 <1586937773-5836-2-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1586937773-5836-2-git-send-email-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020, Abel Vesa wrote:

> Some of the i.MX SoCs have a IP for interfacing the dedicated IPs with
> clocks, resets and interrupts, plus some other specific control registers.
> To allow the functionality to be split between drivers, this MFD driver is
> added that has only two purposes: register the devices and map the entire
> register addresses. Everything else is left to the dedicated drivers that
> will bind to the registered devices.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/mfd/Kconfig   | 11 +++++++++++
>  drivers/mfd/Makefile  |  1 +
>  drivers/mfd/imx-mix.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 drivers/mfd/imx-mix.c

For completeness - Arnd's reply to this patch:

  https://www.spinics.net/lists/linux-clk/msg47703.html

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
