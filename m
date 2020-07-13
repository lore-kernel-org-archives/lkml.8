Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72464C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD7A2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="DyMZQvbK";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="0OOvYoJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgGMJiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:38:51 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40714 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbgGMJit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:38:49 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06D9NwH6021108;
        Mon, 13 Jul 2020 02:38:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=uih7xHozmZFiwatN4fMMv6EPzuJ8FhI7tvkz3b78+K8=;
 b=DyMZQvbKMOsjtBfadXsLvbIxkRI9Y/PiPy9BO3UPyI+oTeFVZHT/4ZSSKldHOUcjljf/
 fbNiLY2+T+qKyS+eb7BldjQSdq756N7JxabWjR0E+JXRxo0j402pGPlQXt6nBVOVxyGN
 jrQ8ZQKkYUK7ddFsW5zG/HRIV9lqRxiD412S03FCYnD0p1cXg9PEzzUC84Ntu5Ke2Aak
 dRDOjWnITaXXSMhUGcskV1HMRoy0Ugh9qG3aks2H2vCd+DFnuBl7cwAEHyVOt2NCSSj0
 Gs0xFewvmSQrdkdOWQ7y+PcIL347bAG3g5NHqfF4F7/x909lJwWz0ut9wfiA50rDW0N6 wg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 328ftugv43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 02:38:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8UoG/iL87aLV1vf7WlmzQJk19PqbNAFbphxGNgXmySfPqrV0oALH6gRkge4eFAL1rAOqvKz/xCVm4cm8wWxy87LGHBnH2mS4+ZI7FpBOLTeVtE99BHy3pPHvbZJwSxyeIXFeOgWSdVDtYums27hxMWmutIA1TWJtw6KSTmWBID4gNbEAN/HUHGqRAvxYs+A4uyFBYOD6rrTAoZWrDEzkEdPwqRzmy8MkvWos7JSa0u6mUyBvQIY5wx14yRRkGES4gHQej1FX63BlWDJwPv+74rCLE4hG954H2aNBv+NHZ1f18IvwKxi9DW3vzI7YyaDe5WSuEsJqywPEqJBSJ3KIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uih7xHozmZFiwatN4fMMv6EPzuJ8FhI7tvkz3b78+K8=;
 b=QDx9RFUyAXtCcOtZ1m1+i1U+Si8HFhK5QgX9q8kusuk6yIfBB1DctE4XfCNOK+LMkNS+jEyjNx9d1flBWqdLt/K/vRFXa5OHff4A65IELTjrxLLn/Lx8oXhQQWHu7CVn+6elE1wx1yGW/6clUJ4wG+bQhWG8ZHPE4KApbWlKHij2t0cQ56476ne7yUnd7cAhlQtncdxLF+ApmOy9x9XIumzZriRC9wiY1/Dq80XL1l6CmH9mpOEvuUkISBsT287h4T9rmMQ0EK6s4lCs5Uq5Lv48koFUYtwfkbUz18tvhnuktxfV/EAazMD7tdEJBwHNxnl3sOZZzcGY7U/88/9LUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uih7xHozmZFiwatN4fMMv6EPzuJ8FhI7tvkz3b78+K8=;
 b=0OOvYoJ4PEyC1Du70NdXOIuH9llYYeKMNcm/cJwfnXcL/SH4SkaM9IoehtFo7XhiPpf8QY0HcFxQnqJ8sjXulTOOzEJF+F9gUAgbUEy/V3wbRww5EzyNIevXkpktXL6XOJOV1gDzCCaUKuQ9SpOi7xDCl+pE2+uBn7JcvVDqGe4=
Received: from MWHPR22CA0056.namprd22.prod.outlook.com (2603:10b6:300:12a::18)
 by SN6PR07MB4208.namprd07.prod.outlook.com (2603:10b6:805:62::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Mon, 13 Jul
 2020 09:38:39 +0000
Received: from MW2NAM12FT026.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::d6) by MWHPR22CA0056.outlook.office365.com
 (2603:10b6:300:12a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Mon, 13 Jul 2020 09:38:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT026.mail.protection.outlook.com (10.13.180.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Mon, 13 Jul 2020 09:38:38 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06D9cYh7012105
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 Jul 2020 05:38:36 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 13 Jul 2020 11:38:33 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 13 Jul 2020 11:38:33 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06D9cXoU004216;
        Mon, 13 Jul 2020 11:38:33 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06D9cXsQ004215;
        Mon, 13 Jul 2020 11:38:33 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <nsekhar@ti.com>, <tomi.valkeinen@ti.com>,
        <jsarha@ti.com>, <praneeth@ti.com>
Subject: [PATCH v3 2/2] phy: cadence-torrent: Use kernel PHY API to set PHY attributes
Date:   Mon, 13 Jul 2020 11:38:32 +0200
Message-ID: <1594633112-4155-3-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1594633112-4155-1-git-send-email-sjakhade@cadence.com>
References: <1594633112-4155-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36092001)(46966005)(82310400002)(70206006)(70586007)(426003)(8676002)(86362001)(81166007)(4326008)(5660300002)(186003)(36906005)(356005)(336012)(478600001)(8936002)(2616005)(316002)(36756003)(26005)(110136005)(54906003)(47076004)(82740400003)(42186006)(2906002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c85b4a8-cdf9-47b8-2fa8-08d8271085b9
X-MS-TrafficTypeDiagnostic: SN6PR07MB4208:
X-Microsoft-Antispam-PRVS: <SN6PR07MB4208736D67E3D8F2D5CA574FC5600@SN6PR07MB4208.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCooPLgBin9Hx226G8Lydju5BzBXD57j3+XNigqmfawPnhWwlDovuGcs8V4hKSnyFb5N+OL/CLncWGu7Z0ATv4hn4Tlirw2T4QL+59TbQHeCdHe54ySOfHpq9q16u1aBgxWmW1vXIOPBDDLTHlWPLuhqr0Aj4YUe49tgbLCBADkxgXq+9QzAzqeh/BC9Ks1w40yHUEJt0vcOmM9+geVNeRPwMMkQFhO1k2CBNvJCYBIy0vPBbO7BM39zs4ATzjbqIzETRQ+/RVVZJSVoWnoYHVnNd0TfYTg3hPJni1Sr9x9gTkMkBS1yy62MKl1uMu5pw6XCPzSvgm/FbSL1nq4HACHJCNHHwoT0WJu/jJofsx3/yYiPq7pKsypfE5bjuOSDZSg4gi9TMjAu40i40KV5L4gjDJfSa5zLhkjSTqd0gH0=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 09:38:38.7932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c85b4a8-cdf9-47b8-2fa8-08d8271085b9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT026.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4208
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-10,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007130072
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

