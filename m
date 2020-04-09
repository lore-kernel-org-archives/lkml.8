Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05228C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BCF2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FdCken2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgDIHTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:19:09 -0400
Received: from mail-vi1eur05on2082.outbound.protection.outlook.com ([40.107.21.82]:13633
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726648AbgDIHTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:19:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTpRBXLV3weyeii9KjI8/hQnUkWYJAU0rnmWqXpmxIaD9lqldOdGUYYpffIo13OcQ2J555DpJDN4H+0bFHilWeOEcfIkEQKCLbTyCyXrJZaxBwtW4tL1uB00HNxi9lcN8S4h1aC1t94OuCUMmCGu0sLYqU93bDk0SJg1FCdjcZQFnmzp7LPhGBhziDjm/9BB13xYtK/H1FBr44eOqPuC4H4F+MB+DyZnWcDSqPCLPIWvVPpwFV3IHLD0dKBDXwjGPrE9tCIBnDRzvRh0t2fFTp+6tBSzN3TI5IOwwRNHDIrdhcIRRpdCLSIyIOs4u9jVYYHTKHNYl7FxL/IN5mUfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IPZKRAwAaIrVRLfg8iGPhbGaDLlLs0YxllEgX41Cbc=;
 b=PNscnJwuEQSxRQUHqZriLlsJ0qdWoMxxTdxSN/LgnAPlZMR66ZSeWRkCJfOdax+X5AywWMVQbc7cDrJdyHfPpHKxw41nyuRDlTQPa3baTqdv6Dmp6tmAlPFKKe1shCXlTic/g9b7gLqqcmRQ3QH+MPoUoPaTZWfWrP7CzfnzyYClm1HjLWc5QFqim9k6ozzN1kAfncZjw3GXSsFCXb+POeCFEm+WexnstiRx+C4mKUDZzI7ym/WqC9WDiG/8rz/JG5prnQczcBiqt3DS5rdRJyYRO/Cp15bmfkc48hd2c3mYn2hhguB8p+GkWqC2vuvSPWG1D9n591MM4Rgs18NbkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IPZKRAwAaIrVRLfg8iGPhbGaDLlLs0YxllEgX41Cbc=;
 b=FdCken2WbE28kxCMFEpWTrxTe8FQfJ6CqGjGoDUgaNkU2TyFlMMc5nimYyxlslMCJxMzPpsgs5P6Ek3aA/GsJI8QiEPOCu/6C+jreWHOWPwFglwTDV0QbjUFOyR/R1LoDCd5F5YPOfCnCStzNh0i8TZ9irrdMMFG5DK4TYBMdgw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
Received: from DB3PR0402MB3835.eurprd04.prod.outlook.com (2603:10a6:8:3::30)
 by DB3PR0402MB3756.eurprd04.prod.outlook.com (2603:10a6:8:12::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Thu, 9 Apr
 2020 07:18:55 +0000
Received: from DB3PR0402MB3835.eurprd04.prod.outlook.com
 ([fe80::f0e5:c143:32aa:ed7c]) by DB3PR0402MB3835.eurprd04.prod.outlook.com
 ([fe80::f0e5:c143:32aa:ed7c%7]) with mapi id 15.20.2878.023; Thu, 9 Apr 2020
 07:18:54 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        linux-imx@nxp.com, festevam@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        shengjiu.wang@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 5/5] dt-bindings: dsp: fsl: Add fsl,imx8mp-dsp entry
Date:   Thu,  9 Apr 2020 10:18:32 +0300
Message-Id: <20200409071832.2039-6-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409071832.2039-1-daniel.baluta@oss.nxp.com>
References: <20200409071832.2039-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::12) To DB3PR0402MB3835.eurprd04.prod.outlook.com
 (2603:10a6:8:3::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM4P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 07:18:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: afb062b3-b327-472f-9b48-08d7dc5642d8
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3756:|DB3PR0402MB3756:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB37569839B2F3F511F4C71176B8C10@DB3PR0402MB3756.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3835.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(4326008)(5660300002)(478600001)(316002)(26005)(4744005)(1076003)(66476007)(6512007)(81156014)(81166007)(66556008)(6506007)(2906002)(66946007)(52116002)(956004)(2616005)(8936002)(6916009)(6486002)(8676002)(86362001)(6666004)(186003)(16526019)(44832011)(142933001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Na/wav08nX1520MHdfKqxygM9P/AWcN2OJC87jyDokiihk5xyRKw/DitGja2R27Afw9uU74dgqpzuI93jDzsWIIslnz91n1EsImOk/nnt31DX/3rc9Iv/I31GlRtVqKdjvVzl5cbFXcHGQR5XSV6J5GMoGjCSUmbuCDsY6u3OpYCnw6AtVds6q5KktPDaSsG4Ot1FxO9iXxXHRrowhBbWPD+FNjLaeoLic6xhg519pNqx/qeitUlA4VL76uvyKs+67a4nV5YnWIjegAOC8T/VgNZ6jrQX2tzwblw+PqHK2k2DOzUxXlbFNY7RXNnOZHTJf6UYEANtV4oqnyEu+TNniNJHvwPrc+9jiyHGcz43mz34QpBL0c3vphR0/+DLa3X/lmYfSclN4xkxPNOQkH26KMp3d8ttn3gQ8ji722u/+0P8PVEXVdwObVCu0OwMMpHdmLmv43LZP/tYn6qecDTWvYqZxgHY71vD/dTkZdL3OqRBM6pXaEZaLJ/fyYxaU+
X-MS-Exchange-AntiSpam-MessageData: jIh5F0jFCcTCLk3Y03GDtm+sNaPhP/y1FV0iG+PPAuOi4FfmqxRgfLuFBgXj8MR/lmUsinfmuNXQyjhLzPX5dO51+E1ns1oBDGHCNZcMK3aVdK0WAz4KJHOdjEbf1zpkgS49srIEM/ssHoZZO3JweQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb062b3-b327-472f-9b48-08d7dc5642d8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 07:18:54.6552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRhiAoLkdSgBUQBawKh2LC7l4QjiRvffyY+xxVM4A0/Any83zGUdra1UtYxufzd6TCr/KOIZV5GMkD1AymHvnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Minimal implementation needs the same DT properties as
existing compatible strings. So, we just add the new
compatible string in the list.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
index f04870d84542..65d4d07e1952 100644
--- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
+++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
@@ -17,6 +17,8 @@ properties:
   compatible:
     enum:
       - fsl,imx8qxp-dsp
+      - fsl,imx8qm-dsp
+      - fsl,imx8mp-dsp
 
   reg:
     description: Should contain register location and length
-- 
2.17.1

