Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E27DC2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AA220675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="dz8+Hioz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbgEMN5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:57:36 -0400
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com ([40.107.237.82]:6221
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388736AbgEMN5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:57:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je239+E+a2tQwfoTMyJzTHIBVTp5mVTTY8kE0o0IgqZc1tD92Frdb/PLqKPP23cWHftyrqsqDyF/eG8VmnF1nrB3bK+aWCq4nyX8K6USnMMakbkz+O3EKLTcP2hklE6FDXWZb8KOxVX2nP5v8doXVp0tNzk9l+czyQ/snxnUxFn7AwGIuLkOXT57Fx7v6SrQL+PN2YIm1P0gaARMaCuDfvyNKAUCqqvacT5AnB/agFkGJeRqjCskiDq1E5s9APk0vQPGFM0Ouz/rWoCAcTEFbnBaoDoen4bAbBKqLNorePEo+ZTeEThjdvwDyRquoOeOgH+1q3o1t6NhvOAp1OmM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYTuzDsYVXlx1KZz3pNkMeyEk60Msi5G8+1GvtTBjLU=;
 b=JlT1qWpfg6S5EjoR8Z0wY0c8rD5twrf6w1vBnJQaHvGjZGzwaf3/mca7gDmmbvBSqSTSEPCyMyLlfpF2JVHvLQdOE/ewhLf7q1E/ggZvc0r1+KD5wyuGl7xEBMLDV6jDvfp9ufMIcAfMZFHfzK+Agxm+rnwxH9rz7jccTDkQ4L8kqUfcgzLCXrwKKU5Q9KwfGexo+xozvZAe2BhkJpKVgV+pCOTe5D4uMg8c5sGmPULBXEW6htPncJ7YF9518I3BqMaZu8QGcEpMa+Nkga90fvBt4NNJte/62KR+Ruvm7jqhzX3/fHgjn8lwxB2Z/dinAY+2p7IhVoWCm+mSahX/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYTuzDsYVXlx1KZz3pNkMeyEk60Msi5G8+1GvtTBjLU=;
 b=dz8+HiozmK0PTvvzRF0NawQA55tzgYXkup90b4f42SNoIyFPGUr0yqkmbxXppCBWnpp+cBB+aO6of5XWGqgpIDkGEf/SPzBFwq0+E1wFvHCofU6eeTG1fBaxua/FTzV8XfsbjHea+9DFAi47mr3OLYm69U4wAIYFSib9xwlTGh4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BYAPR13MB2614.namprd13.prod.outlook.com (2603:10b6:a03:b4::12)
 by BYAPR13MB2279.namprd13.prod.outlook.com (2603:10b6:a02:bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Wed, 13 May
 2020 13:57:26 +0000
Received: from BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6]) by BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6%7]) with mapi id 15.20.3000.013; Wed, 13 May 2020
 13:57:26 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com, atish.patra@wdc.com,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v1 2/3] dts: phy: add GPIO number and active state used for phy reset
Date:   Wed, 13 May 2020 06:57:00 -0700
Message-Id: <1589378222-15238-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589378222-15238-1-git-send-email-sagar.kadam@sifive.com>
References: <1589378222-15238-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::18) To BYAPR13MB2614.namprd13.prod.outlook.com
 (2603:10b6:a03:b4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma07.internal.sifive.com (64.62.193.194) by BY5PR16CA0005.namprd16.prod.outlook.com (2603:10b6:a03:1a0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3000.20 via Frontend Transport; Wed, 13 May 2020 13:57:25 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [64.62.193.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9183ed3-9dd4-4b33-d712-08d7f745912d
X-MS-TrafficTypeDiagnostic: BYAPR13MB2279:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR13MB227972BD90643B270E97D55499BF0@BYAPR13MB2279.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0402872DA1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2614.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(376002)(136003)(396003)(39830400003)(33430700001)(2906002)(8676002)(956004)(6486002)(316002)(7696005)(8936002)(86362001)(36756003)(26005)(107886003)(66946007)(66476007)(2616005)(6666004)(52116002)(16526019)(66556008)(33440700001)(478600001)(5660300002)(186003)(4326008)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oL13haf04sYnckeKMERjgR7lPAyT6iOdx5PBZjQ3eRQ8GffGGI7NTNK9taDClNvGAt/jpgFF4mGaeO0Gk2SqMqVqTBei0kBUw1JvdO+y5i8Z/yKqIZxw/5illGtt661frtF+VWkMLamX6KvsfMwLSaUjwQ7LTs4uCGdBzRpRmdgmCuKttrp3p10LV47qkGDIVPpXN4f1dTNQ++NYfrk4tcMPoMXA2AeTsOV1GkzbIp1ADsRjK3ejA0FoXcxb7/4lleD91XZmacxNMzaBwN6hy8zm53grgXYJ/o4dCkLg0NAGIZ4RWkTQUVIL/mY1GpejnpcqwOLrWWzTC4m9rCEC5PGDkXWMJGw7c2zJxy+zo6i7eYiiftEzLI0qs/m4Zvq88S4A5e+FOX6uc4ovRP1LXJc3bjve9SYVDC6Jr2t8i7CHwvQyjb2dd5eBpqDWjg+l+/sgb0dqmzE6MTFNI3uvmjlHGtwGSJbkMzUDGVIG30MXm7j5bHmZMnQPpiVpoMKYC2BPNMXzaCTFCzQRL0iVSA==
X-MS-Exchange-AntiSpam-MessageData: Y2Spm9L/7Nt4LOQEt2A5NH19/OluB6bsHtKa1dAlbtdOCrYZQzQyBlJel+sNeZVyMOlUR3MkSkQqTYwvoxmkQQh8elvqoiEchOKSypTNRskEamT02bh0vAGuFWH6lEplJmN8oWaX9S4dlnMd1WHzISDKjTYknUoPQWcjvsBJBIUGKWw2FcbcmyGuqB7jX0+4xecgH6Oa4VSCxRYMWM0v2e0ip1bl1ClwzoQBYyB3C7rozbjO+6tluF/0L/AS0zEVscyFTrZvYSdqRL3F85QSMi9NHiUsZDFGwCqIwwOR3RAGb/WDLOFw+hzQpfpfz9OhNX6fexJGmU1KSgmnWLlD43GRBzwskzplxuTXOtDpcHyr380qY/h2G+0dlQVyGLCGpVpCyWVXPVQzx0NQDy7cvtGH8ejXscw7cF4r4c+TL2puSnI/H2QrK5BZho48w/Yi5/ALMDHUt2LwuUoHuBBf5ZZp2G9jRdvRk9LEDy3FxaU=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9183ed3-9dd4-4b33-d712-08d7f745912d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 13:57:25.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8E+EWn3H7CWis32EKJo+A2z4TeJDkkZyhgobgGivbxE2GxAq870bOERfUHVgCFQNCVcWEBcUAHaFOfF8hd6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GEMGXL_RST line on HiFive Unleashed is pulled low and is
using GPIO number 12. Add these reset-gpio details to dt-node
using which the linux phylib can reset the phy.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 60846e8..24d75a1 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -90,6 +90,7 @@
 	phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-id0007.0771";
 		reg = <0>;
+		reset-gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.7.4

