Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B023DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFDB207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SIrMWdHm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nuhyQJj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgEUNrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:47:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:48615 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbgEUNrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590068825; x=1621604825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+fVCosLVNVzYa9DEV+DdvD5UNh9H7AyIvdRwFBPCXsk=;
  b=SIrMWdHmbW9pLrdGwDXwdbS2H53X545PDwrL+6ciwAcxjCAX5yooShot
   xJK4QB6BgM8a/2f4k3F1KorwqOLMevirRqqMfgqFQNwp1PqtNbMeW+9l3
   75COkEkG8ZxTVxUHDFcBBcDWkB7S+d8iqGh+tsLByJzpRZcj4Ozc55l0x
   sCDQZ2i+Ec6Ty3exvyzS61wZWBVg5oxjrOpFuEdcCKyJXvOdAMF/u4auC
   giCKScMWPx//FvKY9UncBqnVfB5ZADUb3qUx3qxYvRZCn7b2BdN2qjHZI
   xNVmFOrdr7/ktC39iUDqy1IEUqftWEyRCxgUJyACvHXNBtTivFJKsCwyw
   Q==;
IronPort-SDR: GwcrF5gb19oC8wCsRO6iAHUmSypYDlrWTw0n4/a7mgQHAyBF59G3XEO/wZZuIHnWy/nW4OctgA
 xtxs4rYTTzqN2/y3qP5JrAgNwMIE7gXoUQLsQZB+L2r8/Sy8HmYK0f0tB0srV1LnAJztayZe7F
 bMVGCd/f7FlG7DfmaoTLwE7fBqZFJZGsSU/oVNU76i+eTXckJjHK4GjbxHMhIVeGLR3VM000L/
 uq5PRXglKIcBSms48tYxRv9oj4FQXcTAnj3vuI2sLbFN3jMoIiKdPHGMIE/+N7SeHCzy5DYhIl
 i7c=
