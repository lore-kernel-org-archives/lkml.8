Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBB6C433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B241A2065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pZK9IXLJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TaPxJmP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgGOHQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:16:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27534 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbgGOHQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594797359; x=1626333359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1yoaZ/MUGy9x/gjE1/0KBb/ZS7OPD3BG648UJnheuqA=;
  b=pZK9IXLJRjgTKYtcbgmePPDZuXYPmeOUZyLc3ztFg3pk7RdetbZYd3Yl
   ViSMWP5mYWugddkzOlFkLlja+1CTVAO11Qe3B/FR0DwHV7UF9SNbU+M0S
   g1qdtZ29mVcmZB4EhxcsRC5cvflbCp2TlTZB6MEt2XlrLNV8tcZDZk8BJ
   7QN4ogRN35vVvnlBWam2fHKGXkiYXoy7JH7bXRVkdL5zcMMMBaEDM7Dw6
   Qo6aNFpIYdow0LIkGDyyLa9iWrv8nEJ7u70VS0MQUvppIWQqBidi145IB
   wuf5vrkWrm5b8UOmzpSerw/ykHSeNFhr8h8Yf1khYWBGlKdKJ1r38kH1z
   w==;
IronPort-SDR: zOywFCWvoQRshbermBlnqhNOs+dUTqQaDvN99+ZvH7BvlA7rSYZuOZAQvGULtniiRekDxVlX/s
 mBEEx64FkU7qNcRQyQ6ghJ6IgJHeIQVT4sWNhI326J15OMU9IvFTleH98bT6WtHW0agrOrl6Aj
 LhzQZbT/ECbftNOdsnGP5oXLwG/w6jkpfx/41VVW20OBCRNoRbwyCM9ddwsMhJoUyOWvWhO/eh
 Hh2QxwnYlLmc+mwTupHnTmxM+zuQgOv2H43766Xp0+AP+iaEV3bGvc0x9gp2Ghyx4W4Gde2nnQ
 nOA=
