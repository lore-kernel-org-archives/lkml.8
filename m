Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69182C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3FC20789
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ribSmai/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mGHoDE+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgHQMnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:43:51 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44431 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgHQMnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597668218; x=1629204218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=JyNpfxkp2keK3sLXO+yvYDrWvAnLTaa7Zr9g/WsLLX0=;
  b=ribSmai/FmWp/ggCPyUxegtv41MUIEa4znc49NU9aDvXFEq7bo9CDNe3
   OB6c5SpAWaJryXrXbHdzrulGDgtTXvEyhRuagnImo1PWWYmJ+tAbvS5f3
   7iCthEza5CyTtvj5yWTM7kR2gZa+pu2ubtMpfJZlYVZomCxCO/YiA0OAt
   3TIX+034WF+Ui2NOdm8XdawmLHI/UQitVLdjD+nMddwQ3NHnrHgYgt9R2
   YqyanCyOY+d8qxZ1oaupL9kMfvbyqsZ2FKKsza5s1GOH+Ha8zdGOcUJfH
   NQv+jDJH1WxPNAX51mvKeUuCB2yFPEFoUSZzv/2KW2vy3ily9xwjOmwMI
   A==;
IronPort-SDR: zZ0OuS6EtCpnOMBZ/GPnxyZkAaMILl4sk9w/Nrzef/+ML1P3AXLbgMunBxCIYzxdGhgEWBNFbK
 vnPc7fJ7fhnbBFRabZGENRjLXZx8U2JYJy63gN4BeWAZbjrIfFJ88C4LlMhHl+EK7QXrRO0UBt
 Q+6x15J/NqxHaWN6CFdZTuglySoH4IOqtmbinFc+4OCOZQwNVCfAH/4GG4OqURFQ6l7XMNbiwN
 FbSu2S4Sg6bz6FwoKsEOD7Esx1Rt2LksBB9vbWgPllAB5rMeTu0XR6ftZDAReGl8GdJPJIHFFz
 RBk=
X-IronPort-AV: E=Sophos;i="5.76,322,1592841600"; 
   d="scan'208";a="145088402"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2020 20:43:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dfa8xj8o0Ysz5YRgAMK+zzeIo1GU4zUajbW8+6C3hdYOlUaPVNkmAoj0ON3E5yqE/kt7jkltXq6EtQOxvMl24zlfgU2lfxuLcqBkJ0fbKG5PD+esXlxnIWm6SIGAsERuEmJH9u8f8yML4NqAzWgeojRwPDx0OrZlOIWVNPVPb4/x8NfVQM2pne2hzQ5c8cXGd86w6pfPojeRS2IkK/i8Ny33LNWyDbG+iTYP2oae8zFGXboesYefkL2vV6tqFe4Yb/s+dzAlEsf4Jq0Cg3p+Bm5VYAEv+K30brmdthX2vQWIB4EyLIcB1Ld5VGcbSKDORM4ERR4p9oG/Le0ddooVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4nDOpVC5t3m64fkB6mkhBrffThbPd1KQLsYW/dOIr8=;
 b=Lu4j+bh+MfJwCpI7YZgwMDpD4FY+JiyB32dqriqwK1wKT6L1SOGhmQNkvFox5QiapfyvJY52q71wefi/nJumud+7xLTsY2bZYSSfhkZOlgL3ojvXSDOMmWkSefBLiRRi1zCfB1+ojvVnjKuXfbBv5YGouQb3j7vao0n1iOZNmL3TzkavBufzDfr1Uk3+CvFyziCrL43DB3yOvOtM70SMPAj/7iT9rzLYfc6YkPojRqFtpJsK0VUPKOwKIj4UX4MqBYGozRdQnV57JxpHTW1UEinPL5jMIn2zPO9Huohwyz7Lc6pzNx0S8kcufdrm/XIw9YkHTkbX3kgDoJcwR+TkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4nDOpVC5t3m64fkB6mkhBrffThbPd1KQLsYW/dOIr8=;
 b=mGHoDE+ttmvK/8vWeGmj/A2/DEgz+SgsJUpG3arZZwyBAk95U5xUUBRtjhLW70IvtqNy+eQiSeSqbHcxGUsBng8aUr0KekbC4mYLTgUX61r3rgtnI7GUhLJMb4dPDryP/I73iBPz+5tiunak9utH/8sogWAu+9iYsejzZdbLdeo=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB3865.namprd04.prod.outlook.com (2603:10b6:5:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Mon, 17 Aug
 2020 12:43:36 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e%7]) with mapi id 15.20.3283.028; Mon, 17 Aug 2020
 12:43:36 +0000
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
        Emil Renner Berhing <kernel@esmil.dk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 4/4] dt-bindings: timer: Add CLINT bindings
