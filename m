Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B41C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DD2207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="va0D27Lt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390228AbgFYGqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389663AbgFYGqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:46:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D01C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u26so5992048wmn.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2mKsGbb/PtyAVg9ggk1Hz11lyz25s2kgotXpuPO+cU=;
        b=va0D27LtDcF26UdSeyL0kkvFbOHBO1SeIpvY5r8WAMDpK/CuCoK6gWg7iSvitAeRaA
         ryg7SmradwXnqeEyywbJGFve2MOz/IujZphJ+CKI08KZftt8JvUgjx3ALYfqDAdSExgd
         HFdT4fk2Ys9jpWVzhGrmy6a9OlzwxMTl/hUthhMkgSFKi1SIOa6GcBG9oyZcebXLBZip
         m41Z5wANw8Seya5ZA7FXHiz7X8tSKqWX8afSxQcytVP36TcVt6gAXVYiuDMDmDzfss/o
         IYL49zByXMBr9NcuNAqRE9msPHvNrfyCmu1lgqgRm+/WycTKKMpJ0a+kxAcG5smLTvte
         pT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2mKsGbb/PtyAVg9ggk1Hz11lyz25s2kgotXpuPO+cU=;
        b=rVVYdWQj4jINLfXLt+8CW+DB3FdC+05lO1DUhdhazqeOD4AecTNfxsSUqSY9gFy9cj
         ybkuKLlBnEtsx8pw9CIZ+CLcihf4y8Msub9urey0Z3+SPaFEgaeX89c5o2YQCSLyl2gH
         R+qR9xugo4Ac0hF/f20fif914zIMy9IknCxa/XbspLSSURR5t1nTVPGRu13+kHF03AK9
         X/IKULGNfcSty1409FHGrlsEcjvMwBaWltGVoy908GrpI7lnuegHiKdKvo5nnr2mrD7J
         nEzUhHuMds6bJOXDEI+KeNP5zhTsFa8oh+uGelsIrF2eTDg9bOkp2RuYizfNUyi5I58M
         Xqjg==
X-Gm-Message-State: AOAM531nKjAKjF6FpP+lrWiBBGxUSt+xeHWDgkOLxlEy3J2Gp+QA8b1x
        9GCA1lfG+y4i2NAhfNq9YQ1eTX3MGhs=
X-Google-Smtp-Source: ABdhPJyhOlpqerGDG90ewZ1q/iBssKLA4GRwer9f7Kth+G9Ad0uiipRFOOtXx5GsQxexwKswpwtZRw==
X-Received: by 2002:a1c:2901:: with SMTP id p1mr1744242wmp.144.1593067590752;
        Wed, 24 Jun 2020 23:46:30 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id c20sm27235363wrb.65.2020.06.24.23.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:46:30 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/10] mfd: db8500-prcmu: Remove incorrect function header from .probe() function
Date:   Thu, 25 Jun 2020 07:46:13 +0100
Message-Id: <20200625064619.2775707-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625064619.2775707-1-lee.jones@linaro.org>
References: <20200625064619.2775707-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not only is the current header incorrect, the isn't actually a
need to document the ubiquitous platform probe call.

Cc: <stable@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/db8500-prcmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 9b58b02967638..a9d9c1cdf546b 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3006,10 +3006,6 @@ static int db8500_prcmu_register_ab8500(struct device *parent)
 	return mfd_add_devices(parent, 0, ab850x_cell, 1, NULL, 0, NULL);
 }
 
-/**
- * prcmu_fw_init - arch init call for the Linux PRCMU fw init logic
- *
- */
 static int db8500_prcmu_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-- 
2.25.1

