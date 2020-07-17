Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F188C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A1F20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eu/Idpav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGQRH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgGQRH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:07:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E8BC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:07:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so7579997wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pXdlEIgb0R2eqM6YdIY4bxUBQ/fZpt56c2B8bap1rNQ=;
        b=eu/Idpav/OdqgVR6qapiS1bO3wnmOzjcE1OUoAvo5H5oEuDQbjZcnZ+Fbax2Yv6hDb
         HYMFLf2931dNSUpYBsBUTl9Zm0XUb9PdV3QDWbh57oxIiVXlcdwlcLrvYUaKOUu+ULVg
         C8DAKsbnyY7FKcOTbxqFPARhb4SuJOPnFzQ7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pXdlEIgb0R2eqM6YdIY4bxUBQ/fZpt56c2B8bap1rNQ=;
        b=N5/nKkKqHASi2Hga1rgUgiBzwRURoaXakWHvq4lVN8tUpgO9Una1zVE7NE0D3LJP7u
         KSg26SIYoBC4zDpJICXHvcKrnnnvCVVhe/xl1V4JQA8ckjm7AmnfbBpa/bm35TXXSmb2
         mvrl7Qs0raClfitHZI/z6tW9cd66UZTLn6c7yw7P0Vfz4edG1ozRESRzyULp2Faje/8t
         CMyNSRQRc5DSWp0t77O1ME2eGHbiC4yO2UiPzSBnbCQCM/N9vH6NEUfBubey2Rcqw1ri
         lHvL78g9djbTDZyBFL6GbWkemWSUzOO4MIs5m6XqDDUL2vRjR2mX+s4h4VxG/fv//PC0
         q6Rw==
X-Gm-Message-State: AOAM531+78kPFq3MTUo6QPCQ/JB2oznKqWvQ2d0QS4WPzYLW1RK2fLh3
        9CmtpN0FzEghiwd9UXVMNvS3bg==
X-Google-Smtp-Source: ABdhPJw7tLX2tF2i9i6qGLjeSU1c50yI8HpYW5M+zZP+AASu4hYwehwUPlCKKWkBpC0SRRk/QhKm1Q==
X-Received: by 2002:a1c:ab84:: with SMTP id u126mr9951175wme.43.1595005675222;
        Fri, 17 Jul 2020 10:07:55 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g145sm19294145wmg.23.2020.07.17.10.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:07:54 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] pwm: bcm-iproc: handle clk_get_rate() return
Date:   Fri, 17 Jul 2020 10:07:43 -0700
Message-Id: <20200717170743.25466-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Handle clk_get_rate() returning <= 0 condition to avoid
possible division by zero.

Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/pwm/pwm-bcm-iproc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 1f829edd8ee7..72a8607b6c8d 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -86,6 +86,11 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 value, prescale;
 
 	rate = clk_get_rate(ip->clk);
+	if (rate == 0) {
+		state->period = 0;
+		state->duty_cycle = 0;
+		return;
+	}
 
 	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
 
-- 
2.17.1

