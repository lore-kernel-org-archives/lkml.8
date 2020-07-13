Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E332EC433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1CE20758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="OawPxiUl";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fjrgGLn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgGMKHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:07:02 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:12856 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729534AbgGMKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:06:33 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DA2AxK014732;
        Mon, 13 Jul 2020 03:06:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=WZbSnjFEtsMI79U8CC7OJlmRdFqJ7SekbuTf/tWMDME=;
 b=OawPxiUlw7kMvxDhabpgQSDQ5o67VnI97ZTG6v1KE30SLUXtlSoJ3Hf+A6tjSQH+hqHD
 wt7e4IUGkZlZnpJ9bWdw3fICYmQ6q9URZolpvpgjeoq3srz/JeFALjkfLyulbeiY/m1+
 3hBEQ+VGOzOwEla+YfyWe+Hfuw3W975vAWI3wAyVbApWUB5W68QJjQcFa4TRlYrowA/F
 5dF5MN7D6rglKF1TsrhQYLPklrc/bBqWxc8vH2ibBJxNFPFZs6OR9xZ+1uT5UrSNEAto
 v9IthEg4KabZsx1jgDM9MLqXNZLICRiJz8DtKMaTNXiWCZkF+25ieTL0S4WQKA9ICdZg 2g== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0b-0014ca01.pphosted.com with ESMTP id 328ftugxdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 03:06:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUVVcvZ+95iNXMRD1bNGpuWHlg0Y7mizMXFM5pWcOWfGr6o/WmtxzjIH8EDFooMWHGji4gd/jigkoKRQGrKk1dZjodvhF6UDG65Mq9xrUBwmmfEbhrth7O9849Y9BmIWaXwXVvjPRYAKusms+CclsMWEK027iRQ0hEV3VpB1oVYCDk9ec8eCG3+OWTASZXHvfCutRp9CFA5vfw5ev/qMPdYcHZoFm1BIf4BUFY9E9HfE4cvBEoN3XDNZZGuLqDAJZI2OG3q0fp0tisLCasyqO1cVhvUIMfjwJgwrxx6YbfELkdv+vRsJGq1/Zxh4dTH2CT+vZelEybdaWr0IFXwOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZbSnjFEtsMI79U8CC7OJlmRdFqJ7SekbuTf/tWMDME=;
 b=WWPskGeaDlSxOrE8rwVu3jMy7M5ZnWPrcch1DFT9QrVp4Hu3e/xo0NOBK2gF0lluxf6TFg8nWrc4ev+MvABrfR6IMK7CTLPPpwFAvkBCWaPouww9PqifD2FRh5Jv41b68xsDza1TcGWe39SNEO1Ca/qGv0PbUM8NncSTKCgG92yzOZxEK0nUfHCdV/71UqU2Bj5BN0SP/bPyQ7ch9HJUpIvfs6HIMlU9kN9fhhnhkO0J1dlbbgkaVpQdPxf/0n8owfNOUtVZ546Zzgz/ELcGD+gTw4wJTlz5JfFBwoWTuZt1+Xuvc0l9AOvYN4DIiaVnmKfx9gy6++kBIOIB3AXCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZbSnjFEtsMI79U8CC7OJlmRdFqJ7SekbuTf/tWMDME=;
 b=fjrgGLn+EeijJ1xvzFsMWZ2g2Yn0yUofwrclcBGPRSHRvGk1nUvVSXkelC2pvI2Co3wbDII4MCrPhgzafkjy1FaGbAeLygQkLvbFUIDB+xCxqTig6CVkhjZ8MQp6p0iBzafU6SpbOGWHZvaNLpOkOf2eWlBiF0Zu5PuXL4JTcYI=
