Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE61C433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA6020738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSffMAIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgGMOun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbgGMOtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5415EC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so16902554wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kuZnz7WuCOMkwDD1kHF8duV0gwdGWneD0aepHdWTlsw=;
        b=lSffMAIjiDbbph0NJ5hNiH1AnJltYNVex8/8sTcMzvYkMUyX77Q3xj/RGRxV9ATaU8
         XM22k/9VDkCjEJHMDcF87f838xV4wRGPOZLlHoBVaNtGuWtYrGfo7DFvqicNsiqWLLkt
         /1ZefGA4zC6egSe8n7ZXocpE4RF4ZcCP1Bd40TGZvnE/OEfTWaogYF78VOJkDHa9AFY3
         0mXklzgSiLdNYEKkh/wQTaX06KVng8upiqlTs3MWKMTdRT4SFtfQQLr/3oik3Qlqaevn
         GTiErSTcJFFrdtyDpjGNSXK5qq5BIV1KLGXz3QD/7wOkJNvbYxuxZgUm0b6z36bYajQe
         I3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kuZnz7WuCOMkwDD1kHF8duV0gwdGWneD0aepHdWTlsw=;
        b=FFF5rcGqA/MN+CUd+OjIAHEzlKIylRMqaCngFnsjYes1Ap8vd5lSB9FOUXl8QYLmex
         8lgdmz1P3wZpWu0Y+uwhpWdIz+vOzhlbFFbCbjIQFDzUnCD9dYAk9APCz0CMwdxZvjSm
         gwamo043JwBDr8ieb727YjWivWxygZu+LG2IksPOCQYj3z2uZIKxAgOPxksxCCGVwHnD
         +W4odg0Z3+M3xoCKvarcE0qWpZKI0dWAr2v46ySiqBwcnJYIgyzvbH6XQcW4o+Hu00gQ
         913oaKSYzaR+1Zsx9N0LuFNjMehOmeARQPGeIRBXPUYyKnj2ZxqWlFe/LDMbV2dFV7Fc
         dhkg==
X-Gm-Message-State: AOAM533AzEdT1yxpKOISIaodvqyfcU9WmYshKdKsfhxb5zx11boGKXUE
        n+lcdkFrs8CiCs/HS3xo1Oew5A==
X-Google-Smtp-Source: ABdhPJzkOTntVNtUria3IBB0VG3R6nUJqy1bqOevtJXFhPJPtP/bOJjtNVSzIbSuXkHNiEmPBZr0ZQ==
X-Received: by 2002:adf:92c4:: with SMTP id 62mr77834184wrn.290.1594651789134;
        Mon, 13 Jul 2020 07:49:49 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 15/25] pinctrl: pinctrl-at91-pio4: PM related attribute descriptions
Date:   Mon, 13 Jul 2020 15:49:20 +0100
Message-Id: <20200713144930.1034632-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/pinctrl-at91-pio4.c:132: warning: Function parameter or member 'pm_wakeup_sources' not described in 'atmel_pioctrl'
 drivers/pinctrl/pinctrl-at91-pio4.c:132: warning: Function parameter or member 'pm_suspend_backup' not described in 'atmel_pioctrl'

Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 54222ccddfb19..8e5a5053a47e2 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -106,6 +106,8 @@ struct atmel_pin {
  * @irq_domain: irq domain for the gpio controller.
  * @irqs: table containing the hw irq number of the bank. The index of the
  *     table is the bank id.
+ * @pm_wakeup_sources: bitmap of wakeup sources (lines)
+ * @pm_suspend_backup: backup/restore register values on suspend/resume
  * @dev: device entry for the Atmel PIO controller.
  * @node: node of the Atmel PIO controller.
  */
-- 
2.25.1

