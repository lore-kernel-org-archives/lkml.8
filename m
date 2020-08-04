Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDEBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02182073E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgHDBmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:42:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729412AbgHDBmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 21:42:00 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1E7E65B8571CDFA4E6EB;
        Tue,  4 Aug 2020 09:41:57 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 4 Aug 2020
 09:41:50 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <digetx@gmail.com>, <mchehab@kernel.org>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] media: staging: tegra-vde: Mark tegra_vde_runtime_suspend/resume as __maybe_unused
Date:   Tue, 4 Aug 2020 09:41:37 +0800
Message-ID: <20200804014137.45444-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200803115901.44068-1-yuehaibing@huawei.com>
References: <20200803115901.44068-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM is not set, gcc warns:

drivers/staging/media/tegra-vde/vde.c:916:12:
 warning: 'tegra_vde_runtime_suspend' defined but not used [-Wunused-function]

Make it __maybe_unused to fix this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: both suspend and resume functions marked
---
 drivers/staging/media/tegra-vde/vde.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/tegra-vde/vde.c b/drivers/staging/media/tegra-vde/vde.c
index a3c24d96d5b9..28845b5bafaf 100644
--- a/drivers/staging/media/tegra-vde/vde.c
+++ b/drivers/staging/media/tegra-vde/vde.c
@@ -913,7 +913,7 @@ static irqreturn_t tegra_vde_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int tegra_vde_runtime_suspend(struct device *dev)
+static __maybe_unused int tegra_vde_runtime_suspend(struct device *dev)
 {
 	struct tegra_vde *vde = dev_get_drvdata(dev);
 	int err;
@@ -929,7 +929,7 @@ static int tegra_vde_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_vde_runtime_resume(struct device *dev)
+static __maybe_unused int tegra_vde_runtime_resume(struct device *dev)
 {
 	struct tegra_vde *vde = dev_get_drvdata(dev);
 	int err;
-- 
2.17.1


