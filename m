Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AA1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6472075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="SJmoXo4t";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="4wBZoAZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgHGLqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:46:54 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:9000 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbgHGLq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:46:29 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077BhO1U011150;
        Fri, 7 Aug 2020 04:46:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=IisfoUh2UY4asdzSZ/pyaVfg4dS3qDinUXZkK781fas=;
 b=SJmoXo4tFYlx6ahGX2dZthnW7h5KhP7HlMRdT6bx6iZUO7qKuerBZV8lOpSNIs7jj36X
 25Z5gmyqkpF47/QOMwmztJifPnVHMIyW2zS5yimT/abhtoM/iywCty4yhGF7HbFxyb3X
 kIUa6dAvtHJtEzZb8i76EYT82OCZm9boe+87mviGAhaJHjAybGI5Tz85mqLIelIpQpgR
 IcDvt8d8VUbO3qpD4OKkodJddndI4gpQ+NpnZsaTJYsrK4H0g7e2Yf2niVQrutS7BUSz
 B4P9tGWVHRElSt7mfScdbznkf70MaHqArHDEj6HAzhp+barEuTQmWNQvMloesk5esXy5 Iw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0mc3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 04:46:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYvN5EYp59UZY/kyUZEfAQTATXgM+5G6b3j53IOJIW9PWqFV6u/PxsIZnFUupOY/+n65IlDiHRFoB2bcRKea5IvT/Y9nLz3JyaJw0ezU7gC9tPDHBN/863QOwRNyMck//m8ZxSe8j+xCDjI3EPTRmZdhZV+0itFrSoAUZcCloH/j1f7EZxbSgA9X3cQASnQ6uK6sLzurz1K78xMcMG2a34sTrePLydm2EIF/sWeF1IXXzZY5unDw50Cr88RmuVzLhuQTJpSilVNqo2INe8SEmpsD/JpviOqJo5tUz/x1JyrvhLIpSlPXsj3tcL/3x5w79wGvAQIqQPLDlceEvzteeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IisfoUh2UY4asdzSZ/pyaVfg4dS3qDinUXZkK781fas=;
 b=DOqfWTRuVFBV4UhdKWlfJDJoJj6f7HqnZm1lQ1vJPYtZc+AWJys20Q1LpO4ilbOhPq9CYz2aUF98LmA1yjArhFSiT10HjV5uQeF46JVCwoqKgNkFD4HkjoKjl98jj9IuzcXtEUkj0//O7tgZdMhCFXs+4aYh7at1zxNJ6lfxo6pW3Omg2WtTot1KTJozg+0jLNa0sUICPRr9xA0AFZQzhy4DcDMdk7U/RHDAYrNn0X/zy+oJt2b1Z08T3RVBtFHJTRuQjbtFgDdAK2ZHRTU6NPpvawD+U0m8FOZSR71K9yqK4Id4TxOWY9Zmddk1rlmSbB+AL/zXbpvQ4FO5lFSx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IisfoUh2UY4asdzSZ/pyaVfg4dS3qDinUXZkK781fas=;
 b=4wBZoAZkNb8+NYTFg7bHYjal/z0T1Dm0jauQRW2U+YAyFO/BGNrnDylRcWokQZgWrXxu/JVzBTPp2fPqjUTM9LgxcsaHphtinKnSldad3rljqhmx1nVV622uUtDeXZQp/aIqpKqCSyZk0/6hPK8lxeWbmYLUxxxg/gGscEQRztw=
