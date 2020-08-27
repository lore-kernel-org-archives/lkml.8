Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91446C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681552054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="frIpTeIo";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="tUPp/Cvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgH0OvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:51:25 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36870 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728117AbgH0N3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:29:12 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RDS8g7004810;
        Thu, 27 Aug 2020 06:29:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=K6qOnJN6usSCAfPPATIMyYfgLkcxVTCLrAjaeLhc8tA=;
 b=frIpTeIo8WunaY9mrSnvAos5Zi/+KnAgxlj75+CqOe313LnsF/hy4+e5JWm/fTM9z6/E
 JYS062expZblA6FEnGTtYlJxRf89ZgGG6L0Pwu+XWn4TuZjQ6fzR8OlZ92TtE1xl0w9s
 kFhiDCobib6KtWkSagI8bfcIb8kuW6U61f3e5IanzZLsMj92mdw7t3cAIAoCABDoPTPP
 bKBzd/NB5uzrhOkhoZrC3DyxIVCfjBTiDnoN7ZKzWtMMGVMPWn/9zNcMwVCAS30xXB7z
 rRo/wEpO8cQyqOk3dMeT1apdsOsYeozf5BPJW+tNvl2mXe4PusUwWkhfrVv44ihZ9N/U mg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332yww45du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 06:29:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yc+KFcif1nAxunSvDyJsUJNM0m/OhwnFKMghQcYE9CTEU8GQPq58sPkN4hwf5vAf8uYib0il67VO7Tfz8spLASqhMAtWCIkJuvcI+ZVFWxV8qP4Fr0999wIM1MMLVQ1F7izdG3cmNGuzVXl8+Zb3KLV9xdAwuupA2d/oiEpNzWD2JlY0doohvHfxWTIl1XX3rvknN/QgCiKz6ajZFrjgyY2dmu7A1Fdpdd/FB55gpISkq/C6dAj5OJ7Ymjd5PyvHTOUbQk50fs2OD+junQVqSWQdAQmJ3BKufKmrYx0txa49dsPVfOIpAY4Gso2b9ln7C0qQ+Uw4OFGNMm7cpGW93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6qOnJN6usSCAfPPATIMyYfgLkcxVTCLrAjaeLhc8tA=;
 b=IWfc96kR656krnMOLWRKZs9yhzsnaAUlBkAnNXwSvRJnGqieX6ATIvouZCuFy7yT3K4MQzY8yfsIx09j6nIIviANGmo1xejPyOyKjgnKI3k4pII5O6qx+YP2Tp8GfzV41uVXKE9lCXWx/qgRAY2ggzMAl7ETkSLrG1re3J0kI4mfm98juP34nadYUbzP8pXxmmom4uIJ4digWNmyVvMJNi2Yy7sypg4pPpT/wU5/i3b9wvYBMh0f5ClJrNZY5xCvFY/aFTdjrppkDqTbFUmOHHUIj3Lv4JwlwLyEBc4w8OCA/R2GIOpzbyY9/kj3w0oyzs/Tj2X24TKmDcW3c6I3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6qOnJN6usSCAfPPATIMyYfgLkcxVTCLrAjaeLhc8tA=;
 b=tUPp/CvciF2IJIY8jOZY/c1fEkYkT0Lnr/p0+mMANFftO63aAiahL1UTcGRwjZkToS8Rxawy4Yus9vSHfr/IwDO9dsiYlfAhmXvaIrtjuIdy/RMWzNFQnIR11fkPzlcSzQlgXmOQe9qBXWj/RB3p/baNQqHkVQFysc9gdH35C2M=
