Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C75C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FD620656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOEH+B4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgF2SxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbgF2Sww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1449C00F819
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:32:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so5092936wrl.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gy5XGROE42zu/OtGr1HVd4C1Erola+sMm0BAiQi5EAg=;
        b=EOEH+B4YAdFOH+2/KoijG8knN+YekUDS5ypT4nuQN27G/Jo02pRILBXHZJ5OmgwIYl
         UXsWDmJqnNK01epEhCxiKDeVnprl7cvBLEDFzU4upD4QbgxddQsrVIua0JmkNof+T46p
         K4zlsTPn6Bij6eu47CcKTpCxVL9+YccP45x5lupJxTtdoYfeNot2cE6OHksag/TRXaqi
         06zg1uc9lqpWNIqi73eXK1RH6cHkXEcQJrBllza8pnEY9j2cpAsvJZntWUYfLzaQRLFA
         LLLRkYrwGcKoLxgpMvKoMT3wFIdZx25ikmSAn6bQ0J3daVmzMXFMs3VR36S7QYHogK+u
         IpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gy5XGROE42zu/OtGr1HVd4C1Erola+sMm0BAiQi5EAg=;
        b=iiU3vKsoYHzV7nEtRFpOTLyfPbQxbkgUGUsC/SCfd9bWQLhIuskq+9CBAn9K4ZJyl+
         jdF13EasHF6amqBHH0P0aYM+VHMGwF8xWjJWV1MOVTFfk+VofTG8ehBqfyzWCwq6mC9q
         8RFR6Lb4vBqfr/agpF1o5elceKE4kUytk3qfNh0W12wBi35LiU+bCdkVATCBpe5qVifZ
         Ute4wxhrfOv73mIiGbfanjV9uaBexuWyL0fu+Rq/qA8CuYLsH8czzv8PdflItllOqxlF
         iZ3qR4N5GGpDsU1QRRbu3KGc0vFd6EEu03LvLUM0fGRDwL8NKTulAgJCM30rDIlV7ch6
         yFFw==
X-Gm-Message-State: AOAM531Kv5l4BOE0G7U7vSM6auDRwCGg62r7TwQt49EkxJWje8GJiFP2
        mTA2LcjArhzwOxn1b3q79dKTwD1fOII=
X-Google-Smtp-Source: ABdhPJzx1S6JaOHDpOE7Um5NlUKwwsXS6LziGKVWvGGhJ+ABrjXd+W/9XaQZh6Ee4qGBqKImmEb7XQ==
X-Received: by 2002:adf:f842:: with SMTP id d2mr18183246wrq.55.1593433943756;
        Mon, 29 Jun 2020 05:32:23 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id d201sm28064111wmd.34.2020.06.29.05.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:32:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 4/5] mfd: sprd-sc27xx-spi: Fix divide by zero when allocating register offset/mask
Date:   Mon, 29 Jun 2020 13:32:14 +0100
Message-Id: <20200629123215.1014747-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629123215.1014747-1-lee.jones@linaro.org>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ddata->irqs[] is already zeroed when allocated by devm_kcalloc() and
dividing 0 by anything is still 0, there is no need to re-assign
ddata->irqs[i].* values.  Instead, it should be safe to begin at 1.

This fixes the following W=1 warning:

 drivers/mfd/sprd-sc27xx-spi.c:255 sprd_pmic_probe() debug: sval_binop_unsigned: divide by zero

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/sprd-sc27xx-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index c305e941e435c..694a7d429ccff 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -251,7 +251,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	ddata->irq_chip.irqs = ddata->irqs;
-	for (i = 0; i < pdata->num_irqs; i++) {
+	for (i = 1; i < pdata->num_irqs; i++) {
 		ddata->irqs[i].reg_offset = i / pdata->num_irqs;
 		ddata->irqs[i].mask = BIT(i % pdata->num_irqs);
 	}
-- 
2.25.1

