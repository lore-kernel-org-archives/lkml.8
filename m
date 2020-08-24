Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63518C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C8F20767
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="kh7lhE58";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Of1mt/37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHXS3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:29:10 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:6546 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbgHXS2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:28:53 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OIRkXT010464;
        Mon, 24 Aug 2020 11:28:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=qSJrTmruxuBWPo4cZX3VheG4nfrUxtRAlm1ZSKsxZpo=;
 b=kh7lhE58//X+C56qhIKtvZQgleqB9fItTbUoTXMG1yYiicn/f2slb3CNJ+sr3vYU3adn
 GuZ/NdT4CYHzsdX3cRDitoiUHyoVBxslk4a+VPauljcoWWhXehtebSP0bg8195LewJRA
 RNuh0b/kCrE50e69qKnH4aLMNWZbDtyIfKb30ZPmbsd5jerYvCmSTC6QTfVfYbe2Twy5
 ExEXFi5p3+lAx/amhNDMVe93YSJ04hHStQ9U1eCImKbDgLQ2GxOkUQwF0v2hU/tomnD/
 01eIkNFwkXdyjIIE0RhtpKikq5nZeUOBbv1BvrEFY9B6ZufdjrQmPAS/fHl7csD56C/n pw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332ywvqfr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 11:28:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWvNI9D/tIR4xU4TjKqGuNaZ0SzYZA470LkMtj8PdH/RlnENnJKFyZkBYCwu0cnB8YbhrxvFhqG++O8NouV/E0ikpL2Hu1k4dMVCyRS0k7y71Sb1f2JRp7tniNdYNk2mQV3jv48nM+zXj5MY+OgoQTOszvJqsQ5GAUqb0M1MBh4LawRHVHHDY4sRxm+EJuIRgGOngYDlPt1wrtkhGxtRwsoSyHcYuGd00FEedz4JCwsFxxL2F6xhnL3hZO12LNJi2x1jpg7apCgfNAHmbtf8pgBF1iCKnLvJzps5xsam/7H3lq+OeOADp6WAuuObf9nvoji2D7NAinlyfPiCmj2mRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSJrTmruxuBWPo4cZX3VheG4nfrUxtRAlm1ZSKsxZpo=;
 b=JDsb4OgaPSO/UKKsWVUktH7l4NY2oOqhHgAlqrxFJJwdCRfbxM1VEY6/rHlhMPYLHGvLSU4Hs4GGvQlqPuY8oCj8QYd0//QnkrEmEpE8tbFGxGekYmB4cfF8XcOgZWKKi/TXRI4H5KuahuZ1BFmoSVW13LcOjOEebjSrGJ9XKN1kbyddg85gJlPjiPS4aPdc0HKVMntEkXr9SONGVHWOfxmr4+4pjk6KuyD+zSNCLQcBrRx29DQh9YE2BKjco3zbqQAXF6UiN0ln9IlJF8kITqO+43P6xKSkBU27/hB2YkxOJLhBPLhUlUrq7i1YCOX4wputyPdkPqKvTcOrxNVNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSJrTmruxuBWPo4cZX3VheG4nfrUxtRAlm1ZSKsxZpo=;
 b=Of1mt/37YrxpZGkjZe7ADg5AH7xDjRvHGAxzp08Lt4OR0m1gUTj9wAtm28FfIq03pwaE3WiYTLLtBQBRA0DqGuK/HVX/8AiAeK5+zLlhyMJnGXGydiFODxBciBpNGWy94id+zBgRr49iT3M73boUcgQpqzqgO/R3/r4RZy1zmpk=
Received: from BN6PR12CA0025.namprd12.prod.outlook.com (2603:10b6:405:70::11)
 by MWHPR07MB2832.namprd07.prod.outlook.com (2603:10b6:300:2a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 18:28:38 +0000
Received: from BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::34) by BN6PR12CA0025.outlook.office365.com
 (2603:10b6:405:70::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Mon, 24 Aug 2020 18:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT065.mail.protection.outlook.com (10.13.182.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.16 via Frontend Transport; Mon, 24 Aug 2020 18:28:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07OISWip013830
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 24 Aug 2020 14:28:36 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 24 Aug 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Aug 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07OISWZW023423;
        Mon, 24 Aug 2020 20:28:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07OISWZO023417;
        Mon, 24 Aug 2020 20:28:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>,
        <Laurent.pinchart@ideasonboard.com>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <nsekhar@ti.com>, <tomi.valkeinen@ti.com>,
        <jsarha@ti.com>, <praneeth@ti.com>
Subject: [PATCH v5 2/2] phy: cadence-torrent: Use kernel PHY API to set PHY attributes
Date:   Mon, 24 Aug 2020 20:28:31 +0200
Message-ID: <1598293711-23362-3-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598293711-23362-1-git-send-email-sjakhade@cadence.com>
References: <1598293711-23362-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b723145-6289-4925-05f1-08d8485b84cc
X-MS-TrafficTypeDiagnostic: MWHPR07MB2832:
X-Microsoft-Antispam-PRVS: <MWHPR07MB2832CCB628E78E5C0C4A149FC5560@MWHPR07MB2832.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxphQN+5eCEtgSkxhcXx8QBXgFWqNkD/sS3Yo4t+yT+HTw/YggvbhR5lIuvfr/AhvFf/ze88xdqj70YUabooU6ON9aFoGYCYNcbgtazNlxAsxZroA2jlndHjbA6phFvew3DX0rn/ADv3oHLbybHpTgZasrHaoBO1LlC3yi3AtLjhYw9A/6HLc3Yi2fUNdpRWGsdn9iuE9R0+KozH/9VfpCjPZdyR41y+CYTMQI8qn84g0NlsZRQ/CR7rYEgTqqMknLTLLNE0pCbAos3G0VwdEb15Iylu5ljr136pvlfy2K3UhuocSYnv4pkt32nobbH7Fal9bmxip+LagM6ekBtFRhCq+Ab/nyyjBHG6Bsded5erRz/QW9M3oMrIk8vQC2E8lIIiRDd+rVXHD/oL1lBYiyrs8XMq4DZMErjqyY2aXGY=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36092001)(46966005)(8676002)(42186006)(47076004)(54906003)(186003)(426003)(4326008)(82740400003)(26005)(86362001)(110136005)(316002)(336012)(70206006)(70586007)(356005)(5660300002)(82310400002)(8936002)(2906002)(81166007)(36756003)(2616005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 18:28:37.9832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b723145-6289-4925-05f1-08d8485b84cc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2832
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic PHY framework function phy_set_attrs() to set number
of lanes and maximum link rate supported by PHY.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 7116127358ee..eca71467c4a8 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1710,6 +1710,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	struct cdns_torrent_phy *cdns_phy;
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
+	struct phy_attrs torrent_attr;
 	const struct of_device_id *match;
 	struct cdns_torrent_data *data;
 	struct device_node *child;
@@ -1852,6 +1853,12 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 				 cdns_phy->phys[node].num_lanes,
 				 cdns_phy->max_bit_rate / 1000,
 				 cdns_phy->max_bit_rate % 1000);
+
+			torrent_attr.bus_width = cdns_phy->phys[node].num_lanes;
+			torrent_attr.max_link_rate = cdns_phy->max_bit_rate;
+			torrent_attr.mode = PHY_MODE_DP;
+
+			phy_set_attrs(gphy, &torrent_attr);
 		} else {
 			dev_err(dev, "Driver supports only PHY_TYPE_DP\n");
 			ret = -ENOTSUPP;
-- 
2.26.1

