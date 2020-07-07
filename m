Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA359C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9467420675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcxeUoQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGGGrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgGGGrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:47:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF05C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 23:47:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k6so43928169wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 23:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pAUaHQGnD3+ZIQQ0Oy5xYapqsREaQJS2n89f+4B15KI=;
        b=RcxeUoQCIgWgnkUSLjmg4dR9sste/vAvBkd1Op5/YaTwssHXSeVR5xiejR22wncB2a
         8Uw9tPYNBl5p5Kj4Hkq+/DMOXE1y0AdFAr2ozkV3c1eIApLwPoQwwdqY2rGztBkf6GJb
         P92aouXq2/SYzxIFHEBXJt6ATRyUuAlJWmhbQfznUC/Qx2FTiAu7vCiPZOCi7a+cwPCo
         dXL8QeCYXg9L+YfGSYnn1q0C5vEMfitOXAoz9a/6/ZhJ5JjD45/YhsJNQw+w6kGMkrrd
         focvXNgM6OYhXUegweM2C+oISvCa5HGv+OTgKeAb58vB71CIHXjx2NUEMgyjDPO7nNYm
         Ribw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pAUaHQGnD3+ZIQQ0Oy5xYapqsREaQJS2n89f+4B15KI=;
        b=gnjOw8oGqb4rGQGx3ZkWygzi3KzqFLTlyowJ6nLkJf1gE5p0yI5y8l1mZt25zLY+jq
         Gjf+p8OntoXOPUtUz/IrsGAy4i0Gw01YB9wrYxSelpIS+H5Zo94ZyJ6RRrp/ZJZZEs40
         0Wp6VywASdo7YmPZ4A0gVVWEb5u4Tgay6rQS0APfsnq/y1yod+1qjPBzDnftee7ExWZ+
         lx+WJCjZaGbkFjIUrAwNSHw/AjLCZ9synwJLPtmSmMWIB5E5nZ69bO9eY3R6cANxVyuR
         vkGqr+9aPwWxCrZGC19Ore3Xf7dI2ulV1zsPbw+h6zjl1nlMNy1fYBo2QG2WrX0G+R0C
         kS9g==
X-Gm-Message-State: AOAM533nmZrRlXA4L0EXBCpJ2wtDVx46DXmaV17qGZvbrn+CKc00Tgpw
        lK/MIM3iqWHzHURvppEEbwFNBQ==
X-Google-Smtp-Source: ABdhPJxYZ9YrCD0dzxdBWyfKxvHKA5xY3Xb6yXZlFWOzNnNc4LwDgOikVdB+P6BMLX5ckmH/XmThTw==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr48558121wrv.380.1594104424095;
        Mon, 06 Jul 2020 23:47:04 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id d2sm27489648wrs.95.2020.07.06.23.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 23:47:03 -0700 (PDT)
Date:   Tue, 7 Jul 2020 07:47:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2 15/15] mmc: host: sdhci-iproc: Do not define 'struct
 acpi_device_id' when !CONFIG_ACPI
Message-ID: <20200707064701.GC3500@dell>
References: <20200701124702.908713-1-lee.jones@linaro.org>
 <20200701124702.908713-16-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701124702.908713-16-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI,
'struct sdhci_iproc_acpi_ids' becomes defined but unused.

Fixes the following W=1 kernel build warning:

 mmc/host/sdhci-iproc.c:297:36: warning: ‘sdhci_iproc_acpi_ids’ defined but not used [-Wunused-const-variable=]

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 225603148d7de..e2d8dfe90077e 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -294,12 +294,14 @@ static const struct of_device_id sdhci_iproc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
        { .id = "BRCM5871", .driver_data = (kernel_ulong_t)&iproc_cygnus_data },
        { .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
        { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
+#endif
 
 static int sdhci_iproc_probe(struct platform_device *pdev)
 {
