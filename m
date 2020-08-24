Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066E9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCDF220738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="EhLHsg3j";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="NjyHo9/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHXS3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:29:25 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:61678 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727043AbgHXS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:28:54 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OIPiT1006088;
        Mon, 24 Aug 2020 11:28:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=/PrWJs8HnhxKbmNeYhWGHLuLFBM+vpMPq1dOtLrwKVY=;
 b=EhLHsg3j1YxrcAVsOKlsCw0VTHvbDCPogWOmBO8cRpUTPx1z63iS7I5GB7s/+bu/fJIt
 p4YKz0itUT3H48ldM3PVvKAw/YD+KdWyTKc2TELy0R2RJtoP9VvtZbAm6HMp9cU+baiY
 LsiFY3NMNBEM40+xryU5AflZPrsDF6QJSB9/R3b/Yc+gQbcsjWMwJ1Dq9VcAp/UbWtu6
 ac+jf5zrlZJh/lGIrpGIuO8rCkiiK2IJlb9+1wAC/NAjAVhr49inp2ntO8k9AqHHItt4
 zbx2mrMKnd3oz781LRSc2f+ZHSRQ9Y9uZBECj0qK38VBEEyfmRep8UUTnnR3XqDCiqZA rA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 332xxwyw6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 11:28:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKEef7sNZtKfpfKljIF3lRPULMCJOwTmDd7I0Zy3BelTHqAUjagsIJ27TqMxTCTZ3R3IICG9x3ARhXMQM7Xp6QVJLAR0om5z48w9tD88xNqBY5S7LpzIHlwYzktTqGRZPj7TWemAl9/bX6em825OxdlT/Pn/HdUlLB7+yOh9ykdaER0weeyZ88Zz+ky9V/sJjYta2Oj3IlZkI0LP3VW74zSLvGB5+hTMw//2TDjAQrOUhwBLggCpnhEVwwGLyXc76jU5Ey9jPjk4wKSf5rQxPqBcBPLizf+4z+DuizhBb5ef0IEGYVorfG72RZElyaMDrUC930IVO/UAaWC7sxhcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PrWJs8HnhxKbmNeYhWGHLuLFBM+vpMPq1dOtLrwKVY=;
 b=ApdgQDJImttixKXKYaTkN3Si2Nbu2az2byv69dyIP2tdCgSPyoIKuORL3EZOSci/w3hNSuQIl2cmBqMm69LncO7fdhFwiex3sgKU/Oego5ewS8NCOE9p2YdSoci6Xpwvry49JcUHgAFy0fVHl53Qc56BKjkg5NdAb53rZpCc4jmQHHT8R9RBkaiEA8UNmgzp+REvDxcnHquQqEeEv9vSsOn3CJROXePyL7wRsOq9zieNy+xtajfYVNVi0W49dsybjv2YUrgEqwRLFRVAvrc1LMpDuyEL0gTqKmuOPuDtQMIxSRxycJpe/41nGCUfPSCyS5oZaIUGDAXTi+ChJbOjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PrWJs8HnhxKbmNeYhWGHLuLFBM+vpMPq1dOtLrwKVY=;
 b=NjyHo9/SAWfczHBcSAsWINSmHIZftKqB5NnNeHOxzBB3Qzlau6e5ZQ4pjzjuffWxwEeWZ713e19IXgiA5BD00croz7rJAxRodD3hWpcXv4P6J3cu2DlL8zZwwRcfRrmP7Mrvj8V+mUctku3Wu96k+/FHujTUztEfL21Aue0Ag40=
