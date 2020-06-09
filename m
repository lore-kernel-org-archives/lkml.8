Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E1EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF552076A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="bxl+5WUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgFIU7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:59:35 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:45391 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727975AbgFIU7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:59:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591736345; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=nvsygZ4LQhN8dkUFS3Ep5pykx2rAOIm/lVHOLxwhF90=; b=bxl+5WUuXMkubPDkVxmcuA2wEqXl9wHmVdPujeNlLzkGmQfFJRcuKHXuIK9KaUaOLKzdqVnm
 +zwacIveFuWJHP0CgxvyaofZqk/jupCSFjdhwOjqVR2PGmztMdQSmi8ST9lzK9n+NvkjTcKV
 IznDnKhlZVueza9+HZ77goPLFBY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-west-2.postgun.com with SMTP id
 5edff8126f2ee827dafad964 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 20:58:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8C515C4339C; Tue,  9 Jun 2020 20:58:58 +0000 (UTC)
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E08AC43387;
        Tue,  9 Jun 2020 20:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E08AC43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, robh+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org, bryan.odonoghue@linaro.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH 2/3] dt-bindings: usb: Add Qualcomm PMIC type C controller dt-binding
Date:   Tue,  9 Jun 2020 13:58:50 -0700
Message-Id: <20200609205851.30113-3-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609205851.30113-1-wcheng@codeaurora.org>
References: <20200609205851.30113-1-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the dt-binding for enabling USB type C orientation and role
detection using the PM8150B.  The driver will be responsible for receiving
the interrupt at a state change on the CC lines, reading the orientation/role,
and communicating this information to the remote clients, which can include
a role switch node and a type C switch.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
---
 .../devicetree/bindings/usb/qcom,pmic-typec.yaml   | 118 +++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml

diff --git a/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
new file mode 100644
index 0000000..34058fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/qcom,pmic-typec.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm PMIC based USB type C Detection Driver
+
+maintainers:
+  - Wesley Cheng <wcheng@codeaurora.org>
+
+description: |
+  Qualcomm PMIC Type C Detect
+
+properties:
+  compatible:
+    enum:
+      - qcom,pm8150b-usb-typec
+
+  reg:
+    maxItems: 1
+    description: Type C base address
+
+  interrupts:
+    maxItems: 1
+    description: CC change interrupt from PMIC
+
+  connector:
+    description: Connector type for remote endpoints
+    type: object
+
+    properties:
+      compatible:
+        enum:
+          - usb-c-connector
+
+      power-role:
+       enum:
+         - dual
+         - source
+         - sink
+
+      data-role:
+        enum:
+          - dual
+          - host
+          - device
+
+      port:
+        description: Remote endpoint connections
+        type: object
+
+        properties:
+          endpoint@0:
+            description: Connection to USB type C mux node
+            type: object
+
+            properties:
+              remote-endpoint:
+                maxItems: 1
+                description: Node reference to the type C mux
+
+          endpoint@1:
+            description: Connection to role switch node
+            type: object
+
+            properties:
+              remote-endpoint:
+                maxItems: 1
+                description: Node reference to the role switch node
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - interrupts
+  - connector
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pm8150b {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        qcom,typec@1500 {
+            compatible = "qcom,pm8150b-usb-typec";
+            reg = <0x1500>;
+            interrupts =
+                <0x2 0x15 0x5 IRQ_TYPE_EDGE_RISING>;
+
+            connector {
+                compatible = "usb-c-connector";
+                power-role = "dual";
+                data-role = "dual";
+                port {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    usb3_data_ss: endpoint@0 {
+                        reg = <0>;
+                        remote-endpoint =
+                                <&qmp_ss_mux>;
+                    };
+
+                    usb3_role: endpoint@1 {
+
+                        reg = <1>;
+                        remote-endpoint =
+                                <&dwc3_drd_switch>;
+                    };
+                };
+            };
+        };
+    };
+...
+
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

