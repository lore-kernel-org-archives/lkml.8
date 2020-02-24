Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BF2C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC3A20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bTz6qbor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBXM7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:59:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45342 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBXM7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:59:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id r77so1740177pgr.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 04:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yppLt986zP7O7xLvSSLQLlvFJY28BCNk54JkxNyWnDk=;
        b=bTz6qbor82mtycDyKzf3JPd0NDWF6X3c5Cv+6+4VBzxLKEn6fnu6l1Vu/Pn/Q+1qMr
         5AtCcdNhCCqVg8naCc3YBOzH0/lLYFfl36qNQ8EOQoowl/tJsG3rNePjDxek0WGNokDl
         k/X8pZh9KRE8bNki0mUIk7BpSsplRD+dujNz1j37i8Q1ZVpJC/jMEIwIiFp59SDP1ymg
         dAhQeJ4NJMWM0wSreAATTF7b15/3gutSd8am8Oqxg86dcgimoTzuxD7CmtPpExhNwUYh
         GRY3nLpudE8tFXWqloM106vHRyeGPdNAS4NKFbMEH5FmeCmSQLgtzOMKZWliU1RGeTh5
         CHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yppLt986zP7O7xLvSSLQLlvFJY28BCNk54JkxNyWnDk=;
        b=TLozct6XqGhMgvn7WqKaPX4AoPpHfOHK+wn7NL9nIyQSTDRnfqU8uYmwlwvJYfx+1L
         lui0bT5RBFjE8O0mj4SUUHOFblIJwNOcsILqcq6PgVM65B/tBwM2+nwAcP1RfF5IGvQ6
         As5iatYk6WYmRo9O11rpDVuX5loMo2dPF9hN9oGUdGuh5y+IUqnW3MXyOeX9FyMcxOVL
         eqwmFYUuQrwPTpc0oG5nn28DwQn3okve/PeFfxCutv8EOPA5DWsKYuKBL8iNOu0Io/8y
         TwQCwZ07akRVgTjwX7kBqw3q5ig4E86CwPP5Q2tTIcOJtAKFg9CDH080MixqpAhiC1JP
         ddig==
X-Gm-Message-State: APjAAAXsKeJ2shkWkuQPLPyWM6AdN9oNSoHAniYCWBj11WhrOwQq7xaI
        NL/mA8UnGaDCYaLiFR1yEAa2Cg6pzj4=
X-Google-Smtp-Source: APXvYqw+aTKw8nd0jX7s+EBsNkLN1X3i8SmLEGHqzK6eOTQrLZ9p/GoRByaGeYZvox38yV66v9kiLQ==
X-Received: by 2002:a63:e54c:: with SMTP id z12mr51521536pgj.415.1582549173602;
        Mon, 24 Feb 2020 04:59:33 -0800 (PST)
Received: from localhost ([103.195.202.114])
        by smtp.gmail.com with ESMTPSA id j125sm12926717pfg.160.2020.02.24.04.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 04:59:32 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 8/8] drivers: thermal: tsens: Remove unnecessary irq flag
Date:   Mon, 24 Feb 2020 18:28:55 +0530
Message-Id: <03f36313db88f31177d1875bcdfb0be50efcd2ca.1582548319.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582548319.git.amit.kucheria@linaro.org>
References: <cover.1582548319.git.amit.kucheria@linaro.org>
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/d3e1c0f148d46e395a0886d9028df0faf8e9f9bb.1582048155.git.amit.kucheria@linaro.org
---
 drivers/thermal/qcom/tsens.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6c6a75528b90..031a656fd2a8 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -104,7 +104,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 	} else {
 		ret = devm_request_threaded_irq(&pdev->dev, irq,
 						NULL, thread_fn,
-						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+						IRQF_ONESHOT,
 						dev_name(&pdev->dev), priv);
 		if (ret)
 			dev_err(&pdev->dev, "%s: failed to get irq\n", __func__);
-- 
2.20.1