X-IronPort-AV: E=Sophos;i="5.75,354,1589212800"; 
   d="scan'208";a="143799820"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 15:15:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsH0H5gqpNvU5K6QJky2Jnm2gZYrOGOGYHr+Qew8h0Fkf7/R4ji8WcgZo8hSe0qbDoMq5g2bATPUBwDfLm4aHXBx0+lHL7Rryg5tOOoEqbqOjB0UjSNku7qYFv38FH27C8T8frftXSBKdta2hhSBPTuhh0g29XduLQHxrb9ef7gz5UnzkZTdDiD6QiXJUJHff+4thrDOfSMdmhdu5NVFvBU5b91OuUfXsMjS/DGtT2ytHn2I7WZdAOmrqTrHLnB2wuoPPxfAqaHdAgKfD+SWafid6rCMIJWQ57tqIu37exUKu2fe/atgMDbVQNhlWT6AoHxyxbq2tDz435APWGEzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czwHAYt3wkUgtuMNubzI18huGHe7j+CzqQ8bZ6r662Y=;
 b=gkhpb1I+xTsttsS7ghTSxH+pqVuYl+Mn0+ZXOhJmPDET3tiMMjCVF53X+IS7JVq3FSZoJDQOV0jnnqDAJtjsawY5aAUhOz7KQY89fOZ6z2st+Xb+YBJ+hNfriK+YMJb/5ihYbyqBUcJQl66DGv3t6JpSWW1OqaVflvDJLmn8oGBUQNQWkQvtgoAuQxLSEIAPQGiW2KEYelLcKbUfAu2oVWQTPxDqlKRZeojaxHEZ7bYTZTkSSOwP6/NDeYs2CM1aPYmFz7gEnbe5DF7m1Rq4N3sU+gHm0OMsObR2FICko2t3g60RNJz+VB5mf75FWiZ5kJPfrNtHp8fjYIGQLJy5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czwHAYt3wkUgtuMNubzI18huGHe7j+CzqQ8bZ6r662Y=;
 b=TaPxJmP3JkRdPKHpEXr/xBuogbbiKWpLsPfak8GiMsluxj1EQ+BkHf7lS0q7Mk+7TuG1kuo2+HT/QL1o6XqVgAKOJ9zdNDNDHP7ENk2dPMZ+bJGzMdGSUbB1OM6HzkI07dhHURGHIIFGGpi9RgXwVjebyrCPsJLM+4nnf13OBCE=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4329.namprd04.prod.outlook.com (2603:10b6:5:9a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 15 Jul
 2020 07:15:56 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 07:15:56 +0000
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
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v3 4/4] dt-bindings: timer: Add CLINT bindings
Date:   Wed, 15 Jul 2020 12:45:05 +0530
Message-Id: <20200715071506.10994-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715071506.10994-1-anup.patel@wdc.com>
References: <20200715071506.10994-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN1PR0101CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::33) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.15.57.135) by PN1PR0101CA0047.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 07:15:51 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.15.57.135]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28026172-b822-4b50-19bb-08d8288eeaf2
X-MS-TrafficTypeDiagnostic: DM6PR04MB4329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB43298AD4B02BC5C83E5E55218D7E0@DM6PR04MB4329.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsHKCFJu258MC/AaoAoupG2M+aegthAcEHKn8ToAJ+LgLq5MQkouWkIaIg3sjzmHNs9vBgZo+ej21b8G80H3nakRTSOU71+mlEy4cQz0lwHIpysW67Ga9NzgPETzsSyBUGAXiq9s5SAFWPG70NbB5lxjumHQcA2k3hCmYO5vqFfE5v2wP+22aoRhDWSQBXc3KTqV7ABvzaPLIYkySRy4b3E5yP+gKnWvYKkaYe8V9GEm3nMUH2QVGGYoiAcD4FlzWe4eRHF2T7rBUbKUT9545as8SvHY7VgYyT7OvJ0k8hFFaPDth/Rx9iCzmpUUiIC78sBHJ3a8fKuSjvpWZ04PrraqaDZJOoliZgLkUaLCK1EhFaGoIOijmOVQ8rbioKhgiNGoDGovjTptEC6JXZk/7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(8936002)(16526019)(8886007)(186003)(44832011)(36756003)(7696005)(478600001)(26005)(66476007)(7416002)(66556008)(66946007)(54906003)(110136005)(52116002)(966005)(2616005)(316002)(956004)(6666004)(2906002)(86362001)(55016002)(1076003)(8676002)(83380400001)(4326008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: bjmXX+mT0UdynPpPXP+2O4kocSeYkelM1klNDTjTAPutqgDNeLUHCHcuhU4VCoil7CUlFccxhItVVU0ewvo6QDrrUGiQohEpZjrAjPANSfyPx8Z8W/Wra3rkG6xNqRpGFBDzdCmHGbTxpKVKN4nIkhVU9eIdd/FKfxEQl5PQ6lDr7eQiO3LPg95/+/qm7Q+9PYRnbqD4u4AiDskrw6EVRoU4BBPR0FQfVLupyGS+tb2rm6FOzIVrV7jWAK2R7P9IonXyjEGDcZpVGSfVgZg8Q5ZfqYJiLLnJK9b44/ptMUnYuRBlW+BOQoTADwf9qNzpSkcT9axRulp+zClygahE4yvSFwUm6anYaK8X5K/3Uk297G0wodCfdw5bRSQj0Gm1j3Cmbt71xZEN3kr6hop2qkM0ukmYzJZZnMDFZ7W7m55eeZgcy+WrXPXuNLPXR9uUDwWeIp9Q5btVz9vY5DZnHIgIbrs7Ntnx4jqQW3YgYlM=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28026172-b822-4b50-19bb-08d8288eeaf2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 07:15:56.7755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7zY8gNgB5dwCKhjpIW9g8jHlEk/sm3jB4WtuvusxBKPHhxP7+lJelsweZksuZgPpwCF45ijJHkdYZpdjGMVUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings documentation for CLINT device.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 .../bindings/timer/sifive,clint.yaml          | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
new file mode 100644
index 000000000000..f5579a759ef5
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
+      - const: sifive,fu540-c000-clint
+      - const: sifive,clint0
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
+      interrupts-extended = <&cpu1-intc 3 &cpu1-intc 7
+                             &cpu2-intc 3 &cpu2-intc 7
+                             &cpu3-intc 3 &cpu3-intc 7
+                             &cpu4-intc 3 &cpu4-intc 7>;
+       reg = <0x2000000 0x4000000>;
+    };
+...
-- 
2.25.1

