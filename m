Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED6CC433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11CB207FB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="h2QQFoLM";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VpJlFeyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGQGu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:50:58 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:28610 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726855AbgGQGuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:50:51 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06H6oY3r004207;
        Thu, 16 Jul 2020 23:50:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=uih7xHozmZFiwatN4fMMv6EPzuJ8FhI7tvkz3b78+K8=;
 b=h2QQFoLMcHSvF7sV4sFBJT0On8pnyUgctTTY1zr/kaMu545qZBgfsV7YSGLt5eNPVGv9
 elZpLa27tVbFPlG6wUMSfukRGELwZL8OTM18Kpsjuj5CA1/6GFuUBSxNDGO9j9ASaAVu
 pc13Ucpvbmnp3wgRiYbclruMgf+w8wbfd446J+VSNAeGCR1Ecj4YVl303Auy70Ky4N+i
 Ll+m5JlhEbdBF3uLHkYkdkwhT4OVY4FCbFJFt/EBDA73Gqd+ZH0+pUfmkIC8i/f1LGWZ
 6cdydhEcNcjIb3djrgkRoZQjXbTCbsLmYZepb6xKp2DShEfUXl5s7E+gb3cI8QdlFiaq zA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0b-0014ca01.pphosted.com with ESMTP id 328ftv2dpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 23:50:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAj5rVdDjAyxelZnnyis3kYZnd7zf/rWMotgq0tMkCCGNS4uNnfi9VCZ8zmlpRLqmumNb+F0P9+hR/66V0Ao66SJhrraCB5ZIDIhkuEThBo2p8OePl78oAvxPQ26ggwYvz+YVbUYrhnin1ZpgxYDO7YjEKcsgOomjs3XHvcx/OOncla1qigx/JB1x+ka5uS1QlVMY4c9nZ20nxEB2wzhq+JE3RsqlwS5tcPtceidKcLowTnfMj/ts00gSxYLh9FEGMOgI54RcrQJgnv4X/Yd0pG3nriR2b1GtLdnEpOe827lTo2Hmc9P9N38QnkJK8k1hk8lXxKo58zNijxXXP0uow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uih7xHozmZFiwatN4fMMv6EPzuJ8FhI7tvkz3b78+K8=;
 b=FSE1qzmYwHSHlwXadWvjZvj/iyeJwurq3YzLx4jLHGO08GGiIL1ko872WphH9KHnH5rmRXWYaQ48unAuQ5xXOITFSwGVLlb0rgz30wjqHo9rWDKzZZSl63PCOrMdhkgseivbSOs/5UOB5wAHgmXcHljCENInO5fbnosPqjveeBucPoK8OUZcE36e1wx/tflR6uYJG/JCGw3rfKnIv0Jqs6nrFhwHOwW72DVvVsDp2D+0Yg8dYAJKXCLAFuyYlPDN7j8WpJdWzasan4RiRbhgSfxIHSBhNJ6LS+pGvkZvPZkzzqJHZb7MkOomF6IXoFwcRT2MCgPoC5jV3WIwZI/Eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uih7xHozmZFiwatN4fMMv6EPzuJ8FhI7tvkz3b78+K8=;
 b=VpJlFeyENJ+RBB2KVrTUqOyZ+XkPNBIgeyxxyjlXztSFdEvX7j2pI7nvWNTwP4WsJjHB0l4N97hXHiRepdoKOponshPi0Ml5jmQjno6IwGW5KlS1DzGlsLebZLuOQlyMwv+DQr6E/i452gPBu/4osqEntikt3gXXnrs456c+S4o=
Received: from BN6PR14CA0025.namprd14.prod.outlook.com (2603:10b6:404:13f::11)
 by BL0PR07MB4097.namprd07.prod.outlook.com (2603:10b6:207:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 17 Jul
 2020 06:50:39 +0000
Received: from BN8NAM12FT038.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::5) by BN6PR14CA0025.outlook.office365.com
 (2603:10b6:404:13f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Fri, 17 Jul 2020 06:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT038.mail.protection.outlook.com (10.13.183.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Fri, 17 Jul 2020 06:50:39 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06H6oYLq016347
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 17 Jul 2020 02:50:38 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 17 Jul 2020 08:50:34 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 17 Jul 2020 08:50:34 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06H6oY4G012586;
        Fri, 17 Jul 2020 08:50:34 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06H6oXIL012585;
        Fri, 17 Jul 2020 08:50:33 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <nsekhar@ti.com>, <tomi.valkeinen@ti.com>,
        <jsarha@ti.com>, <praneeth@ti.com>
Subject: [PATCH v4 2/2] phy: cadence-torrent: Use kernel PHY API to set PHY attributes
Date:   Fri, 17 Jul 2020 08:50:33 +0200
Message-ID: <1594968633-12535-3-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1594968633-12535-1-git-send-email-sjakhade@cadence.com>
References: <1594968633-12535-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(36092001)(46966005)(2616005)(478600001)(36906005)(47076004)(186003)(4326008)(81166007)(36756003)(2906002)(356005)(8676002)(82740400003)(82310400002)(26005)(86362001)(54906003)(8936002)(70586007)(336012)(70206006)(426003)(5660300002)(110136005)(42186006)(316002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ea4cea2-fedb-4a71-dcfb-08d82a1db766
X-MS-TrafficTypeDiagnostic: BL0PR07MB4097:
X-Microsoft-Antispam-PRVS: <BL0PR07MB409728E4878B52917A735A81C57C0@BL0PR07MB4097.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1P61vBczmjdMQDkaTHRkX5Qzf+0XXVPXNCgUA7o5uFi1FENQPYD9srcIhzIt+rR69vimldZbUARCTsHmL3Y70lMdmZMXuIcHSSjnlhUkp6aVxLsqSbYe3t3Rtyxg+c8dzalcvKv4RKouUpycE11fe3iCFG/W/ZPI1BVWWkjG/ace+G8W8Zyi8JcNaFsnV0XF1sVVpMrA6t/y2RQ4KL4XeujEzTxd7hSN33CiDy6o1jei9o7yMdFuWf15aKSZw4skAF/zj8qee88roOkSvPZI4DDDJcv4a/f4K1fqtuedMluuifsF3+KCq64UtawrdsUHB+1bduw8veH6wT+O8DgGs7Ti65q7Sp+NHZwQucLpckPYLKkmK37wkRPX48D7Uh56MRNkzEduLBGTWefg6rj6p+UWpLk+LXea4TOU6XvBEI=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 06:50:39.2055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea4cea2-fedb-4a71-dcfb-08d82a1db766
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT038.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB4097
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_04:2020-07-16,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007170052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic PHY framework function phy_set_attrs() to set number
of lanes and maximum link rate supported by PHY.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 7116127358ee..af81707ff0c6 100644
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
+			phy_set_attrs(gphy, torrent_attr);
 		} else {
 			dev_err(dev, "Driver supports only PHY_TYPE_DP\n");
 			ret = -ENOTSUPP;
-- 
2.26.1

