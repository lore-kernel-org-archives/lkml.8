Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D37C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 335A020752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nc2MC9jZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbgEKOvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730473AbgEKOvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:51:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075D1C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:51:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f134so6170305wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qaGHgoIklkuNmpEkyLvRjJ4yCE6OQ1c2IuH8BxH75mY=;
        b=nc2MC9jZYPU+Gglr1zHepF2nPUzMK7u7MNLTcsttxd5kG+Y8Bv980mUeu06OEqBCm4
         9VhiUSpnHMjHBPMNq5iapkg1qfmOy+Gb/klsL66PneNY1D1WAIIus1bwFOnfiF/C85nz
         65hPxJeEYWxq5iC3HDK5jBQ2SvDsTZ1aj2tSlLMj+LntTzyuF+3xNhSj380CO7DM7U2M
         x6h0V9XNj2BHI/+BEB5YIe9IBbk/E9oWpts2ivEi99qq8s2yTWVO6f9AsKgG7aMiJIL8
         s53N/vvsX6DHGlkuQU0m1TuTCyzCm9Hu4EtENbo+0v/453byPncW801jPJQ5GxZ7l9O3
         b0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qaGHgoIklkuNmpEkyLvRjJ4yCE6OQ1c2IuH8BxH75mY=;
        b=GUJRxXmiJYbpwJfxlQTz6LNi0hQniNG+ItQlSGXNI6HTu+NCctJZbnqaTdOje6Nj89
         th6udlq+6e+UUnagRVVvAxjma7lr2MuHPmFcjf+5+DBJyLE7t+EUI1EuVren7fZMWPzw
         mgxfWtoFKT3s3Kh/woI7tW5L9GSUwpzNvCMxGXn3i6dk4g9Mo5YZeqn7Njkz4U28FN8A
         u+TK1Nfxra1GsJiGDM/vZP0kkQ1OkXwCB31KL5tAsRoTT0O72myW7YH+ZNjgdS2oKjI4
         YNwfjMipGE2PsqmF+C/BulXuEOqtH4dQXDJqba6lZcDi066TCumUWdvb9NHuWx9BrYhy
         Jvwg==
X-Gm-Message-State: AGi0Puaz4YlliypHO4igiEID6lmfs3slAg5S4TTztMrDTSy7J7I/49Xu
        KZWmjKn4tzfLGnYW3G655HDokA==
X-Google-Smtp-Source: APiQypIH+48uGTVlu0nxuHnlstFTZhuvmqjc/WYbSFNTlGuarz/lnSa9XuHiTJbY5VntBekm2bjTcA==
X-Received: by 2002:a05:600c:1008:: with SMTP id c8mr30947100wmc.14.1589208658760;
        Mon, 11 May 2020 07:50:58 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id 33sm18512983wrk.61.2020.05.11.07.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 07:50:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Samuel Zou <zou_wei@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] nvmem: jz4780-efuse: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Mon, 11 May 2020 15:50:42 +0100
Message-Id: <20200511145042.31223-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200511145042.31223-1-srinivas.kandagatla@linaro.org>
References: <20200511145042.31223-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Zou <zou_wei@huawei.com>

Fixes coccicheck warning:

drivers/nvmem/jz4780-efuse.c:214:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/jz4780-efuse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/jz4780-efuse.c b/drivers/nvmem/jz4780-efuse.c
index 512e1872ba36..0b01b840edd9 100644
--- a/drivers/nvmem/jz4780-efuse.c
+++ b/drivers/nvmem/jz4780-efuse.c
@@ -211,10 +211,8 @@ static int jz4780_efuse_probe(struct platform_device *pdev)
 	cfg.priv = efuse;
 
 	nvmem = devm_nvmem_register(dev, &cfg);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static const struct of_device_id jz4780_efuse_match[] = {
-- 
2.21.0

