Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7A9C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8F52068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms9SDi2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgGUOur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgGUOuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:50:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F143C0619DA;
        Tue, 21 Jul 2020 07:50:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so3126775wmj.2;
        Tue, 21 Jul 2020 07:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TwqOb/b5D2FDhuQDA8VKCnkg8Zfyu71mEk7CAcDieEs=;
        b=Ms9SDi2BSDmFemezpTmmc+I5GEPPyvUGsrzPS/4yZFGhi75vbYYLw50TY0iwOh5L9X
         WZpgbYILJBydCJ/tw0byYQDTV03eMpwqaJQYvSwScxW2kr3Q5RGnAZEN//SGbfBcbSSK
         OQsvklwt4rxglNmPuOBeEPO0t0WLs/s2H2fDVRwZA+oyf5jzCI0qgforToySOyDjgWql
         3XGT6QMi/cvEG1vGBrO+O8gAcZwXeLYvHkqIpu9XXA/z6N2vjHwabwJYxPQCJBAoXY2E
         NyHawcmbJ0Xga0XDqBi+4z6tFC2CLU6YK2gknKVYWApRCoixRrafvhtZxNksVvIOSElz
         nUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwqOb/b5D2FDhuQDA8VKCnkg8Zfyu71mEk7CAcDieEs=;
        b=TznCLjKH03Xgq1klZ68utmYKYZhcfKDUL9ETODsxNEdR9zR3aXbfCiY3EE/nU49mtY
         NW1LgX9LKl9ApTWjDWYWcOuKeAdnf+IOquFdYmRJXoyy9CROx/gn0nT5M1jVIjdOSKHi
         j1aCXU9TyYf0E6Jq1AYLt2/zlUe6VQwPgeMz3mafxvqjR8UFFqWcwwAQ9FslOYROGcTy
         7Z0y2pAQDLpfDZMTsuElwSO7GTGaHi1WqXreu/GUoUYHwLQw52gZCZvD0rgiW4KJwTBK
         Qzaic4AczKh27YgYRO5+9wO0RXPOlUG0ZTH+RWXR8iGJhNux0IzfC7pFbCu23sF+bEbE
         O6cQ==
X-Gm-Message-State: AOAM531xE+rH+P9F0rBNeXEW4mZS6IBxdFZsTFdOaZBMOtNU5f8otHNo
        KFd4OFYclsUEnoBG4LmfT4g=
X-Google-Smtp-Source: ABdhPJxoE8VZ5fU5tftUty8wWkq3Uf8kiYRbsalR9XFfgqM45B7qELSYdNZCiMtYIMN6Nfs7XAWBtg==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr4600185wma.134.1595343044817;
        Tue, 21 Jul 2020 07:50:44 -0700 (PDT)
Received: from localhost ([156.204.74.63])
        by smtp.gmail.com with ESMTPSA id k126sm3785068wmf.3.2020.07.21.07.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:50:44 -0700 (PDT)
From:   Abanoub Sameh <abanoubsameh8@gmail.com>
X-Google-Original-From: Abanoub Sameh <abanoubsameh@protonmail.com>
To:     andy.shevchenko@gmail.com
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abanoub Sameh <abanoubsameh@protonmail.com>
Subject: [PATCH 2/4] gpio: gpio-msic.c: fixed style of a block comment
Date:   Tue, 21 Jul 2020 16:50:25 +0200
Message-Id: <20200721145027.770268-2-abanoubsameh@protonmail.com>
X-Mailer: git-send-email 2.28.0.rc0
In-Reply-To: <20200721145027.770268-1-abanoubsameh@protonmail.com>
References: <20200721145027.770268-1-abanoubsameh@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added asterisk to each line of a block and fixed and moved the ending to
the next line.

Signed-off-by: Abanoub Sameh <abanoubsameh@protonmail.com>
---
 drivers/gpio/gpio-msic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-msic.c b/drivers/gpio/gpio-msic.c
index ea5ff2c84a26..0bef1a5a9b70 100644
--- a/drivers/gpio/gpio-msic.c
+++ b/drivers/gpio/gpio-msic.c
@@ -183,8 +183,9 @@ static void msic_bus_sync_unlock(struct irq_data *data)
 	u8 trig = 0;
 
 	/* We can only get one change at a time as the buslock covers the
-	   entire transaction. The irq_desc->lock is dropped before we are
-	   called but that is fine */
+	 * entire transaction. The irq_desc->lock is dropped before we are
+	 * called but that is fine
+	 */
 	if (mg->trig_change_mask) {
 		offset = __ffs(mg->trig_change_mask);
 
-- 
2.28.0.rc0

