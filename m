Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1979C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89DE2467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222162;
	bh=J0Rs58nfBPI0+yMIEHA7ldizGeo8avlFhjdqUwcbVxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EOGY6coQZCx5zc977zxZi6h9JCQJiLboYEEjWJ5UAYYkzSd0eo9CnX9o8l/Z0fYo4
	 3lwHId807fW4Ux1+4KHq5Ikko0fyHdCJFbNWv2sPZGd1jjN4+OBmNBoTz9NfxVcWMa
	 Xs6b/8048csLM6OGc8Tey2GDZ1UcPIsyLpjs6z04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbgA1OWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:22:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731535AbgA1OWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:22:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EDCC24696;
        Tue, 28 Jan 2020 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221343;
        bh=J0Rs58nfBPI0+yMIEHA7ldizGeo8avlFhjdqUwcbVxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQsIl8US2JETlUVg1Ln973PfLH5r/52h/f57CtVWG4DUSNLCsUuJxErhFwfOu7gWI
         517aE5j3a7XluHTlQGDZBxYkoXJvVXbNwE75S8rle9JV+3gH+arNMyHDGyJ3zk3dX4
         DscjShzRoazqeo5fycGow8IdExDxX8VB8h8smurM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 185/271] dmaengine: dw: platform: Switch to acpi_dma_controller_register()
Date:   Tue, 28 Jan 2020 15:05:34 +0100
Message-Id: <20200128135906.340440053@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit e7b8514e4d68bec21fc6385fa0a66797ddc34ac9 ]

There is a possibility to have registered ACPI DMA controller
while it has been gone already.

To avoid the potential crash, move to non-managed
acpi_dma_controller_register().

Fixes: 42c91ee71d6d ("dw_dmac: add ACPI support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20190820131546.75744-8-andriy.shevchenko@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dw/platform.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 5bda0eb9f393f..7536fe80bc33f 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -87,13 +87,20 @@ static void dw_dma_acpi_controller_register(struct dw_dma *dw)
 	dma_cap_set(DMA_SLAVE, info->dma_cap);
 	info->filter_fn = dw_dma_acpi_filter;
 
-	ret = devm_acpi_dma_controller_register(dev, acpi_dma_simple_xlate,
-						info);
+	ret = acpi_dma_controller_register(dev, acpi_dma_simple_xlate, info);
 	if (ret)
 		dev_err(dev, "could not register acpi_dma_controller\n");
 }
+
+static void dw_dma_acpi_controller_free(struct dw_dma *dw)
+{
+	struct device *dev = dw->dma.dev;
+
+	acpi_dma_controller_free(dev);
+}
 #else /* !CONFIG_ACPI */
 static inline void dw_dma_acpi_controller_register(struct dw_dma *dw) {}
+static inline void dw_dma_acpi_controller_free(struct dw_dma *dw) {}
 #endif /* !CONFIG_ACPI */
 
 #ifdef CONFIG_OF
@@ -226,6 +233,9 @@ static int dw_remove(struct platform_device *pdev)
 {
 	struct dw_dma_chip *chip = platform_get_drvdata(pdev);
 
+	if (ACPI_HANDLE(&pdev->dev))
+		dw_dma_acpi_controller_free(chip->dw);
+
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
 
-- 
2.20.1



