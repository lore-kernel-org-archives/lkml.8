Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAF7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7F32065F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="C2Rd3wEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgGBOfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:35:15 -0400
Received: from mail-eopbgr20110.outbound.protection.outlook.com ([40.107.2.110]:57177
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729556AbgGBOfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:35:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnSHRhGMDqtJqMwTLcig6K4PFLsovbN1LjZ5KIwJdaV3Bom0mZkH7ttbTVS6/PYH/ZeiEm7c2hXV4qEmR4qhfhxV40KtORo9/OiiPk4+GmxlhxwcT8GzC6PmlMNzFAq8wz1YHe2rrrRJ2OXs/J8XWtzltFzHjAUAtKqYZILmwDbXWsHg/EJebJXqMNVoZMcusDxu6mYXOtnCTuDDdlwUbUJoZpjYJvjrrcQlbyfZmAmW482/5B9OqQ470Ex6m0P1my2bHr+HKy6jDGg26UKT0lMOUtH3HMy1mOjCRi1416+UdDIzo76b/Nyx/WMASxW6FcWjvtVb1Sb8pSOcWu/J/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5e3TUdZ9UfbslgM4YbaIMxwbpd+RfHk30fRhK02Y5M=;
 b=g0oGuOANILhSb0rJ70jETi7jg86Ee1iKktIOBKsyZnrkMiW7zqbLHkRH7E6QCDm4cLYZp0kqYOHGLCjt7q9Iu6X283gkiwSiMy+KtN2MnVR6rzHDnOrQ8KxSAZBtBOwv08dvDx1d6KeE4ue5dOODpRwp3+YyucyLRIEKNn81Ox29O4/j98tBboGI47U+bO4vaV1g/hI+S7O0A520idVegmOVEyPWg+VoJdywIXZHoKz91Dq374OT2/RLx0Be/+B7lRcLbNo8OoqsJssk58tPK+rTnGa7z10U7/j5JkHrWSNsQ7WPrNnymiGx0b0mJi6mP+CRZJ80pk1uKnPHBkQNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5e3TUdZ9UfbslgM4YbaIMxwbpd+RfHk30fRhK02Y5M=;
 b=C2Rd3wErEQymJCSL7IBhwHtAxfsT3K+tWkENhS8SXYDdY/xw7ycRLNstTxZaMsnH2EZE0gUgNT8NItldWcRcTX75vhVU108nkBRizoJ+Uh+d11h9y2OsMGargV7wtCxdi55YGsvAZplcnV6p6M1q4h07uxIdvnF7t4KktGIv1XM=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB8PR10MB2842.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Thu, 2 Jul
 2020 14:35:10 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 14:35:10 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Li Yang <leoyang.li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm: fsl: Add Kontron i.MX8MM SoMs and boards
Date:   Thu,  2 Jul 2020 16:33:07 +0200
Message-Id: <20200702143337.8590-3-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702143337.8590-1-frieder.schrempf@kontron.de>
References: <20200702143337.8590-1-frieder.schrempf@kontron.de>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (46.142.79.231) by FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.8 via Frontend Transport; Thu, 2 Jul 2020 14:35:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.142.79.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13d5216a-dfed-46fa-90dd-08d81e951fe3
X-MS-TrafficTypeDiagnostic: DB8PR10MB2842:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR10MB28426CADD410FD7B04A787E0E96D0@DB8PR10MB2842.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGDDEa97rJ1uvPiSZkgpQ2tEvdydH6nAAP90pmWWU5EVseTcxOKU4As4mI6O1HKaNNSnmRFAZfs2c9cYjnRJFd4Igj6aaXA9gS+hP9ytllJDuGJYFBeTmdjSrtX31R4oYxoGHwCgn9u/UYyGJ77wLpt70LNoTf3St2bNkoaixzzaApv89uTNNFFUf1Zqwt1PZCstX3/YqAQ8C3gIJ2C94uc/JFoVG5jFZZXGlV/kYDVNt+Zl96bYG1zLXAmvPei7ls0AU/lCcQ4xe8zDXMG2Ci2025vqsZCNsK2mXNtu+n0mQw5voxmkzt8c167J6r/oFsBlKrCJJXIwGzJLsy4sJadPRcfR1foqoJxklq3UruMu7zDLADagq+wq5uaqGFYY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(4636009)(136003)(396003)(366004)(39850400004)(376002)(346002)(66476007)(66556008)(110136005)(316002)(2906002)(8676002)(66946007)(956004)(186003)(2616005)(5660300002)(16526019)(26005)(1076003)(36756003)(8936002)(86362001)(6506007)(52116002)(7416002)(4326008)(6486002)(478600001)(6512007)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: OCi4XKDejog3SDZR3VtTABrLprcWhz6NxlbTFs4q77+LD8B6EgmCemU53440zq/9gUWzYIiTyuFnY4drh2oftgkZgTmrEgRFl5l2yP1DBKS7qfouUD4fm/5uSy4d1kXiVuVgilFlY7lKtqHbwxyIHwoXffOx7K4kbtJoE7a/0e6OxZUUSBu7FggqfgUJJmn3JNn2Y/X8abRu3QASnuIKL+VxILdHRTkb5rtPw79agzV1d1uHavVbRF+QNDg0eV34Njv4K1iXahKuHh0wF0gkv1Y7W2D10yQXhfy6A7edTFg+bhHle5U8nhfTCJFwLcqK988VDWZ9rjUcILneJ4ahCF7dE0y4+96rp0aXDHOCXKcmMTtlP1TBAzI6vbTAMFwG96uzL5qrxxyMhrBI1pUjZBL2m93wBsQPKXdAc5/mM1pnS0yH25/uItkDl0YZWLjekMzJNMfF0+S1yD/XV6H7KbhCTueDSLbrLYWDhBu8SLA=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d5216a-dfed-46fa-90dd-08d81e951fe3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 14:35:10.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rw/MOYaa+3gZZv0XilZ/qIPcDsNoe+whv5AHeK7KhQLrhWSSpfTL9cLuO8bJgkKq9xmupr/Vrn4E/WUjZbNqKioe7GChEo/6TNQBgVwhjq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add entries for the SoMs and boards based on i.MX8MM from Kontron
Electronics GmbH.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 05906e291e38..a99b1c3320b7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -337,6 +337,20 @@ properties:
         items:
           - enum:
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
+              - kontron,imx8mm-n8010-som  # Kontron N8010 SOM
+              - kontron,imx8mm-n8011-som  # Kontron N8011 SOM
+          - const: fsl,imx8mm
+
+      - description: Kontron N8010 S Board
+        items:
+          - const: kontron,imx8mm-n8010-s
+          - const: kontron,imx8mm-n8010-som
+          - const: fsl,imx8mm
+
+      - description: Kontron N8011 S Board
+        items:
+          - const: kontron,imx8mm-n8011-s
+          - const: kontron,imx8mm-n8011-som
           - const: fsl,imx8mm
 
       - description: i.MX8MN based Boards
-- 
2.17.1

