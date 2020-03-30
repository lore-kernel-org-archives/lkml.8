Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B366C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C70E206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgC3Cee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:34:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729055AbgC3Ced (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:34:33 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 56FE985823BD02648F9E;
        Mon, 30 Mar 2020 10:34:31 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 10:34:21 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <allison@lohutok.net>, <gregkh@linuxfoundation.org>,
        <kstewart@linuxfoundation.org>, <info@metux.net>,
        <tglx@linutronix.de>, <yuehaibing@huawei.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] memory: tegra: mark PM functions as __maybe_unuse
Date:   Mon, 30 Mar 2020 10:33:58 +0800
Message-ID: <20200330023358.30100-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, we get a couple of warnings when CONFIG_PM
is disabled:

drivers/memory/tegra/tegra186.c:1578:12: warning: 'tegra186_mc_resume' defined but not used [-Wunused-function]
 static int tegra186_mc_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~
drivers/memory/tegra/tegra186.c:1573:12: warning: 'tegra186_mc_suspend' defined but not used [-Wunused-function]
 static int tegra186_mc_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~

Fixes: 177602b00641 ("memory: tegra: Add system sleep support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/memory/tegra/tegra186.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 5d53f11ca7b6..e25c954dde2e 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -1570,12 +1570,12 @@ static const struct of_device_id tegra186_mc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra186_mc_of_match);
 
-static int tegra186_mc_suspend(struct device *dev)
+static int __maybe_unused tegra186_mc_suspend(struct device *dev)
 {
 	return 0;
 }
 
-static int tegra186_mc_resume(struct device *dev)
+static int __maybe_unused tegra186_mc_resume(struct device *dev)
 {
 	struct tegra186_mc *mc = dev_get_drvdata(dev);
 
-- 
2.17.1


