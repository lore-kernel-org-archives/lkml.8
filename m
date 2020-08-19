Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61C9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB531204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgHSOFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:05:36 -0400
Received: from foss.arm.com ([217.140.110.172]:37978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbgHSOFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:05:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0B861045;
        Wed, 19 Aug 2020 07:05:20 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FF3F3F71F;
        Wed, 19 Aug 2020 07:05:19 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, cristian.marussi@arm.com
Subject: [PATCH] regulator: core: add of_match_full_name boolean flag
Date:   Wed, 19 Aug 2020 15:04:48 +0100
Message-Id: <20200819140448.51373-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an .of_match non-null string is defined in struct regulator_desc, the
regulator core searches for regulators trying to match, at first, such
string against the 'regulator-compatible' property and then falls back to
use the name of the node itself.

Property 'regulator-compatible' is now deprecated (even if still widely
used in the code base), and the node-name fallback works fine only as long
as the nodes are named in an unique way; if it makes sense to use a common
name and identifying them using an index through a 'reg' property the
standard advices to use a naming in the form <common-name>@<unit>.

In this case the above matching mechanism based on the simple (common) name
will fail and the only viable alternative would be to properly define the
deprecrated 'regulator-compatible' property equal to the full name
<common-name>@<unit>.

In order to address this case without using such deprecated property,
define a new boolean flag .of_match_full_name in struct regulator_desc to
force the core to match against the node full-name instead.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/regulator/of_regulator.c | 3 ++-
 include/linux/regulator/driver.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 06c0b15fe4c0..f60cb0093b40 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -414,7 +414,8 @@ device_node *regulator_of_get_init_node(struct device *dev,
 	for_each_available_child_of_node(search, child) {
 		name = of_get_property(child, "regulator-compatible", NULL);
 		if (!name)
-			name = child->name;
+			name = !desc->of_match_full_name ?
+				child->name : child->full_name;
 
 		if (!strcmp(desc->of_match, name)) {
 			of_node_put(search);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 8539f34ae42b..5d9b011fcef6 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -223,6 +223,8 @@ enum regulator_type {
  * @name: Identifying name for the regulator.
  * @supply_name: Identifying the regulator supply
  * @of_match: Name used to identify regulator in DT.
+ * @of_match_full_name: A flag to indicate that the of_match string, if
+ *			present, should be matched against the node full_name.
  * @regulators_node: Name of node containing regulator definitions in DT.
  * @of_parse_cb: Optional callback called only if of_match is present.
  *               Will be called for each regulator parsed from DT, during
@@ -314,6 +316,7 @@ struct regulator_desc {
 	const char *name;
 	const char *supply_name;
 	const char *of_match;
+	bool of_match_full_name;
 	const char *regulators_node;
 	int (*of_parse_cb)(struct device_node *,
 			    const struct regulator_desc *,
-- 
2.17.1