Received: from DM5PR1401CA0010.namprd14.prod.outlook.com (2603:10b6:4:4a::20)
 by MWHPR0701MB3675.namprd07.prod.outlook.com (2603:10b6:301:80::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 18:28:37 +0000
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::86) by DM5PR1401CA0010.outlook.office365.com
 (2603:10b6:4:4a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Mon, 24 Aug 2020 18:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT056.mail.protection.outlook.com (10.13.179.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.16 via Frontend Transport; Mon, 24 Aug 2020 18:28:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07OISWio013830
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 24 Aug 2020 14:28:35 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 24 Aug 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Aug 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07OISVtA023414;
        Mon, 24 Aug 2020 20:28:31 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07OISVXr023413;
        Mon, 24 Aug 2020 20:28:31 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>,
        <Laurent.pinchart@ideasonboard.com>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <nsekhar@ti.com>, <tomi.valkeinen@ti.com>,
        <jsarha@ti.com>, <praneeth@ti.com>
Subject: [PATCH v5 1/2] phy: Add new PHY attribute max_link_rate and APIs to get/set PHY attributes
Date:   Mon, 24 Aug 2020 20:28:30 +0200
Message-ID: <1598293711-23362-2-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598293711-23362-1-git-send-email-sjakhade@cadence.com>
References: <1598293711-23362-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcafca83-6db4-46e1-6701-08d8485b844c
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3675:
X-Microsoft-Antispam-PRVS: <MWHPR0701MB367531F5805EDF9425C520D7C5560@MWHPR0701MB3675.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olMnhYnnqqH7UHd5UFXCYTuB8ZCA9vaQwQ/Lsf35XvlphcQoMD4hXuIXkTbeh5QANVkaCjjrMg99oinmy8/5XEhXaLhDQ2zJtgvj54PUKRu2cRkgsiltiBthCLEZK0C0Hjh+2gKHyYeprWWk378AsyQAp9udV17ZcssQSZzej3GklUmQ2y1pYhbvGp4YCs6XMC3OmEvMMqmrGa+JRxf2tdtbEWotatUviymaY5kyCS9Z+vAuWX9gK8q2W5g9iDSgicvRR8dcneeIv7BMedzC70a+H2XTpCMyNG4D7gH58+tnY6yrMw1ulcuc1R7CUcI0vrOxOuZhHaJtVsJPNvaI6aYh6lF3YdzxwnvYlHUHNaMLxVXRwZD1hHlh43iMIqd9xM0Bkw/laLD0AXi9SHB1FjvIztfa9MbGuO5s83+taSM=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(36092001)(46966005)(478600001)(26005)(186003)(8676002)(83380400001)(70206006)(4326008)(8936002)(70586007)(54906003)(82310400002)(356005)(2906002)(2616005)(86362001)(5660300002)(336012)(110136005)(82740400003)(316002)(426003)(36756003)(47076004)(81166007)(42186006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 18:28:37.1009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcafca83-6db4-46e1-6701-08d8485b844c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3675
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008240150
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
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/phy/phy.h | 43 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index bcee8eba62b3..924cd1a3deea 100644
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
 
@@ -231,6 +233,37 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 {
 	phy->attrs.bus_width = bus_width;
 }
+
+/**
+ * phy_get_attrs() - get the values for PHY attributes.
+ * @phy: the phy for which to get the attributes
+ * @attrs: current PHY attributes that will be returned
+ *
+ * Intended to be used by phy consumers to get the current PHY attributes
+ * stored in struct phy_attrs.
+ */
+static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
+{
+	mutex_lock(&phy->mutex);
+	memcpy(attrs, &phy->attrs, sizeof(struct phy_attrs));
+	mutex_unlock(&phy->mutex);
+}
+
+/**
+ * phy_set_attrs() - set PHY attributes with new values.
+ * @phy: the phy for which to set the attributes
+ * @attrs: the &struct phy_attrs containing new PHY attributes to be set
+ *
+ * This can be used by PHY providers or PHY consumers to set the PHY
+ * attributes. The locking is used to protect updating attributes when
+ * PHY consumer is doing some PHY ops.
+ */
+static inline void phy_set_attrs(struct phy *phy, const struct phy_attrs *attrs)
+{
+	mutex_lock(&phy->mutex);
+	memcpy(&phy->attrs, attrs, sizeof(struct phy_attrs));
+	mutex_unlock(&phy->mutex);
+}
 struct phy *phy_get(struct device *dev, const char *string);
 struct phy *phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
@@ -389,6 +422,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 	return;
 }
 
+static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
+{
+	return;
+}
+
+static inline void phy_set_attrs(struct phy *phy, const struct phy_attrs *attrs)
+{
+	return;
+}
+
 static inline struct phy *phy_get(struct device *dev, const char *string)
 {
 	return ERR_PTR(-ENOSYS);
-- 
2.26.1

