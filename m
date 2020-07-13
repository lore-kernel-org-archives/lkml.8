Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CC3C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8398520758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="c++Il7tU";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="o/3zGxM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgGMKGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:06:34 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:43746 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729127AbgGMKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:06:33 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DA36GR026914;
        Mon, 13 Jul 2020 03:06:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=z9MJJMR3WCtRx/mkugId9tTgosXoT7u0dwHDi8yatK0=;
 b=c++Il7tURbmxdJDcfCbMgQ19+ASpQM+rZMTwdxsuxR9hlThxAZLquxQJV2zTmEtnapiv
 Bq4VZmQiKfz0dZ+WIE2M9/JXHIqoKSnFdbg+xSm7+8Lzd2BCQ8AZu34j8uuuWnSSyEx+
 QEf8W323nPxt3Kl+q/6aQHDM/jdgcH5T4c1Hl3h1mjnmLQ4so2kkJD6V2XAJe8gIrKNj
 HaFjSjEmIxwrs/j7NIrxp9lOe7Uca8otyaY/7v6HRJZW/iD1gHHxh+HLn1J59clkeic6
 Ci08TgM15n5A/25dNGAga1qF4gwz/Fe/nkTXDM/0e5rSFiaXTQlp9Hq+mRHhxwT2Y/2G Gw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3279yud6cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 03:06:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiBTJKjNR7WO1CwK3BTDCDeuOYoBEx4Ji9tf8szltnm0YeauAC7hTMkoQEWsHcNlOZvI8CHW0SzlTocAdzxAAVj09JQ/QkE5Q6oZmXudv3ddckz2ZKFsXvuCHVr9RzbecgvWR3HamI6MPqW1zLaERJDGCeIrrFEUTHUgIRAaiE9mBu3ljRbAdS+9eVjzSMqBCHWFloNfWe0a8kiM195Y9H3LtmGGPqvmzA0+9pezBv0WCwgZHOIUXYI0AyVLgK6I7j+8AEvgaknBOF+fRXeS2Bq0KSZzFwtu4Qtzhg2QTl7f40tpXxv2/o1GOrzCecXE43eX1vKWnpast93ePp/Qpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9MJJMR3WCtRx/mkugId9tTgosXoT7u0dwHDi8yatK0=;
 b=jTvuB2lCL1FhZ65OeL43Bta443V0yElkbxkKeRzp/ceSHGGNGyw0iLWW6MS4wVlOm9DHV7uJWdNo1MHejaKT3SUqRGFzdRXrI6Qsf0WruQT1GbrnCsNp5JN1yuFNlyxpUsg0LRzpoA9iqHMz+Dbe55XdKUJ+3OU86pjCOV8PpnOR86A7CUHg04EmfULWD8yomLLJb5Xjjpaaz0xn6RsZi7j+nJW8HaD+vPXDzUZBxwZqM3EnKPEXVZj4nCJwueZCAjf77HkhzUdiFkHzZlunvz4LYkdIebfccO3pdPggCF5vQbcHHXop3W6BZOY1Pr/2DoRIdvDcOZyGjmkcAkg50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9MJJMR3WCtRx/mkugId9tTgosXoT7u0dwHDi8yatK0=;
 b=o/3zGxM+oMxUMBfqRFILNjsc1QFxF01e8SqcfiFxERl/AWjAWhU+s9ECYKaVGrEFX1Pku77/YXbyoEM1tYaJDpxNT4cmrta8cQooIoKvFHWt4GG0pg8S9eDthh0wmS46x1vshJ8D9WyES2tziWOlmLc4L8LwF5x5HCUhsWLJ6ag=
