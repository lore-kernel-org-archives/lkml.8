Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1015C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1CC20679
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="pxFhTpCd";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="DRV3oqMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgEZOfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:35:25 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:37142 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726977AbgEZOfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:35:25 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QEYPCI031214;
        Tue, 26 May 2020 07:35:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=u3jT2OctnMOe8MwyIw5sI2Fw0KdWv8RgTdM7k9pvMwg=;
 b=pxFhTpCdUJWVCArmb1KJGJr0EMPh6dNnsMmEFKmYd96Y6oeh64l1VnvkNXXQywmENOLk
 IfIs1wJc/Lnz6WJCks9IvEh7VzJdgD/5DA1w79FQfGQKlpvUtIDXkc4pgiPgz9tIY70j
 sxxtlxG5krz5XxKIqKjyavyYxJ33nDuZnzketXWh4QU6JEjV6Iqtt9VD7U1mqe4uf+Eg
 XSPuRxv2xZ4BSXNX2XLQq9U6NBtfiIcyUwuOYBxS8HVwXDDHbpDh2O8SLLDV6+3xrfR/
 ROnafYSwXTeeT24UmgTIVlLbjj6/InbbkrzkRP2Pzt9JKv1+34lCBjXekrAw5839bUqc 4Q== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 316ye08qqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 07:35:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLlm4xtVsNT3pNkQ8PyjmV+ANcckjhiXJ2up+Mesz+CApwh3zrwj7g2I1FKMPWwd/KUqRTMtBR3c+tjChnBkM8kIecjBVzPzplhGcsB9Qm/XMnJGwOryob0m9ZSwp+xPFJ6uo/yfEFk5o8NTqL8xJm5l/B3JBk1G2GEfn/77CwK0n9fblEtcXPpzp5rPj33jXwZooJ+5u4MI8iJDPEALsREd5Fxy0ZXqULJPxPdKyL+if5NksADndDbHazbw5VHKyOx0VEL/MEqeYi+mGPS13xsNluDiN+UxLAM99JlyF9HVZSN2Bgwfzk12j9FwdsQ3D/5IdKw+XVVEKq4oXsR+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3jT2OctnMOe8MwyIw5sI2Fw0KdWv8RgTdM7k9pvMwg=;
 b=XtRwJ4bvoB8FswInauQuZATx1SPhipaVBKWzksQ0M7PlCYnWBsbEn3oqNjCZlWT31jXh6MdphRbH0rtHq0DYn4TOxZK5hZa7zB1eNfGZKySk7UHYiyY+n+GoWBItUaiHZSJ/7AM7UGvqwRIZr8GmNIcq0TgzHp0fBe9ob+mB9QULpyxb+3h35gFwdk/ytCLiQuKOyiWjNyPJGdhn7rAED/J7ELh6F9EYULs9zH3UA+I22jwRTV8AW0vo2+dxmPkPkBJcV3cv5GT8A4JX4Cg6Cn7FlLes8uQSBLiKZE7piEtOyhQfWTFTT3TTfm5n7DsKwAYV53jMXaUgPcUcvi+8mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3jT2OctnMOe8MwyIw5sI2Fw0KdWv8RgTdM7k9pvMwg=;
 b=DRV3oqMRl88qGde8/l71bnsqK728yB6ceIWWN6KrtNBmShQFTIoYpRmNllQaVwu35ZU3SJzYLgLjvN0ay3YNzwOHbcpAAmK9V4/ChWTJeP+XTXSdu9xhEbtUP+3V+rfaYH8rxha18fqMENUPK9oqeWdl5S51ENrYnLJRDFwzRhM=
