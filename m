Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D04C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6760C20663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="fVtOxF6E";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="b7zArpwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgGAGXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:23:30 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:47046 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727841AbgGAGXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:23:23 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0616HCf0014542;
        Tue, 30 Jun 2020 23:22:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Yx/OstEb1e+mVzdVSn72cLU0gdYjamPLns9M36RHJTE=;
 b=fVtOxF6Echy9jgUGI2nLWVEScz1tqjELBnaYbrWncUERvMqOUOsC3NUJFQq9mkUbbtVY
 Julh9K4cWpHpo/EuPeeb+SSYi4tYHuGH9yj5d61ZkZAa0oFuat9hfKBFJZi5YvcxQaTz
 HenCDfGUsyJnUW8EI6lrVov0I8IBGgKj+i/c1Dlu2oqNGGftjY9iRjn/3m4DnSpurbol
 8NVJvopiJiwTIqSz0ICQTdaHZP0T5K/KnpTfkfM8m/v68TkZc0cD245BuzY1Lah/S3bd
 iF4GyYnAgP0S9v3+FXqr8/94YJWQD7Wh1s2bIs9QufwmeBhw42L7RtYaCA43ieUi41Wm QA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31x2nxxa8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 23:22:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz+ewcmSaKs9HWjNBeQ4fNFSFNThZjy2zzsR8GmZxAs+v3QMwhixS5PYNmTY9fCjs+kyrWcc6A0wCQrGAr4+ObhcHemmsPm/OfHCL4JjMSjtlgY9SGGqFb8vlCRRaOartmCBMrFEjNl5ht4cOjCNxC4sOUriWXDixv3UdCVqOryIY+4iZ034qEh23bTK+YBCQi1C6v0fLue/GIefymuiVTuDagxlP6ptzawN/EJ+vcckhPQzpie/eirgB2RVIuQHKjqUmboFZdvUilGcnxV1B7JBPqqB/4ApzPjLi5aV9FXTJji3EY3qz+Cvx9ZUsNsncPJhRFALixiBcrtvbpd8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx/OstEb1e+mVzdVSn72cLU0gdYjamPLns9M36RHJTE=;
 b=FH/FxBoOx9X1/or5mmKWyKCAPz+C8tf1mHf+wPzMmDsWcMdoLdfKAZpDRbvp+ZlDlR+rVjsurSk0OazKIapQU47A7YSNk5oahiwsNneVJBtETzL3jmLEsVjQxodV+MWVXnnIUGQKT92qzEmwEVhEPYVDx1wFAnUszodneF5bNylrbyj1wxUaKRbRY7aD1Tw/xbG4NqfwSlCWZGduBhC2q5On1pXhRyelsSp1x8FXAXD8H7qVyNn2vWqrIgAdhnMvvK2rVBpA6wtOE7xETSjBGyrSA1Zu3OpV3fsk0Z5RZPTCDRuEMvX0K1Fg5gpL8z9d+j+7MSWAynfVICl80QREXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx/OstEb1e+mVzdVSn72cLU0gdYjamPLns9M36RHJTE=;
 b=b7zArpwRMGMiSwJ5j448nyAJUyadkSbkHjFsHGBhA+Cgh9KGbTKojuVD2FG7EPjeDA8nYBhmN5JHRpCQAPNrlsLXX4xDs98jokKHoZOS4ZQDmUjV4q4MlZyduFwgvuWK9sxz8pCNjFqzr52DGfrTOcmXZ7dySeUvQzp/LBeMWn8=
