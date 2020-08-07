Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BB0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD6E5221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="K481Bc7O";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="B3+QiefJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgHGKNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:13:09 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:15830 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728209AbgHGKNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:13:05 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0779vSut023725;
        Fri, 7 Aug 2020 03:13:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=JZmlSqAYHBrW71GNnm51OZzJeHYWKPtLdDTdvG/lo9c=;
 b=K481Bc7OjuveA+ovPrW6DXa4+4ZQD5hftQwgeNwk5yWPEBImjFT2i06mEdUq5bdkzr7P
 IQKR+pHlOjiEtVcesSRG66M4kF5rDccl5LMv7on8ReOTSc8KT2MFsrtCelprR97G+B9J
 u6lxaycarKhwNVHsOeFMNTFelKqttz/XnZxew+PxJuY1xlWFYU7xTP6LslT6l50YqGkn
 k+MxH/zxdwyi+uEOHdiAF3z+zVBBrqK7iWXnMRZNY8lTZZEEsWn0mTkgLEgX5KAnkspK
 HFgVvkNogLnOd3g6gV9I0AEy0ddmt9SOs9jM2io1JVC2czM9iy9e2eriV3ZTDZZZuxGR +w== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0m4s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 03:13:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiVMNlLpCiQ0OhNDJqPSSczVKx6RYShY3f9QmaBaK5ep3sksYmE0PXjjF+h1N4p/ukVq3o/UoWIcgvo5bSj1CN/m3TIpObdBXLq4JkQNIODvlFGkzAOJqxWJn1pLO5+l5xsWDGQjxzbEY0GT9QYAuPPUMO22gtDAS01UZQOCugjPiT3VJtSUinRlwVhdpa64vvGGrLMLKJaVpBrX5SlvivaJ3m9ZE2u6PgszCtlnMqnnf6RJmuL4UUAGAZYtC6gBA6QtEPEezh2wf/1oMt9fZE/Q+z00cltgKOwqwLFM14i+4135perXfQtTjo+xhtCySbSJoRj6hC5xBq1T9+YUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZmlSqAYHBrW71GNnm51OZzJeHYWKPtLdDTdvG/lo9c=;
 b=A4Pf38OS0zcv3PLdc7bXADYNRDGioIdilsADG/ccl5eFtfwOcfDjfLHX1FvU0f7L4veeho2CTarZiRGgshA1KO+gbrB1AmIm3+3sNeq3bhmuYkPDpBi42HlxVNgXyHUQu+MDuKAKxOg0+PfC99b+VJqKRERWoodv511wxLRuojW6B4zddYYm/XjNSQA5MXjTDBSajo/C7ZVG2RmvfFbZuSpT0Mlkzc7nTk2ya7lNvaw6AFyrGq0eqG1/okxnuwWeL9BeRtu736HfYA1HncUt2txAaF/jmxCUSrcv6tYz3Vvnf9wNcfOACoWqwi5kd1AoSfcRYcSSt02JJGrcYDzd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZmlSqAYHBrW71GNnm51OZzJeHYWKPtLdDTdvG/lo9c=;
 b=B3+QiefJltlreSlRtyEB3pP3k+QM6VeL/lrJW7cvK5DQX/LhIVcUgOwtFp+Ke9kauYSrXao8hiwdpcL32l7Ftym44dhS9jJB/ERUg721sPM+vHMB2uFX7kkyend8di3VoG8RXjtMgAL9LYTMzzGXagFcHd+2GGbdFHEZaFNrA2M=
Received: from DM6PR13CA0066.namprd13.prod.outlook.com (2603:10b6:5:134::43)
 by BL0PR07MB4977.namprd07.prod.outlook.com (2603:10b6:208:46::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Fri, 7 Aug
 2020 10:12:59 +0000
Received: from DM6NAM12FT031.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::d2) by DM6PR13CA0066.outlook.office365.com
 (2603:10b6:5:134::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.7 via Frontend
 Transport; Fri, 7 Aug 2020 10:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT031.mail.protection.outlook.com (10.13.179.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 10:12:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACk5h021638
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 06:12:55 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACku1013403;
        Fri, 7 Aug 2020 12:12:46 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077ACkFg013402;
        Fri, 7 Aug 2020 12:12:46 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 6/7] dt-bindings: phy: cadence-torrent: Add binding to specify SSC mode
Date:   Fri, 7 Aug 2020 12:12:44 +0200
Message-ID: <1596795165-13341-7-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
References: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a3b3a4d-e879-4743-082e-08d83aba74c1
X-MS-TrafficTypeDiagnostic: BL0PR07MB4977:
X-Microsoft-Antispam-PRVS: <BL0PR07MB4977C0594587EFA6F2C76101C5490@BL0PR07MB4977.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrlYG7biEWCgOLkY62P8I0emR5DdVTWMBvLMRc5135iP+sCyDPT7T/Y5fn/ABFpgjF4a1fM2wHqelObQw62TUs3ZNdp0D2M5ost7WT/ORLJshBs+A2mTjLFBdV0WFRWiGIgm09Nxuva5g26y9wNWJE3+4jK9fJdfDGTWrZYnlP57fPvwA+NeM0d6KQPb9gjeS77AY88/AR7NbUSf4iz695FpvosAMo8TW73YGYBLHjLEMm5dzTD/VmvL5ch0tBaQcd9FZnvwFLk+zlwBaSgkFjf39aQvV+ZxBQ+X3vwHkVDVTSDxdQNak4ZWIOLX66GLblazpg1OZrr+t7n84e2CcNq032UGI7cJcAbakima3cwm1sNOFzyeYxJ2I1hcAUw9lXZdTXIldH89lWVpxmHaSG3QaVsoU1kB0G1Ts20rLbc=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(36092001)(46966005)(36756003)(83380400001)(70206006)(8676002)(70586007)(26005)(2616005)(86362001)(8936002)(186003)(336012)(426003)(54906003)(110136005)(82310400002)(2906002)(82740400003)(4326008)(42186006)(316002)(356005)(478600001)(47076004)(36906005)(81166007)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 10:12:56.9311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3b3a4d-e879-4743-082e-08d83aba74c1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT031.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB4977
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_06:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 mlxlogscore=890 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding to specify Spread Spectrum Clocking mode used.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
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

