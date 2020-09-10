Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782CBC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B39720795
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgIJDnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:43:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41316 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729525AbgIJDnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:43:07 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 169EB683EB970F9B8DD6;
        Thu, 10 Sep 2020 11:43:04 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 11:42:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <matti.vaittinen@fi.rohmeurope.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>
CC:     <linux-power@fi.rohmeurope.com>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] regulator: bd718x7: Make some variable static
Date:   Thu, 10 Sep 2020 11:42:40 +0800
Message-ID: <20200910034240.37268-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/regulator/bd718x7-regulator.c:576:28: warning: symbol 'bd71847_swcontrol_ops' was not declared. Should it be static?
drivers/regulator/bd718x7-regulator.c:585:28: warning: symbol 'bd71847_hwcontrol_ops' was not declared. Should it be static?
drivers/regulator/bd718x7-regulator.c:902:28: warning: symbol 'bd71837_swcontrol_ops' was not declared. Should it be static?
drivers/regulator/bd718x7-regulator.c:913:28: warning: symbol 'bd71837_hwcontrol_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/regulator/bd718x7-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 159c917b9c4c..0774467994fb 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -573,7 +573,7 @@ static int buck_set_hw_dvs_levels(struct device_node *np,
 	return rohm_regulator_set_dvs_levels(&data->dvs, np, desc, cfg->regmap);
 }
 
-const struct regulator_ops *bd71847_swcontrol_ops[] = {
+static const struct regulator_ops *bd71847_swcontrol_ops[] = {
 	&bd718xx_dvs_buck_regulator_ops, &bd718xx_dvs_buck_regulator_ops,
 	&bd718xx_pickable_range_buck_ops, &bd718xx_pickable_range_buck_ops,
 	&bd718xx_buck_regulator_nolinear_ops, &bd718xx_buck_regulator_ops,
@@ -582,7 +582,7 @@ const struct regulator_ops *bd71847_swcontrol_ops[] = {
 	&bd718xx_pickable_range_ldo_ops, &bd718xx_ldo_regulator_ops,
 };
 
-const struct regulator_ops *bd71847_hwcontrol_ops[] = {
+static const struct regulator_ops *bd71847_hwcontrol_ops[] = {
 	&BD718XX_HWOPNAME(bd718xx_dvs_buck_regulator_ops),
 	&BD718XX_HWOPNAME(bd718xx_dvs_buck_regulator_ops),
 	&BD718XX_HWOPNAME(bd718xx_pickable_range_buck_ops),
@@ -899,7 +899,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 	},
 };
 
-const struct regulator_ops *bd71837_swcontrol_ops[] = {
+static const struct regulator_ops *bd71837_swcontrol_ops[] = {
 	&bd718xx_dvs_buck_regulator_ops, &bd718xx_dvs_buck_regulator_ops,
 	&bd718xx_dvs_buck_regulator_ops, &bd718xx_dvs_buck_regulator_ops,
 	&bd71837_pickable_range_buck_ops, &bd71837_buck_regulator_ops,
@@ -910,7 +910,7 @@ const struct regulator_ops *bd71837_swcontrol_ops[] = {
 	&bd71837_ldo_regulator_ops,
 };
 
-const struct regulator_ops *bd71837_hwcontrol_ops[] = {
+static const struct regulator_ops *bd71837_hwcontrol_ops[] = {
 	&BD718XX_HWOPNAME(bd718xx_dvs_buck_regulator_ops),
 	&BD718XX_HWOPNAME(bd718xx_dvs_buck_regulator_ops),
 	&bd71837_buck34_ops_hwctrl, &bd71837_buck34_ops_hwctrl,
-- 
2.17.1


