Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36740C433F8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9F62076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RMkmFv5W";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wpP55YFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgGQHwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:52:09 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21827 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgGQHwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594972327; x=1626508327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Bu7QYu+rmbl1BgD5j/YqNPU0EHoH6IymWIqTKqf27Og=;
  b=RMkmFv5WCvESxacGeFO1PsgIKiyTF3tVVAR5U7KRzTiRabzab9MXCM4U
   6YchKX3poR+gShkOLkmfGMMxYLQ2lPVBAfW77Tan2kB5bNXQil+4LR79o
   86jM3ErKkaHWEnkyfte2u/rjnWG75JPBcNL/RLuzFhGVXtRo1L29FFSOx
   nnnbgUSPJj7ndMpX9Y6ox+81KJCYqqMvjJMiFE9B5m3apy1KV7aSqXCKm
   pJsXCpxJcH4MP3kXFjUpEGuJFnX5KrGyhLFuxR2dVUxlJtBq6b9k8TOwt
   P5GV8SI5aFIvqzyyS5cKYyGIKP7FRDHYWklR7lUyTExB9zvXtTHG/tmP4
   A==;
IronPort-SDR: T1QGqHF4k/xqLHKuZfwrbMdigQRuNEUFm9pjEc2RGBWhI++KdfLYgzzt6jxPQPhhnienkzVtar
 zUOOyPT1O87JxC/jXP4PfqvzRtxa5kxTr5LQgXxjkQZmlWg3uxUUUKy5+7ZYUBTdAaSkb6MbsD
 ueGULnbsq3MmxiM2cN+U4H7o4BTLX6ZdCPfMYBbmhdhbfjZFrhfMd7NHYdg8apxiJeGdvRPGVE
 X0rprCaVyfCTFwM9fNla1y38JYLNn9HOy88yMHkTB8UuGe9PJPW64BI//v8543T+K1X3y8UUoW
 igQ=
