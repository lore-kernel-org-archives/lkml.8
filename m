Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081F1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D46B92071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="qBGHWg0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgFPMBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:01:49 -0400
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40]:44768
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbgFPMBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:01:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOIms1hqvUY8V3djHWtAqz8spUKVXf0UMb5zaskre+XFju4QfJr7wdox7vEpK61JS6/R6F4rBNnIHrCWxLNC2J7Ryi/FzIITPp8BGq7gglQuex0l7D0AbjLP579mehiC8+Nz5rhzJRyMTVKLCJ0QFaEKUBJTYPnTsu/NWAGZ6BtuVRRQ4GR2ffZLSo4ecCx2GsRnPLSKqLzz0lkg76EQU3KCw8dns3Ak4xNHoscPvTfhuTN69vDnEmm+sy5VdVRz9AiWXYE0QtMM5dUxFEjM3OQtzgO8pmIavRwnQ/Wmai/eab6s1Ve3ED8nubmOmhc0svu2h+0b0PUs09YrxybMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQJzPTJz5Wish6G1MxpojMjQL4F6ZEXBfQCJPjaFESI=;
 b=jakST3/FQiviYJgeA6xjQqAYcoVbtZZR+3qqawdyKNBWDMuj2rcuOBsJM/dWJrjFXUSiIM/FfX0OEFjPowelAVBd+ojPXEfdW1Uk3pKqtkY53a67dn8zvOBV5PF/1H/aQVUr3x/2ilqb3k0dlwCatr3/n5nemg/Fy40WQafWwGEl0BqMNirvlTGRuV1saPPjhijSBDYC8Ch10vfqrSoTMDlDXoNJjdnAEjI7ZeT3Xt6OtTgWXc0udl6RWKzXbBz9Lxopy7RFUXg3I6A/hRid/vmUG0bPlh8Po5uUB3+rqMHIW0dgx/lYwuUdDIDXtFIbbiW74jVEwasjldhv1ryqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQJzPTJz5Wish6G1MxpojMjQL4F6ZEXBfQCJPjaFESI=;
 b=qBGHWg0eBJa3SGW5WQi3SMDVZKtJ6UVlZiFu5jxx72svYiO5o+OQNPerAkj7RrhXU23V5NlLa9Vk7piuJaacOnhXJ/yO4jWeansudtPXRkJQbYjfdH/uNkSL3X5ySzXY4yxvV90hwNjajR2uUFbhVQRD51hc2WQqXNntHNhpNFw=
Authentication-Results: sifive.com; dkim=none (message not signed)
 header.d=none;sifive.com; dmarc=none action=none header.from=sifive.com;
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34) by BN7PR13MB2516.namprd13.prod.outlook.com
 (2603:10b6:406:a9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.11; Tue, 16 Jun
 2020 12:01:43 +0000
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::68f2:768a:7a8b:e790]) by BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::68f2:768a:7a8b:e790%7]) with mapi id 15.20.3109.018; Tue, 16 Jun 2020
 12:01:43 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sachin.ghadi@sifive.com
Cc:     aou@eecs.berkeley.edu, bmeng.cn@gmail.com, green.wan@sifive.com,
        atish.patra@wdc.com, anup@brainfault.org, alistair.francis@wdc.com,
        lollivier@baylibre.com, deepa.kernel@gmail.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 3/3] riscv: dts: HiFive Unleashed: define a default set of CPU OPPs
