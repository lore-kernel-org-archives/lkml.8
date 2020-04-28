Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A4EC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B4F206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="W7jPNLKZ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Zlp099sQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgD1HK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:10:29 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:18852 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD1HK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:10:27 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03S78PFC027927;
        Tue, 28 Apr 2020 00:10:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=a+Bvms+RecvJCSy7Ds7B7Wt6O3EHh6BKvHm1pbj9/lc=;
 b=W7jPNLKZHbB1ApbrS8EtbOPZPQlbzOnP5VV8C/+Ma752CPy4BT3bBIWf2FaP6K7L0Pg3
 6LuIPXlJgbSCMmulI3qrXQaZKVv1zGOESHituMzmKQdsq/F28/9Yb37Y1gaZJHDVySni
 gAae+WVAPTTeIT3+VJvfipc3nSX2Bl8P2Mol3J82ZCyc1+0thHaUoIxkehLB3RIyIKyq
 k+RSdevzg5lOJ70gq/PCazzaTUSTo+B59s+qi8rZEyOQIbHImv2XIfa0HBeSYXwE2Lde
 qjQnZRyBzJXYPGEsFc7Hqa8Dnk4h11OHjVkPrBxbR0K9YAINYEPS+ng+LgZ3Z7oDzxhr GQ== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2051.outbound.protection.outlook.com [104.47.44.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30mhywjw8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 00:10:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEk/GXeh5SQH3S1Ae9omq9FgWJ0rM9Hu1typDbLyb6ELBWKZRXleTSSRFPC6Mmus3sLCRgAOmOpTeaREZSjg8QDJo7L/+wxo21yzoHfjjbSs3HZEsXTntJqNUmbH0ApLxz2tPI9+0HWKV71WxD1XHv3Hy3dP/gE2Sq2x7izPqREfsSiktC8hBe3G0u08XXjR0y+xQC2dVN70IaL7WjjjCFCfK3fHIOosSN6FGw5i/FKm6UVaCeTry4x4qf9TgxH+96BPvhJUc6fOaIpYlnJAQ4ppff6lTYNFvOgouNBbnUvD0L6tZmGuwqBzQAAl2Mg9xOS+aelJSLPRCmnl4gcTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+Bvms+RecvJCSy7Ds7B7Wt6O3EHh6BKvHm1pbj9/lc=;
 b=DEha4S6mWrDoccs0jo4ly3m5fTESP0VSkaM89T85a4H2GKRWbOVJneLJ6ESnJo2omeMk3ccY3Up6PC352waEnIMVzhCSTpXq9AUb6F2UhqeBCzI/3YSI+WpTRtNdWe3HHEDfQdq/jcPjxUDjonJ8IigUgp9Us3EJVw6GKK3AlZNGZ4AbeQirRr8ISaqtH8rLHAOzV7mdkz93yjD2/vdlpxqeHkcdYICvNfn1efS8gn3zZ9f+9UvSRKifXZeRYL5EbMGnGFMMY0eoGXji+8CXQstUrstkCt1T5nAyaVKzg939VfH0e7YST319hZMUZCyO4XwRGuN5PGbs4uRQdlfI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=arm.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+Bvms+RecvJCSy7Ds7B7Wt6O3EHh6BKvHm1pbj9/lc=;
 b=Zlp099sQ1Wd+sqSKnOSMROrYiByS315mW+quN7Z8NZ71ZlqO5gQRgLWHPC/MRKhC2EjGy5upe6oQ1dyNcBo5dh69vjg5amKC7/P05NRCS237rYI+buQsoxCdTz3jQWZAtUrNtv9qYDN5CwNSACi2tcniMQzQhM2lrJiyLzPU60Q=
Received: from BN6PR18CA0023.namprd18.prod.outlook.com (2603:10b6:404:121::33)
 by SN6PR07MB5693.namprd07.prod.outlook.com (2603:10b6:805:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 07:10:10 +0000
Received: from BN8NAM12FT024.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::83) by BN6PR18CA0023.outlook.office365.com
 (2603:10b6:404:121::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Tue, 28 Apr 2020 07:10:10 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT024.mail.protection.outlook.com (10.13.183.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Tue, 28 Apr 2020 07:10:10 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 03S7A6aU203012
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 00:10:09 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 28 Apr 2020 09:10:06 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 28 Apr 2020 09:10:06 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 03S7A6wu029230;
        Tue, 28 Apr 2020 09:10:06 +0200
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 03S7A6JF029227;
        Tue, 28 Apr 2020 09:10:06 +0200
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <kishon@ti.com>,
        <mark.rutland@arm.com>, <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v1 2/2] phy: phy-cadence-torrent: Use PHY kernel APIs to set PHY attributes
Date:   Tue, 28 Apr 2020 09:10:04 +0200
Message-ID: <1588057804-29161-3-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1588057804-29161-1-git-send-email-yamonkar@cadence.com>
References: <1588057804-29161-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:unused.mynethost.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(36092001)(46966005)(70206006)(81166007)(47076004)(54906003)(426003)(8936002)(82740400003)(2616005)(110136005)(356005)(70586007)(4744005)(2906002)(478600001)(107886003)(26005)(186003)(5660300002)(336012)(4326008)(36906005)(316002)(8676002)(81156014)(36756003)(42186006)(82310400002)(86362001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 345eed5e-0902-4cf3-0054-08d7eb43304c
X-MS-TrafficTypeDiagnostic: SN6PR07MB5693:
X-Microsoft-Antispam-PRVS: <SN6PR07MB56938C7B0243A5082381EE8DD2AC0@SN6PR07MB5693.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-Forefront-PRVS: 0387D64A71
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Q3uLnNe58onJ93m11rjsB1LfqiKMwq8/a3aFsBZHxuz5rRlG+co62knfu8bTHbjXNo07wPIG0/sEIezY9Ddf/B9dW7voZq+3WfA/C7EqHE1ErsCH7uwIstzuLfdApTLsTYb5Ibgn4GhEGZ+jLlSAS1LmQQqBOS8ltKZZJRFhD14F074ZgwnUZCOQcy02t8ousZiTk1hXVy34jnUTuPhlcHQ9AUH/12JTQHGCDl7kjbkAgYZPdk7XuUJBZrT5Hg9YITvsRW8sjhMazsRuHRVLJfigryf4UbBW0VawF0zjRQtdwqaXmzmQ4sccCG01n+/VI9rau315Kq1irqY6t2dRVrsNAQiCPwOiqODvsqBNmIDrB9dHCl4nPSbK8wVsnwvdVtvY4X1jRopid54mfqUetmQ0Dc64po31A2IDDvxkPHzsS+Bi9RhAaQKPURqiWeyGJF+NOlkhCtGrMFteOsfMHJEimWVvASIqhBSvu57UqZle9WmJGvB6kY57cOB1ZcPIz2QPeNXlMBaWxjhSO9KiF76Gz8mhRBjk52X4MMco9s=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 07:10:10.0358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 345eed5e-0902-4cf3-0054-08d7eb43304c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5693
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_03:2020-04-27,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004280061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Use generic PHY framework function phy_set_bus_width() to set number
of lanes and function phy_set_max_link_rate() to set maximum link rate
supported by PHY.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 7116127358ee..b914e5ddf93c 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1852,6 +1852,9 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 				 cdns_phy->phys[node].num_lanes,
 				 cdns_phy->max_bit_rate / 1000,
 				 cdns_phy->max_bit_rate % 1000);
+
+			phy_set_bus_width(gphy, cdns_phy->phys[node].num_lanes);
+			phy_set_max_link_rate(gphy, cdns_phy->max_bit_rate);
 		} else {
 			dev_err(dev, "Driver supports only PHY_TYPE_DP\n");
 			ret = -ENOTSUPP;
-- 
2.26.1

