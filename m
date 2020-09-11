Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657A6C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E634F221E5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="pSDucfdV";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="3WSbQ2Fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgIKGS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:18:56 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:4954 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725468AbgIKGSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:18:53 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08B67vBU005480;
        Thu, 10 Sep 2020 23:18:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=UzrVY84r8A/A99uSAjzCzZACOw9QN7eZQsHVwIzbkAA=;
 b=pSDucfdVFGv9OLPTw4DXhfsFQMEOA+0HPfTyaYRggHnH3fMt2NAJye9OvK8NV4/pDB17
 0BmUXIVVm3Rm0ZnLn3kT7PIGeiNvPVJTLRdpD4/FSHu9jDmEDedLM3Lplf9dO5pw38+0
 cf8pb5HZ1XRn5vt3dzFnTe1PVuol1zz25ChHws86J+Jqt5ajFh/EhztCd4xBG9wZRPB4
 RrENMy2rsKv0na/go6YbtSMZDDUIzBwwc4nKlsF4Lpa5pYbrHGJMlN+pNUxxex8Iojsd
 sJJ6OnWevVGLK5DL1DmZek3+zQu0T20WaZqwQvE+/XtjeV/BsbqfIJspVBOXMJ4pq4l1 dw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33c77wwq8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 23:18:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2A2Y7IsunHO00ewvSg0H3qiRmTnsua1sFoaeIrxGCJl8Ae0jdBkqS973m1JW3PZdQLniCMrMyTaXNRyJDCN/mvHLhT9HW24L26Ik1n4RiLcO+o7xwbx3v+NrfOYOCjdyKtXVXZAxveNz8QGl4E2lFnPJxb/IRVKd16V7DW4f8GisN5C9OlgT5EjEmZzo5yF1mkMNf3hLu3q6RnnIOMx1b/hcJzxbj7OGbZZi03aQ3drKHo/Ljk86+mrMK6VmaEDOdVjugzRD1X1imla8a4/Iknu8uVgsq+bK3dWklOQgbB644gEOXP9lwQPTC6W14quhJ9pxKl5nb1E++F3rArQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzrVY84r8A/A99uSAjzCzZACOw9QN7eZQsHVwIzbkAA=;
 b=FqILLrKwegJGrjwMatz4NkwkAG+7RybEzuyvzbE+vzNNLgDrdC+9T9FqMvyAzJsUoXitxGVtjqkgJmgZGwQ7OwyRLC683yLq39KB89hgHxc5TJJqy/RWU+UBwel7/iIYqY1sHDUcUnzssxTe5mzIUTcaFW5zQ4zumqWm/Eoz/RhAnhh/eNLQzflRI6fXhOtUlHzfZXgklHGErrDu9J26AA6DUkQu7R1XOUvHkJcVvUzzHYlDwi6+ZqtxjAkxrkkIOiLYlMqXuzx7tKtX1rYPFnTU2dN3VcdZUz91yKQE3QzVpvD7lBw+Mnj6bF4csIAQ6mBSgm00dJxRQHJ5u0/cuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzrVY84r8A/A99uSAjzCzZACOw9QN7eZQsHVwIzbkAA=;
 b=3WSbQ2Fx0KxJyedA8Phj0fCYMqAZfF17m7pYATFQpLCOoo8xyJqew1hVEYgzMKcp2JEF/BrBEXGv5g98UIWjSbP4Ji+h7sR/zcBWxJXubpLNUJSQ/YtEgtPWG8kuvokarDZ+8dWzMrVncjlSGmEN2CfzCuDCiuVqA0mdICO8SJI=
Received: from DM5PR16CA0035.namprd16.prod.outlook.com (2603:10b6:4:15::21) by
 BN7PR07MB4226.namprd07.prod.outlook.com (2603:10b6:406:ad::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.16; Fri, 11 Sep 2020 06:18:42 +0000
Received: from DM6NAM12FT034.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::b5) by DM5PR16CA0035.outlook.office365.com
 (2603:10b6:4:15::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 06:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT034.mail.protection.outlook.com (10.13.178.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.8 via Frontend Transport; Fri, 11 Sep 2020 06:18:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 08B6Iacm037565
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 23:18:39 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 11 Sep 2020 08:18:36 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 11 Sep 2020 08:18:36 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08B6IZsL022132;
        Fri, 11 Sep 2020 08:18:35 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08B6IZIh022131;
        Fri, 11 Sep 2020 08:18:35 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>,
        <Laurent.pinchart@ideasonboard.com>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <nsekhar@ti.com>, <tomi.valkeinen@ti.com>,
        <jsarha@ti.com>, <praneeth@ti.com>
Subject: [PATCH v6 2/2] phy: cadence-torrent: Set Torrent PHY attributes
Date:   Fri, 11 Sep 2020 08:18:34 +0200
Message-ID: <1599805114-22063-3-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
References: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05fc5472-93a8-47f6-22c9-08d8561a8711
X-MS-TrafficTypeDiagnostic: BN7PR07MB4226:
X-Microsoft-Antispam-PRVS: <BN7PR07MB422672C13D45B1FD75A4BC83C5240@BN7PR07MB4226.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTNQTsQm6ciCpApHjEk5wr4Dcgj7rmermmvdzk3LwypgGpAEwnwficZdqBsBYOAIwKa4O0brrETGW1VXSsqZ+0OLFlYWF1cSRb+tlAMnAEkmEtG07Z0IHo8yZXquS+X5jjjhJmhIGDk8BccPErsVUZD+ViADADcE/K18eGaKGtPDlOI7O2r8tPKjvnLRhIBN3UOeOZxgZMuw8tKIhmadPLviU+N92ZsH5D2tbxhc3gmTXrf8pBKuPNwKmKcL/E7+wFjhDDA33/c6qQMyV9pP+TUcaovw984+WqAww4rnhDRY3OqVBjHeC1DYv9GTf7aeMtP38TrTghWTp6IGS6wbCukHUQuTHOgvCq5N/EDYPpZL9JgLS+prfb0cSlVnAlRFv0Rhd1c85jxrHmFfShm1ngS650LmGtukJ/XJF/298f0=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(36092001)(46966005)(70586007)(8676002)(4744005)(186003)(426003)(81166007)(356005)(478600001)(82740400003)(316002)(336012)(54906003)(5660300002)(2616005)(8936002)(70206006)(36756003)(26005)(4326008)(82310400003)(110136005)(47076004)(42186006)(2906002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 06:18:40.7071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fc5472-93a8-47f6-22c9-08d8561a8711
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT034.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4226
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_01:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 suspectscore=0 mlxlogscore=896 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set Torrent PHY attributes bus_width, max_link_rate and mode
for DisplayPort.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 7116127358ee..116aca36f7dd 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1852,6 +1852,10 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 				 cdns_phy->phys[node].num_lanes,
 				 cdns_phy->max_bit_rate / 1000,
 				 cdns_phy->max_bit_rate % 1000);
+
+			gphy->attrs.bus_width = cdns_phy->phys[node].num_lanes;
+			gphy->attrs.max_link_rate = cdns_phy->max_bit_rate;
+			gphy->attrs.mode = PHY_MODE_DP;
 		} else {
 			dev_err(dev, "Driver supports only PHY_TYPE_DP\n");
 			ret = -ENOTSUPP;
-- 
2.26.1

