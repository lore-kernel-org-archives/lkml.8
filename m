Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226B7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E3A20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xS0+pcVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgGAJPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgGAJPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:15:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCADC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:15:21 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so20934861wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 02:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AnYLIkeHE6sj58+nv0/Vk5hg57FNjdW3Ac6WAVrff6s=;
        b=xS0+pcVkWqEMdrN3G6PRZZ72teAo9M8JSk2x57oODJObiFNfviodK5FYKFimXG5Gfz
         vV3O2WkFiGUMZ40b7RlPP1wskQ1M//TbbPzaKSpKlroanc9aIPdlAZPRKQloznTkjSlX
         /U7M2wq99kVsVQTywWCUpk9dliR8PGHSgcoU+tp3JF5SK1L6U/OcIhPYXOv1Ejm+4oDU
         B7Qjup19Sjr9DP+30D8R+6nNJuS8fY0T2Tv5UygsEz7nR+qsH7YzKLbtv0azCGkgygh2
         O0YsS2HHs4iOrs2K28Mj9gjWQ5dD0pko8MsL5QP1qSHBoKEWPdhJDWwHqs5qPs8S840z
         idHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AnYLIkeHE6sj58+nv0/Vk5hg57FNjdW3Ac6WAVrff6s=;
        b=ES+ZYY+hPOh9LMaiEsV7ZjJ9nOiKTGEh/sk1HAeMlq+kSGv5SE2gEZENiFXpnivjO8
         sRv3Tzjh0bpVIh7imCwPLGz4tAAi5DbYbSRON8zXGdNiB1/k6232bBNvJLn3lPFsE/UN
         VZkTXXIRy6Wt9khXbl9fOf1sWvQjkrpfrWq9MHKb1nPtxDdCNhaUSTYNraPrau7OxYJd
         r/1XR0HZlTCZVXXq/Jytv4Qz1II3CTArHxaULl3+3zVo4MaYvOF+rDOrXcDS0scS7OSN
         rH1WrhUVFdYRZlp6jeoD6VHrmTJVT2Ou9JC5PeU9fM9HTn8vUcqGnKgGozMXbQoA8lXE
         Yt/Q==
X-Gm-Message-State: AOAM533hMLQGELf9hjVAUsCglnPsbUdMyU8h/tjqAAHGBSH8sBB7wm0i
        Hkhx8buXuoCJu65HDaCT5DfS2g==
X-Google-Smtp-Source: ABdhPJyeOgaXiHTz+gCNHlzMD8MWNNPfQrblF7m7rJMPcUQ3GQpi7aApPikTlIkbvswu85ysGKIAcg==
X-Received: by 2002:a7b:c8c2:: with SMTP id f2mr24483326wml.57.1593594920333;
        Wed, 01 Jul 2020 02:15:20 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id f13sm6174611wmb.33.2020.07.01.02.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 02:15:19 -0700 (PDT)
Date:   Wed, 1 Jul 2020 10:15:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     johan@kernel.org
Subject: [PATCH] mfd: sprd-sc27xx-spi: Fix-up bogus IRQ register offset and
 mask setting
Message-ID: <20200701091518.GW1179328@dell>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
 <20200629123215.1014747-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629123215.1014747-5-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'i / pdata->num_irqs' always equates to 0 and 'BIT(i % pdata->num_irqs)'
always ends up being BIT(i) here, so make that clearer in the code.  If
the code base needs to support more than 32 IRQs in the future, this will
have to be reworked, but lets just keep it simple for as long as we can.

This fixes the following W=1 warning:

 drivers/mfd/sprd-sc27xx-spi.c:255 sprd_pmic_probe() debug: sval_binop_unsigned: divide by zero

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Suggested-by: Baolin Wang <baolin.wang7@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index c305e941e435c..4a1a61e1a86ea 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -251,10 +251,8 @@ static int sprd_pmic_probe(struct spi_device *spi)
                return -ENOMEM;
 
        ddata->irq_chip.irqs = ddata->irqs;
-       for (i = 0; i < pdata->num_irqs; i++) {
-               ddata->irqs[i].reg_offset = i / pdata->num_irqs;
-               ddata->irqs[i].mask = BIT(i % pdata->num_irqs);
-       }
+       for (i = 0; i < pdata->num_irqs; i++)
+               ddata->irqs[i].mask = BIT(i);
 
        ret = devm_regmap_add_irq_chip(&spi->dev, ddata->regmap, ddata->irq,
                                       IRQF_ONESHOT | IRQF_NO_SUSPEND, 0,
