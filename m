Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6718C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA222054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="mm8NZOVF";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="5yF2KCfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgH0OvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:51:11 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:23620 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728082AbgH0N3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:29:12 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RDS8g4004810;
        Thu, 27 Aug 2020 06:29:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=zLUc7hpKTbLbKpK1Gxo94gO3or5Ig0nrsRE7JZNwq0Y=;
 b=mm8NZOVF1RP0Xgohdnb8+58GHVfT5jWxS/6AOmzhCWr/1/IMRzjjORhbl4Qxgob1D8AK
 GtJxoIacMCBQi3uOaWByueJZPYgiryAjclUjgPtHLQp/rVJNTRc6eyK4YMbrnwmT2Hz5
 2GJJfF44P4jVrwlAC8uAHg5tX04ddVV62xdTbj28PXW5IyJFInu/iHw9icXG3bkRMLei
 31fvrzp+vBWAcZWR8vu/lpsaSVNEgVE+jrS1rIR9HgurwkQRXIAUwUvMUnhKsprvd4ZF
 g9BSpixpLKO9WcA0QNbShehBkawP8Np9zrik6624SUSPZKLnP063idBNqpqzW4hTb0jS BA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332yww45dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 06:29:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA7PYK2jzPay3ONoTHyNYIkc1wyPThShr+h5abjiL56KG0OHzgbN6nYm94yxHVuvjrEk9DjFlAXlytdAKhg+4tQ0N2l3rRFw7RGCNUfqJzyAN6c6mIRyKL+J+f7pMNEzfo1QERIeOny0KVtuStWJ26H5r+oztaoSAmHzQEc1333PdaOfnMlwSsrh1GGpTWboi54XhSxRdXHXZ3eZ3v4ktIaOl85/5QpDx8Kqx7fEwyAKQeptJjBnlJ6UXcYwahc0drLdZzMuP7kcg8+3avhw3qcONbpHYld8YWXFWeoB4xaI4G6A4FF7kZn509BV8yXwUM9egcf2q+0+pfnalKosKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLUc7hpKTbLbKpK1Gxo94gO3or5Ig0nrsRE7JZNwq0Y=;
 b=K4UrPGpdEUDyv7FXbLxkRx2/hAqFAhWPNV6FaJsvVMniAL52TZxXFokvSWbVTBQn1OBK1Pf2mBq28ipcpymhVavbXHiqo3AAeCH8ssOigUuBm+cVD7tHgC0U2M/IiL6bHoBf5YDP1p451TcUv7hiB7U6SWTQ8INSFu4D73KNAmIR5BVZhtmV+RPd10aV7czdfn8xj4BQBzt9hTRWqjKwAfnBgvBC4lnYS+0WSAwshQS9A59nJlCVCJNnkO6lOtTHRO6+C+dQHD0FsqJWwSRh82iIDCb7I3k8WgOocGFA9N59MzIi0eaA6E7QDdLYfaeduH60pCSBP19Ez14ex9Avag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLUc7hpKTbLbKpK1Gxo94gO3or5Ig0nrsRE7JZNwq0Y=;
 b=5yF2KCfgXpO5vfhDMxNs4ib6aCpc4gIUt7Zh0rkaJ5xZGvwlUAbXarRfTgtW4PUaWt13kgeq2tnMzYrsWByhIz1VEeeIhsbmpNfwjHPIC/k9+OF2133/RFOuwTDUyg5xHlmrTRvUNKu2Djq9g9aDeR/KdJdXwHyL0K5O5SwJpkw=