X-IronPort-AV: E=Sophos;i="5.73,417,1583164800"; 
   d="scan'208";a="138224562"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2020 21:47:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/lRpk2V8fciUvmJfTba7dmhd89MYo2KjrXAmxbpHRf0OuOZQqTDWrSB2R0l962bjP+YIMsYMHuyLWFPAgzQwemFpRLhR7mlvk+gjoAKyiRQ2rnjcusJOGUpxt/gDKtKGsR5wV97VTs3/GYfJCcfwiwD5VM26/zhxjXUIz4nUWcRUpzxwq/EZlTcXFI3qMNK23c84NtTcMQEd24369BR+cJPK0QaOQ+1fVAp5cfpmGikfEeDpvbQvosHmFqp4F1z5BiSxM1Q7HboDrByujDD4wtSwZDVu4/BZMHKuOaa4Bapdvm6djGCL5lrPWYICQecxeAu1B+phLeSvkhkMarq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob6uXxeCegrtxqCXvOpGyy8bYomEH+RQ1UdvLcaVtXY=;
 b=LlB/QcbR9Y0YBcVk7V51BOZV380YaygiFji94szr5665y69a6t1nzOnJt8uosib69V5Pc7D2YxNXzafGwkhqvUmvHPiCkCggYgloFplhAktvKRN1v8wwRagiL3ZQGncnQxk1MDUSJguNDGqRVuw4Kc+XlEzYQih4ebARNFlsIoFss5wOSohH9GloEecoYlqENCMx8qAEN9tq1t4Stt+gJ7iHybXNaGOyICDMiwj5CEsTTkRl/pB0C3a8L2eYSclPEi9V6lszQY+IgfiRcQUAN2k5Gskli17RCX7/DNeIE3eR/aH7ROM/jNsXsAonEdGCTDI9uK00TfunxktD02q//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob6uXxeCegrtxqCXvOpGyy8bYomEH+RQ1UdvLcaVtXY=;
 b=nuhyQJj6Fn3ukYQoSICb4oWu9lokJmR1y7LSjhOcz5inN55Q4eQAtNclJe96w17sfO6TFUx6z37Y0TlRgRvl/nlfZNWrSYUcQDjSJlCdWRSSkH6XA2CQ6iJP1t3tRYEp+ETypAa8gMu6v0BoA0rrfCvkupKTM3xFGHV/FCg1wk8=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4380.namprd04.prod.outlook.com (2603:10b6:5:a2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 13:47:03 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 13:47:03 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <anup.patel@wdc.com>
Subject: [PATCH 5/5] dt-bindings: timer: Add CLINT bindings
Date:   Thu, 21 May 2020 19:15:44 +0530
Message-Id: <20200521134544.816918-6-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521134544.816918-1-anup.patel@wdc.com>
References: <20200521134544.816918-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::15) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.30.72) by MAXPR01CA0073.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 13:46:49 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98386d5a-ee42-4782-b152-08d7fd8d6d53
X-MS-TrafficTypeDiagnostic: DM6PR04MB4380:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4380B0868E54FA7CD7489B968DB70@DM6PR04MB4380.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Lg2fExpGHB6x6MZnVlNsqUXGph8i2rWbqTIcAeE5hN6n3ySFK+27g0TALpR2XEyxcUV29Qj5/syfzbFej+5ZnNIVWRyMbRWtqTJ7Z86gom+qWqMsfqvDCdFg/WLoxH3f+KtwIT03wCQiWvDn4lLqjQX4OQIDg7fHB2zjIIvBWl0Mw1fsYMWhOvKNvDgk6NUns9KC5yRC1dwOXxWtAert5zmJ750g3X74O09CM+tbAWd/otC3/2+9Kp2zph6hpAdTMLTCbr4r/Po/xgsrFyie0l3NGtpDBJyCkcN9fGxpZUvcwtFXKSFR1mymTj4988H/A8eGztAcEnXcl6vkmvxhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(16526019)(55016002)(86362001)(316002)(6666004)(26005)(1006002)(52116002)(1076003)(186003)(8886007)(54906003)(478600001)(66476007)(66946007)(55236004)(7696005)(66556008)(5660300002)(110136005)(36756003)(8676002)(2906002)(956004)(2616005)(4326008)(7416002)(8936002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 4o/RxkjniQv+PVj3a/mU8yTIubtVYBIF4Z5H0JqjTfxYoikOgdtZyR4ZHmRhB5cyHCq+t4xrXrPuJ9KfHESLP8khtnOZ7Zn7R12RhUpQ5ZioooQSsXYqkY5DexFZ1He6ZOJp0ZdzLyl4Mr09CB1sWDSZnYsZEQ54ZOSh9gjBA5NkadoO8LsttffLXSdEXiu6UmGFhZlJlnrtwlYRL16FVUSeTeioIx9xdUAdkWLDKk6vgMo/0Pnc/T+jcFC/MokWQropa1Xd3sFJQ3q8MUJsSO65+eC+DlLLHBzCzr1jeBVxvRYZrUpNl/ptzi2pjdlotAG3nZO+esZ3R9oJA3F1NNNoZfZBUndJyDHzyqVHhqC9vizo5Wr6UswvTqhpiUpG3HzAVquzJa51Ge+PCo8et+iMUTFuVbM/sxdAUY1ixlRhqkD04cBFYr+4tVpgseACm4dosgLlA07Bfngm+UJuUqOWzKvutIgVApBBS9vXKH4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98386d5a-ee42-4782-b152-08d7fd8d6d53
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 13:47:03.2367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/X1jPd3ZlSdyzWOnT1kclSpeALm6NkF0kU4mRjVBeALnj+PcmN4nUaPN9DRUocF8vxhMI8Y0k6D1SwGnTuSzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4380
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings documentation for CLINT device.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 .../bindings/timer/sifive,clint.txt           | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.txt

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.txt b/Documentation/devicetree/bindings/timer/sifive,clint.txt
new file mode 100644
index 000000000000..cae2dad1223a
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.txt
@@ -0,0 +1,33 @@
+SiFive Core Local Interruptor (CLINT)
+-------------------------------------
+
+SiFive (and other RISC-V) SOCs include an implementation of the SiFive Core
+Local Interruptor (CLINT) for M-mode timer and inter-processor interrupts.
+
+It directly connects to the timer and inter-processor interrupt lines of
+various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local interrupt
+controller is the parent interrupt controller for CLINT device.
+
+The clock frequency of CLINT is specified via "timebase-frequency" DT
+property of "/cpus" DT node. The "timebase-frequency" DT property is
+described in: Documentation/devicetree/bindings/riscv/cpus.yaml
+
+Required properties:
+- compatible : "sifive,clint-1.0.0" and a string identifying the actual
+  detailed implementation in case that specific bugs need to be worked around.
+- reg : Should contain 1 register range (address and length).
+- interrupts-extended : Specifies which HARTs (or CPUs) are connected to
+  the CLINT.  Each node pointed to should be a riscv,cpu-intc node, which
+  has a riscv node as parent.
+
+Example:
+
+	clint@2000000 {
+		compatible = "sifive,clint-1.0.0", "sifive,fu540-c000-clint";
+		interrupts-extended = <
+			&cpu1-intc 3 &cpu1-intc 7
+			&cpu2-intc 3 &cpu2-intc 7
+			&cpu3-intc 3 &cpu3-intc 7
+			&cpu4-intc 3 &cpu4-intc 7>;
+		reg = <0x2000000 0x4000000>;
+	};
-- 
2.25.1

