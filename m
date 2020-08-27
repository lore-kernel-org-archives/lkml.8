Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE757C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F97C22B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="kUQ3ihZr";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="GBcfbw+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgH0OvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:51:07 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:5846 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728089AbgH0N3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:29:12 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RDSBPH004858;
        Thu, 27 Aug 2020 06:29:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=sUfAFaQ91xEwa/9obC3b/GtBipGtqjQo+T11D+eD0l0=;
 b=kUQ3ihZr3WCG0nd/r1RcCVS0+ij6AM3ADtUPT8QgkMFbDyu3KLv3noxganj+pLJYWoNb
 kznTYTKBzvU1dUwBh+f1XXp9XcuPt0P9cgE0A05EEJrqylilGKscSk1/w35d0bgkEaUU
 G1n8t/eAMjlKSxv42nqCIEShZVpA9yEQrTPxV4BQILMCkUyiq6XXfXgzX2q9FiYCgvbk
 Ax8J9kt78Arl/3OBgtgc1fYDQ0T+GKzAYdDp5D/rRPIyaj6ND9HhEEXQ3i0wCx8ODWxl
 v0b9NPh1dEWXFZudAFmLnBXCre0RgglRV3MZLG8So2sbLkfX3UFP0ZCSECQwYJ+KwQaW fw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332yww45dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 06:29:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FP/PFe7Sb9C7Cw24Gu2n+3TdDGvO8BLcVlcLZavTwPphWM85EZ5lUEq+e/cntuQxx27rEBCa4Q/pqtxscP1yto0uwmRHAb9WVhBKgwwyQOcdeW+KiLgTTZP0KSCIhSkxI59LVy6sZ7H8+qn91Hsv9Kj7o4gxkqV8+a5LqQEaUVnEtYy7H8QiAUhuu1dkkdK2FVXUGP+4rERyVbJS8+nba1YaoKkL4j/68bdB5ZOe2RyEgO5kknlN/r84OeZxhUnpP6oECBTGiAxKBwVGeKJNZWHdQREfwxzk13o9F6n4zgfzu33LzJWhKKDf1ll1D+bdmr9O5ytcffVILNo0Xeh59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUfAFaQ91xEwa/9obC3b/GtBipGtqjQo+T11D+eD0l0=;
 b=SfZWusht8jBrCGzJyaz8X13YPUzPyIbxwwKk0lMroAQ0F2ufIYQF+vYVIsIXE5E6djGYLN5+RGUoth2bIOlLFhifIWg5lgtmEFXyVb7QJLJfHvHZ4MESnqRi/TNYKhj6k1S//txJvhX/7F8ttHk0S72VjmwfmI+WoWBBN56LFql0I0ji0HK6sT744eQzfzW8/tzGP9UVXLEw+o2RVWiyQtKZQv2f/B/rffyra4Nf4p/xi/q4Cu+lQqrGyl6kZMmbd+C847AZKyEG7Tf8d9KBibSNzRoNy4Cvzump+e+0STSSS/LqeSOpSFv7GOOaUz/zRGofpkwqGWDjPwkvAIhjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUfAFaQ91xEwa/9obC3b/GtBipGtqjQo+T11D+eD0l0=;
 b=GBcfbw+cq9uvn8vISUUbbifrI0FQn7VS9lVGo0i0A/w7wdB9QO6JFOJSMnz8TYMT5WqUqTsK5RXocu6eJjoPG9cQFKwdj1SkEchGUhIqdTE7kpPdWBdQjFtPPrybLW8Jdmc05sa4xtoavCVk1j1tKcfBawELN0CtjgBv/QGr8ig=
Received: from BN8PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:94::32)
 by BYAPR07MB4536.namprd07.prod.outlook.com (2603:10b6:a02:c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 13:29:02 +0000
Received: from BN8NAM12FT059.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::d3) by BN8PR03CA0019.outlook.office365.com
 (2603:10b6:408:94::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 13:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT059.mail.protection.outlook.com (10.13.183.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 13:29:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSrRj001550
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 09:28:59 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSrdA018750;
        Thu, 27 Aug 2020 15:28:53 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RDSrYk018749;
        Thu, 27 Aug 2020 15:28:53 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 3/7] phy: cadence-torrent: Enable support for multiple subnodes
Date:   Thu, 27 Aug 2020 15:28:48 +0200
Message-ID: <1598534932-18693-4-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
References: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2daeb98b-3ffa-4fc6-6cb0-08d84a8d28d1
X-MS-TrafficTypeDiagnostic: BYAPR07MB4536:
X-Microsoft-Antispam-PRVS: <BYAPR07MB45366C8BC73A7522423D397FC5550@BYAPR07MB4536.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:131;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPoU+156xpC9X5XatjPNzb/GUWxxC8Qgt4889pJFoePAqulvI8ifawcXI3bcHcAyMXoADwrsEnWEr+OxDOMOK10wUUw7O3NzHpko4QiGHYdGRRFOaJgMBzIldpQTPr6eBP8RAh8IEzRDw7kHdE7rMe5MFEoX1W1uYcIcXFFChLrzfEdSq5BmG9YTJwE+6L8qx6naO2IboF2DcR/eNOm2bj1tFa3fCntygHdoY3MCnaOANrsjv99MeznPefPwsHtmpyLpO7TVvvprkNFAkpULz3EUly4E0bSEV5EjPweZTJMrE2k/tIq0hVg8O6ptuyIKGwAS6/miTKS6G4h/WTChVCEhmjyFjhV0AazyAZp2jqIZuzkZn/VVOM2ITi10BtzxvkcHVX9Cq8RA4TgA8Z4ZZ1ZWMeO/PtenF/6ol42Kdmg=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(36092001)(46966005)(42186006)(316002)(70206006)(336012)(70586007)(82740400003)(2906002)(36756003)(8676002)(86362001)(4326008)(83380400001)(8936002)(426003)(81166007)(110136005)(54906003)(82310400002)(5660300002)(6666004)(47076004)(186003)(26005)(2616005)(478600001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 13:29:00.8312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2daeb98b-3ffa-4fc6-6cb0-08d84a8d28d1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT059.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4536
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=843 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for multiple subnodes in torrent PHY to
include multi-link combinations.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 566edf0e7937..ee633c8bf2d8 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1747,9 +1747,6 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (subnodes == 0) {
 		dev_err(dev, "No available link subnodes found\n");
 		return -EINVAL;
-	} else if (subnodes != 1) {
-		dev_err(dev, "Driver supports only one link subnode.\n");
-		return -EINVAL;
 	}
 
 	for_each_available_child_of_node(dev->of_node, child) {
@@ -1772,14 +1769,6 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 			goto put_child;
 		}
 
-		if (cdns_phy->phys[node].mlane != 0) {
-			dev_err(dev,
-				"%s: Driver supports only lane-0 as master lane.\n",
-				child->full_name);
-			ret = -EINVAL;
-			goto put_child;
-		}
-
 		if (of_property_read_u32(child, "cdns,phy-type",
 					 &cdns_phy->phys[node].phy_type)) {
 			dev_err(dev, "%s: No \"cdns,phy-type\"-property.\n",
@@ -1852,10 +1841,6 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 			torrent_attr.mode = PHY_MODE_DP;
 
 			phy_set_attrs(gphy, &torrent_attr);
-		} else {
-			dev_err(dev, "Driver supports only PHY_TYPE_DP\n");
-			ret = -ENOTSUPP;
-			goto put_child;
 		}
 		cdns_phy->phys[node].phy = gphy;
 		phy_set_drvdata(gphy, &cdns_phy->phys[node]);
-- 
2.26.1

