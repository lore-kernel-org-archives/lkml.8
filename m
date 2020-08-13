Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8BAC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4329720716
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="iCnfxsF2";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="riCPLfxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHMHMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:12:03 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:41382 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgHMHMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:12:02 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07D78QlD004458;
        Thu, 13 Aug 2020 00:11:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=NLKHHLtcHycL7y0952artV7D3TdCAL8qifpbwRHEavQ=;
 b=iCnfxsF2Zr/SM3IMT51eio5/sL2AzVdTTdBfnvNZjoly3zbUbYl5Qk+NtN9PARs5GIj1
 VLwQVyZgwc/WR50+NM8549Z6Zll2Z47bmmU22C4lUJVNf6vkjw/y0k0vDs5RUX7UwRvd
 Y4QCB0w3JvOgSmUY5yITwjYYjp3WvhgyAwMAeugihjVbjQ4yAxeXLHOjxii8CyBjORkQ
 BoVo1eCWjXh5gRfCoI6YVr2HVURL65dEthnKVHWvvxobR1UQSKGx5okiYHRpJbxMeWzw
 0fODZUUIWAcfyPf96I/tFsC2SD7X6KDga5OJ7SAPsbTV8J7DR9okn4Qbimev3fM18+nC 6g== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32srkw8dty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 00:11:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cmg5AZEGlxa4nncbLfCK3Z9/2v4vCKNDJJbLpAYszlgjHdTyUi1HyDeEj6mVfdhgM3CpLrJ79CYsOuIMeqAV3YDgKdktZSDkkvCIe4DAMFjb2vbtOgFlrx0i2epUqgbFRUTc6ja2lcKpb1GjIEA1CJiEkVKMewg1fZytB//ak1rg2Nj6ORHQXKiWYNT6e/UrMwAc5vPJiOajKVOjSvXg55RLpPYmHxBw1G9jfSfXBJjNJMaGKWzzVXzcLM/r6jkTh4qAFRaia7c+RrqgiS7igGUiboTIFLclU/oF+WJD56tkap7fISeZVRh5K9TcOQanA992Bf4NCo7f4KBklrfHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLKHHLtcHycL7y0952artV7D3TdCAL8qifpbwRHEavQ=;
 b=R1K4bHZVyGXd1fYX+8crnZm39ld7mJlo7+kQQ3qF63kovTtTbAdMNHTxaJlQqy4ldb8/zYwjUaGPtE96nTa14rnRcTx+0PDFVuP1s7/Kiv91grKpBrdISydPkKXo527zihKnNd43HQMbYbYqUU9DRrKqSkrqTxAxSkKgCgUOl2Ze513Nf/dRqVxVZYyObjyWayH1lYFuS2G8HGzHDMTw6+1qSCq5KOSQySWNd5lgJFVCT/ialoyViO8CzgbmB6Z/W96ayH6OyJMs2AlPISojDOnObpatgNwsqRJP5cu1aKs7avxKFe0QOuMo/lSPjYa2HV3+1FkMKiy9KX6XidmZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLKHHLtcHycL7y0952artV7D3TdCAL8qifpbwRHEavQ=;
 b=riCPLfxNIa1q7zeRctruCdGyNsAGDtwv0uAPTSOXt2RAwa3JDuAL0Abex4YqprlZlvSnFrEFiSavAV6z6ivwILD3sOn3vgX0XlfH3hVotd0p8gNxomRiU2Fw/zbmsZUd4ueC9EYkgzicVjCjNV90LZDl9Z7koJXj3/jOHorhnJM=
