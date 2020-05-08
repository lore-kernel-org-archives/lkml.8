Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C98C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C70572173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEdh6teJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgEHS10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727122AbgEHS1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:27:24 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA4AC05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:27:24 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z1so1378668pfn.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FPmqoCXX36w4GNczlcEbzhCF5NhaIu3IfGEPKdSsIJg=;
        b=tEdh6teJdWxWwOZfwMnhMq2HWT1f4CEEU7n1RmhTwKCkHufLGPaswfGUAEV8ZpCWoo
         i0l7+VESYpg9DDsy24alcVpRwIIm64YZB/hu8vxML8DO1Uw3l33usrtChwu5VblA4JTR
         RKH33A/BAgobJ0PkLNflputiPlQzJvcUCY6U1C0U5rlJpwgHntmZzpl/+ysRAaZIgEqb
         7WzxLaAmjjKS1EPQaB5gR6Ek3tjVG5zALcfG77gELS5dqIhkzPmEAxUXqaK1T6PiiBXB
         EXUHs+a6NYAEZ/bzFuaPrpj8x2n5nrR4JQPNWJ/8F+amqVCpliEkWOTr+YTnTpC7jADk
         cqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FPmqoCXX36w4GNczlcEbzhCF5NhaIu3IfGEPKdSsIJg=;
        b=ltBy3QhYydpjVuhpJd7j1dk2j52ssPZhcXxdGCfKXHf7ycYh3LKBIWfDY+3p6xzmVn
         iDK3NvEZX/QUwPFqPOfSlCdOyFjf65ttKj4Yt3NIkyjZfLmXxdDj5LsMZgLl3aQ5NPuQ
         4wyPZR1Y9MZSW018rS5TghabWmecGnFx9BarIMpf9zfFkWhzwYyCw22MwwIiNcmYtU8Z
         JIV6NHqO8dL1ScNlHGwUMgC0bV3EaAi1H/Hrm52m3Yuu1v1Y6PG20TGc8I39WrOuZ2dO
         Ne3q09v3s5e4222l++2EUl+XfptZy4LteDiBmKdLFyDGGlAF+mKHRoPQelfcbYw9XTCm
         R6Zg==
X-Gm-Message-State: AGi0PubPDTn8U/jsZO+j9XSni68QKuR16Sq5KGWBJwE6rgkubsK/WYdU
        XSzZvOAbxMvbDR0PUuFUKxSo
X-Google-Smtp-Source: APiQypLpzEWwMMWWU3xte7NCk2pv5KpSKutlVWaAaQKWZaM8bP9nRqaJOgWFk1Z9X3nSnQFP6pj2lg==
X-Received: by 2002:a63:a1b:: with SMTP id 27mr3231310pgk.423.1588962444103;
        Fri, 08 May 2020 11:27:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:9e:e39a:a052:f8c0:a37b:3255])
        by smtp.gmail.com with ESMTPSA id y24sm2248379pfn.211.2020.05.08.11.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:27:23 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: mailbox: Add devicetree binding for Qcom IPCC
Date:   Fri,  8 May 2020 23:57:01 +0530
Message-Id: <20200508182703.29021-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508182703.29021-1-manivannan.sadhasivam@linaro.org>
References: <20200508182703.29021-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree YAML binding for Qualcomm Inter-Processor Communication
Controller (IPCC) block.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/mailbox/qcom-ipcc.yaml           | 77 +++++++++++++++++++
 include/dt-bindings/mailbox/qcom-ipcc.h       | 33 ++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
 create mode 100644 include/dt-bindings/mailbox/qcom-ipcc.h

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
new file mode 100644
index 000000000000..62e7bc8ceb0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/qcom-ipcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. Inter-Processor Communication Controller
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  The Inter-Processor Communication Controller (IPCC) is a centralized hardware
+  to route interrupts across various subsystems. It involves a three-level
+  addressing scheme called protocol, client and signal. For example, consider an
+  entity on the Application Processor Subsystem (APSS) that wants to listen to
+  Modem's interrupts via Shared Memory Point to Point (SMP2P) interface. In such
+  a case, the client would be Modem (client-id is 2) and the signal would be
+  SMP2P (signal-id is 2). The SMP2P itself falls under the Multiprocessor (MPROC)
+  protocol (protocol-id is 0). Refer include/dt-bindings/mailbox/qcom-ipcc.h
+  for the list of such IDs.
+
+properties:
+  compatible:
+    const: "qcom,ipcc"
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 3
+    description:
+      The first cell is the client-id, the second cell is the signal-id and the
+      third cell is the interrupt type.
+
+  "#mbox-cells":
+    const: 2
+    description:
+      The first cell is the client-id, and the second cell is the signal-id.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
+        #include <dt-bindings/mailbox/qcom-ipcc.h>
+
+        mailbox: qcom,ipcc@408000 {
+                compatible = "qcom,ipcc";
+                reg = <0x408000 0x1000>;
+                interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+                interrupt-controller;
+                #interrupt-cells = <3>;
+                #mbox-cells = <2>;
+        };
+
+        smp2p-modem {
+                compatible = "qcom,smp2p";
+                interrupts-extended = <&ipcc_mproc IPCC_CLIENT_MPSS
+                                IPCC_MPROC_SIGNAL_SMP2P IRQ_TYPE_EDGE_RISING>;
+                mboxes = <&ipcc_mproc IPCC_CLIENT_MPSS IPCC_MPROC_SIGNAL_SMP2P>;
+
+                /* Other SMP2P fields */
+        };
diff --git a/include/dt-bindings/mailbox/qcom-ipcc.h b/include/dt-bindings/mailbox/qcom-ipcc.h
new file mode 100644
index 000000000000..b8c04f6df57c
--- /dev/null
+++ b/include/dt-bindings/mailbox/qcom-ipcc.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_MAILBOX_IPCC_H
+#define __DT_BINDINGS_MAILBOX_IPCC_H
+
+/* Signal IDs for MPROC protocol */
+#define IPCC_MPROC_SIGNAL_GLINK_QMP	0
+#define IPCC_MPROC_SIGNAL_SMP2P		2
+#define IPCC_MPROC_SIGNAL_PING		3
+
+/* Client IDs */
+#define IPCC_CLIENT_AOP			0
+#define IPCC_CLIENT_TZ			1
+#define IPCC_CLIENT_MPSS		2
+#define IPCC_CLIENT_LPASS		3
+#define IPCC_CLIENT_SLPI		4
+#define IPCC_CLIENT_SDC			5
+#define IPCC_CLIENT_CDSP		6
+#define IPCC_CLIENT_NPU			7
+#define IPCC_CLIENT_APSS		8
+#define IPCC_CLIENT_GPU			9
+#define IPCC_CLIENT_CVP			10
+#define IPCC_CLIENT_CAM			11
+#define IPCC_CLIENT_VPU			12
+#define IPCC_CLIENT_PCIE0		13
+#define IPCC_CLIENT_PCIE1		14
+#define IPCC_CLIENT_PCIE2		15
+#define IPCC_CLIENT_SPSS		16
+
+#endif
-- 
2.17.1

