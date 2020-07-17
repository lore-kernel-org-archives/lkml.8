Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BC8C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929072074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eK0lGRU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGQQ4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgGQQ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:56:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66133C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so18184217wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6yWYvMcU6Zb1q02j95UBx70RfKm9AF439nSQ0EKZmBU=;
        b=eK0lGRU9nKtV3NbUA7v6qAxbF/r+JqwBn5w+uhOSIKVyBDS6uUAhaItyocCUBuO3w9
         K3dXkDZbzXDQWz9zAmZ9K5LS7Q+TnCVBhWCyuRiXuBWSF7KlWna2JZhd6dLdkXNx1v61
         JUGTWEaw5BbJWcvbGO6CyTrSS1oYFEdCoc6fSXNBmzD7owmfFFC+aP9+srt0wApjxmpe
         YC0pxYT4HMA5Ic42xYDYIzx9s8UZjVxofxaiibycQHBJc9mzyIHLoekM1Pljpxjan48S
         aunPIDfnDB43VHl0azBwEscG1g2rrd0iftZ+Ux+p7zcdzzHnd/kxkFZ91JYJOI5WOxkK
         NLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6yWYvMcU6Zb1q02j95UBx70RfKm9AF439nSQ0EKZmBU=;
        b=TdqpCWan0+fgQk8U8B9lKFQJhAvtE8QXGT5yfiJsxagC2JPnQqQxOHRbF7F7JGpXg5
         rBmIbzU4gMIEywNVWMcKFZ2OPMU2Mbi5YtYu8+eOXqPPv3sS1hrLKNtr2zqOdX9/0yzK
         j3ZJXqWBPgPPxQVdZ02FAWHaQ2LSy17zqZHI75ldP5jNebx8vI+oxUMFL5MNpoYaPrrC
         lNTGCfl0tumXS3S+4rbt++jDeY5dyh4hT5CNRE8hRfqZTQNloxl9ndCa37+lOiwyyUzs
         SDatgOFPb9/9Io1tEO8muGkMH4GQoYUjhK25ZJYRN/yVbYiKObEELezNbOc7+THHGt0U
         kETg==
X-Gm-Message-State: AOAM532MDwkL42+aNgd3cYz7bCI+P1VpvjrNgyRrR+MTNyecGK0oNISM
        LKjQqlw5ak9JpzAB4hYPz0zivw==
X-Google-Smtp-Source: ABdhPJzLb21jyV+I6Qu3YiGgdMcprDQRVbpNQ8nybgXlwGOQm+2UWGyQWhaS+LfhbyooqiIsfrvC2A==
X-Received: by 2002:a1c:ab56:: with SMTP id u83mr9936549wme.94.1595004991500;
        Fri, 17 Jul 2020 09:56:31 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 30/30] iio: adc: rockchip_saradc: Demote Demote seemingly unintentional kerneldoc header
Date:   Fri, 17 Jul 2020 17:55:38 +0100
Message-Id: <20200717165538.3275050-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only use of kerneldoc in the source file and no
descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/rockchip_saradc.c:190: warning: Function parameter or member 'reset' not described in 'rockchip_saradc_reset_controller'

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/rockchip_saradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 582ba047c4a67..cf4ec59c1dab0 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -183,7 +183,7 @@ static const struct of_device_id rockchip_saradc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rockchip_saradc_match);
 
-/**
+/*
  * Reset SARADC Controller.
  */
 static void rockchip_saradc_reset_controller(struct reset_control *reset)
-- 
2.25.1