Received: from BN6PR04CA0082.namprd04.prod.outlook.com (2603:10b6:404:8d::32)
 by DM5PR07MB3594.namprd07.prod.outlook.com (2603:10b6:4:68::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Mon, 13 Jul
 2020 10:06:12 +0000
Received: from BN8NAM12FT062.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:8d:cafe::cf) by BN6PR04CA0082.outlook.office365.com
 (2603:10b6:404:8d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Mon, 13 Jul 2020 10:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT062.mail.protection.outlook.com (10.13.183.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Mon, 13 Jul 2020 10:06:11 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63Yt013926
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 Jul 2020 06:06:10 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 13 Jul 2020 12:06:03 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 13 Jul 2020 12:06:03 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63b3028645;
        Mon, 13 Jul 2020 12:06:03 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06DA63DA028644;
        Mon, 13 Jul 2020 12:06:03 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 5/9] usb: cdns3: drd: changed return type from int to bool
Date:   Mon, 13 Jul 2020 12:05:50 +0200
Message-ID: <20200713100554.28530-6-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200713100554.28530-1-pawell@cadence.com>
References: <20200713100554.28530-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36092001)(46966005)(82740400003)(47076004)(5660300002)(8936002)(7416002)(316002)(356005)(336012)(82310400002)(2616005)(8676002)(81166007)(4326008)(426003)(42186006)(83380400001)(36756003)(107886003)(478600001)(54906003)(86362001)(26005)(70206006)(1076003)(70586007)(6666004)(110136005)(2906002)(186003)(36906005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6e88e59-8504-4a98-0d06-08d827145ed9
X-MS-TrafficTypeDiagnostic: DM5PR07MB3594:
X-Microsoft-Antispam-PRVS: <DM5PR07MB3594F07FDF58D33E5CD968E4DD600@DM5PR07MB3594.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QORibwCv1ljgeDoptmtBvO5DAPfTPyhInPBqxTfec/MSNWOk//vj6gPUYP7vgP1dNvuV/Zu+U8fcAyuqLWJNRF2OgTcNZA6+4raJCIrkpPpbtqagaW8Vx60bSc7zDJ55qKwonEyzFViMYTM6ITFVDPJhXxwhS2r27Wqrp1eMAJupS5LI0TeBRBNfkHMblklenC2JSreN9tceBymOjyxsIEHwkSdBI0BwEwJiTZS8BY3v4mEpOSM4YWGao/W/kFJov0869DjvvEGXDPqOgBpMH3ixUoNciJyjWEKBQIY7/qdiL8gjoXGImCfYDKPoL8RxBxXd1+43pjBGnuWZbk3tvKnuAqMAY9XTn1FdVbVlc5cwNMBPHxFHPdAbNxHiJ6SyQhKdN7XDvtFznvYtFO6ALosZCRavs47D0YzlL9UpPVk=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 10:06:11.6757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e88e59-8504-4a98-0d06-08d827145ed9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT062.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3594
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=724
 mlxscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch changes return type from int to bool for
cdns3_is_host and cdns3_is_device functions.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/drd.c | 16 ++++++++--------
 drivers/usb/cdns3/drd.h |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 05a9f7d54c46..6fe092c828b3 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -83,25 +83,25 @@ int cdns3_get_vbus(struct cdns3 *cdns)
 	return vbus;
 }
 
-int cdns3_is_host(struct cdns3 *cdns)
+bool cdns3_is_host(struct cdns3 *cdns)
 {
 	if (cdns->dr_mode == USB_DR_MODE_HOST)
-		return 1;
+		return true;
 	else if (!cdns3_get_id(cdns))
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
-int cdns3_is_device(struct cdns3 *cdns)
+bool cdns3_is_device(struct cdns3 *cdns)
 {
 	if (cdns->dr_mode == USB_DR_MODE_PERIPHERAL)
-		return 1;
+		return true;
 	else if (cdns->dr_mode == USB_DR_MODE_OTG)
 		if (cdns3_get_id(cdns))
-			return 1;
+			return true;
 
-	return 0;
+	return false;
 }
 
 /**
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index 04e01c4d2377..35b6d459ee58 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -153,8 +153,8 @@ struct cdns3_otg_common_regs {
 /* Only for CDNS3_CONTROLLER_V0 version */
 #define OVERRIDE_IDPULLUP_V0		BIT(24)
 
-int cdns3_is_host(struct cdns3 *cdns);
-int cdns3_is_device(struct cdns3 *cdns);
+bool cdns3_is_host(struct cdns3 *cdns);
+bool cdns3_is_device(struct cdns3 *cdns);
 int cdns3_get_id(struct cdns3 *cdns);
 int cdns3_get_vbus(struct cdns3 *cdns);
 int cdns3_drd_init(struct cdns3 *cdns);
-- 
2.17.1

