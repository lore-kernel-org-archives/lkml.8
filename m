Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB8DC433E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71283221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ElHV4O4v";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="jkbgyKjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgHGKM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:12:59 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:43676 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727821AbgHGKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:12:58 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0779vUW4023777;
        Fri, 7 Aug 2020 03:12:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=jsmbDPWBto+CCOwhvKkBeBi3MR0cIjoVP46NlkkHRxk=;
 b=ElHV4O4vRXimi4+qn2IZAOt9/PxIGB/ZPNCBvIIvGar5dh0y0dTTWlIahJuZjrGSd+KG
 9gZTKtVfMfec6+cW4J9OfMwMnOOCQKuXVGyFS9UlCLBSokZIOWTRH6pZk0D4D3RX8Sv+
 DpYYf/0adfi2aqpI7JJJrsrFIztqtfOSX8dw9L8yMEuWp2Rz6KIP8tvb6ARP0cMxPL/9
 x2MgTp8DtWh4QM8J/TIweNrPMBwQCiA8c/vUbhWTRlynq+sNBad7ifgHoBfuYYdptTxd
 3LxmsW3s0OtOR3gGwCxE4OjOF6SyAeyOz9UjyKUXvmP+kbGrd5LBy5Y8u7vPfScTR8XT gQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0m4rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 03:12:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmmLupPGY1K0dYVEhgtgXlEORI2dxkVxzPSR2QGVf51hFO1YOZTBT9wDnxhYrGvVMNo8RgrjATTrtwky85oh9dTvrOgWp/89ZVoPAhr8QyrAyXD513vWgEzPRUSflPs8ZiZt2OH1WJDpy788k6anrQUfAWiOv56GR1GNbOq/d7pjXjeWtVfLHZ4Pg7TBAR6pDFIAkufkbj8uL4RGEkX0JXfX95TjjLhd8jvJIrHSiURxSk5vqE7mNuo5Y6yOzdDKiBw5nQoNAPMXLxkyp0Md4Iwsg19KyRKUWG0LlKUFlrKjwMo3PIGPu4UICydvf6xXiDdPnqEExBCLOPOAisIynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsmbDPWBto+CCOwhvKkBeBi3MR0cIjoVP46NlkkHRxk=;
 b=SMq99qX4Kdu/u6xSXxkE0tibSveVFFBp21rTRDc5IFIow1V0BecnseRHv8ZFmwG/SobyI7RWuZpCWSOlVptLedV88ufPD26Xaoxlx/vcHziRokiQ8KQbJKMjQgQf1AgrktdBIW/OtLZIIrfcFIL4WLFWiOcSf3NpT8FvCl9h2n9cM0oV2xfqV6JwMqJJOWKmyVNGQAaXwYbjZCYumymG+zTyQp0qC43uBFn6KxIb3WFVjqetZfUqPztrO8EzVqUlO1YJrERS/+i2/qrdlf9+qR286ZwS9g7m+DE2qtMrye3Z42CIbieWucr5db5aIsfe2zCcuHB1mA2/g+z5ssSc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsmbDPWBto+CCOwhvKkBeBi3MR0cIjoVP46NlkkHRxk=;
 b=jkbgyKjqqKzqX1iNmf+wPtbUqT82J/JNDa+aozTfEOQj0JnJWK1ap2wmY5HLWaNbewYYNER0gooNIY8YEa3JBXAMilr7yrlDPtQ1Sp21uIrrMX+deQWM34T0dwj1cOTTly+cKdheM+oKKKJ4TcJugLUhYFCsA+j3GQ0dm4KFxIM=
Received: from MWHPR1401CA0007.namprd14.prod.outlook.com
 (2603:10b6:301:4b::17) by MWHPR07MB3055.namprd07.prod.outlook.com
 (2603:10b6:300:e5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Fri, 7 Aug
 2020 10:12:51 +0000
Received: from MW2NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::2) by MWHPR1401CA0007.outlook.office365.com
 (2603:10b6:301:4b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Fri, 7 Aug 2020 10:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT050.mail.protection.outlook.com (10.13.180.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 10:12:51 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACk5b021638
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 06:12:49 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACkhQ013383;
        Fri, 7 Aug 2020 12:12:46 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077ACkqS013382;
        Fri, 7 Aug 2020 12:12:46 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 1/7] phy: cadence-torrent: Use of_device_get_match_data() to get driver data
Date:   Fri, 7 Aug 2020 12:12:39 +0200
Message-ID: <1596795165-13341-2-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
References: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea6d639a-7253-4f1f-30c9-08d83aba7181
X-MS-TrafficTypeDiagnostic: MWHPR07MB3055:
X-Microsoft-Antispam-PRVS: <MWHPR07MB305554D91084A8C561B8D756C5490@MWHPR07MB3055.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cESMhkykGDJs5KMenRShqQbB0h8XYctxQEA2jndb+3LJ6KawQQ/HVLPUw1wNLuuxtBhbl5E0rOFk84VC2f8k+XhOfCZFAGNVPFyGi+INqQocloq1IZLB+3kI389jZWNsLi+Qugx0E2mzbBUmBmAVaBPfX4FPqXykVt5Txb3OPnA3R3nwfnfFK09i8s4pXE6T0pAtBiXDZMyBHT2iqBp3WCX1dBomimaShzBl5MMfRnD1jFGIUclUvzC0S0/EvOsTG7PW1ftHTLwtz6cUCwnRLBGqPwsYu7AzBye3jOvrej4C+HaqyE12VX32JKkNfVg9s/QP6RgkCnlcOIQANBfOJXHARm20G3KVelt2gjdJRndJC2ViR5fTLF68aiINpQfWWBFF6TqV2M1fnZp2cgTCOxJihWNqm+A7f0+0QSipkG0=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(36092001)(46966005)(8936002)(8676002)(186003)(82310400002)(83380400001)(70586007)(26005)(2616005)(70206006)(356005)(6666004)(336012)(426003)(42186006)(81166007)(110136005)(54906003)(316002)(36906005)(478600001)(82740400003)(2906002)(4326008)(5660300002)(47076004)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 10:12:51.4016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6d639a-7253-4f1f-30c9-08d83aba7181
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3055
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

Use of_device_get_match_data() to get driver data instead of boilerplate
code.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index af81707ff0c6..50c30d49300e 100644
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

