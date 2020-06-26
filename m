Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2112DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1BAB20775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQXuPCc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgFZG6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgFZG5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:57:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81860C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g18so8397066wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRfQMWFiLuo72c4Et2D0Wla00RQIPz6rSbxQq9GAn0g=;
        b=MQXuPCc7Mjv33UQSHtC4N3wrHkIlhRxtHQwgqZtO4v7nCEB36kZKmsUQi6wdGYHIPL
         VQb8HSHug4A0Lgyb89wHbep9mhuiQbFY4edoDQGhK8MDrVxYq9EU0AHoRScOzad/EcNZ
         Ucjr7ATwejxJmF1az44c0zA9yy4nIqLqT9xeZLJf3hoS5CLzCCEqxvXS0/ZHNZ4n7Tvu
         LK7V9grgePhB3Lhuke4DCkxcRYN7eOB9WmyT6sO1lTIORYotBCo2hmaLEAwLu2wmrOu+
         JEjNMMcO9gIdIERLXVXkmyKCakRN6+u6VlxH4vUKfhxbimykfd962r69x9g/TYt+R2MB
         4cfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRfQMWFiLuo72c4Et2D0Wla00RQIPz6rSbxQq9GAn0g=;
        b=KF+NV4n5weus8UTTQyVWmFbzaLIt9C3SklLiofDOx/nwZJ+RUQzxZpxe1Hs1PEc6zx
         lNhX5XxGWrU38eJrpjF7AlJ0wNGY/q1g9CBYRLxIUEbzOXxGPaHFF5X9BLi4JdZ6fOdC
         mY7oT+D9iddjjnHK4pXzLydxb4zsh1ojhG+U4RTamESYI8G1cINF/WGmh34mUCXD81aH
         ZWWydQ9cHTvsJ+7/YCDRp+7+oNahvdOXpUNq2g4TFr8kiAh3tBgEqHBbzJjdd++mWE5v
         VqGLLEJb0coutGGw+kS93NQL/qk5tQvYL1bTrAiPf6H5JrsjV6XLApmxL2YowvxiihLm
         BfzQ==
X-Gm-Message-State: AOAM530H+MlFSIk4nVnxzU4RZpOxurIzrKR870R2Rv4CnTxvpX7W6lyd
        VreSU1CTwSzep8Zgwx/uFwKnsw==
X-Google-Smtp-Source: ABdhPJyKozvM3BXdGCNtzmZiByH7kCyGCYKVSZ9+sVOpyMVo9mCtBv8zHsYyN9Z4cgcVvtAYBkL7BQ==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr2262620wrs.229.1593154671271;
        Thu, 25 Jun 2020 23:57:51 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x18sm15355269wmi.35.2020.06.25.23.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:57:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, patches@opensource.cirrus.com
Subject: [PATCH 8/9] regulator: wm8400-regulator: Repair dodgy kerneldoc header formatting
Date:   Fri, 26 Jun 2020 07:57:37 +0100
Message-Id: <20200626065738.93412-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626065738.93412-1-lee.jones@linaro.org>
References: <20200626065738.93412-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W=1 kernel builds report a lack of descriptions for various
function arguments.  In reality they are documented, but the
formatting was not as expected '@.*:'.  Instead, some weird
arg identifiers were used.

This change fixes the following warnings:

 drivers/regulator/wm8400-regulator.c:243: warning: Function parameter or member 'dev' not described in 'wm8400_register_regulator'
 drivers/regulator/wm8400-regulator.c:243: warning: Function parameter or member 'reg' not described in 'wm8400_register_regulator'
 drivers/regulator/wm8400-regulator.c:243: warning: Function parameter or member 'initdata' not described in 'wm8400_register_regulator'

Cc: patches@opensource.cirrus.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/wm8400-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/wm8400-regulator.c b/drivers/regulator/wm8400-regulator.c
index 4cb1fbb597227..e9fd137077213 100644
--- a/drivers/regulator/wm8400-regulator.c
+++ b/drivers/regulator/wm8400-regulator.c
@@ -234,9 +234,9 @@ static struct platform_driver wm8400_regulator_driver = {
  * the regulator API.  It is intended to be called from the
  * platform_init() callback of the WM8400 MFD driver.
  *
- * @param dev      The WM8400 device to operate on.
- * @param reg      The regulator to control.
- * @param initdata Regulator initdata for the regulator.
+ * @dev:      The WM8400 device to operate on.
+ * @reg:      The regulator to control.
+ * @initdata: Regulator initdata for the regulator.
  */
 int wm8400_register_regulator(struct device *dev, int reg,
 			      struct regulator_init_data *initdata)
-- 
2.25.1