Date:   Mon, 17 Aug 2020 18:12:51 +0530
Message-Id: <20200817124251.508183-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200817124251.508183-1-anup.patel@wdc.com>
References: <20200817124251.508183-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::13) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.15.59.21) by BM1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 12:43:31 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.15.59.21]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 55fced12-6c35-4d79-ca3b-08d842ab2861
X-MS-TrafficTypeDiagnostic: DM6PR04MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB3865D3DAC4F52F83EF3523408D5F0@DM6PR04MB3865.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ho0162YShHzwDTQKDvrwcXDUsLythLZPEMEEs8NhE4xyocpik2DbP/tWo4Phq3IA74zLbOMZ+o6sN0Nxp1ZSZeCa7d5E+bdLwU0mZRWSSnKSRg1bw9IVfXb/PROLzQEwjZAZZncyQgH4cvtVWQHhSWqv9jV9I5lWV2a00PLI/k4BrhKyLQzldL764QP/4gL2m4nm/IHFxd3/tdZqDcKCZUnpTCgPoR2XFkgZI+XfIlF8kqWdkVyxglEVOQS7gIbEgBG9Q8Q3Rj48tYuuotf2cZuCghTmFNAtvBaHBbWK2bvNMmzJCHBm0VUe6osX50KURWfJXzVY2HRiQUi5T5v/S2pz6B/uSl0VsUZQMk94mtoGHRlhT5itCX7NGZUSGR1G+6FTm3mz+MX6nbS8PaJMStal2gQCl39qHyXy/AqgwXu591NoBtTA75gBbzafsCAFkGfwNkTCCNzsYbi+AR0GWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(36756003)(966005)(7416002)(52116002)(6666004)(66946007)(55016002)(2906002)(54906003)(83380400001)(110136005)(5660300002)(478600001)(7696005)(66556008)(66476007)(1076003)(4326008)(8886007)(186003)(16526019)(44832011)(8676002)(956004)(26005)(8936002)(86362001)(316002)(2616005)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ZsmgmJtlRQkFLXzv/3quWJIwQh0GSt6LTFhsEIn3A6J357TQw2+VKEsAe9nRXX5ESrn0iMcZxS8FyXovzudJkjSFJmVXaDS3YqMVlE1sdD9nYYIcsSnshXZMHsPvrXCPkNRRFnIdPTYXp0EhaDgkb6PKseDbvDG0QZSDNy5GK1J5ggfcUZkGGuzzSAcAGia0r68X9MGuMCpdovm4bSWMKUHzZv3E8OK4RvTQMkQg8K/2SIaM/1SD9hrkZhjAQNv+XIooP8LelF3sLTpOfNaZQZDgGBW+fWUoZ8QHmTlpkUcs4Z2xlvCWyYcE5wJ3QRRekMwGYDj3FJan3pHctmOJ3r0dDrKL2Y5AKZo16cO+z9k5wRBGdDUY7o/p/iCA2OOWktITgye2aWkNsYltjY2KIMRAk9IC8TVBh6Giv93Y3Jjihhc5MNKzq1IlAQQtaPkzkQjZdjrTYvL329WXOu1aqEzrmVf8gBihRm+4E0V69HQhJdkvheFKOHRjGrD5gQlCDl+2rHh9pxcP66gcuTu2OWuB0Qoa30HLhNJSXsbs87uHJ6tVnfNlFhK0i+kLSoNBEL5yApUhvK2ZWyLs3m3HKkagbw0htEW2rF2YNftYc68QTUq2LubAwJccuxhofhnp+VUb+NwBN+n8rZthoHyRQw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fced12-6c35-4d79-ca3b-08d842ab2861
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 12:43:35.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvhk6RUtXy6nDKdqna9rhwihmt1OzDgvlNWs7g8yKeRJcW83oLRGDn26hM097I2+3yaBGnEg0GrQydkkDMft3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings documentation for CLINT device.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Tested-by: Emil Renner Berhing <kernel@esmil.dk>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 .../bindings/timer/sifive,clint.yaml          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
new file mode 100644
index 000000000000..2a0e9cd9fbcf
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -0,0 +1,60 @@
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
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+
+examples:
+  - |
+    timer@2000000 {
+      compatible = "sifive,fu540-c000-clint", "sifive,clint0";
+      interrupts-extended = <&cpu1intc 3 &cpu1intc 7
+                             &cpu2intc 3 &cpu2intc 7
+                             &cpu3intc 3 &cpu3intc 7
+                             &cpu4intc 3 &cpu4intc 7>;
+       reg = <0x2000000 0x10000>;
+    };
+...
-- 
2.25.1

