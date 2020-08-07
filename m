Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBF5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475ED221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="l/K5EExe";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="P//hoxjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgHGKNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:13:04 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:54638 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726511AbgHGKNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:13:01 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0779vTKI023765;
        Fri, 7 Aug 2020 03:12:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Q/P6SqKfkFAtz99jDu1P49AeqmZwBhbS48U6v/qf4gA=;
 b=l/K5EExevYNxACYogKLYclTSGxhMCL5OkRQV4jW1tFBtiR9k0ZaM560bseoWUZcX0rep
 dlaSM0uB9Bz0WcHpX9u7+bL7rF49SL2JwU7ccSKRajlRwa4zN1h4cFEPYj5S9ektcm7y
 xkDnf95ElYZ6CRwoza0/mtfRXvkMBU/0ZYR7WL16z2jcyFVAvykymN5o6exBkjgwEzj9
 RxYq9M+935mMz/RM0wVvf3OkOp8rAVRiM4XaXz2G6SVpM/6RPY3tcqViGhLH9v3Bi1We
 jPKw5LtoySaq/yDwTMIyitOHEgpjDye6y0QNboQQf6rNkF8E2uEXjDPU3yrG/k6a4nsu 1A== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0m4rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 03:12:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRqiF19HZxxLLy6JdR3yChjmheR2gQOz4wafrxGq6Ll3fQCA2XJzOgSwmUGq3kzGCtUukAzx4os7A3XvS7EUJTap98voySrMKB32exOan2k0XG+XmM+mAV01CjVgm4Ecn33Kkys1RPXTmtVxw6gJl5cvvUey9/aFdr76UXA9gaJM2kojsvVZesw+DG+3cyROtRTCw2AZUAEJYuuXiTI5B7uYaygvifIqZ0H3+btsNHpwU74Fhdvu13W4HeqEr6M6psmY12O+F3nmf7Cr7YzgDoKi1JJQjm9qXI8MYddXE2+wwvgl5+DB6yvxl34PNkYw2c+EFa3G4TE7AL9MhqKs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/P6SqKfkFAtz99jDu1P49AeqmZwBhbS48U6v/qf4gA=;
 b=Npje39dK6Enp8i48uBjw91fu3LNuJcPinBCt24iT+5rWTXPhAQ8fco1neAt81uH7uuD2Oqinjrf/7kuwFrdNlQMBAVTpODBpCizT5bvWi3UmCxTysHA2kBabxNTTks7zUJM5SEyTx2zXaxCYV3pjXsPMcz0nK+n/g44kBhRLKFmk5SjkYTSIVlmiSiBzKb2aTlrefUCVfaSvPGbEcI3bUYTdQafUuO9t2+BGDbN5lch8RIyPsFlJIS+BErDKwpp0tSV6mb49iGcWO/U+TfWkfg6NmWG9Ag6l8dp/2Eag9elxbj6bWxv/MrTy4nPP3l4GL7cTbvuNRQPLa0g2KcMTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/P6SqKfkFAtz99jDu1P49AeqmZwBhbS48U6v/qf4gA=;
 b=P//hoxjkNw5SEck8AcfVutcvo8lTZggQh2iI+a2c31l1B4XNVcxof9hq1Bm0GH1dXRrTFJ4nJBpDABZgukEGDsRDRpT2Kgl7FO5U3FFwYmodiyB3p9gZ8KcdYH8i/avolqKC/pvUt25e6qS0uNZ5/ce7GmvyJnc/j1QQz7KAzcM=
Received: from MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30) by
 BN8PR07MB6866.namprd07.prod.outlook.com (2603:10b6:408:da::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Fri, 7 Aug 2020 10:12:55 +0000
Received: from MW2NAM12FT038.eop-nam12.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::30) by MW2PR16CA0017.outlook.office365.com
 (2603:10b6:907::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20 via Frontend
 Transport; Fri, 7 Aug 2020 10:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT038.mail.protection.outlook.com (10.13.180.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 10:12:54 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACk5e021638
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 06:12:52 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACkbp013399;
        Fri, 7 Aug 2020 12:12:46 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077ACkYL013398;
        Fri, 7 Aug 2020 12:12:46 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 5/7] phy: cadence-torrent: Check total lane count for all subnodes is within limit
Date:   Fri, 7 Aug 2020 12:12:43 +0200
Message-ID: <1596795165-13341-6-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
References: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7061fca2-0e53-40f2-51cf-08d83aba7348
X-MS-TrafficTypeDiagnostic: BN8PR07MB6866:
X-Microsoft-Antispam-PRVS: <BN8PR07MB686600CD9127F1A5A8CE4FF7C5490@BN8PR07MB6866.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HltqO16ytfLeUR/dUvL74s3QC9JIizWRttt6QcySepqUOJST6dfgFRD5w2KqYoX43f8jDRUi1Zw7UMbU63vSTSz3xosC2KMmGMkuGFM0Mk0uVGhdmLWc2ZqAmO8THr435vm9EVAXVpgp04olXz3/rC1UVZKr0EtbWT1jGC8Ddd9wH0dh0XlK0qKgkRzuq0LKvly8LebMafr2/bxXSuLJDCadL6+KbSkYocK03oJ4bYVSbd19v3KS+QEptLrUMQjLOHAFC4mgbz4N54Pq3yAtpUByG82nBnn1iXQ6l4ECzKbzYAkaxf2mE/t5NnEp5TQeryckeH0fsB994wUp2/EtmhYgoPbD/myGEwcqNOcvbhXScYRArb5pFhR90W+kMYFd6QmADgCFL1aI6alUAwTgJEN6+Se6AXq3wwiWmUBvHU=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36092001)(46966005)(54906003)(6666004)(70586007)(8936002)(36906005)(426003)(70206006)(110136005)(316002)(2906002)(4326008)(82740400003)(42186006)(47076004)(81166007)(356005)(5660300002)(336012)(82310400002)(86362001)(2616005)(186003)(26005)(8676002)(36756003)(83380400001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 10:12:54.3763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7061fca2-0e53-40f2-51cf-08d83aba7348
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT038.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6866
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_06:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070075
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
index aff85e55348f..82f48ca5dcc6 100644
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

