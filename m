Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F766C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0ED422BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="LXvQRaAV";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="KYaOlXYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgH0Ntn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:49:43 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:39338 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728121AbgH0N3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:29:13 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RDJwaK014981;
        Thu, 27 Aug 2020 06:29:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=PJoe71sNd60E5t116wHLyiojgVE3e8mA9NRrDbwS8YI=;
 b=LXvQRaAVR/9KWRXk/NWdUS0BxjAoGMp/4HzveTDVeOK5kEunh+I37A7NVcxr3tbKBNQn
 V4AfsvlJ0bu7yOoNV8zPZgSLtSa7+NnE02Mk1seZcklh+Wr2GvV8hKpra8mNeXUItkWe
 GuUhV+57XLKR4RuxRLvn9CdKtxgRT0DvrCIfcXvj3dUpfTzEgK8HTXu3KTTH+mZCbDAW
 DaSkt2UM8tVimcrQa+RRU1kTUlvR85B73ujlapKrWaJgxazOjOfmKma217Mv3UYLv6GY
 XnAL4ZBbcP/q1VVFiPROh9P7wRgVyeNGkHWXLfZbq6Eehu7ii+kX4qlIZXg1ybk4fIz1 8w== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2051.outbound.protection.outlook.com [104.47.45.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 332xxxcnrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 06:29:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJMQ2aKwygETGm3dAIcoyy58a4pZvIzL9vQQU19HhgBntSXCQCe1tPcvY7ttqEPqveu/O5uITS0HL397xksv+nq0fVlPT+NuJGwLukC4LOlVo1ulrPeOoVHgaORXFv51ber7cYTBTUokTLNqX3cL/q1W8aQbVinUNkfcAq7OlzvUOKIsixTGV/e3JNFKQy9j+yEMIPslrBPWB1t3fivoxzuJOq/jouMv6x3kCE0Sa71apBpfB7hLhZMQuDhieDr7LE7P2boKpIR/RJJfDz6oAAXLX/Dj5Qo0EftHQQ0Rk6wSDkq4bI/sfsK9niV1H36Wx2XEu4vRzPT22dzVaWyu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJoe71sNd60E5t116wHLyiojgVE3e8mA9NRrDbwS8YI=;
 b=WjIA+Agwojbsm0xKZ4eEaFdd4+TJoXtT+YXyrHfMfaeV9+8U1KeSPcRjlw3zVAaGbfkFfpgDxeZE4UvDI8m4mym/3hflDXZNxR6M36lA6c2elfS+EBWSYr1tfLt1lV240nK17MYFiKwmhYNvj5eFVs4kPcI84shhUO6fltndtshk3qTwly6drs2K5zR0mS5Akgj8DEUSYlxVyMcaMBu3J60xo1dSTqHNvu2E4nJXMuLdoIExSrZVJOMZmc/ttYHLTyWVRBiFpuZ70Kt/hxkkZymdLNBBx0Tl4ZDdqjXpZKMvDZ4rY+lrLus92guuArwsytL0zcHFagKbTbGyJ6zkjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJoe71sNd60E5t116wHLyiojgVE3e8mA9NRrDbwS8YI=;
 b=KYaOlXYU4F5+fpE1MzXrtBwWXRlEa5bzwvPc74dNtYPUjZEdlaLFvZpBw7PdbTbGKXfVl4/vSvUdCcAeZ8CIrc5bUOXl4zCRBLjL3Mj1KYMyWxr76zqLSsIdXpRh9Vk3qBMfCyjm8zl4UVuGIC6C6LguLWhuuSqUgkA8frtwgPM=
Received: from DM5PR1401CA0001.namprd14.prod.outlook.com (2603:10b6:4:4a::11)
 by BN8PR07MB6051.namprd07.prod.outlook.com (2603:10b6:408:9e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 13:29:04 +0000
Received: from DM6NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::7b) by DM5PR1401CA0001.outlook.office365.com
 (2603:10b6:4:4a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 13:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT065.mail.protection.outlook.com (10.13.179.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 13:29:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSrRl001550
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 09:29:01 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSrIn018758;
        Thu, 27 Aug 2020 15:28:53 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RDSrXR018757;
        Thu, 27 Aug 2020 15:28:53 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 5/7] phy: cadence-torrent: Check total lane count for all subnodes is within limit
Date:   Thu, 27 Aug 2020 15:28:50 +0200
Message-ID: <1598534932-18693-6-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
References: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f44ba98-ce17-41b9-c9f7-08d84a8d29dd
X-MS-TrafficTypeDiagnostic: BN8PR07MB6051:
X-Microsoft-Antispam-PRVS: <BN8PR07MB60518CDF3D226804A2181E8AC5550@BN8PR07MB6051.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyDrkjeqkHaNGuMi9dcZXWn7wC++3uXhXw/4ozcv8PnhKwwuAYmy3lIM6QvEE/9d4t8JI6gNAzfWb4e9wNmAHcNWrrFt/boqYZfFCSxT/gRxg5JrUwpOQhsyQtBK2x2SeUvS1n6k48R63bF2Avo9MMrcdXwNCUKo+3b6mtch2NvVCt0PsSmcNk5ysQLrXGkpal4NbYzIGmxmfFKdOcR+WORd2QwifybngkhimBLB0S6km16hzuUZ55r1mm3s82UsRO4/B76GGuESlK95TgS365FDIDyDyv5b+ZDHJnxv1qpvV2DN/Nt7ZfAenSf14gILb69iL8uxgJXQiANA8GOjdaIUA9a22ML5CeYMeBCjy27Vpsa47evzMlBZehn13tFF/9QD6POzCalYzjk5SAmzLl73YdDAMvAPGsarb1jF7Ow=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(36092001)(46966005)(83380400001)(110136005)(42186006)(54906003)(81166007)(26005)(2906002)(47076004)(5660300002)(186003)(86362001)(82740400003)(82310400002)(356005)(426003)(336012)(8676002)(2616005)(36906005)(8936002)(70586007)(4326008)(70206006)(316002)(36756003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 13:29:02.5510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f44ba98-ce17-41b9-c9f7-08d84a8d29dd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT065.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6051
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008270101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add checking if total number of lanes for all subnodes is not greater than
number of lanes supported by PHY.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 66ae5b749385..ed2140691077 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -25,7 +25,6 @@
 #define REF_CLK_19_2MHz		19200000
 #define REF_CLK_25MHz		25000000
 
-#define DEFAULT_NUM_LANES	4
 #define MAX_NUM_LANES		4
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
@@ -1735,6 +1734,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	const struct cdns_torrent_data *data;
 	struct device_node *child;
 	int ret, subnodes, node = 0, i;
+	u32 total_num_lanes = 0;
 	u8 init_dp_regmap = 0;
 
 	/* Get init data for this PHY */
@@ -1809,9 +1809,15 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 			goto put_child;
 		}
 
-		cdns_phy->phys[node].num_lanes = DEFAULT_NUM_LANES;
-		of_property_read_u32(child, "cdns,num-lanes",
-				     &cdns_phy->phys[node].num_lanes);
+		if (of_property_read_u32(child, "cdns,num-lanes",
+					 &cdns_phy->phys[node].num_lanes)) {
+			dev_err(dev, "%s: No \"cdns,num-lanes\"-property.\n",
+				child->full_name);
+			ret = -EINVAL;
+			goto put_child;
+		}
+
+		total_num_lanes += cdns_phy->phys[node].num_lanes;
 
 		if (cdns_phy->phys[node].phy_type == PHY_TYPE_DP) {
 			switch (cdns_phy->phys[node].num_lanes) {
@@ -1893,6 +1899,11 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	}
 	cdns_phy->nsubnodes = node;
 
+	if (total_num_lanes > MAX_NUM_LANES) {
+		dev_err(dev, "Invalid lane configuration\n");
+		goto put_lnk_rst;
+	}
+
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	if (IS_ERR(phy_provider)) {
 		ret = PTR_ERR(phy_provider);
-- 
2.26.1

