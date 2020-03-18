Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E2C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0192076F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKrJKKyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgCRRmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:42:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42682 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgCRRmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so31570912wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfHkE12SPwv9oOExuWagJVio5igI7Dg3qMUWgvyzpz4=;
        b=jKrJKKyE/p4lUHBNyP6tiyIh0TZebSU64zwgqT5v1sPXVHQ0OSR8/te35Yilh8jKEr
         DJv0F3li/WSh37DkyW+08c+r/3lIwPdCda39oUJ0FQXdtP6Lazc3KXruVTp39wO/NehY
         9nIwqTAmL9xqrpdq0rdcxrLD3yEJ3ooscLYsjS0Gf3ub/Gd8pArnrgg0kw6AIB5uxRb/
         oOQ0iqwOnPeRd6PRb6TxKiyHZIW/qz+711mqfC5ULniE8HYAk2qc2LZVvTmVIbBQqKW/
         ZBO5Wq7QoF3FaXIsFYQFqm8sbQtHdnthcPO/UWHYYWX64IA43LZEs/b+bSqg0tqSPcgH
         sPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfHkE12SPwv9oOExuWagJVio5igI7Dg3qMUWgvyzpz4=;
        b=NXY3VocTnP7WBXbhmmcW5LEPV6kRGyJWUmTqpJ8T4IIweHugzhK5Pn3igJVb2k70Yh
         i3yMUc2hkCokhQpx/ofC0cU7raVL0lDSOYIjera5Q5WH+YJE9zhm3qtcW+tINLAZj1GJ
         0Lq+cv3FYYT7jioDfCdQB9/LL87myhD0l766a2D9MSalb9Lrcg1jzBJbM65Esxk968YG
         YJBupWi6E6xvcc0hxeZlunyebozOmeQYSf8RPXtdRsnzajaeLOt7N1xY4Z9QOOakRwE4
         XHjVMgv6ILjPEYmrm40SAnBFaBTlBI48ncdK5iUt5NiUDKC1Md50xroQzO6cyB8P8uBn
         +ATw==
X-Gm-Message-State: ANhLgQ36vXhbIEYZqsiGqme6Omkx6mgVhoZ820mcEnrIeMpGgSVhaXDz
        N9IT+PHIPrfHpkbsyG51NQWbfg==
X-Google-Smtp-Source: ADFU+vvfYDN4BLUMlzb8C+yVIvokQZwBnUYEJ2fOwlDELfofCxsjXsGoT8WMMK4KKBUeSSOvtn8faQ==
X-Received: by 2002:adf:fc81:: with SMTP id g1mr7041805wrr.410.1584553353921;
        Wed, 18 Mar 2020 10:42:33 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:33 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
Subject: [PATCH 09/21] clocksource/drivers/ingenic: Add support for TCU of X1000
Date:   Wed, 18 Mar 2020 18:41:19 +0100
Message-Id: <20200318174131.20582-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>

X1000 has a different TCU containing OST, since X1000, OST has been
independent of TCU. This patch is prepare for later OST driver.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1582100974-129559-5-git-send-email-zhouyanjie@wanyeetech.com
---
 drivers/clocksource/ingenic-timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingenic-timer.c
index 4bbdb3d3d0c6..496333650de2 100644
--- a/drivers/clocksource/ingenic-timer.c
+++ b/drivers/clocksource/ingenic-timer.c
@@ -230,6 +230,7 @@ static const struct of_device_id ingenic_tcu_of_match[] = {
 	{ .compatible = "ingenic,jz4740-tcu", .data = &jz4740_soc_info, },
 	{ .compatible = "ingenic,jz4725b-tcu", .data = &jz4725b_soc_info, },
 	{ .compatible = "ingenic,jz4770-tcu", .data = &jz4740_soc_info, },
+	{ .compatible = "ingenic,x1000-tcu", .data = &jz4740_soc_info, },
 	{ /* sentinel */ }
 };
 
@@ -302,7 +303,7 @@ static int __init ingenic_tcu_init(struct device_node *np)
 TIMER_OF_DECLARE(jz4740_tcu_intc,  "ingenic,jz4740-tcu",  ingenic_tcu_init);
 TIMER_OF_DECLARE(jz4725b_tcu_intc, "ingenic,jz4725b-tcu", ingenic_tcu_init);
 TIMER_OF_DECLARE(jz4770_tcu_intc,  "ingenic,jz4770-tcu",  ingenic_tcu_init);
-
+TIMER_OF_DECLARE(x1000_tcu_intc,  "ingenic,x1000-tcu",  ingenic_tcu_init);
 
 static int __init ingenic_tcu_probe(struct platform_device *pdev)
 {
-- 
2.17.1

