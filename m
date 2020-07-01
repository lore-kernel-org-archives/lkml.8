Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AD7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6B720663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="S1EhlMI9";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="UPjH4Zgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgGAGXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:23:14 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:1278 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727071AbgGAGXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:23:13 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0616HC8q014545;
        Tue, 30 Jun 2020 23:22:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=kpI9AXyfpjA4dbJZklM0CwGjby9vJInyNJP4bZPsXDQ=;
 b=S1EhlMI9mgNf4ZMR4MYzuLSt4SUlFZohJtZElzvrPXwUKlk7m5GpAMxTtvhVbvmJxSyH
 2fteLy0biTaSQClkXDRIeiLFDiyUk5WctGxLtKaUCJfXwavdZkTuLlWYyusv2nHc3fyp
 33CXG7BX7USTUbnZYZhonGXQaMpRMwL+kjXZSSp3poVglOpMG2f46hy/+DxByjsD6z/f
 UUktcb5EEuOKCXcU4KjnbEY492JzmEY7dQrE/0sIOMFIDo1ZbCBtoquE6dHQnnedZjyN
 V4ShjUX5IWMtysJUizYQx5JvemIqRV7IUtNh+9iXdrm4LpM25T677CWOxi0n3KGXkpLU RA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31x2nxxa8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 23:22:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJFauT391Vtc3VHdGiYzarf0675KbS/8hALnCdkZI0j0iUIVBpRp0JJGz7NeshX44xXhw7hLLRwb2W8D2fRfm5pZspjChYzHkZUHprv1hJd/9cHvttBSsbUhjko/SBgcfrsEAHmw5ezlsJ6KLnFlkKMCR+CxGVB4mxuZQZXF3hc5FOsdbGam3BRM7QIVEdwlU2lxSXWENdiWLxBylnoO9F0/eNyTeTDJS6M0Xm3ZaUKmyZAg7jBSyPwQ0Ue9ZX858QS2bZr+12qbjDp015lJSdrO9H39u8optlCtWdTc9Ulxa8vlgDvwZMuOKhdN9tlGkYVMeZRq08hZfR5kSFmXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpI9AXyfpjA4dbJZklM0CwGjby9vJInyNJP4bZPsXDQ=;
 b=U/ais9Gg40BsRcVGo1dE0GX0M1VUUL+dYC985T4lgaxwhWrheLkAD5AO44BmK1qVXM6VNMEhuyjhPpR4TSaTeyAEazzETI8ZSULVgjOLEIHlXLSqZbQmaq3X/OIKBbYlYoJSLGZ6iP2Jcxp91SGp+3XeMl+Cvu0TJYkvp78YC6Ii3YlqEA4050snMfeU8/EdN0D/PdTX3Kl6z5PY4qMhJWPzZx+68z+2yItAuqoqKE8nK84HVzmw+YsWJ96iSFUEZzJG5adr/YpslPbxu8hFivHtRkbxnDkFumMB3236lNBOMMaK+95Xp9LPkDvxkTkVxnx/OmC+kQmjGwz59mvEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpI9AXyfpjA4dbJZklM0CwGjby9vJInyNJP4bZPsXDQ=;
 b=UPjH4ZgiDY9uWAp5wwebAFNGMY/T/kirqeXwLV2bX5YH36Oms4Z4QzIVtb5W2/rA/pwcm4S1h+kQrQu7ZMaiNDwbAfXXibsiNuoeYbwbv3teZVpPJ115VmL7N2xXgfoMXXj1z8BPv62mNnt9plIRGhMxspgFH1/2otBGEYvqHxo=
Received: from BN6PR2001CA0035.namprd20.prod.outlook.com
 (2603:10b6:405:16::21) by BYAPR07MB6312.namprd07.prod.outlook.com
 (2603:10b6:a03:118::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Wed, 1 Jul
 2020 06:22:54 +0000
Received: from BN8NAM12FT025.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::ab) by BN6PR2001CA0035.outlook.office365.com
 (2603:10b6:405:16::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Wed, 1 Jul 2020 06:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT025.mail.protection.outlook.com (10.13.183.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.17 via Frontend Transport; Wed, 1 Jul 2020 06:22:52 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0616MjiU092304
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
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0616Mjvj030615;
        Wed, 1 Jul 2020 08:22:45 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0616MjXq030614;
        Wed, 1 Jul 2020 08:22:45 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 8/9] usb: cdns3: Improvement: removed overwriting some error code
Date:   Wed, 1 Jul 2020 08:20:03 +0200
Message-ID: <20200701062004.29908-9-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200701062004.29908-1-pawell@cadence.com>
References: <20200701062004.29908-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36092001)(46966005)(86362001)(2616005)(5660300002)(36756003)(42186006)(1076003)(426003)(110136005)(4326008)(6666004)(336012)(36906005)(316002)(54906003)(8936002)(81166007)(83380400001)(2906002)(47076004)(356005)(82740400003)(82310400002)(26005)(7416002)(186003)(478600001)(8676002)(107886003)(70206006)(70586007);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1b33b78-872e-416b-5add-08d81d872f66
X-MS-TrafficTypeDiagnostic: BYAPR07MB6312:
X-Microsoft-Antispam-PRVS: <BYAPR07MB63123A77758098C195D1538DDD6C0@BYAPR07MB6312.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CoscXcAXH16AxEHZBbOOeskD5P5bFV/Jq4X+8qP382SUFb0E7mtfPCXjkvXdlXSPPNMx7rxMAKcYZWm4xHLsRv4zuBysleYPGge+FNa/bTpU8HkirT86p8EPEcSVzwOQ/X8yYcE24UTMWBPRJyeCkI+4so1scotlbvVI7P/5Zb432cW9z4X6wf4E/hNOkuagtEIMJaSJQYa9mGKtyM8nVnQvn0Jloko/SvjueJNp7ke5aeOjJj7Vj6WuMi3f8lDDRV+9FrdEHrxpIikm0e58dxXiBwu37QPP+owoVuDZtmh+JdJO9U9PaVK3RiqFARUrcqY2SrqSL9Zd5IkXhZrfS2cKZzC8sKjfbHaJ+PAwSh7ZCi7NsQ3MNuxV4d4bigrWBaXNc8rXL9ZiVEUU2/CHHSklJRs31psIIbXX8zhE01w=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 06:22:52.4443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b33b78-872e-416b-5add-08d81d872f66
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT025.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6312
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_03:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 cotscore=-2147483648 mlxlogscore=951 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some error code can be preserved, so we can remove overwriting
error code returned by some functions.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 591186987245..01155ab73930 100644
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

