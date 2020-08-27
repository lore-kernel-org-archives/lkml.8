Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD83C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF9C2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Rs2triR3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="sHBw6iuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgH0QRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:17:14 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:26566 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726246AbgH0QRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:17:11 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RGC6Yi005478;
        Thu, 27 Aug 2020 09:17:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=kmToReBptvqN+vQXEs4CuUGAhf8irZeDS2uVLN8DfgM=;
 b=Rs2triR34orS7Nthb6pIwaRaJbGVIqGYQIDPtu8XCI+U7TGetrtr0P7z0L1iDYSaeDvp
 wejk1qSKtGqRsxjDBIr/2tWEsvf+acqPPGGQNyNeJJYpymUcRw0NpEclrTEZFy6Tjl/t
 TfiOp+esBgmCEAxBiAA1bQQ5eLPvarczi9BYhieRVUsRdIYwle3OFK9Ia4h75pc6TbzY
 hhrWr/DQRF07NYKCPZhL5jElTXJcdnLqJRV3UHfpiPSU2bHtljqh4e4yn3pWh0vHjKXT
 XvxxeTkhogoskU6+k8rkDbzJTzGaepGnpu+Gkko3HpPzECoz25FzzvQSoTH0AIf1tWOB SQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332yww4tqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:17:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eil574eNCosdMHjr50KaizNWL89AkrO8fUrPXQt0A4HDLNJ0Mly/tWMnGx3tBDXk04rIJIlvv11IGCZE3FL51nJPquJUaHqR0+DjZwb4nyesVhI1Yqds0hWI5Ntp6PsO9mjvA3HJno9bXQd/qyrTY5IYcP98dVflmbl2ww4M2PnDbtjefMeXsUzJSV8jP3B/1bqDlJEas4a9FT5DWOaYSs1gtYdRj+nmrxoRIEdOpgi0qAySiZN6A0thPN+pRnPkSLSB6hM0pbe3gZN8l9TeDyYgR+c2t7zgVQWggYm0aNXJjo0waAhiA8HdySYuQgtZjdhRKwFmxi8wR4cBnIvBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmToReBptvqN+vQXEs4CuUGAhf8irZeDS2uVLN8DfgM=;
 b=eDlHJePw42r6/xIXtzImeQKmnG66zaIYy6cdoK1q419NKKqeTEToLOTspvXWonoudQUC991N816kADRGqcaYeERocWvMaoGpNeDmgemRX6A8/cNL8e1WD0+e+yTwwe+kl8t08GmKtC/KYMef+I/rkwbX8+HvO2D1kwghUU+eEOxgUrdITabknjL0hLBHO8ZHqsglpflYbfeVSdoz4T6rrnPe7Qkd65Wk7O7H6BGiKLM+Fabt4R/UybW59CtX8XQbVYaiMgLwNfJA55XrksS9eFgRfDe//8AG/GEmDdKAO3Hm9/yd3MYnBOLPQ34aNUEN3tdL+5ve3PN268zALq/HLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmToReBptvqN+vQXEs4CuUGAhf8irZeDS2uVLN8DfgM=;
 b=sHBw6iuJeiLehT3pwL3lF2iHQxt9H+zwnNSg6R6ppAXvT9vlkCNdJcRHCYN2NCj2JoZhsRVTbcsMp6NzldhgA/rrhwErhUmjf7Y3t0wef0P1yG1OKZwgZ11kz1l+p4Vb7AMBjt4z3uqR1InwOUd48TpJMF5cGD8hn7iq4tGbC80=
