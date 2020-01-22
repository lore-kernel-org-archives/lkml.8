Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C83C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB2624689
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="tDs/dnvY";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="MHZrDR8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbgAVKqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:46:42 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:23472 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729567AbgAVKpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:45:41 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MAgdbY009208;
        Wed, 22 Jan 2020 02:45:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=g1ZoMRgjVa1BlxZO0YNEbQnuKkcwGGdEhwS/x7nIiv0=;
 b=tDs/dnvYQJVTWRmKPWujMZbVtSvUk6iEjsUZBS0N9OXKmKPahemhPqSIe36dmT/yrRxj
 u8CkgpzPeLL+c3JpOe0VoyhLS0XtSYaYQng0U6SAaHWq+vw4u3T57+mBtKnPJwQlkwF8
 SVJ8iuebb370/TdIRjKt/tkm4dro9z4Nk0iZHvgtFDEHVQBI0zYGYUZPLQjbKNwOHUch
 CmlpRnftlQlw4v5iagTl1CM1RSiemD65NPf14Y5hsYk1DbIsWZDLiWvEcHdek+0YmZen
 Ciw/NbDxeYhfmMjamYMf6g6gwEL0xh++Ex/MKSF+7u/ZPlmLfSe1W/ZJT3iLYn1WuQP9 Xg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xkyf5mgyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 02:45:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMFlKvXCRmVzrc+St+FBkTR+RLvSRXhPzLLYIXN0bRz6bzupWrz44l4g7D17UzJSCX0MMdScCZt+mDD4Se4pjZgd/Zpgd5ZQfAGPm3prjLIfNVxxtyDrp9ZmbqyatyRrrnqU5WN1kdZyqiOXCkahdqz2w53hTxHf7Isuq/UwPrc7+4obXy9cbwu/ZXZi/0Up+I8Or80nSBXY6SzQNnz6psMZrZiTjVt4xGB7K6BM0hnPsXA9NppcaJH6y+pKd3Cu8LOC3IMcInFUthMAErs1+u3f/UFxo0piIUIHID4tEsszilS+z6wn1snHoFAFaNqaHUYwC92OfE4KSxAgS1xU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1ZoMRgjVa1BlxZO0YNEbQnuKkcwGGdEhwS/x7nIiv0=;
 b=JCW3Q03uwMb2MPWFJgIzr1fd7sK3XBaSL6/c57MlEpBVP+RFvGVZNZbLJV/LyVSDQRG8TNG3/scWM0WG9UOkLHX/b6+QDyVrQWVEHHPOOANMw9t4lYEn13rZxNZQRtEhX8mUZVCa/Bky1XLoNGEnr0awFqJ49V18JXbJMOg/NeifdmdQopukFTJ2ZTGpi6fuZidKR0ehY6IgtI9nswk8ELXIiRsrep0UpxbJYUUXbsOSCwldkSENpYDpKOgbzJLm06FFB3SbMOcMLIrQmtWV6rCQutJogHUCbHyjAcaF7DMaj0VOhi7ywRgrntQ1jMVBnuTTOat1HeJyusHjt+JD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1ZoMRgjVa1BlxZO0YNEbQnuKkcwGGdEhwS/x7nIiv0=;
 b=MHZrDR8yGCik3cqmJu96+AdpT46lr0RS5iXtehsET2A+yORaUOvLMjSuG8gjjZi3P09qU/7vKn/Y3jjMHpIEoT/4kyDxi4vpZY9ic0mIIOVmk237wJhNMD6Hq+Hk4wwqDmQekOgMFJTwhZcg83+XIpx2LeFMMlnDSt0OYjT5O2U=
Received: from DM5PR07CA0049.namprd07.prod.outlook.com (2603:10b6:4:ad::14) by
 DM6PR07MB4939.namprd07.prod.outlook.com (2603:10b6:5:2e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 22 Jan 2020 10:45:30 +0000
Received: from DM6NAM12FT012.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::204) by DM5PR07CA0049.outlook.office365.com
 (2603:10b6:4:ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Wed, 22 Jan 2020 10:45:30 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM6NAM12FT012.mail.protection.outlook.com (10.13.179.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Wed, 22 Jan 2020 10:45:30 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjKBL001726
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 22 Jan 2020 02:45:29 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 22 Jan 2020 11:45:24 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 22 Jan 2020 11:45:24 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjOKW007335;
        Wed, 22 Jan 2020 11:45:24 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00MAjO3t007331;
        Wed, 22 Jan 2020 11:45:24 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v3 12/14] phy: cadence-torrent: Add platform dependent initialization structure
Date:   Wed, 22 Jan 2020 11:45:16 +0100
Message-ID: <1579689918-7181-13-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(199004)(189003)(36092001)(4326008)(36756003)(2906002)(246002)(7636002)(6666004)(26005)(2616005)(186003)(336012)(107886003)(426003)(356004)(86362001)(316002)(26826003)(8676002)(8936002)(110136005)(478600001)(42186006)(5660300002)(54906003)(70586007)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4939;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 676ca15e-3ca7-4db0-a914-08d79f283322
X-MS-TrafficTypeDiagnostic: DM6PR07MB4939:
X-Microsoft-Antispam-PRVS: <DM6PR07MB493955F6C51CEEF87BFDB108D20C0@DM6PR07MB4939.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xk/fjVfzkihW4fi1nekIETuQfZfQzfhpmQRrLm1k7UTnvmyx5j5nNt2mQIZ7f9G7WfkSyiyv2IWXGawPEQ41v+HGS8LxI2sjMxcd5FdD/ySxfHSWetJHo2n4UPUcqRhP5xVd6p9zgMhD3pDDWC2vVSij12eaM+7JIxZTXnMxBn+5ALuZ6t+BqqMJgvbdwWBWu9Rkygbx52NNiyCYbZP7r1KC+TzSYhUr4hTTxR7J7ovDrJBO4oqHDbA8lRiPVCOGfzGVF3o+vQB4yCXIh620pIYw8iyzcYzSE2HCu8q7OeJmvVQrIPZtMLTKOBIxwvaO97SpSucFFc4zTLZOrnPbRAu3kUhPJTl4l6YnNds4PRL0i8aUr0IxhSeUS4rDLhn7QVBUuX4SaYcMsNMBNHjMy6qIJaXXfs1tgC8KARN63xtj5fnYhSSLxWP3zL/TPtIpTIW0Ku0nqXsZMmWXgC4scBB7sUsxD3MjaSnFFQTGBWHRbdAw9v0mtyZeVlV6C2Vm
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 10:45:30.0462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 676ca15e-3ca7-4db0-a914-08d79f283322
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4939
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Add platform dependent initialization data for Torrent PHY used in TI's
J721E SoC.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 0e03d3c..851a685 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1770,11 +1770,20 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 	.reg_offset_shift = 0x2,
 };
 
+static const struct cdns_torrent_data ti_j721e_map_torrent = {
+	.block_offset_shift = 0x0,
+	.reg_offset_shift = 0x1,
+};
+
 static const struct of_device_id cdns_torrent_phy_of_match[] = {
 	{
 		.compatible = "cdns,torrent-phy",
 		.data = &cdns_map_torrent,
 	},
+	{
+		.compatible = "ti,j721e-serdes-10g",
+		.data = &ti_j721e_map_torrent,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, cdns_torrent_phy_of_match);
-- 
2.4.5

