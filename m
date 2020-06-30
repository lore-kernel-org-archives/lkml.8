Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDAFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753732074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3TJl39h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbgF3Nec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388139AbgF3NeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:34:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7F6C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so20130001wrj.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EdUmnOFS5TbxKtJS43wBP3LOOE3V1mwzgMQ7fgYmUtc=;
        b=b3TJl39h/HPdI2rcHJlyhWwzcXi/la21VXhkpUf8MYbyH+xEy9gT+dwl26vyTyJJpN
         TKYzfmEoTP9+Q1yO4ACJSyyqiV5lmloZPd5X1g5PhacwvpOk6vPRbCgx6FvmWqfqnUEx
         1JflzHOd2GaJyjWgT2sUZbp2H5sV9YJFC1Oy/2/HkAroipRDUy0VNFU2/35nhrr4XXSd
         zhCCnXHoaLbQJZO71+qjKO39/0wxT0NlDB7pNBpZbRoIkMdbdDJHxLtqe6ggwn7ejT6o
         RGd+Kf5hIBNxVTP+yMGrIexXx53Wi7fs0b/59vKSfzaYDlVAcmjdXLooHBLqFC1lFVVR
         tGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EdUmnOFS5TbxKtJS43wBP3LOOE3V1mwzgMQ7fgYmUtc=;
        b=I2Xottb1seDxPXoscNL1lZnc+OnUPprl0XxMzhvG2F8JYxY1JQJSKOvrno6YisGnPj
         wLPXSsOCMZt8VuVwm3e3HtJnxiNWKG0u9kbrT379gdXY3rRXhG6OLNBWDx5AuEjb9eoR
         B8pmIq3Wgno87tJg2IWZMF5ICwnr6eplRWfwqCGGZfzqd7upz6Q2Ohz3g4NYVOI5vhxt
         5NPHoQptjkhWmxiUcmz+F8+6u0BXC7/rNKexPTS4w58tU18L33pE5dEEz0Ha6xtb+S10
         p51zXceZg1QeRpXQdd/11CHM61QGi4y4A66zG2fDqxKf2YvuKl1ECBJ8fP1437fW0dMe
         ipQQ==
X-Gm-Message-State: AOAM5329Jkip1taiA4JNsxuSm4vQxoZ6WBWgS+8V5rJDzKlMpy1yeup/
        K2Fx8MHvkpcDgK6Jj8n8EQ+NWQ==
X-Google-Smtp-Source: ABdhPJz0CEADFFk8XWxoF3NfWv5G61HuV3p9+cKSio2MeKeDa7JGlGUrYUDZ8uy5pr8X3Nl+M9pn8Q==
X-Received: by 2002:a05:6000:11cc:: with SMTP id i12mr21614495wrx.224.1593524038502;
        Tue, 30 Jun 2020 06:33:58 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id z16sm3682464wrr.35.2020.06.30.06.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:33:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Asmaa Mnebhi <Asmaa@mellanox.com>
Subject: [PATCH 09/10] gpio: gpio-mlxbf2: Tell the compiler that ACPI functions may not be use
Date:   Tue, 30 Jun 2020 14:33:44 +0100
Message-Id: <20200630133345.2232932-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630133345.2232932-1-lee.jones@linaro.org>
References: <20200630133345.2232932-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... as is the case when !CONFIG_ACPI.

Fixes the following W=1 kernel build warning:

 drivers/gpio/gpio-mlxbf2.c:312:36: warning: ‘mlxbf2_gpio_acpi_match’ defined but not used [-Wunused-const-variable=]
 312 | static const struct acpi_device_id mlxbf2_gpio_acpi_match[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~

Cc: Asmaa Mnebhi <Asmaa@mellanox.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpio/gpio-mlxbf2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
index 94d5efce1721c..861a8d0a84be0 100644
--- a/drivers/gpio/gpio-mlxbf2.c
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -309,7 +309,7 @@ static int mlxbf2_gpio_resume(struct platform_device *pdev)
 }
 #endif
 
-static const struct acpi_device_id mlxbf2_gpio_acpi_match[] = {
+static const struct acpi_device_id __maybe_unused mlxbf2_gpio_acpi_match[] = {
 	{ "MLNXBF22", 0 },
 	{},
 };
-- 
2.25.1