X-IronPort-AV: E=Sophos;i="5.75,362,1589212800"; 
   d="scan'208";a="142816170"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 15:52:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9pYgdRP8rHpaaGyGvdFLOqJbANxQ8eDm0qkODgdPTpnz9RrqP3rJFYLA0qIXErJzhB9RZxtLXpDQnsuKukspiJNt5U2Ui6MNkz6gxQraj1Zp+LdHHUnOQCZU4apZmNkcIOY3xHJNg4vTim3G9j2M5xE9Z6TZBOof6YDSlZFagMgxMYm1XSH5QNdjkC0FtLvS5V82+iwGVsxnGt4WFAhMxbcXIlenFqmKtNCm+dDueal8EgcwuRx5UK6k1xr/aOKpMN/HAjyQrGY8LdOVUsHIY2DX1NdTBXhR34zH9XPcCRlZawOFvm47+zwOfoz7MlpLCN4bdD+/E8HE5L+jaZOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZYtCM7MSi4vbD+2NG5qAzPEcrA1EbyRdRBLFvNpzSU=;
 b=WvTQ4vz9fXa/r578taKXI4Fxqp/cvAu0pAirC3uy3BtXRWveSclM1o6RFVQU2RVEtJXOYonme8WpYW+EPWHUsEuRx4sz2mmw942VRNIEMrkFgs+z8a+/oLEoblE8UGwPjqxPlzT/8hY736WFuE8LGq6VaOiHR48r5QpHkzHHtKCCUphKzL6arBUgU7Z+uESvGYKEzbIaD9m6oZsPoZ01wgUIvzCXOVpEHQt1BcpWT4GB5UskP3epAiSlE2HfEmMraGY1vBUBki0YjxF2qn7GgwKkU2gaDkyWf6WT52pE4MxAt0JjP8WPrO/vqU826M5NDO/8vGNjyqORjduTm6Ujug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZYtCM7MSi4vbD+2NG5qAzPEcrA1EbyRdRBLFvNpzSU=;
 b=wpP55YFnzcwz+ZWRxXo/u36fiR4JLSyvaPNJueyRB+EIYr0/1cgSiXwZXgbkwrh1lyyHiBFvRdKgpTOFYpk9iz0UvI+Cwx1rPjm37LJqwhJTptC5x++kT/rqSRXGKHPC0pzAG/2/oBiEaums3qiJK9Ir8z1FSNGBzE3jwroKUTk=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6331.namprd04.prod.outlook.com (2603:10b6:5:1e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 07:52:04 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 07:52:04 +0000
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
        devicetree@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Emil Renner Berhing <kernel@esmil.dk>
Subject: [PATCH v4 4/4] dt-bindings: timer: Add CLINT bindings
Date:   Fri, 17 Jul 2020 13:21:01 +0530
Message-Id: <20200717075101.263332-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717075101.263332-1-anup.patel@wdc.com>
References: <20200717075101.263332-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::12) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.56.182.72) by BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 07:51:59 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.56.182.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a83df653-b0ea-4381-f098-08d82a264c17
X-MS-TrafficTypeDiagnostic: DM6PR04MB6331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB63312B31968FB7C34829D1C88D7C0@DM6PR04MB6331.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DV8+NwErdPAU8P4F2p75LFe1JGqXgw9dA75CroVU5xcvc0jhyFW8UVD95RvEPdG8/GQIs9l9fFP/7GMOR+KQ+Ps6c7EY1KBcpKGahSxmuldxFXaFzqj+M/jMmn8jcwZ8HSG1qdCuAdvasKhPpRXXSd4ssGPxw3+uXSndCFKWdMzAa2oUWw5TytadTuDd0WMTYanEFMhw8B9Y0dSy+W9mQUarEfUX1EWsObH8cq2nz7on0ZUgf54fNf1LyIxcA314wX36cq6BvXr9lDGrkrLZ7uByrTG1PLViU+YEHUH0WiEuxrsHpJbf/btchLOvgG50AdAD3OZZ+o2HlMk/CUIgwDevEdHN6E6wbys/XPgwddtTzzPWfI/1mJbq7VInyhzbnORdsq56AlbQWyUfubh/62/9q26r6b5KIN855L2SIG7q3RuzFP2rZLGFf6+KfZmye3RjaH/idFdlx7GXngB9jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(8886007)(8936002)(66946007)(83380400001)(66476007)(66556008)(1076003)(4326008)(5660300002)(86362001)(36756003)(44832011)(316002)(186003)(110136005)(7416002)(54906003)(478600001)(2616005)(956004)(8676002)(6666004)(26005)(7696005)(55016002)(966005)(16526019)(52116002)(2906002)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: DRkZ5OZafN0iBLARkxijwWT2nNbOAeG4L1K4FxFUqMSq38QezBlS3c8fc/MJGXoJGBrNcMDOcC4NemMSm3iSjc8nvhnhYRt77VlGWHqC02W+SGvbUwZEwfhYM/Ihq1n8IEBNXGrKdrqfbChpubnaQxTiqNkBlM6oFoncVA4S2QR6m/AldN96CuSMnALCa6rtaQzwEoIg7mVKDdx6sWR1YH4b+KoUkBBPUdNkwkAtPZCzApTlr+Nw8hDnGO8QxWaP9WxaEh0bpBHXinPx4QMCScUv37GqCMw7uRgsyLGRnIrV2ubw3MyiI7gM5+0afe5vUJnP1E0O4f+DuajRY76qMj2bMBrUp9eiWX+SoqS9yzbS5Tp+cQ4n2DfoVmcaSMaDX+Yy0sHZ1mhUvcOrDxrHOrucNvKQVZjrZ0WyO1/RkBlzR8VseNhnncmKtYuJDqnQ+/ulYmXjYGNS8ayyFSoS5tsmV70l+KMiMfS3b9kMSIs=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83df653-b0ea-4381-f098-08d82a264c17
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 07:52:04.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gglcPLq040YOHC+tmvoT6Uo6iLU708MHzB6qOs3pQKbx3p0Sj76sZgh1tSHbhniAyi+mk87QX/5yuXmutAwfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings documentation for CLINT device.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Tested-by: Emil Renner Berhing <kernel@esmil.dk>
---
 .../bindings/timer/sifive,clint.yaml          | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
new file mode 100644
index 000000000000..8ad115611860
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/sifive,clint.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive Core Local Interruptor
+
+maintainers:
+  - Palmer Dabbelt <palmer@dabbelt.com>
+  - Anup Patel <anup.patel@wdc.com>
+
+description:
+  SiFive (and other RISC-V) SOCs include an implementation of the SiFive
+  Core Local Interruptor (CLINT) for M-mode timer and M-mode inter-processor
+  interrupts. It directly connects to the timer and inter-processor interrupt
+  lines of various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local
+  interrupt controller is the parent interrupt controller for CLINT device.
+  The clock frequency of CLINT is specified via "timebase-frequency" DT
+  property of "/cpus" DT node. The "timebase-frequency" DT property is
+  described in Documentation/devicetree/bindings/riscv/cpus.yaml
+
+properties:
+  compatible:
+    items:
+      - const: sifive,clint0
+      - const: sifive,fu540-c000-clint
+
+    description:
+      Should be "sifive,<chip>-clint" and "sifive,clint<version>".
+      Supported compatible strings are -
+      "sifive,fu540-c000-clint" for the SiFive CLINT v0 as integrated
+      onto the SiFive FU540 chip, and "sifive,clint0" for the SiFive
+      CLINT v0 IP block with no chip integration tweaks.
+      Please refer to sifive-blocks-ip-versioning.txt for details
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    minItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+
+examples:
+  - |
+    clint@2000000 {
+      compatible = "sifive,clint0", "sifive,fu540-c000-clint";
+      interrupts-extended = <&cpu1intc 3 &cpu1intc 7
+                             &cpu2intc 3 &cpu2intc 7
+                             &cpu3intc 3 &cpu3intc 7
+                             &cpu4intc 3 &cpu4intc 7>;
+       reg = <0x2000000 0x4000000>;
+    };
+...
-- 
2.25.1

