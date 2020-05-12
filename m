Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1183BC54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0DC8206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o32Ggvzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgELHey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 03:34:54 -0400
Received: from mail-eopbgr60046.outbound.protection.outlook.com ([40.107.6.46]:5862
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729110AbgELHen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 03:34:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+HA65NY32Nt5djNZrzp0Im2nSURHQQx7y1EgFCeLnTXyz0mvcHF6G/8VPyV8KVczBbEmhSCp6UsLmrq9L4p4w/9g4MXuQkHNGOjT6UYD90WX2qRboZ8PPiudbYueXb1rM8V2ac1ybgQxQ2I8tcn9BvD8dp9FdSA1ot1saP19shve/5BqSpYLjVjXH1mc7eRGGs617aBPcmyroI1kMy3B3pog2C1LqRb/gtZbscEDMeKb+wzSrajHNvTVy2e0JCQ4Gr/GjeCTsGslAOsGWuMNdFwKio88qccdzQYwEMjTrjrdK0d1obVxZNISLHTdojLXYfQ4Qfd/74K23YT3V2PFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXpk3f7GEj/8kB6yyCCTcK2F26QP3Dy1CslqVe3tmys=;
 b=fqFyBf0Q4sOLIwU1ZLjR587n/yghgXd1/e+ua7EgPIJyqSC097xts1YBITZEDfOkHBqhztTyI9CYzmfTk7Ln5gC0MqlyMtIKgfZZwR/SSW433NGBgJOh9idhh6s3FIC9GCEWpl9oXr1/zkrB39oLeYdBhcWa+ihEGKI5ti7e6SfK+jnHeCeuFM/cEArlM1NyIk82ufbQ6tTkHVTVboTrmdsFfmCq4Mc322fQu0w+ycgnLvpnppv6xnkTQ12c2JYGTWiMM6ZCyw6VkZxP8cs3Ox8Mk0BOtYM9TYKr99fPaNIDA+WHidiHv40APaEooN+VYIQrN+vVbL58Htf82zYR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXpk3f7GEj/8kB6yyCCTcK2F26QP3Dy1CslqVe3tmys=;
 b=o32GgvzmK3td1E9v9/w5EPBC3aEEHzLTWQsTDyvkOZq1hqlSKItd7Xk9jbSRClReTlKz/WL9R/JJ0MHqM0gNwtDkk02Tf74XWqr6LQZ1Tg1PMogFTQBMueTFbk6zCnF+k+3Vy7SbMeZ4MlDBKMO8bzmmydCuEc6P9z41txq5LyE=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB5882.eurprd04.prod.outlook.com (2603:10a6:10:ae::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Tue, 12 May
 2020 07:34:40 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 07:34:40 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, will@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 RESEND 2/3] bindings/perf/imx-ddr: update compatible string
Date:   Tue, 12 May 2020 15:31:14 +0800
Message-Id: <20200512073115.14177-3-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:3:1::16) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR0401CA0006.apcprd04.prod.outlook.com (2603:1096:3:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Tue, 12 May 2020 07:34:36 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b48df923-55aa-4c63-42d5-08d7f646ee1f
X-MS-TrafficTypeDiagnostic: DB8PR04MB5882:|DB8PR04MB5882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5882750A8DFDF8927FB0EEB3E6BE0@DB8PR04MB5882.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxYOn1MkbOD795pNrzNKPwy/iM2a3vkevaOg1V1QcoLnxwSC4B2c8GuEWiTtFkwGOsoLJon2D1YwwxhPPi8iQrHnSABq/0yBQKlmC79nfyOdWSpOZcbaJc+MPKPLHRV8E/n23VFNtXO3zGHOopAqlAwpYKJwMnNSIXoiZt0tuCvpmJ1845YOTyQeiRZoP3MCPx6lT0/inogBC+kz3o0wwEcKtN4lYssibyIn9TOJMpV0Fh6ByXzpKSt9ANp9FXQ3XuY+VcHoujBcBLUgXq+/lrvjOAjT2rDWIcFuA/Q4wiZnJmVUmWMjBafe1iebF7GrBv7McMnMbIp8Qvks0RVZh0Ap3CHOjSljOFkfAeV+B8zoGUENDPILRykxg2g0Ysot0OASIxyljoBMK9TMojr8JF3ZKEEi4BcPHGIO9tw8Pa8fMCW1N6jECZA7r1MsbVTT72E40FXJtkbom4wrf49WlrZ/e2neAmrOMJJ+nYJHai6x2PqPmPWshSl/ctXbkrPE87791IX1e5R2oxKF3y9E1xfeV1Q8BNqxOP3H/gGSJJj5Sp9eDaO6sqW35fhSAVoz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(33430700001)(8676002)(69590400007)(33440700001)(5660300002)(66476007)(36756003)(66946007)(1076003)(8936002)(66556008)(15650500001)(186003)(4326008)(86362001)(16526019)(6666004)(26005)(4744005)(956004)(316002)(478600001)(2616005)(6512007)(6506007)(2906002)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AV0/tcqZT8nPLpXId9Jc/SqrqCvO4lRNwivCXEYlxq8I9BDUkkqEfmOn/dUrkbfzvg6xUxVfEJ7TrcIf4UPFkWUZLucxh8lEBkypoxQt44X4GpLSj1Gw9n3O5pZQ6EA8kDxZuD7dGSjfZvSK2sUt73vn3XqnlhOc1EenIDQn63jes6Wls0X1PoqNaZYYnvolthTqhviflOGaJZ3LPo0bvGhynGEpqBpXlwPsTv9GnQDMXqqjw3oKuMjSl35fl6CRYJtZsbwAIg5BnTW4eXxKKX6wA2thkDYoBishL10r94Si6eXWj9lify9Q7oPN29moqXd2H2r6FPFiubBFtzb2EZXkgF/d9wvN4AJB+rNtF3eHANYXnsBGUitr5+wA1cUOXl7OXoXyc1XaxUFrsaQ9TNvQ2QAtWLZNRv9BY3v7GMNobBgD/1pfzJSihFqB+ENSkZ+qPclcjZKg99Rk6bqX3RTPbwbPmPUjuuOPOHEXItI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48df923-55aa-4c63-42d5-08d7f646ee1f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 07:34:40.2620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KC/XrWYDykuITGJfmEURwDlhvpfUhrGZDAlTM0Brp/DnOSh+pFOuiv+zHVCvqTjZxmMdUrai6K1RAeZj3Gjw7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update compatible string according to driver change.`

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
index 7822a806ea0a..b27a1d4fec78 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
@@ -4,7 +4,9 @@ Required properties:
 
 - compatible: should be one of:
 	"fsl,imx8-ddr-pmu"
-	"fsl,imx8m-ddr-pmu"
+	"fsl,imx8mq-ddr-pmu"
+	"fsl,imx8mm-ddr-pmu"
+	"fsl,imx8mn-ddr-pmu"
 	"fsl,imx8mp-ddr-pmu"
 
 - reg: physical address and size
-- 
2.17.1