Received: from BN6PR17CA0052.namprd17.prod.outlook.com (2603:10b6:405:75::41)
 by BY5PR07MB7236.namprd07.prod.outlook.com (2603:10b6:a03:20b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 27 Aug
 2020 13:29:04 +0000
Received: from BN8NAM12FT061.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::d0) by BN6PR17CA0052.outlook.office365.com
 (2603:10b6:405:75::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 13:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT061.mail.protection.outlook.com (10.13.182.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 13:29:04 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSrRm001550
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 09:29:02 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSsde018762;
        Thu, 27 Aug 2020 15:28:54 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RDSr00018761;
        Thu, 27 Aug 2020 15:28:53 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 6/7] dt-bindings: phy: cadence-torrent: Add binding to specify SSC mode
Date:   Thu, 27 Aug 2020 15:28:51 +0200
Message-ID: <1598534932-18693-7-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
References: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6fb141e-ea8f-4572-9f3b-08d84a8d2ab7
X-MS-TrafficTypeDiagnostic: BY5PR07MB7236:
X-Microsoft-Antispam-PRVS: <BY5PR07MB7236DE97B06D1DB8A09E5B80C5550@BY5PR07MB7236.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10IxYQIX7fjcyUGW5ns+6qwFLtjUdWJCGxCvPSOGd+NIlDJt39syiGO53eXqHR7NqUUl7g8vEthvNYYMzVCwV7HC6W/xxM5pDhuzdX//7ktCkxHf3eET1Ts6t9XhOwDPix8Oh0sqMhP95Xao+DNehOStOgIFe/2JZ+348j8SYKXXd5DgLUIIG4XWIx7/wi1g5d5KhNjPEiWD4nm3VBUZbjlKa5odsC8Va1e2qOTQ6vnDRM4nm2kqxisvi0Z6XYGdtlAZHsazrvZOofV04O8WeLdegI7y6hr2A3lZpjBnjl9YTV8D8ujnk4Ikvv/iQAoH/IQK0opFhLlRix9LEGDF1EdqQCO9wFnTBYYmQbTerXv232BoPNqC65MLrHtkzFGvfW3iPdE2CIfhApKxnYDPsybLHjkXiFjr42cTUbj7VUA=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(36092001)(46966005)(478600001)(8676002)(54906003)(47076004)(426003)(316002)(70586007)(110136005)(2616005)(70206006)(82740400003)(186003)(42186006)(36756003)(4326008)(8936002)(83380400001)(2906002)(336012)(5660300002)(356005)(81166007)(26005)(86362001)(82310400002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 13:29:04.0176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fb141e-ea8f-4572-9f3b-08d84a8d2ab7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT061.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7236
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=934 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding to specify Spread Spectrum Clocking mode used.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/phy-cadence-torrent.yaml           |  9 +++++++++
 include/dt-bindings/phy/phy-cadence-torrent.h       | 13 +++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 include/dt-bindings/phy/phy-cadence-torrent.h

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 4071438be2ba..a7ee19d27c19 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -87,6 +87,15 @@ patternProperties:
         enum: [1, 2, 4]
         default: 4
 
+      cdns,ssc-mode:
+        description:
+          Specifies the Spread Spectrum Clocking mode used. It can be NO_SSC,
+          EXTERNAL_SSC or INTERNAL_SSC.
+          Refer include/dt-bindings/phy/phy-cadence-torrent.h for the constants to be used.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2]
+        default: 0
+
       cdns,max-bit-rate:
         description:
           Maximum DisplayPort link bit rate to use, in Mbps
diff --git a/include/dt-bindings/phy/phy-cadence-torrent.h b/include/dt-bindings/phy/phy-cadence-torrent.h
new file mode 100644
index 000000000000..e387b6a95741
--- /dev/null
+++ b/include/dt-bindings/phy/phy-cadence-torrent.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for Cadence Torrent SERDES.
+ */
+
+#ifndef _DT_BINDINGS_TORRENT_SERDES_H
+#define _DT_BINDINGS_TORRENT_SERDES_H
+
+#define TORRENT_SERDES_NO_SSC		0
+#define TORRENT_SERDES_EXTERNAL_SSC	1
+#define TORRENT_SERDES_INTERNAL_SSC	2
+
+#endif /* _DT_BINDINGS_TORRENT_SERDES_H */
-- 
2.26.1

