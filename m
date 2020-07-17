Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABD2C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C60B20734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="QiiFffX6";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="JVrzybPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgGQGuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:50:51 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:1596 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbgGQGuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:50:50 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06H6ma2u022001;
        Thu, 16 Jul 2020 23:50:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=XLffi3O7Ko+5FQ+6WSX30S+TSLKNTsCrwENw5mCnxjU=;
 b=QiiFffX6tezfCvEBNyyuyRXKS5Bb9JH3JWil7S4toa/LgXjVV/rPyKZdE4yDICd+1/1N
 /+k+E/Yvw5Pi7onxEclZh2GurOMu4CxZ6h9XWt/voIWRVVZswyWYXGIo1Fy1iKIDx/jH
 KfTVFuA4OWIasKQqLBbzPBXhcVsUHMsiimmwNx1PK51eullaQBlJa4vY3XmB99tsKUwt
 KmqZsmnIYrN97iQcB/57m4/Z080ujB6RaOWCXpJopSm0ORpigkGTdjKNERjnZ/5hFOXu
 YWQoK/yavYFvi9/UuCmbM+E24GXBmmYntP0WR3zlr9OPC26POzN7XbQGvDBNk533HNK+ cA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3279yux5qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 23:50:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYkXKxUJp4C29scpQ1meeUCBP4dmos7wQ6rW8W4wwoMV/CVc61ha2fxOZuBaPosyLAbgy5lWf/o7d0kXKxWC564cWBEoXElHMoq/sfMJe/FITq4MesyR310p62NDVXuY2CML418jr2w9T/1LmQ7MZUa1e4Bxlxo5LLBUgEQ68PZWdrdj15MjCh5m4n2ahIi+wQWjOjZXzv/c3c9DvoJNB6ET1IaYiHel7dMR9l/W4EdMmTaZ2N07cCCucu8BINBdhS7hTLDH5PZzUvrx91P2N46CwfCrwI1EP/aCDw1+K1MVvJjH7tHYLSm3sj/7u3Y9yxEQd7gx8M/UeNN93HWTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLffi3O7Ko+5FQ+6WSX30S+TSLKNTsCrwENw5mCnxjU=;
 b=fxrOiS224PX+E4bZALaHohfZHQ1cvNoRwLKvx9ctUl2PZGWGfmr68zRqUyUSYCBGwfOQI3m1kMwg98bBX3xTNbQasRftPf59e54P/DBSss/XuEUnoWSHe8rQRSXcWBbuoFE4j+CyxzD5VZrDzPg8rzSuRpM03RL9W7ETYx/tmTUTLOnex73ygsccm1SRD8SndN2hwUmx/xhjDAlz+Sks0H9LlqDZ+LmYAxxvq+aLBiW/1g+CCxUKEoelrWkLUmkm5ihe6xotsELfwd31Ey/nk7ECpapWY6zc+AXRd+SxgMjeLXgCFduI1Z4kbrSyRhkRyOIPXl/SrXBMLrBnTU+Pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLffi3O7Ko+5FQ+6WSX30S+TSLKNTsCrwENw5mCnxjU=;
 b=JVrzybPNoIQqYDLIjZDhkKT1Qz1oUUEVEHMQxHTP5k0TkLUbxAm8ZrVihUWL1XQMgwXejC0qaPQbyZSPy+4u8iaDOQ0QaHKTxxtvikD/me3UISgcvtJ4F2Dj829V16U8OebPMump17pM6vqNe8IC+X5upkeY20MT3k1fhZeo3vA=
