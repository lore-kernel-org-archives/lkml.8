Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44481C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13AC20663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="REGtuz6c";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="apVCGlM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgGAGX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:23:27 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:53172 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727838AbgGAGXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:23:22 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0616HCex014542;
        Tue, 30 Jun 2020 23:22:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=rdQONh4CY1EV94jM0VuQyufyzyyqDd27dwJDoPPf5Ro=;
 b=REGtuz6cECBR3IxLAB9FyIToHGf7gvuT9QSnl6BOSWQ1dRGttMNGJCGSOSwXVJM2+MB/
 6w/o9BM/HAGjyRd+mYNXCuGOP78Zft4ZQ3lgO/wj7AJBJ2Vdm4mdKUijRvCAl/P5CLS2
 6hsVf69loqpdTCo8JX+9m2kq2O5xMWTTf5zrxt0wT6in/CTygSVANM7zw4Q8rjZpVqCE
 xQO30ibgUFIW7XXNe4G5pBnw/FaWMRFw3TPZsqaLZXv/FB+ovxtv/Y3k3lP+WX1dpzl9
 0a2+O2uBBO9aeF9u1EEej4mToXgj5kX3OSJFAWKEOor4xDo6almcsFlPqZH8AhYc3/le jA== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31x2nxxa8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 23:22:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRAMi+cHDpS9G6uGNYitX7P8QX9q23BqHhY62BqTLFZ7NTEladwS/FKB3bDH5CqHL9bFNeIK+lYFyQC8nFWKniAHPwnm58XNdugrXgk+hOtIggbqWQe2vkaNlIdWxQMwjD8MQrVpeV7IzEge2paAf17tKEiR606un/HrxTOrFkccGS5WuRMjLIfpiqWf/cmIzJNlEfOdP9H9Q8tVrjkEXqDuhvRo7AcIDy9f3BOOgC09H5wyX6hoQg48x+LUXGyVrDOKzJNeyuBFB5T1O2U41wtBl1iurDhDiM8achT9iFzyYzURFHF+xdWmVXZTOGGlwAuyMspx2Ck1BSIjU612Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdQONh4CY1EV94jM0VuQyufyzyyqDd27dwJDoPPf5Ro=;
 b=SyKMjCa6te7wWeb35xgqD88ZpjmdbK80lw8KtF4PR51zi852XgyTLJlZrpDH3A8m6G2zx5YV7x/inw/Zfor49ERWrnGbnvAKIL90NZ0cTbVMDOwZW6Crol5OSufAmUxxqdxQT9bvxCawRgANmrMKE6yGGFgjpatK0HAA+IiSWt4bcDNz2oyTLE0dMgWTN03kvA2fydNY9PLhXUypX3h5Z2CrOOCwstCH+ZJLFoUaDsG3DhNZUOEkiHsqZp4e5lnDP9QjkQqyaBymoGKqrTMVIJAwYhVz8m2h+nFo5IcLzWZhvWV3SZFvVKBCQ9BZn5eXOsUK/g6YRqxY+IX9tHDUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdQONh4CY1EV94jM0VuQyufyzyyqDd27dwJDoPPf5Ro=;
 b=apVCGlM3QbC+fcjyjCvXg2qKJCPs29a6m54U1HxOiwUai6Ebo7De/ASBLmT4IU6LHDE1MzXOa8PlOiinBDk5JK5h4OwTByvTdg79yB2TPxaVLr2ddhngdJQ33LnaCPrtqRaReB5fPZ7fjbN5+cmzexnptSDDQ6P47fRjEOLTS3s=
Received: from BN6PR08CA0053.namprd08.prod.outlook.com (2603:10b6:404:b9::15)
 by CH2PR07MB6456.namprd07.prod.outlook.com (2603:10b6:610:23::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Wed, 1 Jul
 2020 06:22:53 +0000
Received: from BN8NAM12FT053.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:b9:cafe::48) by BN6PR08CA0053.outlook.office365.com
 (2603:10b6:404:b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Wed, 1 Jul 2020 06:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT053.mail.protection.outlook.com (10.13.182.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.10 via Frontend Transport; Wed, 1 Jul 2020 06:22:50 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0616MjiQ092304
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 23:22:49 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 1 Jul 2020 08:22:45 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 1 Jul 2020 08:22:45 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0616MjsR030599;
        Wed, 1 Jul 2020 08:22:45 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0616MjIA030598;
        Wed, 1 Jul 2020 08:22:45 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 4/9] usb: cdns3: Improvement: return IRQ_NONE explicitly.
Date:   Wed, 1 Jul 2020 08:19:59 +0200
Message-ID: <20200701062004.29908-5-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200701062004.29908-1-pawell@cadence.com>
References: <20200701062004.29908-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36092001)(46966005)(86362001)(107886003)(478600001)(4744005)(54906003)(1076003)(6666004)(81166007)(83380400001)(5660300002)(2906002)(26005)(356005)(82310400002)(8936002)(186003)(47076004)(36906005)(70206006)(70586007)(316002)(110136005)(42186006)(7416002)(4326008)(2616005)(82740400003)(8676002)(426003)(336012)(36756003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9b7b792-e911-4acf-a846-08d81d872e42
X-MS-TrafficTypeDiagnostic: CH2PR07MB6456:
X-Microsoft-Antispam-PRVS: <CH2PR07MB645693BF955F37785C33FDB1DD6C0@CH2PR07MB6456.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZwf6sr6LqLcjR/JatjEYyQFf8qwx+kjeJjI7UKtbp7AnjocJFLSxygVhswxhLoOKyeLm+OhTRy6Jt01pWYSfWTItwObTkHbfpKN3WXeONTCqsskftd69jRAud55BsJdrHVxz7xTq/gzY+Ua4OsJFwmmYTmOC6Nk1cLDKUjONfahA71swiidCxsV2Vbswn4pei5h7QtD967Tqa4UD7FVtQx45SppIeZZI2d7R11b3eBQf+ziypP0PDQJDfMuXGXNvfz8cDHAwx7H3VB4fkGkesqxXtF2cMiMJeqr7oCc62FhRfklEwnBfkJZJ8En1VGUoVhNfRmja+lY/qCGAkAAsA10FDDV04xelPASVUYWKtcuTfFIVB9KLcBaYFUWuYCkJuhboYsyOiCHHF3jRN8pEnicz37hxuTXDDDBqML/eik=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 06:22:50.5326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b7b792-e911-4acf-a846-08d81d872e42
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT053.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB6456
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_03:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 cotscore=-2147483648 mlxlogscore=676 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ_NONE can be returned indirect.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/drd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 6d2da504ad49..05a9f7d54c46 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -279,12 +279,12 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
 	u32 reg;
 
 	if (cdns->dr_mode != USB_DR_MODE_OTG)
-		return ret;
+		return IRQ_NONE;
 
 	reg = readl(&cdns->otg_regs->ivect);
 
 	if (!reg)
-		return ret;
+		return IRQ_NONE;
 
 	if (reg & OTGIEN_ID_CHANGE_INT) {
 		dev_dbg(cdns->dev, "OTG IRQ: new ID: %d\n",
-- 
2.17.1

