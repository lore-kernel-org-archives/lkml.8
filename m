Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1FCC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2B42177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Rtb4rhK9";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="tf+etT4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgH0QRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:17:30 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:15042 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726246AbgH0QRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:17:16 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RGC68A005481;
        Thu, 27 Aug 2020 09:17:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=haw2OBHXwd7ye1hOOPmK1JZScQbX6DBuZWIeL+AatGY=;
 b=Rtb4rhK9wSH1LMlqVDhXlF/LN5OnGS8W2XkL+MrapDPEvN9uehxmHKxnk7YLbZkfDNw7
 bv3Gw99XmP2IHZ9pv1T7cWpbYkOT8Gl3JuCSlo136SL7mz8LJ4PiJgFzyzbVi1LI/E8U
 LHzH7GtnxFdoYUVnZN2VWKbGqa5iKG5eXwGyEwuiHiJ7KamNKfJvWc4CrA/5ZIIOiJ4c
 r9MXGC+CG0EA2adDFYQIC5F+8lPls6A7mydBXWNYb5Lt42SlZMKEI7h7OO/inSso2gEj
 0qmDBHP6GEUmRuAQzCByP3AFSDSaiMLHj5CHWCmZIuSqWdbu2p62tuyFHfMRwvsKdmb5 +g== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332yww4tqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:17:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUTi5fTgjHMxyr9HH4b/+nvi9uK1Mcd6UJCkXP0aCTqyCI2gRG6wJVHeV3K6NFNQORrXLENzOflJabsStxeMFA00tKz0Fq+cGCJF8ZVSKlppiz+LeedbrdNBVSCMb2AHbtPKlto6lHBovUlNz4gNtVGW4aNnBgN/OnNPrgB4OAIeaaCSVxrOXybkj+H/Pci4G5JAEY4mlLyymIc3uwLJ2e6pVqc5xoPYHiO7cukQy0MnnY/FXb6vo84+M7ZQWvr9wjcgmqGUxPPRw+aKiVxA0MI5ZnK8QZFeB/A0tzaFL+HH6Ppo9XdRgumPGu92RfHWOPlzxkGpCGelYahZST3DxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haw2OBHXwd7ye1hOOPmK1JZScQbX6DBuZWIeL+AatGY=;
 b=MFL+jr7XVn00fM8ZlpRi3XFirYrN0zM36l+D86swBFXH058PLZnWknUJxxcW8iMDqVuhQv/+iaZRIrTtCjmrb+r5ZjKrKlLqtFITv0aIWjTs9ogk+CIQiJJUPc1l+IaRLET5Ur+MLl0ns/IFf1SZkwM0UrTJDkyCIMlXKmpm9+MJ0YS7492nnBEsTxjUs9IV8qf2rPEUalhaJYKT7XwLYBdgpREmQkSGZmLz92sx0KpAEEvfI3TgwQCo4LzujC9IuzZ3DPWU62IGb8Mi61tiYHpBR8PrwNyzyuRTBfsj5mgJAEcj7MlSal3Z1bTAMMdqakHHYVFL4xf8nIJUcLTAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haw2OBHXwd7ye1hOOPmK1JZScQbX6DBuZWIeL+AatGY=;
 b=tf+etT4wN2YnVXgLF9d80VdY4aM2vtfjZudk6bm4yrxH6+hQglRrY6d6uX5zD8apm6DZiiInOVHJAjTNjpnaPcn1w0QbWDmNYeXiiM9iqHQtqv/9keGefhbOBYGVWKNq+VVh4THrVTDZfphLIIeqT9cDaYjm8MqwmVemxnKg9Zk=
