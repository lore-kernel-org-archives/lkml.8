Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A3FC55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 05:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D93DC20857
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 05:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gLd7ltrm";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="5dVeQShV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDYFO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 01:14:58 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:5014 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725909AbgDYFO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 01:14:57 -0400
X-Greylist: delayed 2114 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Apr 2020 01:14:57 EDT
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03P4ZGpD012115;
        Fri, 24 Apr 2020 21:39:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=MqN/k1tn11u8dAwLdQH3r+vRyzKOV+MNaZ18+SCPNUc=;
 b=gLd7ltrmeHUxOxcSQLp7oDE7wRDY4Non2cfqujxia2IO8c7mz1Tl5VSoBU+luxKN2I6u
 X80lZer2DUHaTI1kbzfCz9YCINPKiN9CWt5+rA5kQ5fberjONwWTRSZhNqf5D45YRyIv
 BrS5J9FJehKAnPgFfFpKQTkuDgBVi/hVgFA2Xw5adN4dVd5pkWAL1Cr00q2ZYgphhhul
 /Eny7H6vwUXFterlyPastN8Oms659miUwHnXSN61aWPqTR/bj8ZTVKyfgfbnZt8OJS4n
 g4MnMnRk7R0UcG0G8g82xoWc3RzTRJR9DTGveB0BrcljwWqdqyAOe7KPX89JiWeuqurD ag== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-0014ca01.pphosted.com with ESMTP id 30fx3v56td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 21:39:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myZFcwrhIwoUzj/gUWKJPoPC/fSJ/hUV9OuOPRs1qJbjNnI+be6AsesN/eOjBlo3IQpDmAFHq1zN3y3OuAC1yJt3ZjzKWfQHssaKqWWhl1BcWAWGB6HDx0eX5W5MURp4qb5sPOLdaJ4ze79Y6UnbuuKbN6ONEfl6n/+FXseyxjAHtiKvGyqtPkaHr7uepKWTHnGKUR6OE2brCrUiPa2OaWa8PJiRfozqUAuusH/qrxLwJotgiUcp5LEOYgpAeADk2v0198z+m1cAg10lD10pSjr+AnP4Ps0lu0KiXauk2A/2Ydn2nAhuTYhW0RCWUCmTR+TBo3D+eB+f7BesVK0DcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqN/k1tn11u8dAwLdQH3r+vRyzKOV+MNaZ18+SCPNUc=;
 b=ic+BK9Oy0OaE3OseKXYojMxkF5W348KEDrIYyPvYbxTAXFpQodIRLbyIny7mfDtWOX9VToFZ52qoZqrEtJmhcV1rcqIst9sCSsdbXlCsyTzFIQxpQwIU+vK9ob2BaJe6MIt0fYE+tBVHkMuj+5ZBrOtuhsVEUI7tS39DzH7kco/wtWxLaRisiemv3oVb01EtBzVug/CafuuCWxIb4ynmH4H27jgAMiEZX8Xl+l658uBj5By5xqpfwGYu69JJbyEA18pOSn3fCV/8DTKqw/HZIVJJiuGthTecf95Wj1O9uXPQH0Y7UWDpNoXYUY2awnVK1+YhpcdjkQfvkPxYMhmyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=arm.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqN/k1tn11u8dAwLdQH3r+vRyzKOV+MNaZ18+SCPNUc=;
 b=5dVeQShVRRW1eELy9BHiq5jEhPvJsVzcl3zsmcRbCXIeAKmUKTBq/ZDROYuYro23C128G+lFqFm/W89mscDaweUYBIEA7DnsCE7uhoFpUI7CFckzUdF8bTIFqn6rP3XnSYz7e1l66vZNbl7hE5r7kc47kSpJ7Vm7oqmJwePGa3M=
