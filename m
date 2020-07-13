Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72F2C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E9520758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="HIiBhxAb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="SvywCx9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgGMKHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:07:35 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:2158 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbgGMKHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:07:35 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DA35kZ026888;
        Mon, 13 Jul 2020 03:06:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=/QkRZ+7XFtiDlo2uTG2+8Q8lBDudq4qciqIVSHspkGs=;
 b=HIiBhxAb9ssFfCn/AyrwRInNerTZQew/Vn+y70Uwvs+yWD4iEoX5bBb9bIksN+ZnPeoc
 7Gb+MTRQVEbF44Jm5148YYTReTDXi+wZOATHyRqo+xWGRhnkz8fjh9oFLWFAX/MIsACp
 zCn9ei4iLCGINDmOPZfNxXX67vRBXThS1206jgukYc3CDW99HGeFGK9HBotFM/W9daZx
 f1AIEXbfGnQ4Bdz/9nzvbzdB1HG2bDpzj8vpfpLbK/dRMxVsMMwaaOdHR4Y/XCO0bQTi
 ptGweRpTGTTNmivdAD39lD444tNXkG+M+G3RbQKFQghIVQRNMXfit1dAeIh8AkNXVMvD rw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3279yud6cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 03:06:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/uMIQyioIXlGdR6O0jRlU0lV2H5XpxD/MhDIeiICZ/jN31m4GqlXNWHrxZ0xBg98TucGQXC1JPqKOtEku5WpV/hTYBfRSaYslIjglCKvSdfK8pBhEsVDRWtjLvE02khFoGTkoibfo+QQNLtwVsc/ruUzFUTMi+oWgKKhYN0LkdVZZumwnSkqiEJOJ0wehcKUUzH17KjWsRPs/a9KQ9TESmlE96I0tPpYqRTMob3hMB+tyCDwGe2VIGsc7ZgDPvTXJC/g6YQQCTd8r2ATGLbJ6BH8FTgGRtx7JbYLeVaJVuULcEyaRKbfWBRZLdNt1CW2YqzuLqO4rJ/ALK87P6O8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QkRZ+7XFtiDlo2uTG2+8Q8lBDudq4qciqIVSHspkGs=;
 b=fzecAnM3PeK4yQQzHHTnfRR9oQvMElTbQredrt4OEqhiUbKh8pitAe/uDSr1Dv9F7jz328LaM968huY4OCyK1E3cNOsxh9NZvWu+4gpt1VYVH8WYuO3H771CXKptf9R5h0uYBbkNGpCWfzZhuDX6JPcq8R+bTdqM2xrGZBq/tueyW6c8hRc2XYN5G/xa+Th1+74xPTx09STGx9z9iJ17EsqvyJc8HtpmtNqYoMy2z++w3fip1/l95hj0o7K+bpjy7O4WypgSRIiR9j7ItYMP3bwzmMeIs6W41yEqQMBMVh3xTNuHZr51itgjqB6arEpha060oUNNdZuO6ys5jLo3mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QkRZ+7XFtiDlo2uTG2+8Q8lBDudq4qciqIVSHspkGs=;
 b=SvywCx9axVhFuu+YzWmh4gT5TgXIKMXAaYMmyawntufxlCvSMkT3d6wS6Wd1wc/Y60SsotA/6rh94qx4994jR5POcVfPcouy4/7XdE73BqtlHJXdJUYAAcz3z70xiyu81W/1hwUAzuF3HJ6vuCke/3Z9OsDiNvo9Dw1VElgeh9k=
Received: from BN6PR08CA0075.namprd08.prod.outlook.com (2603:10b6:404:b6::13)
 by BY5PR07MB7061.namprd07.prod.outlook.com (2603:10b6:a03:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 10:06:16 +0000
Received: from BN8NAM12FT023.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:b6:cafe::a3) by BN6PR08CA0075.outlook.office365.com
 (2603:10b6:404:b6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Mon, 13 Jul 2020 10:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT023.mail.protection.outlook.com (10.13.183.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Mon, 13 Jul 2020 10:06:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63Yx013926
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 Jul 2020 06:06:14 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 13 Jul 2020 12:06:04 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 13 Jul 2020 12:06:04 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA64nF028663;
        Mon, 13 Jul 2020 12:06:04 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06DA64W9028660;
        Mon, 13 Jul 2020 12:06:04 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 9/9] usb: cdns3: drd: simplify *switch_gadet and *switch_host
Date:   Mon, 13 Jul 2020 12:05:54 +0200
Message-ID: <20200713100554.28530-10-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200713100554.28530-1-pawell@cadence.com>
References: <20200713100554.28530-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36092001)(46966005)(70586007)(6666004)(86362001)(47076004)(8936002)(7416002)(2616005)(1076003)(426003)(42186006)(82310400002)(356005)(54906003)(83380400001)(4326008)(110136005)(316002)(2906002)(336012)(5660300002)(107886003)(36906005)(8676002)(81166007)(70206006)(26005)(36756003)(82740400003)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffca3a88-6c4c-4c41-7dbb-08d827146157
X-MS-TrafficTypeDiagnostic: BY5PR07MB7061:
X-Microsoft-Antispam-PRVS: <BY5PR07MB70610860B4EC13EA311D1C19DD600@BY5PR07MB7061.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcs20q17fdbOxYkHGQmsmeIU7HIKGS7PRfJTOHhBuhR8+3hTVYww+iv/wm+OWXBRc9jtmuhHNuTWj0ArHBq3hvbFSoGtc5ZE+EQPT2j6cTNU6OJ7zSxKMAT9rDBrTGiE6BTa9ZR7ssrF81tY4iWlaH3+tmozuXzYH3MxqqS5+CuSi/cx86vrt7ROUJLUr1df0MJH09YMqQe8uSZU9VAbZFpR0VZ4wovW3Wl6COdv1imJxregZzwHlo9QWRmOHGB9EpHQIK1LLS0IXBC7reMJRl7HwzeJIa7mLOl0iOlFFfZGjCwMdeUTkrD2k/iNHP5qitCK3i+JdIQ6TFCXGobCUtDj2cwnPnG9Hh0R+6CrGsEGxc24/cJ+wzjpN1AMUkV8LscQIHhESJjPnR0fHh0rESm6ei/xHMYpclkHTAQybS0=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 10:06:15.8598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffca3a88-6c4c-4c41-7dbb-08d827146157
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT023.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7061
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=990
 mlxscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130075
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
Reviewed-by: Peter Chen <peter.chen@nxp.com>
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
index d9dde624636b..bf1a7ac1cbfc 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -3015,7 +3015,7 @@ void cdns3_gadget_exit(struct cdns3 *cdns)
 	kfree(priv_dev->zlp_buf);
 	kfree(priv_dev);
 	cdns->gadget_dev = NULL;
-	cdns3_drd_switch_gadget(cdns, 0);
+	cdns3_drd_gadget_off(cdns);
 }
 
 static int cdns3_gadget_start(struct cdns3 *cdns)
@@ -3146,7 +3146,7 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
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

