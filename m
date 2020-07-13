Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D0DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9012076D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WLPj+R0Q";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="qXvrpclR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgGMJit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:38:49 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:46558 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727890AbgGMJis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:38:48 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06D9R5oX006919;
        Mon, 13 Jul 2020 02:38:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=NiFUDVqolXL30tescA5XAC+FdhKhg601Ji7WXpt6UNc=;
 b=WLPj+R0QATmiOZdlLkbZd7GFzCoNepGuUoTcsSxidbMDztep8XcF+W4KZJl1EQXG68s8
 ZNLI7EHq5Tz+xVsFRp8rgFl/AgeA5MVTg3B42LO7HTmwrmXBUd1J7mpvCTfwhQYgzM4c
 yeJuQP7ka3f/GkSLuMOBgUcq329dlVGAxGO61U8xcxxQKPV3Wf0Cjf2WevwMRXzps8VJ
 kSQ1WgiPM2jezxoAZJnmisyHw8I0L82+CweRkxyu3hSQiZ0MolJe1yWRDqRI6asY3FRF
 ZLXZHJAPuaTHyJk6CYedfF9b9NdFSHnomL4Ig9BKPtUfkkIsoZsVrlNfJE6i+d40io/+ fg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3279yud45q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 02:38:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=be+ID3DN5QtF2X6/c8AclIULDUGWHtHUYsSsU9uELZdSMuIj0MG0K9n0bkRaVy0yTWJqJYtfRUsGwoPIVanHj3dlDNNFu+3KhXdNoiWU92FxclIBGlPhzPnT3AyDEBQt/nmFt06zRMbYNJNUKtTyDvPHUC8d4t1sP/oH8w2p2ACz5kUDVUQ7/i0p8JxYLKrUl0XvhY8OWkNtFuPJSmHMK4IirsTe02bZn5uU0NMhCmZ8rnOpMEw2S4YWLfgOuoZDxCmhE94q9ukkph5NJBv/Ehc+FjCHGvJEtxCe6ncoJ3aQqktjnkulwyDqSVCLmI8fVhZuYvHqlB6Fj6cdtMQqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiFUDVqolXL30tescA5XAC+FdhKhg601Ji7WXpt6UNc=;
 b=SXGicSZvZXrfQhSXeXHbIKMD/LDYEpa+e6IWJn6bBKJmIzD45CEk8sWpf6h1fcxTQ+X3utVqODtAcQWV20su/wFoIcwPL62oRIJva74uLbzw5R3YgKys0sXRHfiyOR866psX0P6YGLo6ysE0FyGOyjik4OZPlgAFMO9ILV0zv513IsP8J7OGMfVCaxN8rOm/qkM/+EZKiVwva9PDyP3YHmen5DCpz8TUDHga64zekKh00xsbVBfJi692G72bqNEhPdRdWCxjXQqMeKRbS9dI3G+Xc+MTV+ZHxEsxv7NXMZXGhYAFjfK7BmLISG7yf+cM7Y0cIxurVV+gZbFeMr/a4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiFUDVqolXL30tescA5XAC+FdhKhg601Ji7WXpt6UNc=;
 b=qXvrpclRIg3FFsGkb7SZDSwj4pbre6TjDX3/bkc5Eq5c/aaQAavAG0Ot8VMdtVMG01kkI26jP5stgRT/r9AadkSE2BkJaBlio952ekH0jMfX9KNzuRZhtPDwQc/llPa/EuplswfPOc5MZCRMn3USBvIz9oRsAIfqwdFE9BdrdmI=
Received: from MWHPR13CA0017.namprd13.prod.outlook.com (2603:10b6:300:16::27)
 by BYAPR07MB5765.namprd07.prod.outlook.com (2603:10b6:a03:9c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 09:38:38 +0000
Received: from MW2NAM12FT067.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::8c) by MWHPR13CA0017.outlook.office365.com
 (2603:10b6:300:16::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend
 Transport; Mon, 13 Jul 2020 09:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT067.mail.protection.outlook.com (10.13.181.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Mon, 13 Jul 2020 09:38:38 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06D9cYh6012105
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 Jul 2020 05:38:35 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 13 Jul 2020 11:38:33 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 13 Jul 2020 11:38:33 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06D9cX9J004212;
        Mon, 13 Jul 2020 11:38:33 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06D9cXV7004211;
        Mon, 13 Jul 2020 11:38:33 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <nsekhar@ti.com>, <tomi.valkeinen@ti.com>,
        <jsarha@ti.com>, <praneeth@ti.com>
Subject: [PATCH v3 1/2] phy: Add new PHY attribute max_link_rate and APIs to get/set PHY attributes
Date:   Mon, 13 Jul 2020 11:38:31 +0200
Message-ID: <1594633112-4155-2-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1594633112-4155-1-git-send-email-sjakhade@cadence.com>
References: <1594633112-4155-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39850400004)(376002)(136003)(396003)(36092001)(46966005)(36756003)(8676002)(47076004)(54906003)(82740400003)(4326008)(42186006)(8936002)(110136005)(316002)(186003)(26005)(2906002)(86362001)(82310400002)(356005)(5660300002)(478600001)(426003)(81166007)(70586007)(336012)(70206006)(2616005)(36906005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d564186-e1a3-4985-b591-08d827108545
X-MS-TrafficTypeDiagnostic: BYAPR07MB5765:
X-Microsoft-Antispam-PRVS: <BYAPR07MB57658F65F256AF2B1BB4329CC5600@BYAPR07MB5765.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1S8O0osxOrCHFvsa62COycd5Hh92z3taY2P0h3xEwKkHrdugAKNb3fyb/7/r5q3YZzsyv2kxnL6Yy5ksRvO2hlWmBThHj3qy4aNRFOaxPWdVo8pCh+Rw427pyptqN1KlRRJerBQld1IhRPgPpYatq9Bcv596SF5aY9Bq0b5EkBZOQnDuL3ngxVChUgFhi311Zz4rf9v3BKHKRW7qs3Lo02UMYfG2UjU9SVfqYZ2DqSJvI39aq+2pWukF62YrcT8pOMiKY31ffIkvd3eQp+tzkH6VCan2/7SIcZxRl1EZaVV/GLHibJV1x0rJzciAeX/bodWo7x83DeuyhtVEEteY3N1MUo6jw7o6vbizOp7NQ8QHgSRa46igXjcou7tdKdAd3aJ07WPUCB+r576yI8v+pLIjSp7uLmu5TWvGw5V/LY=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 09:38:38.0354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d564186-e1a3-4985-b591-08d827108545
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT067.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5765
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-10,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new PHY attribute max_link_rate to struct phy_attrs.
Add a pair of PHY APIs to get/set all the PHY attributes.
Use phy_set_attrs() to set attribute values in the PHY provider driver.
Use phy_get_attrs() to get attribute values in the controller driver.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 include/linux/phy/phy.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index bcee8eba62b3..7fb59359ab7b 100644
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
 
@@ -231,6 +233,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 {
 	phy->attrs.bus_width = bus_width;
 }
+
+static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
+{
+	memcpy(attrs, &phy->attrs, sizeof(struct phy_attrs));
+}
+
+static inline void phy_set_attrs(struct phy *phy, struct phy_attrs attrs)
+{
+	memcpy(&phy->attrs, &attrs, sizeof(struct phy_attrs));
+}
 struct phy *phy_get(struct device *dev, const char *string);
 struct phy *phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
@@ -389,6 +401,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
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

