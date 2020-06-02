Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21288C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C4520772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgFBFYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:24:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40846 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbgFBFYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:24:17 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B045320094A;
        Tue,  2 Jun 2020 07:24:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2B23C20094E;
        Tue,  2 Jun 2020 07:24:05 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 274A940323;
        Tue,  2 Jun 2020 13:23:53 +0800 (SGT)
From:   Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
To:     xiaoliang.yang_1@nxp.com, po.liu@nxp.com, claudiu.manoil@nxp.com,
        alexandru.marginean@nxp.com, vladimir.oltean@nxp.com,
        leoyang.li@nxp.com, mingkai.hu@nxp.com, andrew@lunn.ch,
        f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, jiri@resnulli.us, idosch@idosch.org,
        kuba@kernel.org, vinicius.gomes@intel.com,
        nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horatiu.vultur@microchip.com, alexandre.belloni@bootlin.com,
        allan.nielsen@microchip.com, joergen.andreasen@microchip.com,
        UNGLinuxDriver@microchip.com, linux-devel@linux.nxdi.nxp.com
Subject: [PATCH v2 net-next 08/10] net: ocelot: return error if rule is not found
Date:   Tue,  2 Jun 2020 13:18:26 +0800
Message-Id: <20200602051828.5734-9-xiaoliang.yang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602051828.5734-1-xiaoliang.yang_1@nxp.com>
References: <20200602051828.5734-1-xiaoliang.yang_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return error if rule is not found in rule list to avoid Kernel panic.

Signed-off-by: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot_ace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_ace.c b/drivers/net/ethernet/mscc/ocelot_ace.c
index bf2b7a03c832..2ba2859fa2cd 100644
--- a/drivers/net/ethernet/mscc/ocelot_ace.c
+++ b/drivers/net/ethernet/mscc/ocelot_ace.c
@@ -982,9 +982,9 @@ static int ocelot_ace_rule_get_index_id(struct ocelot_acl_block *block,
 	list_for_each_entry(tmp, &block->rules, list) {
 		++index;
 		if (rule->id == tmp->id)
-			break;
+			return index;
 	}
-	return index;
+	return -ENOENT;
 }
 
 static struct ocelot_ace_rule*
@@ -1197,6 +1197,8 @@ int ocelot_ace_rule_offload_del(struct ocelot *ocelot, int block_id,
 
 	/* Gets index of the rule */
 	index = ocelot_ace_rule_get_index_id(block, rule);
+	if (index < 0)
+		return -ENOENT;
 
 	/* Delete rule */
 	ocelot_ace_rule_del(ocelot, block, rule);
@@ -1221,6 +1223,9 @@ int ocelot_ace_rule_stats_update(struct ocelot *ocelot, int block_id,
 	int index;
 
 	index = ocelot_ace_rule_get_index_id(block, rule);
+	if (index < 0)
+		return -ENOENT;
+
 	vcap_entry_get(ocelot, rule, index, block_id);
 
 	/* After we get the result we need to clear the counters */
-- 
2.17.1