Received: from DM5PR2201CA0007.namprd22.prod.outlook.com (2603:10b6:4:14::17)
 by DM5PR07MB3433.namprd07.prod.outlook.com (2603:10b6:4:6a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sat, 25 Apr
 2020 04:39:30 +0000
Received: from DM6NAM12FT032.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::3f) by DM5PR2201CA0007.outlook.office365.com
 (2603:10b6:4:14::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Sat, 25 Apr 2020 04:39:30 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT032.mail.protection.outlook.com (10.13.178.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Sat, 25 Apr 2020 04:39:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 03P4dMOt218050
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 21:39:24 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 25 Apr 2020 06:39:21 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 25 Apr 2020 06:39:21 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 03P4dLpY016488;
        Sat, 25 Apr 2020 06:39:21 +0200
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 03P4dKEF016479;
        Sat, 25 Apr 2020 06:39:20 +0200
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <kishon@ti.com>,
        <mark.rutland@arm.com>, <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v1] phy: Add max_link_rate as a PHY attribute along with get/set APIs
Date:   Sat, 25 Apr 2020 06:39:20 +0200
Message-ID: <1587789560-16440-1-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:unused.mynethost.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(36092001)(46966005)(36906005)(107886003)(4326008)(8936002)(2616005)(82310400002)(356005)(26005)(478600001)(47076004)(426003)(186003)(8676002)(336012)(82740400003)(81166007)(42186006)(2906002)(316002)(81156014)(70586007)(36756003)(110136005)(54906003)(70206006)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e721a722-3c4a-4cfd-3300-08d7e8d2a4be
X-MS-TrafficTypeDiagnostic: DM5PR07MB3433:
X-Microsoft-Antispam-PRVS: <DM5PR07MB343364FA9D38E2C05BE16CA2D2D10@DM5PR07MB3433.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0384275935
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odHrzb9MVCrG/WVBQdbHVCbiVIaSdIZFTza8vhqY6X6pQFXypndeG0aVvg8/u7dgA59RgYXKRENwR9h7oe+VuFnm6/Re6VqHDbX1jgoC1I9g5ocxJruG1tc8001mM3m23b0SjmPQAaZINOR1jlm6egQCXkDp0/iBKvEzviAuaI9pBfS44ZdGol/ew0pbchcY2LXUguNYOeIqT51iWDPfiJaNa6/wHk0/uO1RzRc8L7bwkMa61PVKXGuIUUkr2VczX7ck0WqFt6K7CBloPxrKPERh/78mmzLJXiaSslscrgK9cLgVdzQB7S0/2NgFP11FdVtco+kdsbnYJqVBiPHCznVcDwjLvGJWdTgEw7jO5Kjs/ja4FZckpANV/VxOWmHjftt5qLC0OK9fNv1WJlwVmbClH5G9XU/1IC5eFXNxdWPS+qnq2tDVbpG+RX0EtQnwHIK6SOhL6RW7cKGTU7LgASilbQBfRWBZ5L2VsM58wgXUh/9F22MLH0fD6pDWJEuLlYuY+hT/RwIxb0rmjepMKQp5oxmO6mZX9mbNWfZzMVk=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2020 04:39:29.9879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e721a722-3c4a-4cfd-3300-08d7e8d2a4be
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3433
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-25_01:2020-04-24,2020-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1011 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004250038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds a pair of APIs that allow the generic PHY subsystem to
provide information on the maximum value of link rate supported by the
PHY. The PHY provider driver may use phy_set_max_link_rate() to set the
maximum link rate that the PHY supports. The controller driver may then
use phy_get_max_link_rate() to fetch the PHY link rate in order to
properly configure the controller.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 include/linux/phy/phy.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index bcee8eba62b3..a8b7b4a2b8de 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -119,6 +119,7 @@ struct phy_ops {
  */
 struct phy_attrs {
 	u32			bus_width;
+	u32			max_link_rate;
 	enum phy_mode		mode;
 };
 
@@ -231,6 +232,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 {
 	phy->attrs.bus_width = bus_width;
 }
+
+static inline int phy_get_max_link_rate(struct phy *phy)
+{
+	return phy->attrs.max_link_rate;
+}
+
+static inline void phy_set_max_link_rate(struct phy *phy, int link_rate)
+{
+	phy->attrs.max_link_rate = link_rate;
+}
 struct phy *phy_get(struct device *dev, const char *string);
 struct phy *phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
@@ -389,6 +400,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 	return;
 }
 
+static inline int phy_get_max_link_rate(struct phy *phy)
+{
+	return -ENOSYS;
+}
+
+static inline void phy_set_max_link_rate(struct phy *phy, int link_rate)
+{
+	return;
+}
+
 static inline struct phy *phy_get(struct device *dev, const char *string)
 {
 	return ERR_PTR(-ENOSYS);
-- 
2.26.1