Received: from DM5PR21CA0067.namprd21.prod.outlook.com (2603:10b6:3:129::29)
 by BN7PR07MB4225.namprd07.prod.outlook.com (2603:10b6:406:b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17; Fri, 7 Aug
 2020 11:46:15 +0000
Received: from DM6NAM12FT030.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::bf) by DM5PR21CA0067.outlook.office365.com
 (2603:10b6:3:129::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.2 via Frontend
 Transport; Fri, 7 Aug 2020 11:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT030.mail.protection.outlook.com (10.13.178.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 11:46:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9P7029785
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 07:46:14 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 13:46:08 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 13:46:08 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk8VQ000832;
        Fri, 7 Aug 2020 13:46:08 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077Bk8vC000831;
        Fri, 7 Aug 2020 13:46:08 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 02/13] phy: cadence-torrent: Check cmn_ready assertion during PHY power on
Date:   Fri, 7 Aug 2020 13:45:56 +0200
Message-ID: <1596800767-784-3-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
References: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3acea74-343c-45ee-bca4-08d83ac77db0
X-MS-TrafficTypeDiagnostic: BN7PR07MB4225:
X-Microsoft-Antispam-PRVS: <BN7PR07MB42256C377EF962B564A7EE3AC5490@BN7PR07MB4225.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXjfMOxVMDc6dADXM/2zaIbgOU2in0Oyg9i6ajMc4ZClzElAcUmoo7r3ioA0QggiqYlTToUhXvIc/KndDlyzxAci1/kDESfnlji3X9X3JlwLQEkmSwwz8u4bm3rrzZMrjV/kEuBd7hKg1cBPkFwWWjR9QEQbDIvsaH8z64lxn/oBtizst9ANv1reF5hA92ISvWB5UKHxe/QZczUZVih+ROAJ3pi0TLSk0tUlwG6PlfBKvU4pj9uFafT0u/9k9AbqBLTOO6WaT+rOiYOgBpavlxb8gG0P9P7kjzY76cNyNBxMVDIdroEdQDNvWkBbjZQGHg0DTBOlGJ/jkB7ZJLuSY73z9kbE4MT17+O5EkkG7G+LKWXgSriXG3vBlQLcaV3cyYr7bOFL3kP3CFZGKI7dtAKAOXqKP99dj6OXGtRHPUA=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(36092001)(46966005)(8936002)(54906003)(81166007)(316002)(36906005)(478600001)(2616005)(336012)(110136005)(2906002)(42186006)(4326008)(36756003)(83380400001)(70586007)(186003)(356005)(8676002)(82740400003)(70206006)(6666004)(26005)(47076004)(86362001)(5660300002)(82310400002)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 11:46:15.3893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3acea74-343c-45ee-bca4-08d83ac77db0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT030.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4225
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_08:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if cmn_ready is set after both PLL0 and PLL1 are locked.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 31 ++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index a703fcb355a8..8c6e1aa93b64 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -32,6 +32,7 @@
 #define NUM_PHY_TYPE		2
 
 #define POLL_TIMEOUT_US		5000
+#define PLL_LOCK_TIMEOUT	100000
 
 #define TORRENT_COMMON_CDB_OFFSET	0x0
 
@@ -183,12 +184,16 @@
 #define PHY_PLL_CFG			0x000EU
 
 /* PHY PMA common registers */
+#define PHY_PMA_CMN_CTRL1		0x0000U
 #define PHY_PMA_CMN_CTRL2		0x0001U
 #define PHY_PMA_PLL_RAW_CTRL		0x0003U
 
 static const struct reg_field phy_pll_cfg =
 				REG_FIELD(PHY_PLL_CFG, 0, 1);
 
+static const struct reg_field phy_pma_cmn_ctrl_1 =
+				REG_FIELD(PHY_PMA_CMN_CTRL1, 0, 0);
+
 static const struct reg_field phy_pma_cmn_ctrl_2 =
 				REG_FIELD(PHY_PMA_CMN_CTRL2, 0, 7);
 
@@ -237,6 +242,7 @@ struct cdns_torrent_phy {
 	struct regmap *regmap_rx_lane_cdb[MAX_NUM_LANES];
 	struct regmap *regmap_dptx_phy_reg;
 	struct regmap_field *phy_pll_cfg;
+	struct regmap_field *phy_pma_cmn_ctrl_1;
 	struct regmap_field *phy_pma_cmn_ctrl_2;
 	struct regmap_field *phy_pma_pll_raw_ctrl;
 	struct regmap_field *phy_reset_ctrl;
@@ -1570,6 +1576,7 @@ static int cdns_torrent_phy_on(struct phy *phy)
 {
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	u32 read_val;
 	int ret;
 
 	/* Take the PHY out of reset */
@@ -1578,7 +1585,21 @@ static int cdns_torrent_phy_on(struct phy *phy)
 		return ret;
 
 	/* Take the PHY lane group out of reset */
-	return reset_control_deassert(inst->lnk_rst);
+	reset_control_deassert(inst->lnk_rst);
+
+	/*
+	 * Wait for cmn_ready assertion
+	 * PHY_PMA_CMN_CTRL1[0] == 1
+	 */
+	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_1,
+					     read_val, read_val, 1000,
+					     PLL_LOCK_TIMEOUT);
+	if (ret) {
+		dev_err(cdns_phy->dev, "Timeout waiting for CMN ready\n");
+		return ret;
+	}
+
+	return 0;
 }
 
 static int cdns_torrent_phy_off(struct phy *phy)
@@ -1643,6 +1664,14 @@ static int cdns_torrent_regfield_init(struct cdns_torrent_phy *cdns_phy)
 	}
 	cdns_phy->phy_pll_cfg = field;
 
+	regmap = cdns_phy->regmap_phy_pma_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, phy_pma_cmn_ctrl_1);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_PMA_CMN_CTRL1 reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_pma_cmn_ctrl_1 = field;
+
 	regmap = cdns_phy->regmap_phy_pma_common_cdb;
 	field = devm_regmap_field_alloc(dev, regmap, phy_pma_cmn_ctrl_2);
 	if (IS_ERR(field)) {
-- 
2.26.1

