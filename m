Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE56C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55E52075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Cn4aMity";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="EnRutXpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgHGLqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:46:38 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:43536 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728332AbgHGLqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:46:32 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077BjYOp031923;
        Fri, 7 Aug 2020 04:46:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=cngABHYGC/rVNnZ2RYTsW9AiAFPgHsnr7RVs2BVa2Qw=;
 b=Cn4aMityvN3dI6sQfjMca4aa/46QXzsc1N8KmsWTTxAwTLLLQjqN1C7ci8FxI/rSLE/s
 P7yCGb4RYcjc1RlGPmizwPbX24IL+tmIIiJkPyA9XBRHUE3uqnjrS9mkREdYTiKCKhWu
 5GXQslQOCLbXY1Bigv2PkOGNlAmIO/mIEr2RW8sooLXU05m2GNAgOmRNEOO+zha9pDXy
 rZTKDd7aoIBBRgqKb5+EbpCI6Qg8ZendKRlYf9AjufcfBxeeRCxrBR6RILPgrfDndnQ8
 iNy3rWcdDnhVw8MzjXDLoPSai3/jOA4oUuIHqOcANLCzFwgbbwWBJdC8oBgQPJnO//Cm ng== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0b-0014ca01.pphosted.com with ESMTP id 32n8gy61cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 04:46:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REWpA0nj3big02KojvtFX/7Ipyfvo1TFwzBHJgb47rUyOCliojqby/0UymozMEOv+4ot9Rogt+MsmWmp2Kat6uLpGcjy4zQ+fBeYSAAqiaeSf5jfj8zxoop9izPu7LOg967jIerEckwPofThjiq/9ELpk5HYMw+XVxak5c62itEWK5CdL2zNZHhAwBnMdqhuNWlJWWiBDp2J+Zvo1bXDBlRwYoXsf0uLnkq42TCbEfr4p7O1JZBVt3h17tgKSbr6iUX+6ITlb5lzXO9Tqr5frE7MZFftrqOQvCOwAmgYMXETDhaTJS07XRHL5Lugy6bqHvHWZ2syg8cccYeCjYdnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cngABHYGC/rVNnZ2RYTsW9AiAFPgHsnr7RVs2BVa2Qw=;
 b=e/q7FjPprW3U8YmCw8VyuakxVeVqlzNVANmm7vO5NFXuMj7Q2rc76yjQWBhUt4LMoyv3T5CVLjyBN14ZhEQyke2QAbvIC+z+OfxYiOas48X+qFY3OZEhm7h/0ezIR3Ge5KYzVmOV8KbOZVSm98BENMjhw/EWhxU/XQC5HK19q76S37VKKmd3lI4wOlL783WjEIpytdfv+2fSu1LpHp8aV1xvxgkNRZTBHWb01bBfoWUi6ug+u6UEmlq5IyLmRGu5Bq4DRoDaS9PuknqSFa5PlK8hNZWKF7IiSNppx+Clyf71+QuvQymjPH3Z9gPiFK3GT1vjVVdtt28zkiN+Lt5XOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cngABHYGC/rVNnZ2RYTsW9AiAFPgHsnr7RVs2BVa2Qw=;
 b=EnRutXpoD+4v9R5/cqHkvp2bKfeOaBjNY1m0Aph4UllzbS2PKVR5QPd/lxI9xsLcNBOynuRkcNTvkA980vvxNr2U99OKFEgUIWQM4cXNJkIDBVQoF/QkWf3BGcc4iiVXDOgtJR08pOV0lNNXSoRC/FKIEK4w0n/apG9boY75tMU=
