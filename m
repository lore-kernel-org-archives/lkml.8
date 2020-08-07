Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58CFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF04122CAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gCEtimSc";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="q2Cu7TaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgHGKNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:13:06 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:48548 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727879AbgHGKM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:12:59 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0779xWWK017258;
        Fri, 7 Aug 2020 03:12:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=OCWjvyQ5qsVtRLR9Up9JDGbYCKLb4E3lVdJvKZlnFBI=;
 b=gCEtimSc/h7cWgUnVlhOMGAFxbIDEL+DHAPJelOBHTuUldvtmnQ+xZumLGFv3Q9lYknH
 O1WwxBHR++DshiXM4YdWP7v/Uoadr0CzB5CkZvjxVt27CCh5yEL2lnEtQsVeAPua57CP
 54w9d5UxQGqWSvXfmylI0tHVhmFH1qblbN4WKHG0Ozk9iO767aTK3OkGxPEKkRY9pSyK
 8ivNsdPAEzoehlQXrCxIT7GLd9dFM6e8Bs9hCux/O++DoTXUyWP24DAymPr2V7vfXVXa
 xRxhyMAMPLyktySbGUyERwzQ1wBTIGHAG2B85xy2iT4m5ubxrjh38D9Sd37X43W11EPN zg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0b-0014ca01.pphosted.com with ESMTP id 32n8gy5suj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 03:12:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATBDdouJpM9r5uA4JB2vcuoJKhfr3jfpka/2ypuZeTW6RF5x2d0priBUAYj2eMDDf0kFLPBsmqHKlNcWizsRaMKEpG7YN1D6LFkxTyYRi/u8sOdM8PqeqCnb7EHSfvyd+OV+5idD5oyjyKK8dv9xj6ojcVwQ8j/dbzbH/pxOPiXhJcaClBspqA3F7x+glknh/N5EWQtDsEhJABlRGXlW2F5QSUIvc7HAkXIeGmbOd1997nlaQM3kRzEFmEXZ6JA+Egjfzigstpi6IxyJl98I7AEwq8HWfe+0Qb5fiH3JP909IpATfT+I51svujWjmsnTzLjzbZfZcLZcavaEo67Oag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCWjvyQ5qsVtRLR9Up9JDGbYCKLb4E3lVdJvKZlnFBI=;
 b=Q9u2h/If/rdGmY52msTnbcXPTKQHQe3uAZXigL4kokF+kJen5Cr/eoOAi3U8w94EHs3YGMRfzPVSPoUtw2ixxLaimS31KiZ0AUe3TZKT9aw1VLVeKaWpcTb3xriBwX/X8CB2pDWrNjZiPsDl9vKN29rso640/5qQvOHOPbrVEQZR68KP+gozISrOV6bQ41sBunVyTB2QDaBVQwSYk+5tNYCySjHEbT5JPsFb8CQd/7O/TVPUbEw95+m994ZyrVMOF6eh7cGsEphMNKl8OjnSUMAlHkmjoCmP97TbOd7FYNUT65YQjcIs4M+KUY3WUlOb1sr+awS+hw64FXSKPjk9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCWjvyQ5qsVtRLR9Up9JDGbYCKLb4E3lVdJvKZlnFBI=;
 b=q2Cu7TaGJ1+jWVqPkCzORWPUMGcPUAZVNqmBoou4NVoYkWEEMMhCtHX55088w/ULNJL3/xUJT/Z5mrccu4VdUZpKdZvlGsQXEVJDszbosuUQ+1oiOGZ/CfIYoDhbHmV5bKB81lcnnI9p8+WJk34PNPozPwRkP5CYPN83Tk24r0E=
Received: from DM5PR18CA0082.namprd18.prod.outlook.com (2603:10b6:3:3::20) by
 BL0PR07MB5682.namprd07.prod.outlook.com (2603:10b6:208:88::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15; Fri, 7 Aug 2020 10:12:52 +0000
Received: from DM6NAM12FT067.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::a5) by DM5PR18CA0082.outlook.office365.com
 (2603:10b6:3:3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Fri, 7 Aug 2020 10:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT067.mail.protection.outlook.com (10.13.179.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 10:12:51 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACk5c021638
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 06:12:50 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACkuJ013391;
        Fri, 7 Aug 2020 12:12:46 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077ACkW8013390;
        Fri, 7 Aug 2020 12:12:46 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 3/7] phy: cadence-torrent: Enable support for multiple subnodes
Date:   Fri, 7 Aug 2020 12:12:41 +0200
Message-ID: <1596795165-13341-4-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
References: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cd2c7fc-c19e-4e35-99d5-08d83aba71ca
X-MS-TrafficTypeDiagnostic: BL0PR07MB5682:
X-Microsoft-Antispam-PRVS: <BL0PR07MB56820C29364A87D0559A051BC5490@BL0PR07MB5682.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:131;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npBA1moCCmqtH1KoVDubW35whrzBQslCWqXbRIMw6wtMvK5g7YWNTjvcLYxPmb7HkA/wTUkgDURGTDkFLwBOa4G+dS8wjrizIVrjWM2qHAS+kug5Sx71PhtxC+gbDHhfC51ivbpF0snPmpjwspPQU7G3l5sn1QwmLWBCZnqecJkkVmKllHjobMW1M+C1kep6zctu7UeRTRXcRA2H00fyeAm2MmOM0v0qflH7CQlTADaF3BEj3HP83BzjB644+yz9Q7K0HU+Dgt6SL5HXDyD2cSCrk8Nksq0bZakywCN/78gWKitialiRy9afR+H4qVDA9ZJQGDHD/dah8Rc46A92NuCvt1RJ/mHgBI47gGvtFkASSngvgm6lyxZmt88GV7buWoEzsRFjYI/wf9nJeSycXb/gVI2aHshDPy1DAvRtWv4=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36092001)(46966005)(83380400001)(356005)(81166007)(186003)(86362001)(26005)(47076004)(8936002)(54906003)(82310400002)(2616005)(82740400003)(110136005)(478600001)(8676002)(36906005)(336012)(2906002)(426003)(5660300002)(70586007)(4326008)(316002)(42186006)(70206006)(6666004)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 10:12:51.9656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd2c7fc-c19e-4e35-99d5-08d83aba71ca
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT067.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5682
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_06:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 phishscore=0 mlxlogscore=920 impostorscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008070075
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
index 177120afcc35..8ef97af7308d 100644
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
 
 			phy_set_attrs(gphy, torrent_attr);
-		} else {
-			dev_err(dev, "Driver supports only PHY_TYPE_DP\n");
-			ret = -ENOTSUPP;
-			goto put_child;
 		}
 		cdns_phy->phys[node].phy = gphy;
 		phy_set_drvdata(gphy, &cdns_phy->phys[node]);
-- 
2.26.1