Received: from BN7PR06CA0046.namprd06.prod.outlook.com (2603:10b6:408:34::23)
 by DM6PR07MB4972.namprd07.prod.outlook.com (2603:10b6:5:27::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 16:17:03 +0000
Received: from BN8NAM12FT057.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::5a) by BN7PR06CA0046.outlook.office365.com
 (2603:10b6:408:34::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 16:17:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT057.mail.protection.outlook.com (10.13.182.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 16:17:03 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGquM016160
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 12:17:01 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 18:16:52 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 18:16:52 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGqqU031846;
        Thu, 27 Aug 2020 18:16:52 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RGGqUt031845;
        Thu, 27 Aug 2020 18:16:52 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 06/13] phy: cadence-torrent: Update PHY reset for multilink configuration
Date:   Thu, 27 Aug 2020 18:16:44 +0200
Message-ID: <1598545011-31772-7-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
References: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3732cab8-20ca-4882-5b42-08d84aa4a250
X-MS-TrafficTypeDiagnostic: DM6PR07MB4972:
X-Microsoft-Antispam-PRVS: <DM6PR07MB49726012D6FDB204B753DB86C5550@DM6PR07MB4972.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ls672u4AkJ3tFxuJ/uOhtmCGONM+TAE/r02BvJ7Bx1DiOpYq/J5CPzARGccTwopGZhZ3uATHxQsgrpWddMB2RihEQbtGYzhIdSBycsGaIm3ZwMpdMUKzpXSyaBP1jSkvbFvVU++OisudxOdT1x3lIt1vRAgbUs+KRzuIcXjUh2vKvHSud/6gSFwLT7khM1rPnA8ZCadTb/AZfQjtpY8EcRDMuNqjlD3Of6rMvU6zr5rzy5gqsdLmkLid+tclviuaMt1nPBUwN0Zw5lB9f8n42xWjhcYtP4Ky0xGFoUGK6tWZspSlMHr7ryRt5KfmVmLXtvOgJBukCkuHiclMtJ6bYrDHfcNEhyQIeQU3in9X4Uz8aHRmtn0DnGC3rD0dNDYBoMGOs5HpXHFgDybmG0lsMAKLYwh5ydhPwC0+7y5QBY8=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(36092001)(46966005)(336012)(70586007)(26005)(356005)(2616005)(70206006)(4326008)(316002)(36756003)(6666004)(426003)(186003)(83380400001)(54906003)(86362001)(42186006)(8676002)(478600001)(81166007)(110136005)(47076004)(5660300002)(2906002)(8936002)(82740400003)(82310400002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:17:03.0932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3732cab8-20ca-4882-5b42-08d84aa4a250
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT057.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4972
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_08:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For multilink configuration, deassert PHY and link reset after PHY
registers are configured in probe and only check link status in
power_on callback.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 28 +++++++++++++++++------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index fb49abc05445..56673806812f 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1603,13 +1603,15 @@ static int cdns_torrent_phy_on(struct phy *phy)
 	u32 read_val;
 	int ret;
 
-	/* Take the PHY out of reset */
-	ret = reset_control_deassert(cdns_phy->phy_rst);
-	if (ret)
-		return ret;
+	if (cdns_phy->nsubnodes == 1) {
+		/* Take the PHY lane group out of reset */
+		reset_control_deassert(inst->lnk_rst);
 
-	/* Take the PHY lane group out of reset */
-	reset_control_deassert(inst->lnk_rst);
+		/* Take the PHY out of reset */
+		ret = reset_control_deassert(cdns_phy->phy_rst);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Wait for cmn_ready assertion
@@ -1623,6 +1625,8 @@ static int cdns_torrent_phy_on(struct phy *phy)
 		return ret;
 	}
 
+	mdelay(10);
+
 	return 0;
 }
 
@@ -1632,6 +1636,9 @@ static int cdns_torrent_phy_off(struct phy *phy)
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	int ret;
 
+	if (cdns_phy->nsubnodes != 1)
+		return 0;
+
 	ret = reset_control_assert(cdns_phy->phy_rst);
 	if (ret)
 		return ret;
@@ -1886,7 +1893,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	enum cdns_torrent_phy_type phy_t1, phy_t2, tmp_phy_type;
-	int i, j, node, mlane, num_lanes;
+	int i, j, node, mlane, num_lanes, ret;
 	struct cdns_reg_pairs *reg_pairs;
 	enum cdns_torrent_ssc_mode ssc;
 	struct regmap *regmap;
@@ -1989,8 +1996,15 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 						     reg_pairs[j].val);
 			}
 		}
+
+		reset_control_deassert(cdns_phy->phys[node].lnk_rst);
 	}
 
+	/* Take the PHY out of reset */
+	ret = reset_control_deassert(cdns_phy->phy_rst);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.26.1

