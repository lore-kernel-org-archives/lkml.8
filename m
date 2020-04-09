Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7E4C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828BC20771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDILm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:42:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbgDILmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:42:55 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 84429AF7EE05142D64A7;
        Thu,  9 Apr 2020 19:42:02 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 19:41:53 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] regulator: qcom_rpm: remove defined but not used 'pm8921_ftsmps'
Date:   Thu, 9 Apr 2020 19:40:26 +0800
Message-ID: <20200409114026.38383-1-yanaijie@huawei.com>
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

drivers/regulator/qcom_rpm-regulator.c:607:34: warning: ‘pm8921_ftsmps’
defined but not used [-Wunused-const-variable=]
 static const struct qcom_rpm_reg pm8921_ftsmps = {
                                  ^~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/regulator/qcom_rpm-regulator.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
index 7fc97f23fcf4..1ee8ec686ed3 100644
--- a/drivers/regulator/qcom_rpm-regulator.c
+++ b/drivers/regulator/qcom_rpm-regulator.c
@@ -604,16 +604,6 @@ static const struct qcom_rpm_reg pm8921_smps = {
 	.supports_force_mode_bypass = false,
 };
 
-static const struct qcom_rpm_reg pm8921_ftsmps = {
-	.desc.linear_ranges = ftsmps_ranges,
-	.desc.n_linear_ranges = ARRAY_SIZE(ftsmps_ranges),
-	.desc.n_voltages = 101,
-	.desc.ops = &uV_ops,
-	.parts = &rpm8960_smps_parts,
-	.supports_force_mode_auto = true,
-	.supports_force_mode_bypass = false,
-};
-
 static const struct qcom_rpm_reg pm8921_ncp = {
 	.desc.linear_ranges = ncp_ranges,
 	.desc.n_linear_ranges = ARRAY_SIZE(ncp_ranges),
-- 
2.17.2

