Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDFFC3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8888724650
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOBGN7F6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgBMQkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:40:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34267 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgBMQkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:40:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id n10so5565280wrm.1;
        Thu, 13 Feb 2020 08:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OYWSVDDbY/UxSIzaZwoEm71Xw+c2/ceHjCKgkFAt7oc=;
        b=LOBGN7F6A+j/KSjmlfWKAL6xYBfzNY6jWq/aJt0gIVfRpWfAdpTomvbazv587FWCH4
         b/jLQO2aILx3cSL6MH6XlveVUiXrJp6WYV6aTNox5A5uYyXlqIVkutunXN7PdA6YJPOM
         i+aDHTC0xR7l5mJ/0q0uMx9lDOtuH3TWZHMCaoCbk66JMPp0T5lUh7rYwEluVoxipwhJ
         2pcEfBwmhfTLC0DSn6OjH7g5Bp4TdoXUJEIVC8r3n+XEZin08tulv6BagQSY7vXyS1TU
         JAKfqoLYunkSTGldInLrCBlTL/PXTyG92O15pRv6cFXwf8qlxemwTUTMZSDK0OTHSMuz
         D5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OYWSVDDbY/UxSIzaZwoEm71Xw+c2/ceHjCKgkFAt7oc=;
        b=oTSl85e5xtgWCDRSbj34m7KqUWBvjBOGtq2Pqfr4OuanZxWuiw/UzZSLTdjbWgMpA7
         ZPgUnfi+6jzu7HBnuty5u9wppk/yAX7bHkIUA9WVClaLrDkKurxajgukjnaRMQ/wbzxW
         sgs522F8QeC2wLDw2xmPe+qEA5HJUvTr/qqrBSn5pkat6ga0gifedTN5meKPF6tKErAu
         7vr24b8ONWiMDpKqKL1Kqb8tJ0lOOXM3QNr4/ognjSlzkLqzVwwImpvHlPQZ3iiTS7yn
         Dae3tbUyW2o+7ipgXFWEfAwAV456Wc3hbklwCeVVxhqYiEoQJ7wPtQef/PJkd4RiMVne
         /2fg==
X-Gm-Message-State: APjAAAUq0UvBhtdx5jLQRYt/ljH3Z7GbiMAVkOTxfekzC5UuUphkDq54
        sjkDtOzUBCvkD9D+PPZKo5U=
X-Google-Smtp-Source: APXvYqwcKc8OQOLbjhzBWeyXihMSClM0SSK/ywAQmwsvkxrLdQEL2WkFxm0wyd0LYcMkdI11IjjTZg==
X-Received: by 2002:a5d:6151:: with SMTP id y17mr22130398wrt.110.1581612015663;
        Thu, 13 Feb 2020 08:40:15 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id o9sm592460wrw.20.2020.02.13.08.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:40:14 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Olof Johansson <olof@lixom.net>,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] memory: tegra186: Register as memory controller
Date:   Thu, 13 Feb 2020 17:39:58 +0100
Message-Id: <20200213163959.819733-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213163959.819733-1-thierry.reding@gmail.com>
References: <20200213163959.819733-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Registering as memory controller allows other drivers to obtain a
reference to it. This is mostly useful as a way of ordering probe
between devices depending on one another.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/tegra186.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 5d53f11ca7b6..8c43702340e8 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/memory-controller.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of_device.h>
@@ -32,6 +33,7 @@ struct tegra186_mc_soc {
 };
 
 struct tegra186_mc {
+	struct memory_controller base;
 	struct device *dev;
 	void __iomem *regs;
 
@@ -1532,13 +1534,18 @@ static int tegra186_mc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mc->soc = of_device_get_match_data(&pdev->dev);
+	mc->dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mc->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(mc->regs))
 		return PTR_ERR(mc->regs);
 
-	mc->dev = &pdev->dev;
+	mc->base.dev = &pdev->dev;
+
+	err = memory_controller_register(&mc->base);
+	if (err < 0)
+		return err;
 
 	err = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
 	if (err < 0)
-- 
2.24.1

