Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E04C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A90B20758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="AFJxSlm2";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="OXK6Sl9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgGMKGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:06:41 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:10254 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729659AbgGMKGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:06:35 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DA359s026892;
        Mon, 13 Jul 2020 03:06:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Yx/OstEb1e+mVzdVSn72cLU0gdYjamPLns9M36RHJTE=;
 b=AFJxSlm2w0FOLFUn5fz9OhRXGFBiGng+bw3da1hc6AEQs1Mz7LRa3fJ7WrZAdft0FArf
 9AknlZ4vK+E8SB8/22tFo38tQVGRA8suTeUAvKql/nF9DA0AUMMGhx/kbv2zPFAXPgRy
 T5duNq+8cieztQm+EncMRPrduLjf03U5NL9jOlMIeMe49XarnmZiibtxnaBK7oF2posP
 Uerg+ghQgDdwO1pCK/sf7oQ9x3ydDjNIc9qbDMmbOnWFe0ietpXpIH2mTNFcQ+dhOgAC
 YqLFun1xI1IjfXtAcdD6yuGHn4+emolAjO3GqCl9aanlt/zmg8UxUQI257jvHrz18gFF KA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3279yud6cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 03:06:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bk+YClGTVhyA5V16JUOvbbvnW1rgZmFxMLQvv5Crou/3YERUGUKvip67q70MsS8U9aGdc1dBtODaUERZcpIISI6ehN5S2dTgWZPiyW3UCYxkcUVanOFPvjnHql7Ynj5tecKmH3jHAwfSYXi8LD3rh9pGcmzcixkOc9YtbaY4uW2zLuppnvG+IQNSdp1ih+QZclOzwJ6BCCq0LGwHcF7cddbu6fji2CdfeSHppJOI0fFdYMVzacYhjjFBwBEVSC39i9lNq54lYyV8Y9y+g6DbksHdTrnurd2PYR5FhNC2j3xQ6dHM6oTp7Mn/ZSxUc9RBjcHyAna6FBSjgQYYMquJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx/OstEb1e+mVzdVSn72cLU0gdYjamPLns9M36RHJTE=;
 b=DzRPti6ePFI1sCWMFLGYxpAzR9cHoLGehX81K57QclrtoNYGfmcTcH02ENXkXTywm9HsusYOGGCspsF35F+Vy4jXHKdeKYV8DNGQpnuMq12sOjp0boAMvgA9mAq0fnbCaFfnL1yUkgN4zLxAhr0KvW+UB3obui/B/i62ABt9k98EZXwAXZmCHQ1uJpbEvP+w6XSvSxw+XNbD2WwFmD8ttGdRhAY5+idQ2BNtKb9V710We768nebW1Bb7+POH/g1pFOk3WeGvoTyVkLUp2N2lx/6o5+iI/7e/0vVlzc0Dp6G/mr3DtqN70mhWClCh4PFSAIF/uewcJLKYQAm8Gidd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx/OstEb1e+mVzdVSn72cLU0gdYjamPLns9M36RHJTE=;
 b=OXK6Sl9LCVeNpraMakA/4XnyGGiHKdWgEBgfL9bVqnTyhkJiLs/a/xX5p9w1QYh2ORqfSOqkp8R2s4qzHa+o72SofCPnlVs6ph1iyonINAkeRRkx+if3H2PnTa33hjOw9Fj7DwkL7DLFDrdtWfkFilfCLxa2IjQqwPSI/6HqRkA=
Received: from DM5PR15CA0035.namprd15.prod.outlook.com (2603:10b6:4:4b::21) by
 CY1PR07MB2668.namprd07.prod.outlook.com (2a01:111:e400:c610::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Mon, 13 Jul
 2020 10:06:14 +0000
Received: from DM6NAM12FT012.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::1d) by DM5PR15CA0035.outlook.office365.com
 (2603:10b6:4:4b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23 via Frontend
 Transport; Mon, 13 Jul 2020 10:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT012.mail.protection.outlook.com (10.13.179.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Mon, 13 Jul 2020 10:06:13 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63Yv013926
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 Jul 2020 06:06:12 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 13 Jul 2020 12:06:04 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 13 Jul 2020 12:06:04 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63du028649;
        Mon, 13 Jul 2020 12:06:03 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06DA63tN028648;
        Mon, 13 Jul 2020 12:06:03 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 6/9] usb: cdns3: Added CDNS3_ID_PERIPHERAL and CDNS3_ID_HOST
Date:   Mon, 13 Jul 2020 12:05:51 +0200
Message-ID: <20200713100554.28530-7-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200713100554.28530-1-pawell@cadence.com>
References: <20200713100554.28530-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39850400004)(396003)(376002)(136003)(36092001)(46966005)(81166007)(478600001)(336012)(356005)(5660300002)(107886003)(426003)(47076004)(316002)(54906003)(42186006)(36906005)(8676002)(82740400003)(4326008)(110136005)(6666004)(26005)(8936002)(36756003)(70586007)(2616005)(186003)(2906002)(7416002)(70206006)(83380400001)(82310400002)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47c7fedc-54eb-40db-c61a-08d827146028
X-MS-TrafficTypeDiagnostic: CY1PR07MB2668:
X-Microsoft-Antispam-PRVS: <CY1PR07MB26689E94F99F16BBBB448C57DD600@CY1PR07MB2668.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MF8CgGT2d+ZGA+RpX633TKV20joiX7dS18atP/YmrEDthuWlybCypnoN70s0nqbgzAJl4x15jQzFfRjE8AuLlOUm8TP9CfDV+SqJIVHVVMw82sfR4/nlG3a97KUTquk2KJzCC26ujMypuTUpYR26qK8VjPhxr2DKPwjRdlQ7Udj0aQz1VWPMWi9v+nXiUxsmXAzQmkr/JATDtBjfSfeVK5jsb4ykXaetuilBAfTjQvQ9Rl8dESx0XUhfTCphC0WkqPgdWyf4yf7XwcPo/fQKJqr5pAY4VzFHSq/ES0uGLk3dsp3WK9MkENWIdvaMdt74T4mXsGF40op9XIkyQkNcZBUAwabSkvHswMs8gw6tqbb0Kn4jC2abQOmmnUvrbSYtiV9K8YgxTfc9SkzLNEUx1Pporh+YU7762DGbTDezqUE=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 10:06:13.8329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c7fedc-54eb-40db-c61a-08d827146028
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT012.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2668
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=582
 mlxscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130075
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

