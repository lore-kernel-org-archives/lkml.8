Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60630C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F13B2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zSvp1cyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGOPGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgGOPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:06:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E5BC08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so6163491wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5bZU73kxT5M1JMsvuGC6Lo9dJE8hXmdkV8EdjzvhWs=;
        b=zSvp1cyp9NwMoDYQ099HhmCQeArDGEPwCWKkWWzxkXBbj5HghEulOTG6delZXfRB4V
         7pZwKEOvp46RKySf8Yzgtk9eN3B4BrBHD+xBCvj58iH13cRfFWtS2B5C2Nhix1PIZUxg
         JREpBcxLC3C7l0qnK44ImxJ1a2yrz/6U6//NpLOhRGhvW5Ui21FgwTqGG8Jn0swFlid/
         7fez9lVPIMrbEJ9VMehmmZlRi4gHVJBZjIzmMBGGfGCL5Rt4m8lN9MaPazxs8psW/9VH
         iV600X2ZSWoU8ZSzhXfgAfPccHmAflze7iWKZwsSmgjjO7Pft90i2o6F6TpklayyKXza
         Cw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5bZU73kxT5M1JMsvuGC6Lo9dJE8hXmdkV8EdjzvhWs=;
        b=uBdBV8tqoVhN0Tn7s7tHbqPu2ojXWCx1/PTT5InsOwnSdUFJHlxRYf4rIwxnNVXG4B
         xqYU8yFtYcyHt2K0Dvxf1Damzu8jC4ML+N16oIXqDE5O+n5MqvAwa60X4sRxd9I5+ZDs
         /sBXy3Zl9ZNn0KrnM+7rrqI1cn+e3sz8Tm/p/eop90NpYjDhLqbjqk2qutgqvrUOdxVl
         t41ByJGMfyVAlkuvUMvzuVZ98sJcMz68GlsJzaqDQVuFc4JclgJAy121ScMBa3dDXN8g
         lsVbChPMO1c7Sz99AttC8ge09AyjrvMK4J+kekyEKiNfz8BlWK6JxquF6FrQGn5EcnBF
         8lwA==
X-Gm-Message-State: AOAM531i506YY29fEeYbQpjsBx7iVPG5cygixkD9QpPUnnpbO13mUcmU
        YTSvOlVCUFCTEa4FLKTOhWE9xQ==
X-Google-Smtp-Source: ABdhPJyhdfGUmrtF4d7P3vciFQvDcpZfiGbqTTuoOSU/tp9T2pBra1bNvwYIGOrWZFGbTtCfW3Nx+Q==
X-Received: by 2002:a1c:5986:: with SMTP id n128mr8694473wmb.112.1594825600839;
        Wed, 15 Jul 2020 08:06:40 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Beniamino Galvani <b.galvani@gmail.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 05/14] spi: spi-meson-spifc: Fix misdocumenting of 'dev' in 'struct meson_spifc'
Date:   Wed, 15 Jul 2020 16:06:23 +0100
Message-Id: <20200715150632.409077-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-meson-spifc.c:80: warning: Function parameter or member 'dev' not described in 'meson_spifc'

Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-meson-spifc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index c7b0399802913..8eca6f24cb799 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -70,7 +70,7 @@
  * @master:	the SPI master
  * @regmap:	regmap for device registers
  * @clk:	input clock of the built-in baud rate generator
- * @device:	the device structure
+ * @dev:	the device structure
  */
 struct meson_spifc {
 	struct spi_master *master;
-- 
2.25.1

