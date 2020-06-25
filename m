Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC46C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEEB72065D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCAo2lhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406560AbgFYTR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390775AbgFYTRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:17:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346D6C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so7010901wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dtxyN/1kKIF9/7TTE8iRG6sUFtmO+Fu1upUgVSih01U=;
        b=dCAo2lhMHJ6NdZfByQXxyz/SilOR/HaQ4pU6fAkuElnZt1kyUUuWW2txb7RP5Sx71d
         vPyJ+232KysYhAHj/oXvRQFfipE38M//axfZd6N7wNBzZdRFiaw9PpV3gjYTBOGqQdp6
         SSsdT9motcSOSYnmISrrkVk0qXEmHXBKgrfMwAVaqtoY9k8PFSuHp8pto4xyc/j7leAY
         g9vwZCZYX59BKX4NPsZnzEx59VQoikmfepvWXsMfBFzu23yrwxoKS1CtX2yupeJ5l2Ve
         ejZGLPZr2e0cQAavi37yJcRawSGCUMqTMugvD+tmKqh99xDzcLd7njI7mCs1IcuzRREO
         TgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dtxyN/1kKIF9/7TTE8iRG6sUFtmO+Fu1upUgVSih01U=;
        b=BCZq9kdnCNvC60GAQued61HEJeVxPSIOCltiTYYf+r1ipsZj7C63slmHd/XP5hiBlt
         LFzA1JAdzXZ1dTWTKlCRy7HGuNqH5PYVAg3cgb9nAVUpnZZDh6YHaJo2sCktmoCAAEU5
         acGtPUIufKxUsehP6HSN8OTMIx8eWxWV5854dLFqmKjMBRKst/VkNCgpp63+Odr7O+j1
         eYo8IE9R5LX7l8gpHB5DoI0PUMPSpx6xADFvMNLFSdyeqIoXMmTj8Gla23NeczbVRttD
         MrJldU+7qmX13YfJmCloMduR+uIXw38yYBWXnGpOkouRfOYDoxAc0hY+E7zjAYoe7xVw
         /UZQ==
X-Gm-Message-State: AOAM531erHg0CeutE4WgTFfw5DfRIlRi5spz+Hkw+6CIQMm/jl8rNJGp
        QbbBdCnZyHkgf25N4bBz49Z1Kw==
X-Google-Smtp-Source: ABdhPJzCK3QqVbhCKU/8mHFqhgDbsJuNWAuV/wA5EVreGSMHRhwhU/xzif2uG9N7vr5wfQE6elguEw==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr17386670wru.158.1593112640968;
        Thu, 25 Jun 2020 12:17:20 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p13sm22693983wrn.0.2020.06.25.12.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:17:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, patches@opensource.cirrus.com
Subject: [RESEND 06/10] regulator: wm8350-regulator: Repair odd formatting in documentation
Date:   Thu, 25 Jun 2020 20:17:04 +0100
Message-Id: <20200625191708.4014533-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625191708.4014533-1-lee.jones@linaro.org>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects function arguments to be in the format '@.*:'.  If
this format is not followed the kerneldoc tooling/parsers/validators
get confused.

Fixes the following W=1 warning(s):

 drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'wm8350' not described in 'wm8350_register_led'
 drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'lednum' not described in 'wm8350_register_led'
 drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'dcdc' not described in 'wm8350_register_led'
 drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'isink' not described in 'wm8350_register_led'
 drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'pdata' not described in 'wm8350_register_led'

Cc: patches@opensource.cirrus.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/wm8350-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index ae5f0e7fce8bb..2e7bfdf7c87bb 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -1216,11 +1216,11 @@ EXPORT_SYMBOL_GPL(wm8350_register_regulator);
 /**
  * wm8350_register_led - Register a WM8350 LED output
  *
- * @param wm8350 The WM8350 device to configure.
- * @param lednum LED device index to create.
- * @param dcdc The DCDC to use for the LED.
- * @param isink The ISINK to use for the LED.
- * @param pdata Configuration for the LED.
+ * @wm8350: The WM8350 device to configure.
+ * @lednum: LED device index to create.
+ * @dcdc: The DCDC to use for the LED.
+ * @isink: The ISINK to use for the LED.
+ * @pdata: Configuration for the LED.
  *
  * The WM8350 supports the use of an ISINK together with a DCDC to
  * provide a power-efficient LED driver.  This function registers the
-- 
2.25.1