Date:   Tue, 16 Jun 2020 17:31:04 +0530
Message-Id: <1592308864-30205-4-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592308864-30205-1-git-send-email-yash.shah@sifive.com>
References: <1592308864-30205-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by SG2PR02CA0019.apcprd02.prod.outlook.com (2603:1096:3:17::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3088.25 via Frontend Transport; Tue, 16 Jun 2020 12:01:38 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 193f3de1-14a9-48c0-9a1e-08d811ed0946
X-MS-TrafficTypeDiagnostic: BN7PR13MB2516:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR13MB2516E7A42F0828379498E6368C9D0@BN7PR13MB2516.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNcysuIQWUOSQIpiXgTlmx+qBs53kjnJpZE05CGr2sAJyLkZVDKe9BRqFSdPY8xWknBIGBJBgXtlCjhB8wg8rhDMtt8BMopsXtDUSBU9vW+QsOdMgWhr0LwMH+8fqCm5OnbHIoW1wCnvhFJgGt5aib16jvY+peQjQI7JBVZ477rcVhAY+MS6bt8D5igJv0SY4aNdxWQJ+XY+b3EYG+ug9ME7i0ZvDcGNOmsXidOi+/sSTUfd43RRTxj6pw5/A9yRTMgFFGdvc8SLtu5knZ3y1+G+epR1M7AXylFjsPozHwXa8q16BBJ8XzyXFrMs7fdgIh42rsw+vnjA7mRvKApc5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1301MB2020.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(396003)(366004)(346002)(376002)(136003)(39850400004)(4326008)(316002)(52116002)(6486002)(8676002)(83380400001)(6666004)(6512007)(7416002)(44832011)(8936002)(86362001)(36756003)(107886003)(956004)(186003)(2906002)(2616005)(16526019)(478600001)(66556008)(6506007)(6636002)(66946007)(26005)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: M91XTOtoytIGEm3ctCH7O4hre70q4zTPNkd/m234jCFrtzq1v/M2/l/UrekeSH8xzZJDUyvQ9n/asbSocDLeOSgMUrcFA/QO6RKpX5MTXPcUuCN89sdGuK5LM8JfwoaU3V2uZ89PdMhuqDdsy0vijAOV107nH01faNl/4sQA1a9eUhfRVyBdbCvlExiejffgHH/weJ19UoktDtwbHZeI3ixPwtYxjHFcetV+uNkIUPg9k7K1gYoabbBn26WCfmeWEB45aVXASivpNaMzjVbiDp0FNruJIsjuTKEE2E2I3joylJKWS5x2SrnsuZCPeVtr+cUVwVILH2WgGlzWGzxGyPWYXR2ISwkWeMH0VaRIfbNaqGtZ6iLIwJGcgQl8x23PieP3d8B1KW3j+EhRz6Y01Czeu/iKYMoOwReZxJt76gPYPmk/g2EPqOjADO7WkEaAvZNnhA8yOMlqwesTEFOVboplUa7uyR59jCH+a4/vfx0=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193f3de1-14a9-48c0-9a1e-08d811ed0946
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 12:01:43.6606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIHIeAl5PIXzona0uiljAqJ2RdUUuIc9ZRv9erZYiIJEgilw85Elgkxr3sqnFOypIgurRU4P3MfpdtRxMkwyQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR13MB2516
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a default set of CPU OPPs for the HiFive Unleashed with the
FU540-C000 SoC. This allows CPUFreq to be enabled for this board.

The FU540-C000 SoC PVT corners haven't been characterized separately
from the HiFive Unleashed board. Thus the OPPs are added to the board
DT file, rather than the SoC itself.

The specific selection of OPPs are designed to enable fast switching
by simply changing the CORE PLL output divider. The exception is the
1GHz OPP. Since the OPP code apparently requires that, upon kernel
start, the CPU clock frequency must have been set to an existing OPP
frequency, the 1GHz rate is present solely because the default HiFive
Unleashed bootloaders set the CPU to run at 1GHz before starting the
kernel.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 4a2729f..59db9c0 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -46,6 +46,44 @@
 		compatible = "gpio-restart";
 		gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
 	};
+
+	fu540_c000_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-350000000 {
+			opp-hz = /bits/ 64 <350000000>;
+		};
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+		};
+		opp-999999999 {
+			opp-hz = /bits/ 64 <999999999>;
+		};
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&fu540_c000_opp_table>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&fu540_c000_opp_table>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&fu540_c000_opp_table>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&fu540_c000_opp_table>;
+};
+
+&cpu4 {
+	operating-points-v2 = <&fu540_c000_opp_table>;
 };
 
 &uart0 {
-- 
2.7.4

