Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155A0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA37820663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="pZr97A89";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="vX7Z3h7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgGAGYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:24:15 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:61930 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727051AbgGAGYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:24:14 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0616FbUW012536;
        Tue, 30 Jun 2020 23:22:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=kKWh4NEvAqTMFpxq9hIhC22mjHpeqWZCikNnAE1CP6s=;
 b=pZr97A89yV0MSYpqMSVSX9cZOMpFx4AJ2IVJhlk814B2fypmZs8Ep3eEgYqsFTFRQK92
 Fje55Yj8Xi6zcwiT7LGGSF7s6GgqO/bWEDAr321NtwsNoPaxYe2NVNiBiXvAeyWJmfb4
 uNMkolaLVEVXq4gVQw411Wg398IM7lOfHDUg+wLXlY/Re8xXS5d/RuVxrNO0GS1R3Ybv
 SCxLSX+lkriwxC/5FrhwixmrvR+F63llalP1KxnSZhtYadDYBe5F2qFvuyrDTnKYEufZ
 RpI0rf6W2FpZIYsG4TS0InqMdmU779ZyG8AUf1ACkiQJ8bsdfsrlhy7WyrB5+4F5WIO8 Rw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 31x1pyq6s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 23:22:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxymTz8XBG06cc4LkBnBP6djBxRFjX7ntFmXfVRUOI1bP2wAPSnm0GEp7g7+P9cBC16PPiRgA+femx9HURNd3G8ohQP10tFEBYoxwUcuunQfkU5zoDIt5MM7ZS8b8LTMjQy7ggiHGl/bdpYyZraNB/rj3aO+x8vgNDX9xCUvk6jHJ8ts3WofMixbaeAYOMYDZRbIfzCMSMoul3zfikiuDFEbz+GmKtJvibevYXDeOZASa8UCl9YRIocg9CyuDol+RWAIKdh5pNtD5Q44bV80mhA/roOoMk7FdZOjdYmgaMPIMbZwfQjT6MvNidAf/aL3fJ/Bre3iv5lbOXecefn7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKWh4NEvAqTMFpxq9hIhC22mjHpeqWZCikNnAE1CP6s=;
 b=QM11GT37UF3rG3iN5wj181okOnqA0yf7E/7lERpCIqd17L7Si6vNYkpty0YXsZNV7kbvcCn230R9MLHzvOF1zyjdZgAFHVsp9jZtvKrSL42KRuQyY9MxG8hNzvSo8G/9iKTutXbgEJ6iiIxvZTetVW5j3CaO1bGj3RPGjQVIYR9HkW/l34D6ij2AYIMuzEfIFiasu9RaESkUGVOGPR0xQZ1L3LBeUsrkcdvJTX1nW0Lf2av2Y+r0s0iDTAMXk1Hk5m4AHNKWScUajlPfxmfbeU2detwfb2Izc/CLkoqZnHp8WrceHcdvVSprfYjQKhoOB1P+y0PK4KS6XGU7p3pwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKWh4NEvAqTMFpxq9hIhC22mjHpeqWZCikNnAE1CP6s=;
 b=vX7Z3h7ts2xB+bDhHnLuM6eTQ5AO3L5Y6qRJP2o5rlV6AOeTrkHfc6bZ2O/CtStfwthZZ/Cp4wD7C13I4tjfaekX5BaJZ4BNMSslf/ZaDxFYIfZ+t1I7bQDs3hGmAHZgBRUuPHg4JYskh3LUeKWiwIn9qMy8L2mZgEAnOes4kgk=
