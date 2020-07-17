Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E3FC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D302083B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KkJ58wTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGQNyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgGQNya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:54:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBF1C0619D5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so11236579wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKemoWjqR6g96Xgsgirmftjm/E0sdVIsOFgpktr/D0I=;
        b=KkJ58wTNLjFEfso6eafu7XHSWYDgIT2QpWO7ZoFkscH8T9bz8ZmXHL/FjjlmZ89szi
         SaFxtVC+zwUMaS9y7ToZr9FGXrgGE9lajWTHriEwPcmteH93rS1qRDvL4YRUgyiwqVjY
         j2XI/cb69GWiMEVGLVZJpYOnN7mJxmtOVxzdc5xq7P1QqsKa5UyRwAwgxwGNN4SMhZ9c
         TqcG0zsLXsFS6Z54kAMk4BtYeysJM7Og48NOlrTAwXyP4f1nYDQ2Co2a33Si6aDn5C8r
         t84r0SBiYXp9Hn5nQINc7//3xnye6zTLmDHLpUWGwXf2nG1a/uQpGh81nFfjKIfX3oCe
         TMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKemoWjqR6g96Xgsgirmftjm/E0sdVIsOFgpktr/D0I=;
        b=DKd9p0lAtjGMsMsjTevMzO3V8m1ITps1ZuObJJr93zi+QHcweIv7iOXbdQgadMJbmo
         +sYYGNFVnddvC2wP7RgTo5U64En2p3WgLj0QT0aOFdikDoCKa5L8s0Vhblm/45mT5JU4
         g7cmAJ4xpanhCpCiVhTbpoIGKNLEyYSnVt2KevaBMyjBVUHNCDkn3TQlsBhz7H+4PsC4
         v0QG4PxRkrTvVheElVQvvqaEcgmDDZe3zqiZVpqJNRYU82J6BKyH9HrNj/YQi3nQKL+8
         TG2Ac1+4WzKwgnRU76KEUsjvh1E+Q5E2jNjWbWdDAZFzQHcKCkYEtpf9XW4v4xYOvBzZ
         gB3g==
X-Gm-Message-State: AOAM531h7KUSfWcQWRRn/CDfmBpRC/Dto+Al0KCn4aP2E9kgy138bnSQ
        F+95wRuonpHXLvx9lh11vRkCIA==
X-Google-Smtp-Source: ABdhPJyScPf7JwQtEZvA5sD1ShLQoa/+KNAe8xTjYnMg0F86HrLTvwwPzQtxX+Mk4a1wGK3SMbuJaQ==
X-Received: by 2002:adf:e44c:: with SMTP id t12mr11315545wrm.103.1594994069964;
        Fri, 17 Jul 2020 06:54:29 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 03/14] spi: spi-davinci: Fix a few kerneldoc misspellings and API slippages
Date:   Fri, 17 Jul 2020 14:54:13 +0100
Message-Id: <20200717135424.2442271-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-davinci.c:249: warning: Function parameter or member 'dspi' not described in 'davinci_spi_get_prescale'
 drivers/spi/spi-davinci.c:249: warning: Function parameter or member 'max_speed_hz' not described in 'davinci_spi_get_prescale'
 drivers/spi/spi-davinci.c:249: warning: Excess function parameter 'maxspeed_hz' description in 'davinci_spi_get_prescale'
 drivers/spi/spi-davinci.c:719: warning: Function parameter or member 'data' not described in 'dummy_thread_fn'
 drivers/spi/spi-davinci.c:719: warning: Excess function parameter 'context_data' description in 'dummy_thread_fn'
 drivers/spi/spi-davinci.c:735: warning: Function parameter or member 'data' not described in 'davinci_spi_irq'
 drivers/spi/spi-davinci.c:735: warning: Excess function parameter 'context_data' description in 'davinci_spi_irq'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-davinci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index f50c0c79cbdfa..818f2b22875d2 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -236,7 +236,8 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 
 /**
  * davinci_spi_get_prescale - Calculates the correct prescale value
- * @maxspeed_hz: the maximum rate the SPI clock can run at
+ * @dspi: the controller data
+ * @max_speed_hz: the maximum rate the SPI clock can run at
  *
  * This function calculates the prescale value that generates a clock rate
  * less than or equal to the specified maximum.
@@ -710,7 +711,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 /**
  * dummy_thread_fn - dummy thread function
  * @irq: IRQ number for this SPI Master
- * @context_data: structure for SPI Master controller davinci_spi
+ * @data: structure for SPI Master controller davinci_spi
  *
  * This is to satisfy the request_threaded_irq() API so that the irq
  * handler is called in interrupt context.
@@ -723,7 +724,7 @@ static irqreturn_t dummy_thread_fn(s32 irq, void *data)
 /**
  * davinci_spi_irq - Interrupt handler for SPI Master Controller
  * @irq: IRQ number for this SPI Master
- * @context_data: structure for SPI Master controller davinci_spi
+ * @data: structure for SPI Master controller davinci_spi
  *
  * ISR will determine that interrupt arrives either for READ or WRITE command.
  * According to command it will do the appropriate action. It will check
-- 
2.25.1

