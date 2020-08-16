Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE749C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A7C20708
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5paUYdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgHPLje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 07:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgHPLed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 07:34:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37225C06138A;
        Sun, 16 Aug 2020 04:34:05 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bo3so14517811ejb.11;
        Sun, 16 Aug 2020 04:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=msrdwPbqHQ8BLhMLLtrF1zjcunPvIyHoXyHAIw4Pnvc=;
        b=q5paUYdclK8ewke59GjeMYxkYtKcAgVzRHZQ+z1H3SMYSJ4y776HOojWHfUTdqYGa3
         SnJipD5GEJEP77YGC0Uoa0bI3zOjh/+mfdVv2gHyYm+z+Fh7Y//t3nPZL9+bPJi8XftR
         VrRQJtVgEOrhVjJ074Rys6FtmzLcHYR26MmikQ9KeZqYKobDTAZUNM7+3K4kFwhJOQy8
         88YoThXKcZxt3GKplUKlvzARI6jCK4YUcOy7F3FhLdTh7pqi8XNZ5niNn/kTDbnoWV1N
         xGFa7jbdkfm2Le2BNCahZQSM96BtrgDhAqpU++kWUWD89yrUxu412v4fS3Iap09kof/a
         xomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=msrdwPbqHQ8BLhMLLtrF1zjcunPvIyHoXyHAIw4Pnvc=;
        b=M5ZdcGBseLkP0w2fKhEmAokWo8cekmcUDwZcrRL0pryodT7OTjeTi6UAQcfjCzZWnA
         UBGhWiKIyesfvcVVusx2ZiBnEt71rRA2qvGyKixRCyiaqz+DJ/jTSMLy1o9rWzAk64y+
         gTAaYdKmJwoD/PYorM5Cg3AdVm2LwdAldpe86h40DCg3uOkfefbSRJpxO3eaw66WSs8Y
         MHy1gK+56jKg5fupbGcTMMOMwVQuWWcAycsT9J1HamArqf9SvJc7EP72ZHuG9rQbjJNm
         CcrWPUb7qyECP/U9nno1nCm1UsWuEodr58A8PYlH6AhvUfif0Gad9rvdsVVwRd8nMfqE
         QZFw==
X-Gm-Message-State: AOAM530IXnW0RvIZHLmIeCQ+8DSx8KDHhXzI7MmzCQjGIHXYbCjVtX8b
        Xw/Clq255vWYz63wTe228UU=
X-Google-Smtp-Source: ABdhPJw4mulA63Rkou3LrnCSgU4gnREMJyDLeK3VJp0eXtON3dguIYcD20aKA4nqeUX1+IMu6gj88w==
X-Received: by 2002:a17:906:c310:: with SMTP id s16mr10626313ejz.466.1597577643581;
        Sun, 16 Aug 2020 04:34:03 -0700 (PDT)
Received: from localhost.localdomain ([188.24.144.238])
        by smtp.gmail.com with ESMTPSA id p1sm11272945edu.11.2020.08.16.04.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 04:34:03 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v4 3/3] MAINTAINERS: Add entries for Actions Semi Owl SIRQ controller
Date:   Sun, 16 Aug 2020 14:33:56 +0300
Message-Id: <85dc5395fef32d2e99c586168fc604effe392b7c.1597571397.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597571397.git.cristian.ciocaltea@gmail.com>
References: <cover.1597571397.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for Actions Semi Owl SIRQ controller binding and driver.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87fa408d0f15..00eb0fb2eb68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1518,6 +1518,7 @@ F:	Documentation/devicetree/bindings/arm/actions.yaml
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 F:	Documentation/devicetree/bindings/dma/owl-dma.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
 F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,*
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
@@ -1529,6 +1530,7 @@ F:	drivers/clk/actions/
 F:	drivers/clocksource/timer-owl*
 F:	drivers/dma/owl-dma.c
 F:	drivers/i2c/busses/i2c-owl.c
+F:	drivers/irqchip/irq-owl-sirq.c
 F:	drivers/mmc/host/owl-mmc.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
-- 
2.28.0