Received: from BN6PR11CA0002.namprd11.prod.outlook.com (2603:10b6:405:2::12)
 by BLAPR07MB7539.namprd07.prod.outlook.com (2603:10b6:208:296::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 06:22:51 +0000
Received: from BN8NAM12FT021.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::f4) by BN6PR11CA0002.outlook.office365.com
 (2603:10b6:405:2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Wed, 1 Jul 2020 06:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT021.mail.protection.outlook.com (10.13.183.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.10 via Frontend Transport; Wed, 1 Jul 2020 06:22:49 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0616MjiP092304
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 23:22:48 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 1 Jul 2020 08:22:45 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 1 Jul 2020 08:22:45 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0616MjIa030587;
        Wed, 1 Jul 2020 08:22:45 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0616MjTF030586;
        Wed, 1 Jul 2020 08:22:45 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 2/9] usb: cdns3: Improvement: removed not needed variables initialization
Date:   Wed, 1 Jul 2020 08:19:57 +0200
Message-ID: <20200701062004.29908-3-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200701062004.29908-1-pawell@cadence.com>
References: <20200701062004.29908-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(36092001)(46966005)(47076004)(82310400002)(8936002)(7416002)(186003)(107886003)(4326008)(5660300002)(36756003)(426003)(336012)(1076003)(8676002)(26005)(6666004)(83380400001)(54906003)(2906002)(70206006)(70586007)(86362001)(81166007)(356005)(82740400003)(36906005)(2616005)(110136005)(478600001)(42186006)(316002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45866955-7e99-451f-ad64-08d81d872ddd
X-MS-TrafficTypeDiagnostic: BLAPR07MB7539:
X-Microsoft-Antispam-PRVS: <BLAPR07MB7539F977A0A4BF1EF6D165F5DD6C0@BLAPR07MB7539.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:160;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wlp2ypGgyacPOSlyZQDhKbzoVFZhaPQpbQyAH4zofbHaZXYD/XBKrsg7PtQG+XfdK1TaNAbKm4qmMKdL3BbXxMAvjsm40TkqJcga6aHFCfpc8fQiyav26Qd02ulvKVzuYEFqtfd0eeBzLkU8yICEI3yyYnCGj/A3eW343rI20wtPJgFSwtcyNx0eiuMNebgpdkyAb4EELMUd+YwDzKpaVUwDMRD6QPreiONNQH27LI11QE9sqDmnKC/FFDSHmZ5woEePSVLFFYq5zuzvcT5K/fPybOi0K3J3PzDcSNbiAyJ6PsD6bSQP2gFXdJmVBdJD4+zQB9C+D/W9yIFg5rJc1e0gvYshsrEoL59+4i6q+HV71Exu82wW88OcW5j+o6pNEg30cxw6oCdP/g02rakpdnKKJZyV1xhjQzTmn+crWjg=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 06:22:49.8679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45866955-7e99-451f-ad64-08d81d872ddd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT021.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB7539
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_03:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 malwarescore=0 cotscore=-2147483648 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=614 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch remove some variables initialization from core.c and drd.c
file.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/core.c |  4 ++--
 drivers/usb/cdns3/drd.c  | 19 +++++++++----------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index eaafa6bd2a50..c3dac945f63d 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -86,7 +86,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 	struct device *dev = cdns->dev;
 	enum usb_dr_mode best_dr_mode;
 	enum usb_dr_mode dr_mode;
-	int ret = 0;
+	int ret;
 
 	dr_mode = usb_get_dr_mode(dev);
 	cdns->role = USB_ROLE_NONE;
@@ -177,7 +177,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 		goto err;
 	}
 
-	return ret;
+	return 0;
 err:
 	cdns3_exit_roles(cdns);
 	return ret;
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 58089841ed52..4939a568d8a2 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -29,7 +29,6 @@
  */
 int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
 {
-	int ret = 0;
 	u32 reg;
 
 	switch (mode) {
@@ -61,7 +60,7 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
 		return -EINVAL;
 	}
 
-	return ret;
+	return 0;
 }
 
 int cdns3_get_id(struct cdns3 *cdns)
@@ -134,11 +133,11 @@ static void cdns3_otg_enable_irq(struct cdns3 *cdns)
 int cdns3_drd_switch_host(struct cdns3 *cdns, int on)
 {
 	int ret, val;
-	u32 reg = OTGCMD_OTG_DIS;
 
 	/* switch OTG core */
 	if (on) {
-		writel(OTGCMD_HOST_BUS_REQ | reg, &cdns->otg_regs->cmd);
+		writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
+		       &cdns->otg_regs->cmd);
 
 		dev_dbg(cdns->dev, "Waiting till Host mode is turned on\n");
 		ret = readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
@@ -212,7 +211,7 @@ int cdns3_drd_switch_gadget(struct cdns3 *cdns, int on)
  */
 static int cdns3_init_otg_mode(struct cdns3 *cdns)
 {
-	int ret = 0;
+	int ret;
 
 	cdns3_otg_disable_irq(cdns);
 	/* clear all interrupts */
@@ -223,7 +222,8 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
 		return ret;
 
 	cdns3_otg_enable_irq(cdns);
-	return ret;
+
+	return 0;
 }
 
 /**
@@ -234,7 +234,7 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
  */
 int cdns3_drd_update_mode(struct cdns3 *cdns)
 {
-	int ret = 0;
+	int ret;
 
 	switch (cdns->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
@@ -307,8 +307,8 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
 int cdns3_drd_init(struct cdns3 *cdns)
 {
 	void __iomem *regs;
-	int ret = 0;
 	u32 state;
+	int ret;
 
 	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
 	if (IS_ERR(regs))
@@ -359,7 +359,6 @@ int cdns3_drd_init(struct cdns3 *cdns)
 					cdns3_drd_thread_irq,
 					IRQF_SHARED,
 					dev_name(cdns->dev), cdns);
-
 	if (ret) {
 		dev_err(cdns->dev, "couldn't get otg_irq\n");
 		return ret;
@@ -371,7 +370,7 @@ int cdns3_drd_init(struct cdns3 *cdns)
 		return -ENODEV;
 	}
 
-	return ret;
+	return 0;
 }
 
 int cdns3_drd_exit(struct cdns3 *cdns)
-- 
2.17.1

