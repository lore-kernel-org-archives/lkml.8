Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402A3C433FB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C5ED22B47
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CsWfJTYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgGWP1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgGWP1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:27:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A111BC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so5334766wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8HBikDJd8D0bbTIBIP40Zzk8yKbUIViYDvqn8ymfoMo=;
        b=CsWfJTYSs5cdgzgASIuWbWpguMQSZlUyCucI+aRQpvJTSmw6orYLDQ9r2ygpfEfHII
         49zomTT5YpiZNViqMeuUIOj8MK93Tluw3KNvSNsp3P04ZulEL/kA2mPDskMGSMQ99Iyj
         MlWbjLg7Q3D2Mf5EivO0WwHQdTfi2KyE6xf/3/4Bb52Iu4Atph2aBA2QO3tUHraNHuCP
         XL6bAONBBwfxyrJSZRYIajUeahtEVtteGjZbs0l4QtuhgW6U7u8vvtX0SbWHEVZicq5u
         XIjpNBGw9yipsJh1+OyVE6dGE7w72QYqUpLReF58Wq8UQs0FaARkNbcPpI0+dN/ApZHj
         FsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8HBikDJd8D0bbTIBIP40Zzk8yKbUIViYDvqn8ymfoMo=;
        b=XFIWD1p1YMWEahtROKuXsZh8hD5+aVbqpzloM9yI2vI1sfp9C97obweEf8Mea3rsYs
         Ln675XwnniUKgt8PyJzaBK75dYQczGTu01Mp9dkfRy8Tt/hCmW+Z5QrM282co04165ww
         r+KoTgBGA8wss9h2L+sRzS4PGcfUu7OkbGomJ0hpfowUpKvgilqsAkmIeX4Yg3D1dc1J
         pfOilPqcn+Ovsa1rTAalsXvzH96zaKEdJRJz5jC1n76wycOwnVQ+WruBBk86VeQMssOY
         hLMPIzUxfxOCOmRLxwHD102eWCrV9wyoOD7IQuL7/teBmKusiGQ8fPsSZHg/31QDc9Bb
         6Vdw==
X-Gm-Message-State: AOAM530ddorob2utAaqpUrvrWrF8jY9NBvvzRI/PU80BRzn5/37aVOkm
        FFnWeaSz/c56YlAOmD4F36V9POW9lR4dog==
X-Google-Smtp-Source: ABdhPJyRjWO0ZKuBwR3+y53ACMTiU+/vI/4CLOMJSTp9PIZGxNXzdzZHU0YJLc5wHkS5kEEoeNRNMQ==
X-Received: by 2002:a1c:6809:: with SMTP id d9mr4610146wmc.34.1595518028235;
        Thu, 23 Jul 2020 08:27:08 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.gmail.com with ESMTPSA id g145sm5963491wmg.23.2020.07.23.08.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:27:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 12/16] clocksource/drivers/sh_cmt: Use "kHz" for kilohertz
Date:   Thu, 23 Jul 2020 17:26:32 +0200
Message-Id: <20200723152639.639771-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723152639.639771-1-daniel.lezcano@linaro.org>
References: <1b1122f4-bce9-f349-e602-ed8e14cbb501@linaro.org>
 <20200723152639.639771-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

"K" stands for "kelvin".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200618080212.16560-1-geert+renesas@glider.be
---
 drivers/clocksource/sh_cmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 12ac75f7571f..760777458a90 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -349,7 +349,7 @@ static int sh_cmt_enable(struct sh_cmt_channel *ch)
 
 	/*
 	 * According to the sh73a0 user's manual, as CMCNT can be operated
-	 * only by the RCLK (Pseudo 32 KHz), there's one restriction on
+	 * only by the RCLK (Pseudo 32 kHz), there's one restriction on
 	 * modifying CMCNT register; two RCLK cycles are necessary before
 	 * this register is either read or any modification of the value
 	 * it holds is reflected in the LSI's actual operation.
-- 
2.25.1

