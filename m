Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49323C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBD520773
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgGMKRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGMKRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:17:10 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55842C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 03:17:10 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9355136B; Mon, 13 Jul 2020 12:17:08 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/mediatek: Include liunx/dma-mapping.h
Date:   Mon, 13 Jul 2020 12:16:48 +0200
Message-Id: <20200713101648.32056-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

This fixes a compile error when cross-compiling the driver
on x86-32.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/mtk_iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 6ff62452bbf9..122925dbe547 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -15,6 +15,7 @@
 #include <linux/iommu.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/dma-mapping.h>
 #include <soc/mediatek/smi.h>
 
 #define MTK_LARB_COM_MAX	8
-- 
2.16.3

