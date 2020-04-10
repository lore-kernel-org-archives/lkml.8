Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15476C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42062084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDJHfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 03:35:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbgDJHfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 03:35:19 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 842447D1C40349AFE12C;
        Fri, 10 Apr 2020 15:35:17 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Apr 2020
 15:35:10 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] regulator: ab8500: remove some defined but not used variables
Date:   Fri, 10 Apr 2020 15:33:43 +0800
Message-ID: <20200410073343.39031-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/regulator/ab8500.c:195:27: warning: ‘ldo_vdmic_voltages’ defined
but not used [-Wunused-const-variable=]
 static const unsigned int ldo_vdmic_voltages[] = {
                           ^~~~~~~~~~~~~~~~~~
drivers/regulator/ab8500.c:169:27: warning: ‘fixed_3300000_voltage’
defined but not used [-Wunused-const-variable=]
 static const unsigned int fixed_3300000_voltage[] = {
                           ^~~~~~~~~~~~~~~~~~~~~
drivers/regulator/ab8500.c:142:27: warning: ‘ldo_sdio_voltages’ defined
but not used [-Wunused-const-variable=]
 static const unsigned int ldo_sdio_voltages[] = {
                           ^~~~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/regulator/ab8500.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index f60e1b26c2d2..716ca5bb178e 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -139,17 +139,6 @@ static const unsigned int ldo_vintcore_voltages[] = {
 	1350000,
 };
 
-static const unsigned int ldo_sdio_voltages[] = {
-	1160000,
-	1050000,
-	1100000,
-	1500000,
-	1800000,
-	2200000,
-	2910000,
-	3050000,
-};
-
 static const unsigned int fixed_1200000_voltage[] = {
 	1200000,
 };
@@ -166,10 +155,6 @@ static const unsigned int fixed_2050000_voltage[] = {
 	2050000,
 };
 
-static const unsigned int fixed_3300000_voltage[] = {
-	3300000,
-};
-
 static const unsigned int ldo_vana_voltages[] = {
 	1050000,
 	1075000,
@@ -192,13 +177,6 @@ static const unsigned int ldo_vaudio_voltages[] = {
 	2600000,	/* Duplicated in Vaudio and IsoUicc Control register. */
 };
 
-static const unsigned int ldo_vdmic_voltages[] = {
-	1800000,
-	1900000,
-	2000000,
-	2850000,
-};
-
 static DEFINE_MUTEX(shared_mode_mutex);
 static struct ab8500_shared_mode ldo_anamic1_shared;
 static struct ab8500_shared_mode ldo_anamic2_shared;
-- 
2.17.2

