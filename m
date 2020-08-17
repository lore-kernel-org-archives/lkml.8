Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A19C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0213A2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597650692;
	bh=VpSbfYXzRPSnQuOLCl0Ddt6PoN45I0ZQPp4ER+hVYAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cpu16aG1AjMbv4G0XwSfG1EbPCE5tik0sQ7z/A6vNFCvw8IFmVEEcPAgejIFv8GaU
	 EiRC0/7wPfmfPYTjvy4sf1s8+Eo/YaScZHDF1ghd9FXYrzUOvs1woX363r9n793kHD
	 7zYeREWHJuQX+iGujmUtYfNiOclXIXc0ykipNk9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgHQHva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbgHQHuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:20 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E08F42080D;
        Mon, 17 Aug 2020 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=VpSbfYXzRPSnQuOLCl0Ddt6PoN45I0ZQPp4ER+hVYAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKpfMasXULPraU9glsF6Bh1l0Lvl34RJFqxbeX18OVcBF2Y91SCssso8xKwEXHcmt
         6xPj9cTDP8W8zLwJNKPRubam1s4Ffu+zzNOnhLIJVTkm4yL8kYNmcBuXInTDZOwLFB
         GGhYKZ8xcPG/3tsymrb1riX8tih75+ugYona0eQU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuM-00Bfc2-15; Mon, 17 Aug 2020 09:50:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chenfeng <puck.chen@hisilicon.com>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 05/16] iommu: hisi_smmu: remove linux/hisi/hisi-iommu.h
Date:   Mon, 17 Aug 2020 09:50:04 +0200
Message-Id: <ebabd683057b4069ab74a5460e89a6090f16742e.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just move its contents into drivers/iommu/hisi_smmu.h.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi_smmu.h      |  8 ++++++++
 drivers/staging/hikey9xx/hisi_smmu_lpae.c |  1 -
 include/linux/hisi/hisi-iommu.h           | 13 -------------
 3 files changed, 8 insertions(+), 14 deletions(-)
 delete mode 100644 include/linux/hisi/hisi-iommu.h

diff --git a/drivers/staging/hikey9xx/hisi_smmu.h b/drivers/staging/hikey9xx/hisi_smmu.h
index bd3ee53735bd..c84f854bf39f 100644
--- a/drivers/staging/hikey9xx/hisi_smmu.h
+++ b/drivers/staging/hikey9xx/hisi_smmu.h
@@ -93,6 +93,14 @@ struct hisi_smmu_device_lpae {
 	struct iommu_device iommu;
 };
 
+struct iommu_domain_data {
+	unsigned int     iova_start;
+	unsigned int     iova_size;
+	phys_addr_t      phy_pgd_base;
+	unsigned long    iova_align;
+	struct list_head list;
+};
+
 struct hisi_map_tile_position_lpae {
 	struct scatterlist *sg ;
 	unsigned long offset;
diff --git a/drivers/staging/hikey9xx/hisi_smmu_lpae.c b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
index 5acde3ddbd99..fcaf97f92e7f 100644
--- a/drivers/staging/hikey9xx/hisi_smmu_lpae.c
+++ b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
@@ -24,7 +24,6 @@
 #include <linux/spinlock.h>
 #include <asm/pgalloc.h>
 #include <linux/debugfs.h>
-#include <linux/hisi/hisi-iommu.h>
 #include <linux/uaccess.h>
 #include <linux/bitops.h>
 #include "hisi_smmu.h"
diff --git a/include/linux/hisi/hisi-iommu.h b/include/linux/hisi/hisi-iommu.h
deleted file mode 100644
index 00dd5e97db59..000000000000
--- a/include/linux/hisi/hisi-iommu.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef _HI36XX_SMMU_H
-#define _HI36XX_SMMU_H
-
-#include <linux/types.h>
-struct iommu_domain_data {
-	unsigned int     iova_start;
-	unsigned int     iova_size;
-	phys_addr_t      phy_pgd_base;
-	unsigned long    iova_align;
-	struct list_head list;
-};
-
-#endif
-- 
2.26.2