Received: from DM5PR06CA0039.namprd06.prod.outlook.com (2603:10b6:3:5d::25) by
 BYAPR07MB4664.namprd07.prod.outlook.com (2603:10b6:a02:f0::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Thu, 27 Aug 2020 13:28:58 +0000
Received: from DM6NAM12FT046.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::63) by DM5PR06CA0039.outlook.office365.com
 (2603:10b6:3:5d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 13:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT046.mail.protection.outlook.com (10.13.178.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 13:28:58 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSrRg001550
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 09:28:56 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSr3W018742;
        Thu, 27 Aug 2020 15:28:53 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RDSrGH018741;
        Thu, 27 Aug 2020 15:28:53 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 1/7] phy: cadence-torrent: Use of_device_get_match_data() to get driver data
Date:   Thu, 27 Aug 2020 15:28:46 +0200
Message-ID: <1598534932-18693-2-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
References: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bdb1d9f-f4b7-4db8-f025-08d84a8d2728
X-MS-TrafficTypeDiagnostic: BYAPR07MB4664:
X-Microsoft-Antispam-PRVS: <BYAPR07MB4664209E52A9A34C40BEBF4CC5550@BYAPR07MB4664.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZrttBHu7eHyofK1ft9r8rdspDQuE/3Y0tYKNNS8igpIgpkAn68gy1+JVdWJ8I5wZx3MrcrahhkE9Cq4b8uWf3pww9D/QVVskpUKb99d9rapPykGKYeLVUqrMfWQTrp4M1v379L3XWqRiEHLdQwEoe8rtSpk5vhH8V8350/h02DUYeFO5F80DtPcdR9yziAdcKKudy4AAL65+ktpg7KCEN9SCpQQVcGeZ0MwZJ5W2Rvv7TjxTrtPMU9W4CkXHOs0jiZtHKM4XuXW2hhk6qqQndpAtvT5e1esmNr+ySaNOE+yF2uQt+Df2sPlOsXllcU5DPhk+5PEQmxG0mNPF9OEbhhip9RPf6k8iAftHEvkCGlPHCwRjF6Dx1OHvI+3CcvN6Ua1MZnvtBN+q1SEqcJj6YzkmY+wNJ/wQxGf44R70gWE=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(36092001)(46966005)(81166007)(4326008)(316002)(8676002)(82310400002)(36756003)(36906005)(70206006)(8936002)(478600001)(47076004)(356005)(54906003)(70586007)(5660300002)(26005)(336012)(426003)(2616005)(82740400003)(186003)(6666004)(2906002)(110136005)(83380400001)(86362001)(42186006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 13:28:58.0054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdb1d9f-f4b7-4db8-f025-08d84a8d2728
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT046.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4664
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to get driver data instead of boilerplate
code.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index eca71467c4a8..98f644ae0a07 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -183,8 +183,6 @@ static const struct reg_field phy_pma_pll_raw_ctrl =
 static const struct reg_field phy_reset_ctrl =
 				REG_FIELD(PHY_RESET, 8, 8);
 
-static const struct of_device_id cdns_torrent_phy_of_match[];
-
 struct cdns_torrent_inst {
 	struct phy *phy;
 	u32 mlane;
@@ -203,6 +201,7 @@ struct cdns_torrent_phy {
 	unsigned long ref_clk_rate;
 	struct cdns_torrent_inst phys[MAX_NUM_LANES];
 	int nsubnodes;
+	const struct cdns_torrent_data *init_data;
 	struct regmap *regmap;
 	struct regmap *regmap_common_cdb;
 	struct regmap *regmap_phy_pcs_common_cdb;
@@ -1711,24 +1710,22 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
 	struct phy_attrs torrent_attr;
-	const struct of_device_id *match;
-	struct cdns_torrent_data *data;
+	const struct cdns_torrent_data *data;
 	struct device_node *child;
 	int ret, subnodes, node = 0, i;
 
 	/* Get init data for this PHY */
-	match = of_match_device(cdns_torrent_phy_of_match, dev);
-	if (!match)
+	data = of_device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct cdns_torrent_data *)match->data;
-
 	cdns_phy = devm_kzalloc(dev, sizeof(*cdns_phy), GFP_KERNEL);
 	if (!cdns_phy)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, cdns_phy);
 	cdns_phy->dev = dev;
+	cdns_phy->init_data = data;
 
 	cdns_phy->phy_rst = devm_reset_control_get_exclusive_by_index(dev, 0);
 	if (IS_ERR(cdns_phy->phy_rst)) {
-- 
2.26.1

