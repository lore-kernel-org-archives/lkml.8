Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D84EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1190720663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WenFUo3o";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Hp7FCv7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgGAGXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:23:44 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:55010 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727839AbgGAGXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:23:23 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0616H9GK014532;
        Tue, 30 Jun 2020 23:22:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=wgBXd/eRewPjVKWni72sYgBXfTGxIrpwbPBz3CJqa+U=;
 b=WenFUo3oyv2Fesg+yhP6obxDluTQ0GVpb4ESf1OxMbesaKyHcGydbbfnERxI7AgFQBPJ
 uhcYkqNAknftQwHZ93Z1/Tz9J/P0VG0S0eaSGgL+9liiBCOHJ0JcMiAY56s7bYi1HaFd
 S16o2LhDctHoUu0r4Y0fUlnwEZsb92E4sCxxz/HgrH2X0ZOfm2gOyJbrJDfAdv7/IubN
 BQCZsGLWX8JCl8oEvYP2U05eq93LYWw2uAUuD2tJDE7Y2h2IUuIVyZl7aQLqYeYgRjRn
 Hwq54coCwH/YysdRSbFbuosp174yscwe5hhsF1LqvJYZeI/2gJPht4HsrXmt8EzgyzyV QA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31x2nxxa8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 23:22:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1WPxpPHajjPKaUi48zlWyVwDlO+8G6g1qql35DOraHfRJXq3SNBFmxy842C/r0awuRvKANVzCBu1t6xSUVOzN3K0bEWUjf7+1isRDX87MHZYwclOFsus22hfcyB0O5uzXcu/9rM04TwNtGVkahMFbBCu32+DOtSOM57ydqVzkn6WJExiIJXOXoO4vBMEG/Z7l/W59fbvrTLoFTTxiCTlWiQHbM1YxCzpEmeu9Fa1X3MFvaLGJt9K+UG5qvHe7zFsl9GPCRkLe3zIPkMjGxuthUBFhb5HhHyQibG9db4r48uRj1jDggluGZFFeMKL50fKoC5zWKYdxtyqWXzg/KNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgBXd/eRewPjVKWni72sYgBXfTGxIrpwbPBz3CJqa+U=;
 b=jiau3ID7odRphT2OuXtBBVZky8us1xYhWQBT4olmqFxhwJCuroc3mLHJeLn5zyJB+4SHQEs7KCSOeggxaZUIWzn/K4RQ5vOqG7bP7PZXGrsFwPoXlgWftTd/e7r/+xWbdesUORF+U9VyB5EGB24EMhTU40pWmmPXMi0OXdmM17JCNahXR8igQWsSC/dKqsmi8ybFxTBY+DMeMRGokqke1VOTYlJV0DdkCrGWLRSjkeSlinhFfG9Gq0YvwI4+6ze9Al5ZDXVS+HjYBEZB+jFj/bPNoDovzNVfOHhYZHTtfOzMH258/arh+ca5EF2WAsW70Nb2X8c5lGomRDEzyeYI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgBXd/eRewPjVKWni72sYgBXfTGxIrpwbPBz3CJqa+U=;
 b=Hp7FCv7C85t+B7xylKBatsWoJmAL4Hy8ap1KyOsaC8mWSBbisadX8Zj9C0WfBEe/d0pKHi8AiIwVTiiOV186XSswKj0xH3fRaxqDFMTFoE5+Tq14+rde/CsrQ8F5aou8eq/QWjVTcmCxnJ2cgu6tS1laXJMvLK7H+tFxaf8QAKw=