Received: from DM5PR19CA0019.namprd19.prod.outlook.com (2603:10b6:3:151::29)
 by BN7PR07MB4146.namprd07.prod.outlook.com (2603:10b6:406:ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17; Fri, 7 Aug
 2020 11:46:21 +0000
Received: from DM6NAM12FT045.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::f2) by DM5PR19CA0019.outlook.office365.com
 (2603:10b6:3:151::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend
 Transport; Fri, 7 Aug 2020 11:46:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT045.mail.protection.outlook.com (10.13.178.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 11:46:20 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9PC029785
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 07:46:19 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9dH000857;
        Fri, 7 Aug 2020 13:46:09 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077Bk96h000856;
        Fri, 7 Aug 2020 13:46:09 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 08/13] phy: cadence-torrent: Add PHY link configuration sequences for single link
Date:   Fri, 7 Aug 2020 13:46:02 +0200
Message-ID: <1596800767-784-9-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
References: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43f96ed7-b509-4033-08dd-08d83ac780e6
X-MS-TrafficTypeDiagnostic: BN7PR07MB4146:
X-Microsoft-Antispam-PRVS: <BN7PR07MB41465D05179CFC0469B7C37CC5490@BN7PR07MB4146.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EB3r2rBeSwlaCIZGzL5lHG283g2xkTtBFSOGJ3c+1wvw6bpsXdtXnvD9bhK1WO59yu/oiuSeTLCfoh7s7fQvw86F5ckNBf0mLq0c/VE5YDXEzuGu8WUIJR2jRyCjIZEfaS+el8BKcwnnaUY6Km86oQpXSxyH9S50kf7WpybqabasJeEwsXOFQSvfpP/RFcunvpi6Dy2wZp5EV67ETVzYh5MtUrmT9q0YUl+hqc9/DeuNqokAhcElqVWAIlh/CVlcrWFCDAQ5kDPzT4+3rBxfvqjc6zcwhMI3qicfU2nuAP23ujegoEIlWFcvhD0ffMg0Fho2gCvb38lZkZcXx6rltWMPqFVKzZr1f3IyzciHva4WkxQ8f9B8l7nw5msd3iR2H+yxRopI60xv76+yYhZ6AUg3dVNDwdTYe42TgPgUoPM=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(36092001)(46966005)(426003)(36756003)(81166007)(70206006)(36906005)(110136005)(8676002)(478600001)(336012)(54906003)(82740400003)(8936002)(4326008)(42186006)(316002)(70586007)(6666004)(26005)(82310400002)(2906002)(86362001)(186003)(356005)(2616005)(47076004)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 11:46:20.7727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f96ed7-b509-4033-08dd-08d83ac780e6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT045.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4146
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_08:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 phishscore=0 mlxlogscore=825 impostorscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008070085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to configure link_cmn_vals and xcvr_diag_vals in case of single
link PHY configuration.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 691d4aa5b2ed..d01a44b93e99 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1809,6 +1809,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	enum cdns_torrent_phy_type phy_type = inst->phy_type;
 	enum cdns_torrent_ssc_mode ssc = inst->ssc_mode;
@@ -1823,6 +1824,29 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	if (phy_type == TYPE_DP)
 		return cdns_torrent_dp_init(phy);
 
+	/* PHY configuration specific registers for single link */
+	link_cmn_vals = init_data->link_cmn_vals[phy_type][TYPE_NONE][ssc];
+	if (link_cmn_vals) {
+		reg_pairs = link_cmn_vals->reg_pairs;
+		num_regs = link_cmn_vals->num_regs;
+		regmap = cdns_phy->regmap_common_cdb;
+		for (i = 0; i < num_regs; i++)
+			regmap_write(regmap, reg_pairs[i].off,
+				     reg_pairs[i].val);
+	}
+
+	xcvr_diag_vals = init_data->xcvr_diag_vals[phy_type][TYPE_NONE][ssc];
+	if (xcvr_diag_vals) {
+		reg_pairs = xcvr_diag_vals->reg_pairs;
+		num_regs = xcvr_diag_vals->num_regs;
+		for (i = 0; i < inst->num_lanes; i++) {
+			regmap = cdns_phy->regmap_tx_lane_cdb[i + inst->mlane];
+			for (j = 0; j < num_regs; j++)
+				regmap_write(regmap, reg_pairs[j].off,
+					     reg_pairs[j].val);
+		}
+	}
+
 	/* PMA common registers configurations */
 	cmn_vals = init_data->cmn_vals[phy_type][TYPE_NONE][ssc];
 	if (cmn_vals) {
@@ -2646,6 +2670,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 	.reg_offset_shift = 0x2,
 	.link_cmn_vals = {
 		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 			[TYPE_SGMII] = {
 				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
@@ -2674,6 +2703,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 	},
 	.xcvr_diag_vals = {
 		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 			[TYPE_SGMII] = {
 				[NO_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
@@ -2806,6 +2840,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 	.reg_offset_shift = 0x1,
 	.link_cmn_vals = {
 		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 			[TYPE_SGMII] = {
 				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
@@ -2834,6 +2873,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 	},
 	.xcvr_diag_vals = {
 		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 			[TYPE_SGMII] = {
 				[NO_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-- 
2.26.1

