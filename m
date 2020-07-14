Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407E5C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28CF622224
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgGNMC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:02:29 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:52653 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728175AbgGNMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:02:23 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with SMTP; 14 Jul 2020 15:02:20 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06EC25do004353;
        Tue, 14 Jul 2020 15:02:19 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v2 11/11] platform/x86: mlx-platform: Extend FAN platform data description
Date:   Tue, 14 Jul 2020 15:02:03 +0300
Message-Id: <20200714120203.10352-12-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200714120203.10352-1-vadimp@mellanox.com>
References: <20200714120203.10352-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend FAN platform data with register presence field.
Add register present entry per rotor (tachometer) description tuple.
The purpose is to allow indication of FAN presence.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/x86/mlx-platform.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 034736cec9a6..90bc7969b199 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -1840,6 +1840,8 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_fan_data[] = {
 		.mask = GENMASK(7, 0),
 		.capability = MLXPLAT_CPLD_LPC_REG_FAN_CAP1_OFFSET,
 		.bit = BIT(0),
+		.reg_prsnt = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
+
 	},
 	{
 		.label = "tacho2",
@@ -1847,6 +1849,7 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_fan_data[] = {
 		.mask = GENMASK(7, 0),
 		.capability = MLXPLAT_CPLD_LPC_REG_FAN_CAP1_OFFSET,
 		.bit = BIT(1),
+		.reg_prsnt = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 	},
 	{
 		.label = "tacho3",
@@ -1854,6 +1857,7 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_fan_data[] = {
 		.mask = GENMASK(7, 0),
 		.capability = MLXPLAT_CPLD_LPC_REG_FAN_CAP1_OFFSET,
 		.bit = BIT(2),
+		.reg_prsnt = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 	},
 	{
 		.label = "tacho4",
@@ -1861,6 +1865,7 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_fan_data[] = {
 		.mask = GENMASK(7, 0),
 		.capability = MLXPLAT_CPLD_LPC_REG_FAN_CAP1_OFFSET,
 		.bit = BIT(3),
+		.reg_prsnt = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 	},
 	{
 		.label = "tacho5",
@@ -1868,6 +1873,7 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_fan_data[] = {
 		.mask = GENMASK(7, 0),
 		.capability = MLXPLAT_CPLD_LPC_REG_FAN_CAP1_OFFSET,
 		.bit = BIT(4),
+		.reg_prsnt = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 	},
 	{
 		.label = "tacho6",
@@ -1875,6 +1881,7 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_fan_data[] = {
 		.mask = GENMASK(7, 0),
 		.capability = MLXPLAT_CPLD_LPC_REG_FAN_CAP1_OFFSET,
 		.bit = BIT(5),
+		.reg_prsnt = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 	},
 	{
 		.label = "tacho7",
@@ -1882,6 +1889,7 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_fan_data[] = {
 		.mask = GENMASK(7, 0),
 		.capability = MLXPLAT_CPLD_LPC_REG_FAN_CAP1_OFFSET,
 		.bit = BIT(6),
+		.reg_prsnt = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 	},
 	{
 		.label = "tacho8",
@@ -1889,6 +1897,7 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_fan_data[] = {
 		.mask = GENMASK(7, 0),
 		.capability = MLXPLAT_CPLD_LPC_REG_FAN_CAP1_OFFSET,
 		.bit = BIT(7),
+		.reg_prsnt = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 	},
 	{
 		.label = "tacho9",
@@ -1896,6 +1905,7 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_fan_data[] = {
 		.mask = GENMASK(7, 0),
 		.capability = MLXPLAT_CPLD_LPC_REG_FAN_CAP2_OFFSET,
 		.bit = BIT(0),
+		.reg_prsnt = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 	},
 	{
 		.label = "tacho10",
@@ -1903,6 +1913,7 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_fan_data[] = {
 		.mask = GENMASK(7, 0),
 		.capability = MLXPLAT_CPLD_LPC_REG_FAN_CAP2_OFFSET,
 		.bit = BIT(1),
+		.reg_prsnt = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 	},
 	{
 		.label = "tacho11",
@@ -1910,6 +1921,7 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_fan_data[] = {
 		.mask = GENMASK(7, 0),
 		.capability = MLXPLAT_CPLD_LPC_REG_FAN_CAP2_OFFSET,
 		.bit = BIT(2),
+		.reg_prsnt = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 	},
 	{
 		.label = "tacho12",
@@ -1917,6 +1929,7 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_fan_data[] = {
 		.mask = GENMASK(7, 0),
 		.capability = MLXPLAT_CPLD_LPC_REG_FAN_CAP2_OFFSET,
 		.bit = BIT(3),
+		.reg_prsnt = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 	},
 	{
 		.label = "conf",
-- 
2.11.0