Received: from BN6PR06CA0005.namprd06.prod.outlook.com (2603:10b6:404:10b::15)
 by SJ0PR07MB7613.namprd07.prod.outlook.com (2603:10b6:a03:289::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 06:22:55 +0000
Received: from BN8NAM12FT014.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:10b:cafe::82) by BN6PR06CA0005.outlook.office365.com
 (2603:10b6:404:10b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23 via Frontend
 Transport; Wed, 1 Jul 2020 06:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT014.mail.protection.outlook.com (10.13.183.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.17 via Frontend Transport; Wed, 1 Jul 2020 06:22:52 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0616MjiV092304
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 23:22:51 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 1 Jul 2020 08:22:45 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 1 Jul 2020 08:22:45 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0616Mjks030619;
        Wed, 1 Jul 2020 08:22:45 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0616Mjj1030618;
        Wed, 1 Jul 2020 08:22:45 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 9/9] usb: cdns3: Impovement: simplify *switch_gadet and *switch_host
Date:   Wed, 1 Jul 2020 08:20:04 +0200
Message-ID: <20200701062004.29908-10-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200701062004.29908-1-pawell@cadence.com>
References: <20200701062004.29908-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(36092001)(46966005)(81166007)(7416002)(2906002)(426003)(83380400001)(110136005)(36756003)(336012)(70206006)(86362001)(356005)(6666004)(54906003)(70586007)(36906005)(82310400002)(2616005)(5660300002)(107886003)(478600001)(47076004)(8676002)(26005)(316002)(42186006)(8936002)(4326008)(1076003)(82740400003)(186003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fab5526c-24f6-4ad9-d893-08d81d872fb9
X-MS-TrafficTypeDiagnostic: SJ0PR07MB7613:
X-Microsoft-Antispam-PRVS: <SJ0PR07MB7613388BD8A4231770E22787DD6C0@SJ0PR07MB7613.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPdVpPyarF9aJlYolyf4rl5PhsGAKcs0HO6J9Xcmct6U7Sj9GaLPhtIGVR+qL3RIGk/n+chcRin7+bUTE6c5Dc9MGPN3o2A2ShKcjMY8XDjVjhf6LkfvM/P8A42erVu+ojGc6ham/8wG3dZvEImHe0M74c/qSSGMa6sf37x/LZN4L7uUAmx7lbUJzq4OJ6g3ChyhQ3bgk7WsyJvjN5q/v6LgyWUGL0UJYiwQghRYkK09pl1z7W40a0NY171mhIKio6ppD6+P+adjteaE94/h/Nmn6DazNHBlg/4xV0RyJm75emFe+6fL64fmMILAFQS598cj8bxgeJYbDVyiuaSeUFG5jPm6TF7+J2Vplegr2i/0HpDWEkyMeUlWiLPLI9EaKeS2BrbKJf0OrwGmusSlRZC3Yc5QF3H0AaB7f/vqtXE=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 06:22:52.9885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab5526c-24f6-4ad9-d893-08d81d872fb9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT014.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB7613
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_03:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 cotscore=-2147483648 mlxlogscore=896 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch split function cdns3_drd_switch_gadget and
cdns3_drd_switch_host into:
- cdns3_drd_host_on
- cdns3_drd_host_off
- cdns3_drd_gadget_on
- cdns3_drd_gadgett_off

These functions don't have any shared code so it's better to
have smaller, faster and easier functions.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/drd.c    | 124 ++++++++++++++++++++-----------------
 drivers/usb/cdns3/drd.h    |   6 +-
 drivers/usb/cdns3/gadget.c |   4 +-
 drivers/usb/cdns3/host.c   |   4 +-
 4 files changed, 76 insertions(+), 62 deletions(-)

diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 8e7673da905e..6234bcd6158a 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -124,85 +124,97 @@ static void cdns3_otg_enable_irq(struct cdns3 *cdns)
 }
 
 /**
- * cdns3_drd_switch_host - start/stop host
- * @cdns: Pointer to controller context structure
- * @on: 1 for start, 0 for stop
+ * cdns3_drd_host_on - start host.
+ * @cdns: Pointer to controller context structure.
  *
- * Returns 0 on success otherwise negative errno
+ * Returns 0 on success otherwise negative errno.
  */
-int cdns3_drd_switch_host(struct cdns3 *cdns, int on)
+int cdns3_drd_host_on(struct cdns3 *cdns)
 {
-	int ret, val;
+	u32 val;
+	int ret;
 
-	/* switch OTG core */
-	if (on) {
-		writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
-		       &cdns->otg_regs->cmd);
-
-		dev_dbg(cdns->dev, "Waiting till Host mode is turned on\n");
-		ret = readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
-						val & OTGSTS_XHCI_READY,
-						1, 100000);
-		if (ret) {
-			dev_err(cdns->dev, "timeout waiting for xhci_ready\n");
-			return ret;
-		}
-	} else {
-		writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP |
-		       OTGCMD_DEV_POWER_OFF | OTGCMD_HOST_POWER_OFF,
-		       &cdns->otg_regs->cmd);
-		/* Waiting till H_IDLE state.*/
-		readl_poll_timeout_atomic(&cdns->otg_regs->state, val,
-					  !(val & OTGSTATE_HOST_STATE_MASK),
-					  1, 2000000);
-	}
+	/* Enable host mode. */
+	writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
+	       &cdns->otg_regs->cmd);
 
-	return 0;
+	dev_dbg(cdns->dev, "Waiting till Host mode is turned on\n");
+	ret = readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
+					val & OTGSTS_XHCI_READY, 1, 100000);
+
+	if (ret)
+		dev_err(cdns->dev, "timeout waiting for xhci_ready\n");
+
+	return ret;
 }
 
 /**
- * cdns3_drd_switch_gadget - start/stop gadget
- * @cdns: Pointer to controller context structure
- * @on: 1 for start, 0 for stop
+ * cdns3_drd_host_off - stop host.
+ * @cdns: Pointer to controller context structure.
+ */
+void cdns3_drd_host_off(struct cdns3 *cdns)
+{
+	u32 val;
+
+	writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP |
+	       OTGCMD_DEV_POWER_OFF | OTGCMD_HOST_POWER_OFF,
+	       &cdns->otg_regs->cmd);
+
+	/* Waiting till H_IDLE state.*/
+	readl_poll_timeout_atomic(&cdns->otg_regs->state, val,
+				  !(val & OTGSTATE_HOST_STATE_MASK),
+				  1, 2000000);
+}
+
+/**
+ * cdns3_drd_gadget_on - start gadget.
+ * @cdns: Pointer to controller context structure.
  *
  * Returns 0 on success otherwise negative errno
  */
