Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914F2C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB1921582
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZyJJq+J3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436634AbgAPSYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:24:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54926 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732415AbgAPSXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id b19so4779988wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4U0uZCU/Rr6PoKH6pSzWhzEkWNaZ8xO84k3nCsnn5OE=;
        b=ZyJJq+J3IE1qdbpxmR4r7mAu2xCxOpzyZwe1Nor4fwHVMuNTa1h+oCzTa9pqupE4P5
         uLfwsK7ECwKe1yfT8tZVRI32gTINOnXMcsdjBDJyvK3m/yVtcN1Z21yPH+82SOHzxdEd
         rJEEVbzxbyMCscSnoq9son2YPYdPRFa6EWcllUu8b+NXp/MDzgXBnIlacI3Uo1R8SWKu
         mmr3QrWdQ8A6hIx8d2eu/spJb69OG+LPYbqn/A45Bsdmh9gwsd5CAPvCPUFN/MZly0yQ
         Vqn4/30jBdLOlgTo2j4atlZj6x5IHeQp3DXXI3lJtUONW3AXUR3YZZRPboAt7nV6MK4r
         r+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4U0uZCU/Rr6PoKH6pSzWhzEkWNaZ8xO84k3nCsnn5OE=;
        b=ZS6Fg/R28B/B0gzRXxSx/rhgYUI3GM9Az213mTZxrsOUSYhzflcwsoeilFrPqo7JF2
         /XXsvJdM9jZUTisBNbWod+n2Bpa8rp1xT1AichIrBY1uXVcv5PbRR324O26jJ/o8wuZJ
         6cgSikPM6eJEXSuujgOdpeXoNOjsFycS6hjSrnEBP6wYkPib77No50sRMtydxjXTcMyg
         oNitXqJ9dLE8OdKinWEQDlwE0ZL4MqtMNnmgFwydZRoGBrbwJEV8hff6i9MnVZQPmam8
         twodYnRtVtOIeaOZKnh5svG8GraxL68suMj+9+KEOgo3SYNvZiuUB/dFlRb9NkAz3upC
         m/ow==
X-Gm-Message-State: APjAAAWfXlw+8QR0qSTQk5TNSvlRT7H6wvX2grnhphgpln5WeamrH0fk
        HtwhaH/DgelSzlCii4NCEk1UcsTzRI92vQ==
X-Google-Smtp-Source: APXvYqw+adYtVGwSEdwljN1ecGJm+9fFPw1JMr59kdZvVBUM2PdyipL40luf6mBM0jscUkRTI6fUwg==
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr290966wml.157.1579199016261;
        Thu, 16 Jan 2020 10:23:36 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:35 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 10/17] clocksource/drivers/em_sti: Fix variable declaration in em_sti_probe
Date:   Thu, 16 Jan 2020 19:22:57 +0100
Message-Id: <20200116182304.4926-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116182304.4926-1-daniel.lezcano@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
 <20200116182304.4926-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

'irq' and 'ret' are variables of the same type and there is no
need to use two lines.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191221173027.30716-3-tiny.windzz@gmail.com
---
 drivers/clocksource/em_sti.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index 086fd5d80b99..ab190dffb1ed 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -279,8 +279,7 @@ static void em_sti_register_clockevent(struct em_sti_priv *p)
 static int em_sti_probe(struct platform_device *pdev)
 {
 	struct em_sti_priv *p;
-	int irq;
-	int ret;
+	int irq, ret;
 
 	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
 	if (p == NULL)
-- 
2.17.1