Received: from BN6PR10CA0003.namprd10.prod.outlook.com (2603:10b6:405:1::13)
 by BYAPR07MB5333.namprd07.prod.outlook.com (2603:10b6:a03:62::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Wed, 1 Jul
 2020 06:22:53 +0000
Received: from BN8NAM12FT038.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:1:cafe::9f) by BN6PR10CA0003.outlook.office365.com
 (2603:10b6:405:1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Wed, 1 Jul 2020 06:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT038.mail.protection.outlook.com (10.13.183.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.17 via Frontend Transport; Wed, 1 Jul 2020 06:22:51 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0616MjiS092304
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 23:22:50 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 1 Jul 2020 08:22:45 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 1 Jul 2020 08:22:45 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0616Mj20030607;
        Wed, 1 Jul 2020 08:22:45 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0616MjSs030606;
        Wed, 1 Jul 2020 08:22:45 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 6/9] usb: cdns3: Added CDNS3_ID_PERIPHERAL and CDNS3_ID_HOST
Date:   Wed, 1 Jul 2020 08:20:01 +0200
Message-ID: <20200701062004.29908-7-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200701062004.29908-1-pawell@cadence.com>
References: <20200701062004.29908-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(36092001)(46966005)(47076004)(70586007)(70206006)(356005)(81166007)(336012)(426003)(36756003)(82310400002)(7416002)(110136005)(316002)(478600001)(83380400001)(6666004)(2616005)(54906003)(42186006)(26005)(82740400003)(8936002)(186003)(4326008)(107886003)(1076003)(2906002)(5660300002)(8676002)(36906005)(86362001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b50eb41d-4840-4205-54e1-08d81d872ec2
X-MS-TrafficTypeDiagnostic: BYAPR07MB5333:
X-Microsoft-Antispam-PRVS: <BYAPR07MB53331F172E2ACA4D3FEDB02CDD6C0@BYAPR07MB5333.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8vEJAHZ3xuvfyWVO/yKwm5NwsuovllDaeDc09TzSnYwfZsLx8GsSIZfkreIAgOfUvlEB1n42R/nxIpfO22LMU/GAVETy582fpO6wp/GaZNB6w2fCA+NbyfRaX+YUU5tlZEynFm8/cSJZCnelLA1cXcxwo+Ggb26K10/Ng2MqS7PoB5/mlLuX9NWuz8H/vodBVkBHVynbb1amSRIz82XZV0BSluvZWaQtJhENhcRlctBI3GpGTVExcqU1Z7BP6AmkXMZZKAz/NjmG6oMDSNW3GPuHHiw97mjK2WZ8rdYjUhKbC1tir//luSHP0XBBX/9yOPx8RcPdawEDhsZ2zXsPbTPOvkcYIOghLTVvAhvIRNlFrflXdFqXgU3/P7pLdAuKb586t4iIr82wvdyzQtnjTGPRpbKZMSAm0NzEyMQI/w=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 06:22:51.3624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b50eb41d-4840-4205-54e1-08d81d872ec2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT038.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5333
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_03:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 cotscore=-2147483648 mlxlogscore=572 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds 2 definitions that make it easier to understand the code.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/drd.c | 4 ++--
 drivers/usb/cdns3/drd.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 6fe092c828b3..8e7673da905e 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -87,7 +87,7 @@ bool cdns3_is_host(struct cdns3 *cdns)
 {
 	if (cdns->dr_mode == USB_DR_MODE_HOST)
 		return true;
-	else if (!cdns3_get_id(cdns))
+	else if (cdns3_get_id(cdns) == CDNS3_ID_HOST)
 		return true;
 
 	return false;
@@ -98,7 +98,7 @@ bool cdns3_is_device(struct cdns3 *cdns)
 	if (cdns->dr_mode == USB_DR_MODE_PERIPHERAL)
 		return true;
 	else if (cdns->dr_mode == USB_DR_MODE_OTG)
-		if (cdns3_get_id(cdns))
+		if (cdns3_get_id(cdns) == CDNS3_ID_PERIPHERAL)
 			return true;
 
 	return false;
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index 35b6d459ee58..3889fead9df1 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -153,6 +153,9 @@ struct cdns3_otg_common_regs {
 /* Only for CDNS3_CONTROLLER_V0 version */
 #define OVERRIDE_IDPULLUP_V0		BIT(24)
 
+#define CDNS3_ID_PERIPHERAL		1
+#define CDNS3_ID_HOST			0
+
 bool cdns3_is_host(struct cdns3 *cdns);
 bool cdns3_is_device(struct cdns3 *cdns);
 int cdns3_get_id(struct cdns3 *cdns);
-- 
2.17.1

