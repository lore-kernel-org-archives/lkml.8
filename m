Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDB4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DA520758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="c4dXY9VV";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="pKXWE6r9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgGMKHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:07:00 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:37664 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729408AbgGMKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:06:33 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DA35kY026888;
        Mon, 13 Jul 2020 03:06:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=WuwGkilP8meNxX/PwAO2woJ8oPynNV3zJrfeWhpzYeM=;
 b=c4dXY9VVqWnoTIUOVtMKMBvBppSZKN4eUMjJp+xI5IxjFGMfPniYDRN7QSNQtssOzIiV
 NDd8EUqI6NG8Nod7aDdkzoqkaGXp+kc4Nq6DJjuL15K7942tqEAuv3ga38xThgS/ZzBs
 ZQxcU3cCtynbN1lEVrtEqCXTxTfJ89WuvdctHVkJIqgiSOSTaXBodYxTAonD/zvXbJc6
 Qgz0+kKtR9Yfb6fSR/NRMXUQdRwrvJZOTbUT0hnnX2tpMqrLQTDY1VI7dkvhVa+Xoyr1
 wx41elHFEaXPXgyv6JRck1mXxF4xcpuyfFCxzanBm5RtlOwmES+Lr2ux9XtseT3rkNvG Hw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3279yud6cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 03:06:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qhd5mPaZqI8aPjg/eVOy69wfUuWX5skBmyn/Fybj0ck2vnMujRAUdnEqlsxTQK/+c8MBktU1Rdwdip8y8/cZLrTq89EjJlNuqfTf+OZY48+R6o5W50OJCRcGzyhtZhbfPdbqxX2MdpoHNOHBVvEBp1LaBSDckqop6iOMvMxR7EairTIedStG849u9S5L6VvAR3GsK3ee9GPs/iP+pdpDreogW3pSkagqrqU52OuTpTkAIsgiTWSYsvlNK4J1mIEmXhmkDfUm1zQCqNzQUEVSIW8QIRP+rdqPi0T73LmvXIassSyW3O9MwbRNJQkqwhP/ilv9o676Wh6wdTkGpwYBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuwGkilP8meNxX/PwAO2woJ8oPynNV3zJrfeWhpzYeM=;
 b=GXMBwyiJbFs4qpg/wzsvoNWqPJXIp+ev0F3E/7hNnMW1ejfzPF2d6MPlW8V7x3BkBhEbkc33C6yLOeJBsoezf+6MhvKO0T/zJ8TDkEaWcQr2phYezsbi4cqvqkTr8abhz6aJwDOd175XW+c/tJIHN8TydUbYvMdYjaXiQv/LKZJzX9B47LVGp7az384ZPzAuKYM7n/ECn2w/xyGUvQ8jlzdLZ54wz2PE8TE9l22QQbYy4n32VC+QV4SIqBNrw2vZoVXjNSmxiUS/pXsuDWnhd2xWhQCcPtIimdYONtFzUGH4hDshCFNC4KvAvD1DViDxY0iAAwQF4X3DtpKmPQ6ptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuwGkilP8meNxX/PwAO2woJ8oPynNV3zJrfeWhpzYeM=;
 b=pKXWE6r9EeZc18tMG53lePWORb/mq//WQNa3Vc9NFCOLDfGpoBwWguLOU6r38C/hklI1Eja0H3JBz/AftEnUxi4JlgX5PpHIgAv/Q4zaSjBW2gCQnq6q5beFrnp0onNHLS7s/LvBKuJljEsZQxx3kzcxlu1ItLhnh1bT9vDSJCg=
Received: from DM5PR20CA0002.namprd20.prod.outlook.com (2603:10b6:3:93::12) by
 SN4PR0701MB3647.namprd07.prod.outlook.com (2603:10b6:803:44::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 10:06:15 +0000
Received: from DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::a4) by DM5PR20CA0002.outlook.office365.com
 (2603:10b6:3:93::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Mon, 13 Jul 2020 10:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT016.mail.protection.outlook.com (10.13.178.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Mon, 13 Jul 2020 10:06:14 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63Yw013926
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 Jul 2020 06:06:13 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 13 Jul 2020 12:06:04 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 13 Jul 2020 12:06:04 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA64MJ028657;
        Mon, 13 Jul 2020 12:06:04 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06DA64M4028656;
        Mon, 13 Jul 2020 12:06:04 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 8/9] usb: cdns3: core: removed overwriting some error code
Date:   Mon, 13 Jul 2020 12:05:53 +0200
Message-ID: <20200713100554.28530-9-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200713100554.28530-1-pawell@cadence.com>
References: <20200713100554.28530-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36092001)(46966005)(86362001)(8676002)(8936002)(107886003)(1076003)(36756003)(5660300002)(70206006)(426003)(42186006)(36906005)(2616005)(316002)(7416002)(2906002)(6666004)(82310400002)(82740400003)(47076004)(110136005)(26005)(54906003)(70586007)(478600001)(356005)(336012)(186003)(81166007)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8402f618-c86d-411c-1b47-08d8271460c3
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3647:
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3647DFCE3E68270BD32DA006DD600@SN4PR0701MB3647.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BrS3l6B8rDXt/PptkKrNMenXzQDNolzwEvhrIWCfDyyqCigorJ1M8uuenKkA6kfUwJt19vCbxkfdHcdSF5Un8NTNRJtKZ2Lnau5cUTPFGQRae6UHocijTntr0p2LhsE6saFFyAMdupKgtK5BjVY7iXFKPuDT/3fKCysAAKC5GkwljlKnplQ61AbdzegoirQ0+5a0/6eFaSU9fKjlEvirZr8LIfOI9WKJmtazkT7erIY5cqFmzUp2qhh+dIWi3GghXoOC3XqzmjVKF1iduKOumYgyElcqeACmy3Cn9f+ScaS2yvvp3KO0jlvqWAhUEGW9mXHUtN+v3N05g8cpl7aRrC3DuxFIb5FT+VqfYcKtUfweYO0sVLTxWMS6uwj9liHYG2X6JuGTbZW9kdGAGebnpBQQGnrig2QWdqQZ2xonzmg=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 10:06:14.8483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8402f618-c86d-411c-1b47-08d8271460c3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3647
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some error code can be preserved, so we can remove overwriting
error code returned by some functions.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/usb/cdns3/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 8e3996f211a8..72885c5edb09 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -347,7 +347,6 @@ static int cdns3_role_set(struct usb_role_switch *sw, enum usb_role role)
 		case USB_ROLE_HOST:
 			break;
 		default:
-			ret = -EPERM;
 			goto pm_put;
 		}
 	}
@@ -358,17 +357,14 @@ static int cdns3_role_set(struct usb_role_switch *sw, enum usb_role role)
 		case USB_ROLE_DEVICE:
 			break;
 		default:
-			ret = -EPERM;
 			goto pm_put;
 		}
 	}
 
 	cdns3_role_stop(cdns);
 	ret = cdns3_role_start(cdns, role);
-	if (ret) {
+	if (ret)
 		dev_err(cdns->dev, "set role %d has failed\n", role);
-		ret = -EPERM;
-	}
 
 pm_put:
 	pm_runtime_put_sync(cdns->dev);
@@ -393,7 +389,7 @@ static int cdns3_probe(struct platform_device *pdev)
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret) {
 		dev_err(dev, "error setting dma mask: %d\n", ret);
-		return -ENODEV;
+		return ret;
 	}
 
 	cdns = devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
-- 
2.17.1

