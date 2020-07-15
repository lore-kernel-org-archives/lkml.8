Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC97CC43445
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95EB2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ic4mFINw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgGOPHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgGOPGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:06:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB262C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so6163968wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Neuk7hlxyMHOEJZl+c3Ce+fuWuJ+zLYxzzvecm8U2ZQ=;
        b=ic4mFINwL49QSVPf3k9/rgWYim5/9jEoZkN3gqetr4K9fAHlJVyJ3XypL6SuWfRqDz
         +S7WszcHEof6BWrZKfFj9g/YLF71Qcm1yt4zHcQPPYgdqTAQxCrOZh51+TZvW0YQ8Ck0
         aLn5KjCQKZ3Gd/aFzV5L2DQfyiqU8ujb9Iv4xSapyMw6tqW4tt5JwZPpcrPnOA8PiwaE
         0yOlSql13qvWzpkdNz/tyd6HeetzNbv+eay/5/xjytCtAkIYMyDbb9Uefd2mAG3NGm2+
         EaVE9UW+LkFfgx1Zg5Rp6RueZCf8/5881/TkICwUazyXDTk14I4cs6dLDvr0xHFNjtcl
         EisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Neuk7hlxyMHOEJZl+c3Ce+fuWuJ+zLYxzzvecm8U2ZQ=;
        b=DnA1Rp5kxkxeDM+W4srP7F0Z4RTuP0iYepvzh0IjNYMozsKQsqdGk933AInREjEvvs
         2KPz9DPiYAXbRRDs3wW7cYSsoCQOPiaJof4hgGv0YHFOAeR21CeAEfXEyb5FrjrBS8FQ
         ZzD4UAPG05auv54CIBQmTATY39esIM2MZHheTuszc1KiShLRjtp5JSQuFjjWrkm+Ui4x
         aCS2ynSG033tP9qjJ/Xgdhzr6V9vQWplQpyvQWFFoUEtCLrokZ++IPbnXteqxdTApW2o
         btX8n7D+mds0hzGhqyThBIczuqpaOrhHvcNmzBAmPCagf8XM/243YV3i/D7JtRHoH9eB
         pKww==
X-Gm-Message-State: AOAM530RpuKkHLvDdPVLzZ4s2WkVJsHVe8wB1U7glz5J0ptkJs/yoBo1
        cZyvn8tlpWAcKs5eM355YsM84w==
X-Google-Smtp-Source: ABdhPJyhQwehdC5E5vWdp2tq0inGEyTI0AsEuhIDReVDRKACyOC/THNq1DETNswb/m5QQ3kSVY3afQ==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr8770056wmb.108.1594825602210;
        Wed, 15 Jul 2020 08:06:42 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 06/14] spi: spi-meson-spicc: Remove set but never used variable 'data' from meson_spicc_reset_fifo()
Date:   Wed, 15 Jul 2020 16:06:24 +0100
Message-Id: <20200715150632.409077-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like it hasn't ever been checked.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-meson-spicc.c: In function ‘meson_spicc_reset_fifo’:
 drivers/spi/spi-meson-spicc.c:365:6: warning: variable ‘data’ set but not used [-Wunused-but-set-variable]
 365 | u32 data;
 | ^~~~

Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-meson-spicc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 77f7d0e0e46ad..ecba6b4a5d85d 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -362,8 +362,6 @@ static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
 
 static void meson_spicc_reset_fifo(struct meson_spicc_device *spicc)
 {
-	u32 data;
-
 	if (spicc->data->has_oen)
 		writel_bits_relaxed(SPICC_ENH_MAIN_CLK_AO,
 				    SPICC_ENH_MAIN_CLK_AO,
@@ -373,7 +371,7 @@ static void meson_spicc_reset_fifo(struct meson_spicc_device *spicc)
 			    spicc->base + SPICC_TESTREG);
 
 	while (meson_spicc_rxready(spicc))
-		data = readl_relaxed(spicc->base + SPICC_RXDATA);
+		readl_relaxed(spicc->base + SPICC_RXDATA);
 
 	if (spicc->data->has_oen)
 		writel_bits_relaxed(SPICC_ENH_MAIN_CLK_AO, 0,
-- 
2.25.1