-int cdns3_drd_switch_gadget(struct cdns3 *cdns, int on)
+int cdns3_drd_gadget_on(struct cdns3 *cdns)
 {
 	int ret, val;
 	u32 reg = OTGCMD_OTG_DIS;
 
 	/* switch OTG core */
-	if (on) {
-		writel(OTGCMD_DEV_BUS_REQ | reg, &cdns->otg_regs->cmd);
+	writel(OTGCMD_DEV_BUS_REQ | reg, &cdns->otg_regs->cmd);
 
-		dev_dbg(cdns->dev, "Waiting till Device mode is turned on\n");
+	dev_dbg(cdns->dev, "Waiting till Device mode is turned on\n");
 
-		ret = readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
-						val & OTGSTS_DEV_READY,
-						1, 100000);
-		if (ret) {
-			dev_err(cdns->dev, "timeout waiting for dev_ready\n");
-			return ret;
-		}
-	} else {
-		/*
-		 * driver should wait at least 10us after disabling Device
-		 * before turning-off Device (DEV_BUS_DROP)
-		 */
-		usleep_range(20, 30);
-		writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP |
-		       OTGCMD_DEV_POWER_OFF | OTGCMD_HOST_POWER_OFF,
-		       &cdns->otg_regs->cmd);
-		/* Waiting till DEV_IDLE state.*/
-		readl_poll_timeout_atomic(&cdns->otg_regs->state, val,
-					  !(val & OTGSTATE_DEV_STATE_MASK),
-					  1, 2000000);
+	ret = readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
+					val & OTGSTS_DEV_READY,
+					1, 100000);
+	if (ret) {
+		dev_err(cdns->dev, "timeout waiting for dev_ready\n");
+		return ret;
 	}
 
 	return 0;
 }
 
+/**
+ * cdns3_drd_gadget_off - stop gadget.
+ * @cdns: Pointer to controller context structure.
+ */
+void cdns3_drd_gadget_off(struct cdns3 *cdns)
+{
+	u32 val;
+
+	/*
+	 * Driver should wait at least 10us after disabling Device
+	 * before turning-off Device (DEV_BUS_DROP).
+	 */
+	usleep_range(20, 30);
+	writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP |
+	       OTGCMD_DEV_POWER_OFF | OTGCMD_HOST_POWER_OFF,
+	       &cdns->otg_regs->cmd);
+	/* Waiting till DEV_IDLE state.*/
+	readl_poll_timeout_atomic(&cdns->otg_regs->state, val,
+				  !(val & OTGSTATE_DEV_STATE_MASK),
+				  1, 2000000);
+}
+
 /**
  * cdns3_init_otg_mode - initialize drd controller
  * @cdns: Pointer to controller context structure
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index 3889fead9df1..7e7cf7fa2dd3 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -163,8 +163,10 @@ int cdns3_get_vbus(struct cdns3 *cdns);
 int cdns3_drd_init(struct cdns3 *cdns);
 int cdns3_drd_exit(struct cdns3 *cdns);
 int cdns3_drd_update_mode(struct cdns3 *cdns);
-int cdns3_drd_switch_gadget(struct cdns3 *cdns, int on);
-int cdns3_drd_switch_host(struct cdns3 *cdns, int on);
+int cdns3_drd_gadget_on(struct cdns3 *cdns);
+void cdns3_drd_gadget_off(struct cdns3 *cdns);
+int cdns3_drd_host_on(struct cdns3 *cdns);
+void cdns3_drd_host_off(struct cdns3 *cdns);
 int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode);
 
 #endif /* __LINUX_CDNS3_DRD */
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index c303ab7c62d1..6ea6839a2a8c 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -3014,7 +3014,7 @@ void cdns3_gadget_exit(struct cdns3 *cdns)
 	kfree(priv_dev->zlp_buf);
 	kfree(priv_dev);
 	cdns->gadget_dev = NULL;
-	cdns3_drd_switch_gadget(cdns, 0);
+	cdns3_drd_gadget_off(cdns);
 }
 
 static int cdns3_gadget_start(struct cdns3 *cdns)
@@ -3145,7 +3145,7 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
 		return ret;
 	}
 
-	cdns3_drd_switch_gadget(cdns, 1);
+	cdns3_drd_gadget_on(cdns);
 	pm_runtime_get_sync(cdns->dev);
 
 	ret = cdns3_gadget_start(cdns);
diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index ad788bf3fe4f..36c63d9ecd37 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -19,7 +19,7 @@ static int __cdns3_host_init(struct cdns3 *cdns)
 	struct platform_device *xhci;
 	int ret;
 
-	cdns3_drd_switch_host(cdns, 1);
+	cdns3_drd_host_on(cdns);
 
 	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
 	if (!xhci) {
@@ -53,7 +53,7 @@ static void cdns3_host_exit(struct cdns3 *cdns)
 {
 	platform_device_unregister(cdns->host_dev);
 	cdns->host_dev = NULL;
-	cdns3_drd_switch_host(cdns, 0);
+	cdns3_drd_host_off(cdns);
 }
 
 int cdns3_host_init(struct cdns3 *cdns)
-- 
2.17.1

