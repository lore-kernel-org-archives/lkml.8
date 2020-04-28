Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC78C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415EE206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="he537WK9";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="lWqr+mlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgD1HKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:10:24 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:62544 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgD1HKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:10:23 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03S78Klr013117;
        Tue, 28 Apr 2020 00:10:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=MqN/k1tn11u8dAwLdQH3r+vRyzKOV+MNaZ18+SCPNUc=;
 b=he537WK9WsaODCxmhC6MkwCedIbYIN67PsTQl95EWxbSWZKdnPeUiW3Sh4GtPMum2esM
 ZoGVx3Kk0I9s6pEMSphp/fX0Dbpp7MoV12/unJGoO/pdhMqQHG+Csw5PW1ZAmmBQzD94
 Mgi+AE50MOqHujLUYxonSWJDrS7tX524dZ+R9LDIsimqFnqPtlthMP2Z7mts3I1auVu/
 8nsjiBKttuKlQczDsqd/bX98dbkquShdCG3TwG5S+I3PVl4GxdurL/4Iek/46G4sJ5Ta
 TGt94hlOwIGjhXbOD0tOJ5BH5sWObkKWmMlwkeJ8QvXLWH6IVg1bYxo7UTQEGn5eYs5B Og== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-0014ca01.pphosted.com with ESMTP id 30mhrv2xqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 00:10:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drGcKee342QwGME6gQ91czxyJp8OulGqJXmdA6RkGS/TLiqifhwrnNoCtWog2AAyVVGflUpKPFMC/klOCE85yDHaUW4Gaqi3MHY78KXwIK1xFr3YZc298VIzejZLE9dC78naBU7dHkq3ui7MbC6fvfAzJ9A8YDAlXrxBz3CbePQtgGZNJf9d/j99WiDpTed9wZrMLiwKgg5XDMeuZ2dWROD28qKw/OCwZyZtI9UFIdKp+sMiCKqlLc84So8O4yzOA6lKjGORIefz5s33l9D0haoU3C8xNlfOah+DlFZtHK8BbNImi3CjhNnWLrVkjjU2NcCEW3QR3mFeNQczOYRi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqN/k1tn11u8dAwLdQH3r+vRyzKOV+MNaZ18+SCPNUc=;
 b=QRAdcA6nmqLic/lpbVMVney872IpHZbkUWzQIYd/aqek5wSnvRS30oEuGLS8zh8saozQp1TXTitCHHZRThYb76WhROX8sFcWIDZm/B6W1o+vEo4Hq6fBCRv60ZIZwsnqrtmsxT66V+F2Vzt5B30Caot6fBJAJIKY0KDbEU1zmxcPevdQeVSXxTvUDcWGeAcvySvuOm9uMhF2Ovjzo+2EVJzNk0WdS8suz5+nqJJuvEhGE5m2tToTe1QQyrdcj/JRRXOto59kcswepmuJFoCOz7Awum7p5sx5fKujPxI+5Yy3rKhrjifDiTKJXA7GDEqxv5xjqaR7l9VSePeKHp6jcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=arm.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqN/k1tn11u8dAwLdQH3r+vRyzKOV+MNaZ18+SCPNUc=;
 b=lWqr+mlLKFFGs47nYK0d9D31u+Dq3m9SEiZkWiTH3+vzKqkdl4o4zyik9TQA7p4nCPps+BOCHZXUQqsxtvpVGWupsBWWQg5Lcpmja7rd+ib+pl4PWNx0r+hKi6p8bWCczq62obw99GnuIChFDJnG7neldM2W9Ac/TW7uHLij32M=
Received: from BN6PR13CA0005.namprd13.prod.outlook.com (2603:10b6:404:10a::15)
 by SN6PR07MB4398.namprd07.prod.outlook.com (2603:10b6:805:5f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 07:10:10 +0000
Received: from BN8NAM12FT008.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::ee) by BN6PR13CA0005.outlook.office365.com
 (2603:10b6:404:10a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.14 via Frontend
 Transport; Tue, 28 Apr 2020 07:10:10 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT008.mail.protection.outlook.com (10.13.183.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Tue, 28 Apr 2020 07:10:09 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 03S7A6aT203012
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 00:10:08 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 28 Apr 2020 09:10:05 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 28 Apr 2020 09:10:05 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 03S7A5VF029222;
        Tue, 28 Apr 2020 09:10:05 +0200
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 03S7A5ch029221;
        Tue, 28 Apr 2020 09:10:05 +0200
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <kishon@ti.com>,
        <mark.rutland@arm.com>, <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v1 1/2] phy: Add max_link_rate as a PHY attribute along with APIs to get/set its value
Date:   Tue, 28 Apr 2020 09:10:03 +0200
Message-ID: <1588057804-29161-2-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1588057804-29161-1-git-send-email-yamonkar@cadence.com>
References: <1588057804-29161-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:unused.mynethost.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(36092001)(46966005)(54906003)(82310400002)(26005)(47076004)(356005)(426003)(36756003)(186003)(336012)(8676002)(36906005)(5660300002)(478600001)(2906002)(81156014)(8936002)(110136005)(2616005)(42186006)(4326008)(316002)(82740400003)(86362001)(107886003)(81166007)(70586007)(70206006);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f47d04d6-442d-4d79-2e8d-08d7eb433005
X-MS-TrafficTypeDiagnostic: SN6PR07MB4398:
X-Microsoft-Antispam-PRVS: <SN6PR07MB4398E1F594FDF7CA84443BC4D2AC0@SN6PR07MB4398.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0387D64A71
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fyr1l4MVQjvLag6QDUBG33Dd3lFBGEM2LTxnGRfjnIiLhVMzbkF5Bc+ZaF425TOApDTwkWxTstAl6UHQfQg/qn0C5ZICu6GCXW2D6Pivk1IHk+4MXUx3XetlBGETn3WT8jqfFt81qb8RS6ud8KVNhz9LYrzryhh3stIFfznW2v1Lxw4LoVI0Qn5932H1HTXMHPFH/rRy/V0W2stGFHcpUCrP0RKsZYqZkyCT4T7KUptWEGzrol9I1q9meOuSVKtNeyMogkLXspfqLcXWF0b0hMOq94GCcbim8vvQKv86GIAu7gAnU0e3+FjyYTgtzRxeKh+Q+kmcJ//f4ho+8zakOQcFdFCze6ZR0dZwPhd3fK2Xh3m4HWMWEvByfn3qFsv3LE9Yc4+gKSVx2tXC0RQxVSlkzNedFHKwxycFldngh4Zg2M8PUT+yWtYsQQw+amo3oQpovD1gQtI200iBlSv8eKHn/6RZn//d0eRy1EAvkHsUlTb8D0nCKR4vHvdUbWjYQv/WRrOLZypR95jv6tOi/Toysdty18ZC+V4IHZNpiCo=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 07:10:09.5777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47d04d6-442d-4d79-2e8d-08d7eb433005
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4398
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_03:2020-04-27,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280061
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

