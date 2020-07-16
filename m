Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8537AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7C920739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="I9thro3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgGPQNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:13:11 -0400
Received: from mail-am6eur05on2092.outbound.protection.outlook.com ([40.107.22.92]:64033
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728837AbgGPQNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:13:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDsMqwvINswtF5yTg6H/bs8mw+DsJ6Q7IxFrDuLdE+8sRRiWcW1jBnHHxQrdpEHTAE1/2r0ZE/9lKuQ7PvhBElTf64Vu65E5+FBiQkgluOpM28PbOEsIJd8m8wHXoT8KJ554RcU0RpuDYGh5G04SrJAN4sfGu+zZeWfLIYwsVnxUIpX/AGnkKguYif5xeOFLEUrqCzwp7MkJQgs5dp/TJypPZ3QRGj6Y33c5wcRuh7uU7hPFj5yXrFrUoiQmvjrJKs6ahhNeWvfCSK/eSVQN7JNZPJKfJvRdl7GvCIh55zgXxAv6F0sliLmwnz9qC1I9JwSwWdCkEqPDVgmNhwpTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hg3/R462FSyJIj+X+i+PSNU14PCGQ8zP/EKyalUzQY=;
 b=g7X10+iGmxqsiDrw4+TRtLl+AWupaOKLtX8xQWPWZ3yKUctiV1RWuYDXW5eOBzokY/QhuzNvRCOoO0nD9o/mbYBDKiiNtaPmhjzPq2xENX1cJL+ctpUbUDT/TmSci6sfauPVcHIH68MAulszTjdSIWf8IxDrtJRUjyyo7LbeZjx+whFxszdSxHqjBV4DNNBtBF0N/R/Gmkgp6kuJpySkgW/ExsUVljBDtA1Ute3Jv2cVDHbek1hsKHi8Fd7hhv/yT2dAcNWHGIF3RnQh/FRWq58aIxZzUt4jCCJLW3CT3Cnu1MDl8zVRetdrgRzKrJ+upmz73c4Tc/KTTQNK1sQePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hg3/R462FSyJIj+X+i+PSNU14PCGQ8zP/EKyalUzQY=;
 b=I9thro3YvIc+fpa/UZDjFc73m4NgAYWbDSoWojmt9karc3Xm0nbu0MaWzbtuLrbO4tTRzU6bJ1jg3JpzNXZ6LhAimq9mWk3wm+fXlQZFcKcugxifHPZ35U+m+p56U3qLVReU0LyzD0dOM3XsPpj+sBW+5+GKd7zfkW0uRHzLts4=
Authentication-Results: kemnade.info; dkim=none (message not signed)
 header.d=none;kemnade.info; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB8PR10MB3339.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 16 Jul
 2020 16:13:07 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3174.027; Thu, 16 Jul 2020
 16:13:07 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
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
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: arm: fsl: Add Kontron i.MX8M Mini SoMs and boards
Date:   Thu, 16 Jul 2020 18:11:59 +0200
Message-Id: <20200716161216.15461-3-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716161216.15461-1-frieder.schrempf@kontron.de>
References: <20200716161216.15461-1-frieder.schrempf@kontron.de>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:208:136::32) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (88.130.73.71) by AM0PR05CA0092.eurprd05.prod.outlook.com (2603:10a6:208:136::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 16:13:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [88.130.73.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f813de1f-b5e2-44cb-4b80-08d829a32064
X-MS-TrafficTypeDiagnostic: DB8PR10MB3339:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR10MB33395DB08575E34F0195A52AE97F0@DB8PR10MB3339.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvgywO/4jMhhGOs4MiRscsiweJ8z1HxDL2tT1MTABZZoWEoHHl5cFxe55d/olqTnJWgjwk8FlnXa/cmpyvZHq/uEZDXOxhnFlRL8MbqnOqK7VErfQRT3VrKd1kzT1KSH8t86PNMSd/PHVIA38KDfwT1fzQto7EBL5PHCKBIWJz4IeUyiPSZLNnWLA1XRP7cmD5RkCLtGtoveYg1dZX+QDTU8nQtVrKWCEhlJHRcOED2d3cU0dIsx3v9yFAwIV20RmEC9R1m4KdWrNjAM62fgir3qXhfHF3pLonP++0cK1YdZN89CREwxEtiq4kA3FauTv4CDAE4dO3LRpFBsMIvntAopa6EHNbFFlya4aQddgwe22Z1Zgq6lyKqgzBSdFE/U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(52116002)(86362001)(6512007)(66946007)(956004)(4326008)(6506007)(110136005)(2616005)(8676002)(186003)(26005)(8936002)(16526019)(2906002)(6486002)(7416002)(36756003)(5660300002)(1076003)(66476007)(66556008)(316002)(6666004)(478600001)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: V1JP3eBV0rhAeAllwrkzuPQIdhGjKBaClDLB0qve7g99edZ5hi4v1nHeLH8S3kkcUSBsqor9h+g40pfklqChyF4MBNSbNLvnj3nkb/aE9z6gqvDviaA0U4Oe6fs7BcWzAnNlzATKDu1uziJIFLezWHRdtGud59BLh/dkulGP/qf+lIreD2522DROwMIr9J7SsSbQGBWMxbGBRtLquH0p5CQFH69wTNC96xhQRe0ftsd3U6SkuTDoSRmCjxA90P+Is8y9uu4zCxdWPcbX7kqUpLHAVK2ZihltAtFn59NsVNmTdKGgoLDlk+Dr9ewkigNvyAY75r56sKhD0LkIZjH5hUpgBFP7xQis1/FEF5ydDYot8K/q1n6blZIgxU7jhFmvAbvwFDWfCAXdOUmhV9XsSQWiCNRsWDD/UH5Lm7ZdTnYocivIzrbkOGb76NNgpltabr2mxp75c01wquuSIXGTVJt2+OiwaoUcbvhsv5zYsSg=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f813de1f-b5e2-44cb-4b80-08d829a32064
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:13:07.4895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: couRI8/Awtfg6VocvpTe6MhYwJdoUzf6QgDjt4UoOhnohfRzj4wjR8riT6eXBxiT+R11mSorL7/4wwGkZQVET11rPWMa7WjjSrTtkdGmJi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add entries for the SoMs and boards based on i.MX8MM from Kontron
Electronics GmbH.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v2:
* Merge the SoMs and baseboards N8010 and N8011 into a single
  configuration (N801X).
* Add Rob's R-b tag
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 05906e291e38..33ae19e8fcf6 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -337,6 +337,13 @@ properties:
         items:
           - enum:
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
+              - kontron,imx8mm-n801x-som  # Kontron N801X SOM
+          - const: fsl,imx8mm
+
+      - description: Kontron N801X S Board
+        items:
+          - const: kontron,imx8mm-n801x-s
+          - const: kontron,imx8mm-n801x-som
           - const: fsl,imx8mm
 
       - description: i.MX8MN based Boards
-- 
2.17.1

