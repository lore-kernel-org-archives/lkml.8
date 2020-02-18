Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E720FC34049
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C8D21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFZj2Ssq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgBRSM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:12:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41208 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgBRSMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:12:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id t14so8394407plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLeONphgN8bI3yXOD6b6adnLltoiWoWgl8XWN+7QgxY=;
        b=VFZj2SsqMCbIShucyuZlAHB1hbUvkl/E0khDnin9ueeSQG3ICe56NLzND/ROolqv75
         PZZ9/TYDfmZ9pqyrg0NxDm8rItdRvQFa7QGeBPRtCKN1XuOk6ngqul1pfAFXiY1bXifU
         SXBqfoKKQP3z7DfVjxeiRZPKL/YfhK57cBLYhoPLyaOUvYLFEaQU7v4eMLtWgO9RlyuM
         9jLWV6VYMNO14UpvFfy6IFOmnxkaTmtdqRSjbrOfkaDevdhUYK0q6V0aLEj1F23fyCPA
         t41CTKy627ZQrELEExiV+bG7DcAUzoygNamg/ZgSVmVbjBF58ki6jVazVq3iLe/oIQ/y
         7z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLeONphgN8bI3yXOD6b6adnLltoiWoWgl8XWN+7QgxY=;
        b=srNgGYuOLN1/IZqSgNLEgeduHDhI7EkKCCk+UC/DIBwb9SpEnbgT4D8W7ZJ8q83rie
         w3S94VeYJaaRhzC+Tydur65QZzU7kH0WEuVlTvLfnshvjas6MD0SFqBI9eaM+GsFaFPP
         2JuCv/YzOkxjDlYmbqLA5KQzPD/qkMtHe1sComqNQjOX7N9b+oyfRTojMUmadWrPUDxt
         A/oL/TN9a7ui7le7jQyEBgdQmmQNOejfdaZFY7jVSgJbHWNmuKkRDhUfeB7GInvZX8jn
         LrWzaZ04hGpkhFhLcAEnlJyIEZvQhcxmYiaxgRwm5R+FKQyrCBCbwGulTyX7ePLvhC37
         KPPw==
X-Gm-Message-State: APjAAAWNoxRkemNCNPVLics70BP4YXP4k4NO8ncITqjnGUBEo1cmuWUw
        80DpVUbzXTcZp8YctFkjfVzpFGrZTNk=
X-Google-Smtp-Source: APXvYqxiNPa/1gH9eAM7SpBofRF5udb8qqSPMvgm5ozyIY2/qfio9pHlLjFssqaOxPtTkBAL38KDCw==
X-Received: by 2002:a17:90a:cb11:: with SMTP id z17mr4153616pjt.122.1582049572841;
        Tue, 18 Feb 2020 10:12:52 -0800 (PST)
Received: from localhost ([103.195.202.120])
        by smtp.gmail.com with ESMTPSA id t66sm5185236pgb.91.2020.02.18.10.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 10:12:51 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 8/8] drivers: thermal: tsens: Remove unnecessary irq flag
Date:   Tue, 18 Feb 2020 23:42:12 +0530
Message-Id: <d3e1c0f148d46e395a0886d9028df0faf8e9f9bb.1582048155.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQF_TRIGGER_HIGH is already specified through devicetree interrupts
property. Remove it from code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 5b003d598234..9ee00c67144c 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -118,7 +118,7 @@ static int tsens_register(struct tsens_priv *priv)
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
 					NULL, tsens_irq_thread,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					dev_name(&pdev->dev), priv);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: failed to get irq\n", __func__);
-- 
2.20.1