Received: from BN6PR06CA0016.namprd06.prod.outlook.com (2603:10b6:404:10b::26)
 by MWHPR0701MB3724.namprd07.prod.outlook.com (2603:10b6:301:80::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Mon, 13 Jul
 2020 10:06:12 +0000
Received: from BN8NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:10b:cafe::22) by BN6PR06CA0016.outlook.office365.com
 (2603:10b6:404:10b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Mon, 13 Jul 2020 10:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT019.mail.protection.outlook.com (10.13.183.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Mon, 13 Jul 2020 10:06:12 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63Yu013926
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 Jul 2020 06:06:11 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 13 Jul 2020 12:06:04 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 13 Jul 2020 12:06:04 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA64o9028653;
        Mon, 13 Jul 2020 12:06:04 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06DA64kp028652;
        Mon, 13 Jul 2020 12:06:04 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 7/9] usb: cdns3: core: removed 'goto not_otg'
Date:   Mon, 13 Jul 2020 12:05:52 +0200
Message-ID: <20200713100554.28530-8-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200713100554.28530-1-pawell@cadence.com>
References: <20200713100554.28530-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(36092001)(46966005)(81166007)(186003)(7416002)(2906002)(70586007)(2616005)(6666004)(26005)(8936002)(36756003)(82310400002)(86362001)(83380400001)(70206006)(1076003)(356005)(5660300002)(107886003)(316002)(54906003)(47076004)(478600001)(336012)(426003)(82740400003)(4326008)(110136005)(42186006)(36906005)(8676002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7e26fd8-4367-4e85-fe0a-08d827145f7b
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3724:
X-Microsoft-Antispam-PRVS: <MWHPR0701MB3724A4849FAB6FE74CA8C24ADD600@MWHPR0701MB3724.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2bPHw9Osi3MBCVVVz+vHa03n3msvhoQOC6/QKJpP1gDf+LAsbi1HfGtg0V7GSXLmX1Ph60IxRm0IfWKSdKeT/HtX4DVZoSVL7de7ayQq1GbFxb+k/d3rX8lTqmnxDYAwm2YTqMjW9GhU8xma3D2OoZUbUNGhQZWnMJOvVdHlYLwVOMBLjnTDzLarjTk9/rYJg9vt166xHPRZ20uvxQb5tvEerM1JPDPOAIR2hfnFn7lubI7HaVU1Uyx0IGBV4Lx7MMyHLb7ReDtHPX+iUV5bO/0YrwZnmDEU/ezliKNWJfm/zYTfY9LsanaOMKFxm+tt899teEybdS5bXyl1GP5E6Riby/c7jwz/n4AWG4GNTxGH1iuCQeAIIsQom7wqfDTc8GsJ9bhv6upzhzG/Rdrj56EEtOq19m5f8zBVXmbscZo=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 10:06:12.7446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e26fd8-4367-4e85-fe0a-08d827145f7b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT019.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3724
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-10,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=756
 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007130075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch removes 'goto not_otg' instruction from
cdns3_hw_role_state_machine function.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/core.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index c498b585eb13..8e3996f211a8 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -191,11 +191,17 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
  */
 static enum usb_role cdns3_hw_role_state_machine(struct cdns3 *cdns)
 {
-	enum usb_role role;
+	enum usb_role role = USB_ROLE_NONE;
 	int id, vbus;
 
-	if (cdns->dr_mode != USB_DR_MODE_OTG)
-		goto not_otg;
+	if (cdns->dr_mode != USB_DR_MODE_OTG) {
+		if (cdns3_is_host(cdns))
+			role = USB_ROLE_HOST;
+		if (cdns3_is_device(cdns))
+			role = USB_ROLE_DEVICE;
+
+		return role;
+	}
 
 	id = cdns3_get_id(cdns);
 	vbus = cdns3_get_vbus(cdns);
@@ -232,14 +238,6 @@ static enum usb_role cdns3_hw_role_state_machine(struct cdns3 *cdns)
 	dev_dbg(cdns->dev, "role %d -> %d\n", cdns->role, role);
 
 	return role;
-
-not_otg:
-	if (cdns3_is_host(cdns))
-		role = USB_ROLE_HOST;
-	if (cdns3_is_device(cdns))
-		role = USB_ROLE_DEVICE;
-
-	return role;
 }
 
 static int cdns3_idle_role_start(struct cdns3 *cdns)
-- 
2.17.1

