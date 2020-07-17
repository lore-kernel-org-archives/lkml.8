Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA89C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A3120717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJWYGXYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGQNyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgGQNyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:54:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1CDC0619D5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so11236342wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AI7c50J2x+3VkfEYyAsOrnfGhBXfcF4lm0Ws/hDguDo=;
        b=BJWYGXYq1pgsO4ivqCiR82eR35O7gSNMT6QzlxPG0J5WFo7f9l9ct2/Tj5hbius4wJ
         Z3Nj9oYaqBKMg1Xoi6M4UZkmmfrLIkOblh0TJcSGnmWoWrAo6+546QwFRUIZFYt0uk9F
         P4n6sI1WeB+yEJLGruWOY5oFh5vAAwBE0sSKpokIUpMVYM0U5mlq0hoKOTFrP6pj1ogt
         qBVxuMuEOaLVOwxwyszj1rDIl05cV1teNU20ANvSq5UID796wEmfuWiVh9kq+r3ORgD1
         CKk+4gQ6lc1SCsduPRjx9fMiZ8f6nvrTSL7uHPXLrhtjK2mTSQcMBXQMTJfGqOP5i/M3
         qjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AI7c50J2x+3VkfEYyAsOrnfGhBXfcF4lm0Ws/hDguDo=;
        b=Ywwws8Gu2oGkd/Df6xfkDBvgr21RQ0kW2E9mm89fkZaRh4LvMAz8zX3ri7uoZdd6j/
         YPRpS03DbByJKh5BFNOIYhN0nOtFmjRcissj24y4oGHIgF7hQ0lXP+7yS80973PvyRFg
         j7WXqaKbUPPaskQ2t1ig3UjPCuBKdR+Y8IhxNNAbKpZmZcKaBpCb+c+5JcWrNMaavYc8
         riuQCeiPp2y8z9vHk2WE/5i12GdLUC/J5Gqh13OihxJBtD/xMqhUxWpXSNUmJU/71mfQ
         CA+a5ETjN8vUdQKczW6Z/cxspEnXl7LXe4yWvycuh0LQOoIMqdV7MIC6+5JJaCuL3ItW
         iHcA==
X-Gm-Message-State: AOAM530fr3swWXmGilzq5jQaH08S32L6uJzo7wovjTIjmld5SHxNBpC6
        Kfd9fr6U2Fe1M9++++R8p+BqACDLZQ0cjA==
X-Google-Smtp-Source: ABdhPJzcxiqCEsLDkUJ5mleRr1Wv9TnyI904k47F56Gh6ETTAgfzBGp386wph9T+fLWOu0SbjVA3ng==
X-Received: by 2002:adf:f104:: with SMTP id r4mr10951860wro.90.1594994080427;
        Fri, 17 Jul 2020 06:54:40 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:39 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 13/14] spi: spi-pxa2xx: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
Date:   Fri, 17 Jul 2020 14:54:23 +0100
Message-Id: <20200717135424.2442271-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI,
struct 'pxa2xx_spi_acpi_match' becomes defined but unused.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-pxa2xx.c:1435:36: warning: ‘pxa2xx_spi_acpi_match’ defined but not used [-Wunused-const-variable=]
 1435 | static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 | ^~~~~~~~~~~~~~~~~~~~~

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-pxa2xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0040362b71622..814268405ab0b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1432,6 +1432,7 @@ static void cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 	{ "INT33C0", LPSS_LPT_SSP },
 	{ "INT33C1", LPSS_LPT_SSP },
@@ -1442,6 +1443,7 @@ static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
+#endif
 
 /*
  * PCI IDs of compound devices that integrate both host controller and private
-- 
2.25.1

