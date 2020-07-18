Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D428C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 10:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C3220759
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 10:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGRKDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 06:03:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41372 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbgGRKDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 06:03:33 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 88E1626DBED3CA935B7C;
        Sat, 18 Jul 2020 18:03:30 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Jul 2020
 18:03:21 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <UNGLinuxDriver@microchip.com>, <vladimir.oltean@nxp.com>,
        <claudiu.manoil@nxp.com>, <alexandre.belloni@bootlin.com>,
        <andrew@lunn.ch>, <vivien.didelot@gmail.com>,
        <f.fainelli@gmail.com>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <wanghai38@huawei.com>
Subject: [PATCH] net: dsa: felix: Make some symbols static
Date:   Sat, 18 Jul 2020 18:01:58 +0800
Message-ID: <20200718100158.31878-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse build warning:

drivers/net/dsa/ocelot/felix_vsc9959.c:560:19: warning:
 symbol 'vsc9959_vcap_is2_keys' was not declared. Should it be static?
drivers/net/dsa/ocelot/felix_vsc9959.c:640:19: warning:
 symbol 'vsc9959_vcap_is2_actions' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 1dd9e348152d..2067776773f7 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -557,7 +557,7 @@ static const struct ocelot_stat_layout vsc9959_stats_layout[] = {
 	{ .offset = 0x111,	.name = "drop_green_prio_7", },
 };
 
-struct vcap_field vsc9959_vcap_is2_keys[] = {
+static struct vcap_field vsc9959_vcap_is2_keys[] = {
 	/* Common: 41 bits */
 	[VCAP_IS2_TYPE]				= {  0,   4},
 	[VCAP_IS2_HK_FIRST]			= {  4,   1},
@@ -637,7 +637,7 @@ struct vcap_field vsc9959_vcap_is2_keys[] = {
 	[VCAP_IS2_HK_OAM_IS_Y1731]		= {182,   1},
 };
 
-struct vcap_field vsc9959_vcap_is2_actions[] = {
+static struct vcap_field vsc9959_vcap_is2_actions[] = {
 	[VCAP_IS2_ACT_HIT_ME_ONCE]		= {  0,  1},
 	[VCAP_IS2_ACT_CPU_COPY_ENA]		= {  1,  1},
 	[VCAP_IS2_ACT_CPU_QU_NUM]		= {  2,  3},
-- 
2.17.1