Received: from BN8PR16CA0004.namprd16.prod.outlook.com (2603:10b6:408:4c::17)
 by BN6PR07MB3586.namprd07.prod.outlook.com (2603:10b6:405:65::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 14:35:13 +0000
Received: from BN8NAM12FT061.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::8e) by BN8PR16CA0004.outlook.office365.com
 (2603:10b6:408:4c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend
 Transport; Tue, 26 May 2020 14:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT061.mail.protection.outlook.com (10.13.182.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.10 via Frontend Transport; Tue, 26 May 2020 14:35:12 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 04QEZ8HC002019
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 26 May 2020 10:35:11 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 26 May 2020 16:35:07 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 26 May 2020 16:35:07 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04QEZ7OH015144;
        Tue, 26 May 2020 16:35:07 +0200
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04QEZ7hV015143;
        Tue, 26 May 2020 16:35:07 +0200
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <kishon@ti.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <maxime@cerno.tech>
CC:     <nsekhar@ti.com>, <jsarha@ti.com>, <tomi.valkeinen@ti.com>,
        <praneeth@ti.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 1/2] phy: Add max_link_rate as a PHY attribute and APIs to get/set phy_attrs
Date:   Tue, 26 May 2020 16:35:03 +0200
Message-ID: <1590503704-15057-2-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1590503704-15057-1-git-send-email-yamonkar@cadence.com>
References: <1590503704-15057-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(36092001)(46966005)(82740400003)(107886003)(2906002)(8676002)(186003)(70206006)(26005)(42186006)(36906005)(70586007)(4326008)(47076004)(5660300002)(110136005)(316002)(54906003)(8936002)(426003)(82310400002)(356005)(6666004)(81166007)(336012)(478600001)(36756003)(2616005)(86362001)(2101003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d64c937-1e1e-4a1b-741d-08d80181ffe2
X-MS-TrafficTypeDiagnostic: BN6PR07MB3586:
X-Microsoft-Antispam-PRVS: <BN6PR07MB35861884D510AEB91EEDC9F5D2B00@BN6PR07MB3586.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QoVWUMvgtXaCo9StsWPFqL9m6juBFaqzBUBg9N4GNJeChl/Z85DKSGU2LAlnAo2/RTNepu52CgMwRtyWXjGtd2ULfj93JVI4IlZorX9BHY0khDPv1odqGMz7R74Jughn2mPIptXyidIMaSMyxLxHtaK2jRUA34Py2h2X3a9ZUjciGXV2y8DsxJfb9k4OuM0dw7WUR7oTeFjG1p/Ca83s+fQD+3bGOgdO64DlhYocFY6vp0SvEHrTV4/Rt6Vz0CCR8wonVzGMe2Khd5sBpoXs10m7UCBTiYHJYPLAVfvPQivWPl7RCUUsoOlHObLMmwp6h0f3TItQzDSGouu7fLSax5Q66vEwWyBOdHX8kXTGwU6ryHU3Lo+vedWvNJKqczELhLStgbXDACdA29Ud1FLLOszyXzpWhtjYyUADd7VOxC6as4K/xqkB0EYDfUlEmAcy
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 14:35:12.8095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d64c937-1e1e-4a1b-741d-08d80181ffe2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3586
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 phishscore=0 cotscore=-2147483648 spamscore=0
 mlxscore=0 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds a pair of APIs that allows generic PHY subsystem
to get/set PHY attributes supported by the PHY. The PHY provider
driver may use phy_set_attrs() to set phy attributes that the PHY
supports. The controller driver may then use phy_get_attrs()
to fetch the PHY attributes to properly configure the controller.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 include/linux/phy/phy.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index bcee8eba62b3..48693321ae36 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -119,6 +119,7 @@ struct phy_ops {
  */
 struct phy_attrs {
 	u32			bus_width;
+	u32			max_link_rate;
 	enum phy_mode		mode;
 };
 
@@ -231,6 +232,20 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 {
 	phy->attrs.bus_width = bus_width;
 }
+
+static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
+{
+	attrs->bus_width = phy->attrs.bus_width;
+	attrs->max_link_rate = phy->attrs.max_link_rate;
+	attrs->mode = phy->attrs.mode;
+}
+
+static inline void phy_set_attrs(struct phy *phy, struct phy_attrs attrs)
+{
+	phy->attrs.bus_width = attrs.bus_width;
+	phy->attrs.max_link_rate = attrs.max_link_rate;
+	phy->attrs.mode = attrs.mode;
+}
 struct phy *phy_get(struct device *dev, const char *string);
 struct phy *phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
@@ -389,6 +404,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 	return;
 }
 
+static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
+{
+	return;
+}
+
+static inline void phy_set_attrs(struct phy *phy, struct phy_attrs attrs)
+{
+	return;
+}
+
 static inline struct phy *phy_get(struct device *dev, const char *string)
 {
 	return ERR_PTR(-ENOSYS);
-- 
2.17.1