Received: from MWHPR20CA0038.namprd20.prod.outlook.com (2603:10b6:300:ed::24)
 by DM5PR07MB2924.namprd07.prod.outlook.com (2603:10b6:3:a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.23; Fri, 17 Jul 2020 06:50:39 +0000
Received: from MW2NAM12FT051.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::3c) by MWHPR20CA0038.outlook.office365.com
 (2603:10b6:300:ed::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Fri, 17 Jul 2020 06:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT051.mail.protection.outlook.com (10.13.181.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.9 via Frontend Transport; Fri, 17 Jul 2020 06:50:38 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06H6oYLp016347
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 17 Jul 2020 02:50:36 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 17 Jul 2020 08:50:34 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 17 Jul 2020 08:50:34 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06H6oXtN012582;
        Fri, 17 Jul 2020 08:50:33 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06H6oXw8012581;
        Fri, 17 Jul 2020 08:50:33 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <nsekhar@ti.com>, <tomi.valkeinen@ti.com>,
        <jsarha@ti.com>, <praneeth@ti.com>
Subject: [PATCH v4 1/2] phy: Add new PHY attribute max_link_rate and APIs to get/set PHY attributes
Date:   Fri, 17 Jul 2020 08:50:32 +0200
Message-ID: <1594968633-12535-2-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1594968633-12535-1-git-send-email-sjakhade@cadence.com>
References: <1594968633-12535-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(36092001)(46966005)(36906005)(70586007)(26005)(36756003)(356005)(47076004)(2906002)(82740400003)(2616005)(5660300002)(478600001)(4326008)(336012)(83380400001)(70206006)(110136005)(86362001)(82310400002)(42186006)(8676002)(8936002)(426003)(186003)(54906003)(81166007)(316002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aaf563a-3efa-4cba-19cc-08d82a1db74a
X-MS-TrafficTypeDiagnostic: DM5PR07MB2924:
X-Microsoft-Antispam-PRVS: <DM5PR07MB29248F169F25D16DF1B4B9C9C57C0@DM5PR07MB2924.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 15ptmTtyh8J1j+JBvQhhSKpAIPKNusxprXFH7CIm0LU0xS3j2SHXByHd9FgpTz5iEuzqSuTz4C2/y3xo1cbuJCxu1P7+XFiRtedSurLtNjps3dwpO0qf4umwmTTk+J25kPHfOqiAISkswL9lVyPXS1CZlc+cg8bF/97RGPxKkqqWAX3CnIqiolShOwThmL1RAjCXt2ia1JlH3rDJI11VSpsEO1sut/UbPTw0tDYxPSNgc2SNY5jLbacqTfmK3m86wxD694qyUg/K5YrDFflulSRU2zLW32fqrawVw3XIjz/mXb2Ge/nK6ZFgw27mJ9Z1D26tzaoH/e3+FXQFHlnE4XXU7Ed76EKp+AEL/KUsjBwGPTX5g0WqyyLw66p2p6wUl6jIFIqkRwyKQ9N2JJoB2Rs4/YOtVHGmSqL3uooMG2c=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 06:50:38.8961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaf563a-3efa-4cba-19cc-08d82a1db74a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT051.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2924
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_04:2020-07-16,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007170052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new PHY attribute max_link_rate to struct phy_attrs.
Add a pair of PHY APIs to get/set all the PHY attributes.
Use phy_get_attrs() to get attribute values and phy_set_attrs()
to set attribute values.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 include/linux/phy/phy.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index bcee8eba62b3..5d8ebb056c1d 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -115,10 +115,12 @@ struct phy_ops {
 /**
  * struct phy_attrs - represents phy attributes
  * @bus_width: Data path width implemented by PHY
+ * @max_link_rate: Maximum link rate supported by PHY (in Mbps)
  * @mode: PHY mode
  */
 struct phy_attrs {
 	u32			bus_width;
+	u32			max_link_rate;
 	enum phy_mode		mode;
 };
 
@@ -231,6 +233,20 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 {
 	phy->attrs.bus_width = bus_width;
 }
+
+static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
+{
+	mutex_lock(&phy->mutex);
+	memcpy(attrs, &phy->attrs, sizeof(struct phy_attrs));
+	mutex_unlock(&phy->mutex);
+}
+
+static inline void phy_set_attrs(struct phy *phy, struct phy_attrs attrs)
+{
+	mutex_lock(&phy->mutex);
+	memcpy(&phy->attrs, &attrs, sizeof(struct phy_attrs));
+	mutex_unlock(&phy->mutex);
+}
 struct phy *phy_get(struct device *dev, const char *string);
 struct phy *phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
@@ -389,6 +405,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
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
2.26.1

