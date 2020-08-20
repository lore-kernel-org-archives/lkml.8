Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70E6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4512075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="J5yOZEYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgHTJTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:19:05 -0400
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:58367
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbgHTJSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:18:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHErzm8tHm7tp8V9Gc4Dk4uCmiU8fvoTyP8IcqupT2U6Zmx6lnMn6tCnfUIHkIvv3MZqqXUGwHRipTqQztQnIEdjzqC6kodEVUa0c6Sf3BaEV6JFh5aBA+k3tA1/83Gz4LGQdSZmxPfLLvuqJMF+RFlkQeowPG1SlibOBt7fuxu4UhayVf4Go/fRYlbfam0dlOOsLMtVAZ0knVVys6BZni5d1XY9ScggjzB9slvi/iTglzNsbvB2tPMj7CSsYGRadoKC+ZdVsYv+736Hzgr7q8pbXpkDOuEKRML49xXRnfqHYprl00Kr3MrQFRpnNcCYsamxxZX4O8VWRFGXrNB9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8S0kZq4Zvc8lWRFN2ZeHPnOrb5Btj4ZFpf+hggkO/MU=;
 b=jInirSxPmXEQx9SW3ocW/Cy5B6c5x4hQo9jUbHwydBkQmwooxAOlX2YyEi7jdQg5L+b1ISCGq/+k82bM3lBhnydtDtAU/452hTqmkyeVR8ocfnK098rEmroU/AfOyTgo8pQ0tu1AreW+Tlb5LgB2zksEIlrXG31nAw7yQDgMSqUvHGBSYzQtXajdAvtEI0yd4GkTld+Erp1IYPNji1Lbbdu87FBPlegKbvZSns/bm0vKe7lEskFOB+WPZ46AXYEpVEiqV03/e2SgQL9IV2Ti+RNlyNgyLjhx6uqOD+2BjdlNh0/eDDbO0DmZ3UC7uyEdONJXGUYn8komM0t5P0XGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8S0kZq4Zvc8lWRFN2ZeHPnOrb5Btj4ZFpf+hggkO/MU=;
 b=J5yOZEYZFGD/3GK51f4WI+OhbyKZVVn2hB7RZSntbHnSA5wO0waJJv61aDWwussSmBtB2p4sxUp4T3FGMbs8HlFlfjUqbiGCHg9VgntdsvUp9Rxl5SBEdkhjdkkRqVz53tMXAtBXe+dXrleqmlB0YrC6Pw9GMylmJns1L3Ncer8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN8PR03MB4738.namprd03.prod.outlook.com (2603:10b6:408:6d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 09:17:19 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 09:17:19 +0000
Date:   Thu, 20 Aug 2020 17:11:29 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: regulator: mp886x: support
 mps,switch-frequency-hz
Message-ID: <20200820171129.62bb4105@xhacker.debian>
In-Reply-To: <20200820171020.5df4683b@xhacker.debian>
References: <20200820171020.5df4683b@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:404:14::27) To BN7PR03MB4547.namprd03.prod.outlook.com
 (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TYAPR03CA0015.apcprd03.prod.outlook.com (2603:1096:404:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Thu, 20 Aug 2020 09:17:17 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b617b1e-d884-43ae-a016-08d844e9d6cf
X-MS-TrafficTypeDiagnostic: BN8PR03MB4738:
X-Microsoft-Antispam-PRVS: <BN8PR03MB4738A415E70E70D037AFDC3CED5A0@BN8PR03MB4738.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kmpjfDhyIK1xpHzr9dy/Qrxpn6oe6Em5FQtimyGOXaMU3+0uN11xZtGPTWwLSmBnzo9GiRJVl8gpZAiXZttLPH1u10IpIdFSDq2qQ8UFLH+dsrJOdWtJDrIXgon32vPQNuqDDnVKYisBBuxunIp/YDF88/Qhy3FNMU+xSdvUzfbP3BMAQ2MVAAxfCSCZHJe/+3GIHi+Lkqn9E0XlKnrqjvFkEZFnHdO1ZLrOkqICMDiAystCYzDnPN8FoJZRibWiLSUndNpvE8mCnEKmzus8FCvzwTs4xupU9tvYv33eVZOzod7fS/HeVoKhy8qR8xgf0guWgSkBTnFM1NF1ZJC3q0Q/mtJ1R1LBFr75q7poFZHmrUEUqe6som6tdo4AkCxhaOpGHuDOXVS9ROM+gB61xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(366004)(376002)(136003)(316002)(2906002)(110136005)(66476007)(6486002)(66556008)(66946007)(110011004)(16576012)(4326008)(8676002)(478600001)(5660300002)(26005)(4744005)(86362001)(9686003)(6666004)(52116002)(956004)(186003)(1076003)(8936002)(142933001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Q1d9Eucka5Ezk65u8KD/HAnAj2Cfbe2TpcUoCYQ9l7erk0eXAFYnk2cXHHCEgWzJlYfWnYBxnhq2ioGyH9r4kMc44vdpqzm77iWOgWieF9FLNj1SFtxAAM+9MVd9gyltS67y5PAwYmqBTy8+OrvpBfWc9/w1zeqrZfpekRuKWd+aPepAlynwjTYthkpIapYEfLb5NOITOdXj07R7K4hbt6bQPNUAJ5SUwXpz6RIy7EcZek3SvWq5W7k6W2y0RHYaHbVHRCWyk6cWQJzwiinwHaTlcyATz0H/s/MkDHawUZm3te8Ft62yTA/Mb5XB89ClGIPpVnaeyR7T6FMQpsU5JE0qMmVw8qAB1DfjtdyKdVjz6EjVsxTy1PKzz/LBRT2hmRT1kZAjgNNfGp6U5z5VQ/ydUJngKAKMk8Yzpqy+So9QuNjZoSweR9m5rBpF8ZZk9XhxspID9x3mghxhE4w42B7FpvBvfD5y8frsCeDewkYPctcn+BTk+gk16zG2kz167gAmgBiAggxia/TKRRfkGY4A5x59YdjU8nyvhZX6rU0OFWxdz2l+zhUFKOlwAMXqw6dt9KE6ntD0Uj+6DWEkwQAN8n0AkAc/P2TPJeaoh62c9QYa7UnL204SKXh9RoC90l5mYDluBx4hqV+NohbkiQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b617b1e-d884-43ae-a016-08d844e9d6cf
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 09:17:19.8493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/44Iwdgk/yWsK3vxL7eYSH3E0F5kAN0N5Hg4joQlnZrLLwwCoE24VG+fHmsGPdrYSUXVQN37YH7OXFCpmSSZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both MP8867 and MP8869 support different switch frequency.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/regulator/mp886x.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/mp886x.txt b/Documentation/devicetree/bindings/regulator/mp886x.txt
index 551867829459..b05307bbb0d9 100644
--- a/Documentation/devicetree/bindings/regulator/mp886x.txt
+++ b/Documentation/devicetree/bindings/regulator/mp886x.txt
@@ -9,6 +9,10 @@ Required properties:
 - mps,fb-voltage-divider: An array of two integers containing the resistor
   values R1 and R2 of the feedback voltage divider in kilo ohms.
 
+Optional properties:
+- mps,switch-frequency-hz: The valid switch frequency in Hertz. Available values
+  are: 500000, 750000, 1000000, 1250000, 1500000
+
 Any property defined as part of the core regulator binding, defined in
 ./regulator.txt, can also be used.
 
-- 
2.28.0

