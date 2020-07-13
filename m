Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F1AC433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216F920758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="doS/uECG";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="M7Hstm4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgGMKGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:06:51 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:6820 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729565AbgGMKGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:06:38 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DA36GP026914;
        Mon, 13 Jul 2020 03:06:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=zi89usVL8YiHCSsDGGey2Zi5WPZ+2wMY592+ivrE6Nc=;
 b=doS/uECGA5LDWIEr594RsRvQu+w7c93RJi/ECryJR16EEvgZ8SwYdgd53kgj+d9kA0Nc
 kiHU3VgZ+dy9xHuSz9vjHHxGS4Riz5LfScLggSOiokbBYXKZQqlA++EX5OEVDL0C3FKI
 plq0KEmCHyymSC5UwV8ZsErHlBRPNoCsXeM4xU+TqKIprCne/mzq4lJlYALWH51PlB8P
 viyOsCp9o2A0HsnDthhmszsOyuI6Yac1sqbBwXST+mQkZS44mROyPAoy1GVAXY6gCbtQ
 yH2NfqK7B1a3Je5dv38UkoLd/Np5+MDwBfTOj5PoO/J3EIQ/CIiZsKd8AaiY0P4BWxHP 4g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3279yud6c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 03:06:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llREbXGf+sX9T5JNRVVSB9X+phLlSIHp8WY3VGynSdVwYMUljP3RLS27Y9i0BRFppbCtKzoemfooL1nlO9C3VjJseHbOZukIxPGgBP8eIAEyJPZQl01k9B0ORZMGEoMUr0QJ9HKIGmJouThG27KNuXvzW9qrlkw+WPiEJKNCIb4E3rk6sNcQgmb1u8r6k/vmAXaOSWIxT/7nKvaJ6au0ZFY05NyeoBw7EItKdTTbgiuvpUdqmvjSf32Z9le5FWRI+y9eIVGdLByqhtBTz885q4HS1MuEmMGdNB4nAZeH9RZ6u/DrjnfDf0Bm7V+0MgTYXKjO/8NZZFyNgh9i24wUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi89usVL8YiHCSsDGGey2Zi5WPZ+2wMY592+ivrE6Nc=;
 b=AkDpG5Ap/YrR8AhJejTkAVqGEVjVDCIQhTEcPL+1tAwjEVFXHZiO3PA4V9Gd1l+QVWTWC3d3iANFoSwyKQcwcLL9dEel3dqgBX5kb0qdblMTQzXYDdnoDr32ElYCeyhGFfggacmJOBJzxp90yZL+d8JTxXGfwWnq2qPm/yeVTLzFdE6cvskUMwYMbV2rBWdaa255PgQWdqv04SJVJvI2RhpY63tNzeXUQz2MIOIw5Imp1/j8X8O/r8ykDCllZj1d9pxDOK5QDKn+MhYK4EVQuq69i7RoedgeD5J1Qwspki0QyKvItjqT37h5OHtMVVaIN9Xufh6mCX/dL3ACzCkliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi89usVL8YiHCSsDGGey2Zi5WPZ+2wMY592+ivrE6Nc=;
 b=M7Hstm4g2qUCExQBhIPxtib6BgRzGycUtxFJAls0tA1t5JV9ECc4axs8lrEXCZM8gOiFxY2l7uTBSTy/rD2aCgnwUUkuNv1AiLtAhfHZ+ohdAVi15HU8QCM1HI4tBpGDePRcgz0LiIv2fB7kykSzHxH7VuA7GKYdbAQiTzZNu4o=
Received: from BN6PR11CA0029.namprd11.prod.outlook.com (2603:10b6:404:4b::15)
 by SJ0PR07MB7663.namprd07.prod.outlook.com (2603:10b6:a03:28b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 10:06:09 +0000
Received: from BN8NAM12FT010.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::d0) by BN6PR11CA0029.outlook.office365.com
 (2603:10b6:404:4b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Mon, 13 Jul 2020 10:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT010.mail.protection.outlook.com (10.13.182.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Mon, 13 Jul 2020 10:06:08 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63Yq013926
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 Jul 2020 06:06:07 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 13 Jul 2020 12:06:03 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 13 Jul 2020 12:06:03 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63g3028631;
        Mon, 13 Jul 2020 12:06:03 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06DA63Ts028630;
        Mon, 13 Jul 2020 12:06:03 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 2/9] usb: cdns3: drd: removed not needed variables initialization
Date:   Mon, 13 Jul 2020 12:05:47 +0200
Message-ID: <20200713100554.28530-3-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200713100554.28530-1-pawell@cadence.com>
References: <20200713100554.28530-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(36092001)(46966005)(5660300002)(36906005)(47076004)(107886003)(2906002)(1076003)(82740400003)(8936002)(42186006)(110136005)(86362001)(356005)(8676002)(54906003)(83380400001)(6666004)(81166007)(478600001)(336012)(4326008)(7416002)(316002)(186003)(2616005)(426003)(70206006)(70586007)(26005)(36756003)(82310400002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 368351c2-8120-467b-e1bb-08d827145d34
X-MS-TrafficTypeDiagnostic: SJ0PR07MB7663:
X-Microsoft-Antispam-PRVS: <SJ0PR07MB76633552D888B427E9059628DD600@SJ0PR07MB7663.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:160;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Vu2+es1PjQhLHll4YoqzXG3Xa0yui7YJkhOf58u0FFNHKWfKc/Z5y0w4cArKEgD/dSTyOVQsiUkRM/3cfsiAAf9oY9qOef/vSHCvJe311igRhAoHv3S9ON5BXTGMffLgmOImBxvlpsns/3g+yMTzmPwupJShiVWmT8K32OYImKrvhKopgg/cDX3LhwB9RRFyGPsGCf1dJCPqDllif4vQs7OaEA3hGhasYV0tkRXlUnH62YdAkaJO0b/PpfD5YrLo8IjdVeYIqiK3qFEN0Mt8qMzJOxhfF466pR11madVcPgJDtrHOb0g+z9CG4nH9SZAeAOm+rMv4PnqLbUEl9K+2h4Nfu1Pv8/ynLPe+NC8baA+Y0aVnnNxVzMBiff9BR6aWQi/l5WJEpDGZQ66+c3i5UR4cT6OsT452rgvEbae6A=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 10:06:08.9231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 368351c2-8120-467b-e1bb-08d827145d34
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT010.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB7663
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=564
 mlxscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130075
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
index 1f77fb5aefbf..c498b585eb13 100644
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

