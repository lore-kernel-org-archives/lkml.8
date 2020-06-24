Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59029C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38940206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDV2gBaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404414AbgFXPHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404194AbgFXPHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:07:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6831EC061797
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so2631031wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0YMw50ghAnk+HJlng7jm1/7u29zz1+p4P4aWF+LxTM=;
        b=kDV2gBawSXjgK3E9pSWH7A3EwP21b+YwX9fkeeuRcMt8E5kiFMZWVW0uYtCNOKcJuj
         IlqNWloTM+FAEb+U0biu0LntpBbm0JAACtz0XyTEmV/gKbjUFfaJRomKsF4zGlZT6I6p
         LWpzY3Sh6pcWRuViXK7g/WZpDc1qvOlw/ZeK6Ed8mKvL+wr7SabH/mKNbAPxWZApEJFa
         gnE8MA+E6U/pAaKDfv5CX9jACfdEpHTXEEfxN3ZvrkXac3mtnPw7zaScjyiQv+xl5GaK
         nJtMTi3C+ufi2umQbtp/YQ4YV/LWR8gsuIQXPdgTB0GBXH/9BabuZmOM7P9L0JNXcm1i
         8fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0YMw50ghAnk+HJlng7jm1/7u29zz1+p4P4aWF+LxTM=;
        b=jzSu1Iq+/UbKp/wpoYn7e83bit3WpiR+SmYRkvHNt+85qHg14kmP+kWfSofNb8PfaS
         whZUipeEG7FrsRTJ01xCTvl/eUbCnVfy6PLm6zDQtNI2Y7m9fvQNi6XaGBSCELvrRC6X
         hlu4SxN6botsUcjHC5vygtD+lsj9mVeeBKgFR6gerlo/zkYtuKiY0OSl+qfCnmluIHXY
         b23JbSPUUd1nnihhmHxC0KTBZS80xRikMpxXqHltmSWS/sp4xTkPF+JoHa7G+/NNBNWG
         na3V8Jxk++tCY3WpzpAxzYDzoAf1SZuEpn1goOnu/0uAf2SLP+atxMpX+/RUbJUtJpSf
         wV6g==
X-Gm-Message-State: AOAM533karSX5FWp+Dz0qFLPY1kZ4O7bXd4woB2V2Ktn9CEtm3EdYQo2
        mJ30yGmQ/JuU4wdfQyiTJ92VVg==
X-Google-Smtp-Source: ABdhPJw7fzjIBqiuXbknQUNCT1qFwoGdpdovl6TpOoVdAxH9PdAL4zXdFmFzQ0XUdcgHG+7Xx0AVNg==
X-Received: by 2002:a5d:4611:: with SMTP id t17mr30149480wrq.243.1593011238093;
        Wed, 24 Jun 2020 08:07:18 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id h14sm11543361wrt.36.2020.06.24.08.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:07:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 05/10] mfd: sprd-sc27xx-spi: Fix symbol 'sprd_pmic_detect_charger_type' was not declared warning
Date:   Wed, 24 Jun 2020 16:06:59 +0100
Message-Id: <20200624150704.2729736-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624150704.2729736-1-lee.jones@linaro.org>
References: <20200624150704.2729736-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports:

 drivers/mfd/sprd-sc27xx-spi.c:59:23: warning: symbol 'sprd_pmic_detect_charger_type' was not declared. Should it be static?

... due to a missing header file.

Cc: <stable@vger.kernel.org>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/sprd-sc27xx-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 33336cde47243..c305e941e435c 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mfd/core.h>
+#include <linux/mfd/sc27xx-pmic.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
-- 
2.25.1

