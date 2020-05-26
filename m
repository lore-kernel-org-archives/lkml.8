Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29213C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02CD620723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="RuARg/02";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="EGWBE6f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgEZOf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:35:28 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:8798 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727885AbgEZOfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:35:25 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QEW6cI017600;
        Tue, 26 May 2020 07:35:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=VKdkdx/WaFTIf/5ZgIKVsNmYVpihvQ+TfdG7E44f+oA=;
 b=RuARg/02rL1v+TIy3S0ESAxOxyCcaa34fHO8NxZt9HwJvBQsathMRZPujwx33Jx9Ot1x
 eUzk5Cj5axFsaEFcQAgOY27QCF1YoHvmC/YDwEs1KOldgvt9yMsNAy8pUkVunx8vgiMr
 F9C/MiZFy7NEmh7c4qU45cxzjVvLNBSARzjRvSoR6LtO1sddm+UAgCxs4KB3rQ2lJxAb
 7gJu6mE8gd0GnLpCQ80y4mtBhCkce5ed2mnmy0XY+U3ru4In24GSlAokIKgCofh7J3/z
 ccyqSWS18KXTx2bQ+Hp+cNA1L7I/68fioWOC+x8aEH7oOJXimhzO/O81cGAkPl/+Xh7W Lg== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2051.outbound.protection.outlook.com [104.47.36.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 317jeyegef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 07:35:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9jaYugj5Sv05Tz55aG4Gdw3d1HUspxms2+tUUnjkVa3YMCvMs6SvFtDdmqYBHKbaC+n7+ASY9FXzPXvEfWgfUkynkfG3DX5MdWqR2Ct53/TdDt5rIoCa1eYEtAuDvgCZzic62ELS+NnPboPc0hH6TxbIsakbmbm4zn2ZRqF6ByHlw5sObf16yuAwbJNcrHDZeka7fU+V/WmJyR3O7nccd7RErnF1ZrQ5d0tXOwBuZwfpOoWWTzesBHfOW1KHYX/xewS9jaFIXnaV2bI7aIzmg4OZAwZ/BsSO2W+TqsvfkNY76sj6iPNOiNvU0O+dZx24rwjBfjDVuKhP7aZYcrsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKdkdx/WaFTIf/5ZgIKVsNmYVpihvQ+TfdG7E44f+oA=;
 b=ghjc51DxbAbL866qZHstZzk7yN22vqglR+Sf1/8lwb90tIH9BIqvVxMlPEOa/WXSPFLc6h1hnXomemopPQu2+dAVCgMJ+f4UpxVsB6mBf6xOmZJjmrSAcNPk6XUPpIECUTpUCiMiVPrr+l93wSXzpF3mI+iA6VkiDy786opvgEg8/F2CJLcoul6ujacE5XSlOmodcaXo+SwqPAhWoT4IwdlZmbdo8kDMfW5Bf9SOSODNAnZIJqCd6F0IdjTgx48kgTnoaiqVVb9Ky3nRXMuVlkYvp7fe3rsZbt2RaLSCU5My5KvX3N9oTL+JapXxxPW9mkDlj5D6LZzFwjEZ66WXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKdkdx/WaFTIf/5ZgIKVsNmYVpihvQ+TfdG7E44f+oA=;
 b=EGWBE6f7WqHcayZ7tTKpWm0E+bsCQiMTGKnUUxdiZ1zQL/7r7X8FK877FH4P+q4nSUz09KZYAwKepHUak+z5V07iU12nuY/mR8gwvU/nv347epgimKpCxZzarRJXJMskklIMPiMSU3GKfJmMHOBBYug5ML5VpEyXSCt5o1/ncSA=
Received: from BN3PR03CA0067.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::27) by MN2PR07MB6669.namprd07.prod.outlook.com
 (2603:10b6:208:165::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Tue, 26 May
 2020 14:35:15 +0000
Received: from BN8NAM12FT025.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:7a4d:cafe::40) by BN3PR03CA0067.outlook.office365.com
 (2a01:111:e400:7a4d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend
 Transport; Tue, 26 May 2020 14:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT025.mail.protection.outlook.com (10.13.183.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.10 via Frontend Transport; Tue, 26 May 2020 14:35:14 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 04QEZ8HD002019
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 26 May 2020 10:35:12 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 26 May 2020 16:35:07 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 26 May 2020 16:35:07 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04QEZ70h015150;
        Tue, 26 May 2020 16:35:07 +0200
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04QEZ7M9015147;
        Tue, 26 May 2020 16:35:07 +0200
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <kishon@ti.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <maxime@cerno.tech>
CC:     <nsekhar@ti.com>, <jsarha@ti.com>, <tomi.valkeinen@ti.com>,
        <praneeth@ti.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 2/2] phy: phy-cadence-torrent: Use kernel PHY API to set PHY attributes
Date:   Tue, 26 May 2020 16:35:04 +0200
Message-ID: <1590503704-15057-3-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1590503704-15057-1-git-send-email-yamonkar@cadence.com>
References: <1590503704-15057-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(36092001)(46966005)(2616005)(8676002)(478600001)(316002)(8936002)(42186006)(107886003)(6666004)(4326008)(70586007)(36906005)(70206006)(110136005)(336012)(54906003)(426003)(82310400002)(5660300002)(2906002)(26005)(81166007)(186003)(36756003)(86362001)(47076004)(82740400003)(356005)(2101003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fa79d1c-0ad7-4f2f-9dd6-08d8018200dd
X-MS-TrafficTypeDiagnostic: MN2PR07MB6669:
X-Microsoft-Antispam-PRVS: <MN2PR07MB6669DDFBD7690F9FEF275026D2B00@MN2PR07MB6669.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37GTrMgXPxwTlCNF9pPbRbKelwJ6h3gKugm9k0MMNlszGO6joTYqiS7h4okZOi2peiLDulwvVI9GvGNAnBNLo/uJ7zAuRNogMdNpbsiHD1ADBKuz25djEKgKDDfz4QXxWv/h+2SNvFeFKE6HKPA0O+DIB1Zwgh+pk6szJG3cZGmTL7/FlHlkij6stKg9IqnqDm3VB1H7ijlaBJSLczR/lDrRwkIvJvapLMvtSvnFJza1nFF2C/pJpge5XvZgr2KSTuN0lOqzs5N3z6kHg6BN2aqpN9VfQ9LOc6ByAEWNK+gWnphrTeBWCoJ1g0RgVbJTvrdv1JrAaFnbvXhGZtMCdlrFNv0swvnTFCCHwMNiBdF6rrBse9/n8nSbMpzA2oVmgplNVebWGb+HSYrj7W2VCfwqwNXOSlLtkmewI7UPRenIt7rrl/oMPhfmUgxfoK04
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 14:35:14.4515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa79d1c-0ad7-4f2f-9dd6-08d8018200dd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6669
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 cotscore=-2147483648 bulkscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Use generic PHY framework function phy_set_attrs() to set number
of lanes and maximum link rate supported by PHY.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
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
2.17.1