Received: from MWHPR20CA0031.namprd20.prod.outlook.com (2603:10b6:300:ed::17)
 by BYAPR07MB6151.namprd07.prod.outlook.com (2603:10b6:a03:11f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Thu, 13 Aug
 2020 07:11:41 +0000
Received: from MW2NAM12FT040.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::c3) by MWHPR20CA0031.outlook.office365.com
 (2603:10b6:300:ed::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Thu, 13 Aug 2020 07:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT040.mail.protection.outlook.com (10.13.180.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.11 via Frontend Transport; Thu, 13 Aug 2020 07:11:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07D7Bam1031745
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 13 Aug 2020 00:11:38 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 13 Aug 2020 09:11:36 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 13 Aug 2020 09:11:36 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07D7Bamb025936;
        Thu, 13 Aug 2020 09:11:36 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07D7BZBO025935;
        Thu, 13 Aug 2020 09:11:35 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>
CC:     <rogerq@ti.com>, <peter.chen@nxp.com>, <weiyongjun1@huawei.com>,
        <jpawar@cadence.com>, <kurahul@cadence.com>, <sparmar@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb: cdns3: Removes duplicated call to the cdns3_exit_roles function
Date:   Thu, 13 Aug 2020 09:10:54 +0200
Message-ID: <20200813071054.25837-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e55b736-bbfd-4724-15e9-08d83f582069
X-MS-TrafficTypeDiagnostic: BYAPR07MB6151:
X-Microsoft-Antispam-PRVS: <BYAPR07MB6151E7FAE955D6DC997D552DDD430@BYAPR07MB6151.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcUMacY/833DyKywzwMjEAz6BnyTpfVroPr5bEvrPSBnnrRO2eO/WQBOScHs0sIVza5lYa7bcMz6RwXfuyFpQMfcNTJDIYyH0kDlxpJerRHYDy2RbKuVxE+mcVkprBcwaoogFXjh0O3Z5/Jb2EqxstXmiT+XCiPJss8ajfc3a2lsFgLFtOacqgMlbELADnxdy3phEKbTZ5T9i+cvYT9hzN0EbcoOlQYmmT7TcdvdWL9m8AC8Njj7LPa+gBlX8BxKTYXfFjZYBSgdgFX2jCLH2wZvurLG36W6NzpwlASojEoej4FDp5Yf6fg6+qJrsBEdKmPtRIjPOKZCtJXWwqIvn6b7ndtc54WNB1D/+1WyrHz5o0Hn76rGeZJY5xeOcXHH9HCrpoB4wl6Fq9aEKTgxdrSzTC3xVSbdMUOaHAFDJgI=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(36092001)(46966005)(86362001)(70586007)(8936002)(336012)(107886003)(83380400001)(36756003)(82310400002)(70206006)(2616005)(426003)(1076003)(26005)(186003)(6666004)(2906002)(316002)(47076004)(7636003)(36906005)(356005)(82740400003)(4326008)(8676002)(110136005)(5660300002)(42186006)(478600001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 07:11:40.5715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e55b736-bbfd-4724-15e9-08d83f582069
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT040.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6151
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_04:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=706
 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid double calling of function cdns3_exit_roles when initialization
failed patch removes invoking this function from cdns3_core_init_role.
This function is invoked again from cdns3_probe when
cdns3_core_init_role returns error code.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/core.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 5c1586ec7824..c22c7224642a 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -132,7 +132,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 		if (ret) {
 			dev_err(dev, "Host initialization failed with %d\n",
 				ret);
-			goto err;
+			return ret;
 		}
 	}
 
@@ -141,7 +141,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 		if (ret) {
 			dev_err(dev, "Device initialization failed with %d\n",
 				ret);
-			goto err;
+			return ret;
 		}
 	}
 
@@ -149,38 +149,34 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 
 	ret = cdns3_drd_update_mode(cdns);
 	if (ret)
-		goto err;
+		return ret;
 
 	/* Initialize idle role to start with */
 	ret = cdns3_role_start(cdns, USB_ROLE_NONE);
 	if (ret)
-		goto err;
+		return ret;
 
 	switch (cdns->dr_mode) {
 	case USB_DR_MODE_OTG:
 		ret = cdns3_hw_role_switch(cdns);
 		if (ret)
-			goto err;
+			return ret;
 		break;
 	case USB_DR_MODE_PERIPHERAL:
 		ret = cdns3_role_start(cdns, USB_ROLE_DEVICE);
 		if (ret)
-			goto err;
+			return ret;
 		break;
 	case USB_DR_MODE_HOST:
 		ret = cdns3_role_start(cdns, USB_ROLE_HOST);
 		if (ret)
-			goto err;
+			return ret;
 		break;
 	default:
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	return 0;
-err:
-	cdns3_exit_roles(cdns);
-	return ret;
 }
 
 /**
-- 
2.17.1

