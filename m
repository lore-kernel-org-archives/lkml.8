Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2FEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2871E20663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="SZuVH/5T";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="0T1mrLfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgGAGZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:25:15 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:21100 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbgGAGZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:25:15 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0616FfFA012554;
        Tue, 30 Jun 2020 23:22:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=z9MJJMR3WCtRx/mkugId9tTgosXoT7u0dwHDi8yatK0=;
 b=SZuVH/5TVUzVeqD4HjTflunAre51qNpEHEe64n2HEhWjbo/2Puwr94NFYtoRYg5dZ/l4
 PFegOdUgRrBoD90Dv+xDMtzzM/9XMgOd7n/NkWsgvCg/I9IVmTPsutsGb1hyVrF+Xu16
 vbhFyr2nfF41uSmI0HRMr7tFoLUXKBl7S9p6kbPTqxNeHoimMDa2AkCU8o1iIlBKPNs9
 0S4yw+RZf6/3YXCly2fHK0vJVoOFRnaA1x41Qb0B+5TZs5iL2pAFGP4YuH8lGJ1XOFsG
 d6JkD41YFoq5dkBQeX6bp3P9FddZPNTzk6oLtpExkqL7SKliqkgwgRkXEmRCTwF6hM4C yg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0b-0014ca01.pphosted.com with ESMTP id 31x1pyq6s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 23:22:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDbYfKfpDaN5DXiUNBTw9iUYtNkWwPoYyupLI1af7ETrnR5veaExolME3TloqETCt2XE+lAqSuT9E3n5dXerb9AGEDbyKbiag/OVtLEI99V/aJQl+5fLTkVl+qa83mYuuU/6f6SUvl1tggspYm3CJGJw9LmxArFwL5zTLjFYqkc32TmyuXXFvsEMyYRc6eyKyeMY3EQqCtXXsz9+/Ner3PrnLD6ifUoeu8dEwu7pRmw9TEjtBJHzVQaJK9ZEv9YzAgVkqgDIgpysT3gSZfUM3ETr/CS/7hYr1TXXwmQaD9BJR0ZDjhDkf8pjtnPI42LZUI1wbzTlytmXz3h7MMb7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9MJJMR3WCtRx/mkugId9tTgosXoT7u0dwHDi8yatK0=;
 b=g6US9ro40w6dgoe/AfqZKLj9oCCaT0I+vv7aU59wT9leaSODbx23Rw8xdgoNaExxj9jAVVlSW48fig8Y7lZiXFbjJzC8egRG1ylXp3v1KWqBzhMEDuFPP4ORJfdwxr0N3R2RBDforYoMBdKUdE/3F5kCXa5DtR4zLcYN5CtSGJbeAQGRn1yT5eQZbui2KlP8RzlnrstU9eJgZqpSa65icRqJ0Lw2fbQFG5/Es7SDBKhZIaeDAVmgCx6DKAWB3mM9Cih5OaDVcEju8yQD+oNnLH0qbnP2tAm/qKmitZqWbtGYHk/kO4Gz7y1lr+FuMqyWnpaOebct8ZS0vV/dGpSktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9MJJMR3WCtRx/mkugId9tTgosXoT7u0dwHDi8yatK0=;
 b=0T1mrLfI1uPKd4R+0rXGHl17tTHOvfUxN7V7PKgndDR20Rw0JMlUS8S7biqkLdAM068nTBcqOgNUJYPrcxWbOMBoqMloWmuIuTVCPK4DIR4uyhr+Bk1CQA4h27Nl5nyFaE1keRuiE48eJXABC4WGgY6MCUN7/Ugx4bvl0swittI=
Received: from BN6PR03CA0071.namprd03.prod.outlook.com (2603:10b6:404:4c::33)
 by SN6PR07MB5632.namprd07.prod.outlook.com (2603:10b6:805:e9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 06:22:52 +0000
Received: from BN8NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:4c:cafe::2a) by BN6PR03CA0071.outlook.office365.com
 (2603:10b6:404:4c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23 via Frontend
 Transport; Wed, 1 Jul 2020 06:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT019.mail.protection.outlook.com (10.13.183.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.17 via Frontend Transport; Wed, 1 Jul 2020 06:22:50 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0616MjiR092304
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 23:22:49 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 1 Jul 2020 08:22:45 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 1 Jul 2020 08:22:45 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0616MjS2030603;
        Wed, 1 Jul 2020 08:22:45 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0616MjHR030602;
        Wed, 1 Jul 2020 08:22:45 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 5/9] usb: cdns3: Improvement: changed return type from int to bool
Date:   Wed, 1 Jul 2020 08:20:00 +0200
Message-ID: <20200701062004.29908-6-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200701062004.29908-1-pawell@cadence.com>
References: <20200701062004.29908-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36092001)(46966005)(4326008)(6666004)(2906002)(83380400001)(36906005)(316002)(42186006)(110136005)(478600001)(47076004)(82310400002)(356005)(82740400003)(81166007)(54906003)(107886003)(5660300002)(86362001)(426003)(70586007)(7416002)(70206006)(8676002)(26005)(186003)(36756003)(8936002)(2616005)(336012)(1076003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f294e33a-7bd4-45c4-82af-08d81d872e83
X-MS-TrafficTypeDiagnostic: SN6PR07MB5632:
X-Microsoft-Antispam-PRVS: <SN6PR07MB563256274CB7450AACF3D35ADD6C0@SN6PR07MB5632.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkuUNCnc+7Yq9MdoyEMI8Zn7jsOteRERHTYJXjdAG6quHCn9Um9vwdr/aZSsN6jOqViel40b6tzO7DIiUD9r5UU3uQAojzIWedscbvajRMZm1npdPzLvGhWSEnarLq7S4TLoJ0dB+hRxQjyZvel1lcqFiOW0r/sKFKocmDoukSDGKavWVSRzeeiT3Fih5RboPcg6q74Ug2pdqleoP2v4ITAFJW7dB9VMM0Fx5jcCYCHReq4MQUJlEM4/FyQREijXB3WAhyBlFxKm8wGdw3ae0WQlOlxNEXv1pn2U8hTETRtLBdbmPmanvpwvm0IJM+zfFFlxsPCGaP5k/txzTGLa6uVmmy0aylEfbpZdtDUUY92mP7OjpOS+1RQxVzxIaJ3Aiq6XY+aXxhakk+bZnLzwk0oeaYsyY+WTS/as0Q3adpA=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 06:22:50.9557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f294e33a-7bd4-45c4-82af-08d81d872e83
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT019.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5632
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_03:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 malwarescore=0 cotscore=-2147483648 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=774 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010045
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