Received: from BN3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:400::25) by
 DM5PR0701MB3783.namprd07.prod.outlook.com (2603:10b6:4:7d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Thu, 27 Aug 2020 16:17:01 +0000
Received: from BN8NAM12FT022.eop-nam12.prod.protection.outlook.com
 (2603:10b6:400:0:cafe::bf) by BN3PR05CA0015.outlook.office365.com
 (2603:10b6:400::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Thu, 27 Aug 2020 16:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT022.mail.protection.outlook.com (10.13.183.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 16:17:01 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGquI016160
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 12:16:57 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 18:16:52 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 18:16:52 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGqJS031827;
        Thu, 27 Aug 2020 18:16:52 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RGGqPN031826;
        Thu, 27 Aug 2020 18:16:52 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 03/13] phy: cadence-torrent: Add PHY APB reset support
Date:   Thu, 27 Aug 2020 18:16:41 +0200
Message-ID: <1598545011-31772-4-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
References: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4af7918-038a-4977-fc0b-08d84aa4a128
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3783:
X-Microsoft-Antispam-PRVS: <DM5PR0701MB378386923FEC2E7B59BA2D70C5550@DM5PR0701MB3783.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FzmPSFiLbqwiHgAc5LosX6z/qcXZf3oGGmYfNs5t3zF57nckrzbiPbe4/FSgm14LMqBIaDpOIS2iRdYLGpcCbieIp1QRGNyyxVoSgLEFDIxTjvV7peKnw473YhpHFB/ULEB0WBBjhJ9hF6wZhv35ri5SE2o0E7xkiWv9/p91xQPpwycX8wLQ0caAvBoLZlx551V3o7TeVeNRBRn7g44r6ZFdJ1J/8waXb0H4IHfeZ2woNKUDGXkhcxTfGTLRRkI3D0EKWHogH3KEog4KqZpO9NdoXZdcGrkY5Gk2AVt4hXG3NAxzCx9LfzPQVobMypow147ruuDO6pikwjWhEHBVduMJOfPK+LE2x9dcE7ggus7aLdN7iCy5kwgvejQlaTXqScK0xI1moM7UUYhUHW8UVKLsQO8HqUhoBcVzBNFe2k8=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(36092001)(46966005)(8676002)(47076004)(478600001)(8936002)(2616005)(2906002)(70586007)(5660300002)(6666004)(70206006)(86362001)(82740400003)(83380400001)(110136005)(26005)(186003)(54906003)(42186006)(4326008)(336012)(36756003)(426003)(316002)(82310400002)(356005)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:17:01.1575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4af7918-038a-4977-fc0b-08d84aa4a128
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT022.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3783
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_08:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=942 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PHY APB reset and make it optional.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index af307af2f221..3038b50c7b12 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -228,6 +228,7 @@ struct cdns_torrent_phy {
 	void __iomem *sd_base; /* SD0801 registers base */
 	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
 	struct reset_control *phy_rst;
+	struct reset_control *apb_rst;
 	struct device *dev;
 	struct clk *clk;
 	unsigned long ref_clk_rate;
@@ -1884,6 +1885,13 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(cdns_phy->phy_rst);
 	}
 
+	cdns_phy->apb_rst = devm_reset_control_get_optional(dev, "torrent_apb");
+	if (IS_ERR(cdns_phy->apb_rst)) {
+		dev_err(dev, "%s: failed to get apb reset\n",
+			dev->of_node->full_name);
+		return PTR_ERR(cdns_phy->apb_rst);
+	}
+
 	cdns_phy->clk = devm_clk_get(dev, "refclk");
 	if (IS_ERR(cdns_phy->clk)) {
 		dev_err(dev, "phy ref clock not found\n");
@@ -1908,6 +1916,9 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Enable APB */
+	reset_control_deassert(cdns_phy->apb_rst);
+
 	for_each_available_child_of_node(dev->of_node, child) {
 		struct phy *gphy;
 
@@ -2062,6 +2073,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	for (i = 0; i < node; i++)
 		reset_control_put(cdns_phy->phys[i].lnk_rst);
 	of_node_put(child);
+	reset_control_assert(cdns_phy->apb_rst);
 	return ret;
 }
 
@@ -2071,6 +2083,7 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	int i;
 
 	reset_control_assert(cdns_phy->phy_rst);
+	reset_control_assert(cdns_phy->apb_rst);
 	for (i = 0; i < cdns_phy->nsubnodes; i++) {
 		reset_control_assert(cdns_phy->phys[i].lnk_rst);
 		reset_control_put(cdns_phy->phys[i].lnk_rst);
-- 
2.26.1

