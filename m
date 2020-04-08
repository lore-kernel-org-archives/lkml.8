Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A0DC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA1E206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgDHUgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:36:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgDHUga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:36:30 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 038KXpKi050590;
        Wed, 8 Apr 2020 16:36:27 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3092098vwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Apr 2020 16:36:26 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 038KUfd6004457;
        Wed, 8 Apr 2020 20:36:25 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03wdc.us.ibm.com with ESMTP id 3091mdyus2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Apr 2020 20:36:25 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 038KaPBd52101450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Apr 2020 20:36:25 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70BF628059;
        Wed,  8 Apr 2020 20:36:25 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7D7E28058;
        Wed,  8 Apr 2020 20:36:24 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.211.136.102])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Apr 2020 20:36:24 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, joel@jms.id.au,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] clk: ast2600: Fix AHB clock divider for A1
Date:   Wed,  8 Apr 2020 15:36:16 -0500
Message-Id: <20200408203616.4031-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-08_08:2020-04-07,2020-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 suspectscore=1 clxscore=1011 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest specs for the AST2600 A1 chip include some different bit
definitions for calculating the AHB clock divider. Implement these in
order to get the correct AHB clock value in Linux.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/clk/clk-ast2600.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
index 392d01705b97..99afc949925f 100644
--- a/drivers/clk/clk-ast2600.c
+++ b/drivers/clk/clk-ast2600.c
@@ -642,14 +642,22 @@ static const u32 ast2600_a0_axi_ahb_div_table[] = {
 	2, 2, 3, 5,
 };
 
-static const u32 ast2600_a1_axi_ahb_div_table[] = {
-	4, 6, 2, 4,
+static const u32 ast2600_a1_axi_ahb_div0_tbl[] = {
+	3, 2, 3, 4,
+};
+
+static const u32 ast2600_a1_axi_ahb_div1_tbl[] = {
+	3, 4, 6, 8,
+};
+
+static const u32 ast2600_a1_axi_ahb200_tbl[] = {
+	3, 4, 3, 4, 2, 2, 2, 2,
 };
 
 static void __init aspeed_g6_cc(struct regmap *map)
 {
 	struct clk_hw *hw;
-	u32 val, div, chip_id, axi_div, ahb_div;
+	u32 val, div, divbits, chip_id, axi_div, ahb_div;
 
 	clk_hw_register_fixed_rate(NULL, "clkin", NULL, 0, 25000000);
 
@@ -679,11 +687,22 @@ static void __init aspeed_g6_cc(struct regmap *map)
 	else
 		axi_div = 2;
 
+	divbits = (val >> 11) & 0x3;
 	regmap_read(map, ASPEED_G6_SILICON_REV, &chip_id);
-	if (chip_id & BIT(16))
-		ahb_div = ast2600_a1_axi_ahb_div_table[(val >> 11) & 0x3];
-	else
+	if (chip_id & BIT(16)) {
+		if (!divbits) {
+			ahb_div = ast2600_a1_axi_ahb200_tbl[(val >> 8) & 0x3];
+			if (val & BIT(16))
+				ahb_div *= 2;
+		} else {
+			if (val & BIT(16))
+				ahb_div = ast2600_a1_axi_ahb_div1_tbl[divbits];
+			else
+				ahb_div = ast2600_a1_axi_ahb_div0_tbl[divbits];
+		}
+	} else {
 		ahb_div = ast2600_a0_axi_ahb_div_table[(val >> 11) & 0x3];
+	}
 
 	hw = clk_hw_register_fixed_factor(NULL, "ahb", "hpll", 0, 1, axi_div * ahb_div);
 	aspeed_g6_clk_data->hws[ASPEED_CLK_AHB] = hw;
-- 
2.24.0

