Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94974C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F34206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgVGj+Xj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgA3N1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:27:49 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:56075 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbgA3N1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:27:46 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so1324735pjz.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 05:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pomAiPgtoR9hWjv7O7J3D7woUIclgXwvwvp+FTh+Xkc=;
        b=ZgVGj+Xjty+b8TbQTeuSX4IRcaCODllhvIOAdUsKTcQGjerqKlWz/naS+7dHeVZ3v3
         bmfyYWU/EYGnBW5nmfLTXdJullrWqYDPckcERQUZfoZc0VnHqPnOYAEZRiK7zmHEQo6q
         1z9Hi8us5lF1vDdf4ZuRS1k7uAWGbtW59YtyUasoaFvIj2prirzeHdbLm4Rwe2aTziYt
         /kEERJXvs/aBq4ybV8XwT2Wtmqcfc+bYrZJY+hIBX2WAD262hGrLqRigK6CNvS8cjSCF
         iwDcYkRSU4nGfXZwTcq8xv7ngZMqzpJQXUG4UfyzgHdGxEPAuSAJSQuGKq93LQzzROYT
         ZcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pomAiPgtoR9hWjv7O7J3D7woUIclgXwvwvp+FTh+Xkc=;
        b=L+vVxQ9+k6J1qIGAe9L1o10+1ItCQZ340PWlrEBU3oxeH7qjk1CBnxjtFHGne6whn7
         xZ0akcyIXJyvAyhwUu+a5LQH6LbviKmkWJ6ViV8HuZcXyxMCH/umvBHnFI/0xPL5fWeM
         oeQZmI2OyCAT0D43qUtlrL39H1NhH+oSYrrcFehUf4aqKKP/6U2jbcRqnMFweiyVosJ1
         bOUFDBvIwGaexyzRbKNXTYJikMaeKNgttbqxbbz6e/JfdkbTUrokt/n3JRi1n35USPQU
         mfLVEaBp+b1SVqYbNN1NjkoyWBQZoP4NTJ/XQuaque1npvgdUz6FZwCsx8XUOXfu/Y/m
         i8Uw==
X-Gm-Message-State: APjAAAUdiiABD/ejivh6sC3EohrG1f8aT/4qIpf5KOTKwCZ+AIkb5PiE
        S0nKd44AqiwRp73F6DtZZSPn74NBKrhRjw==
X-Google-Smtp-Source: APXvYqxhD3CwYxceVh8ePcp5J8g05jLBz0vgt4lcREJGnxcbxpgzim8BcdEJ/8KXfLQ+sRj82Y0LTg==
X-Received: by 2002:a17:90a:8a0e:: with SMTP id w14mr6097193pjn.51.1580390865120;
        Thu, 30 Jan 2020 05:27:45 -0800 (PST)
Received: from localhost ([45.127.45.97])
        by smtp.gmail.com with ESMTPSA id gx2sm6625098pjb.18.2020.01.30.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 05:27:44 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 7/7] drivers: thermal: tsens: Remove unnecessary irq flag
Date:   Thu, 30 Jan 2020 18:57:10 +0530
Message-Id: <b6db92ea41420c907beb7643f82b6b8011645ac6.1580390127.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1580390127.git.amit.kucheria@linaro.org>
References: <cover.1580390127.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQF_TRIGGER_HIGH is already specified through devicetree interrupts
property. Remove it from code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
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

