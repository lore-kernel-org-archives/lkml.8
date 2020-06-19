Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0050DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD8D2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NSUTUSp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgFSHFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:05:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:47205 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbgFSHFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:05:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592550345; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=7CtM3ABzZRen6H6ak/iY6UbUQKKrC7O86F6qhtQjSfk=; b=NSUTUSp4FaV9wExppw06xX2ckyriIrHopKUow8JUTxsnSCHigey+sna87i1B77srzdaNNhur
 qVPwYUHF4rTcRV/ejHluD3+L1MuYMQcJkTmWR8eM/fM3BcB0quqCq74gG/QncsYrQVh6aQEW
 d689xi8ySTbeEJscMDrMSs8tLEo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5eec63b83a8a8b20b88ae607 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Jun 2020 07:05:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CBBA5C43391; Fri, 19 Jun 2020 07:05:28 +0000 (UTC)
Received: from kathirav-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kathirav)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F837C433CA;
        Fri, 19 Jun 2020 07:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F837C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kathirav@codeaurora.org
From:   Kathiravan T <kathirav@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, kathirav@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     sivaprak@codeaurora.org
Subject: [PATCH 1/6] dt-bindings: soc: qcom: add YAML schema for SMD-RPM driver
Date:   Fri, 19 Jun 2020 12:35:02 +0530
Message-Id: <1592550307-11040-2-git-send-email-kathirav@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592550307-11040-1-git-send-email-kathirav@codeaurora.org>
References: <1592550307-11040-1-git-send-email-kathirav@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML schema for the devitree properties used in the SMD-RPM driver.

Signed-off-by: Kathiravan T <kathirav@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  | 62 ---------------
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 91 ++++++++++++++++++++++
 2 files changed, 91 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
deleted file mode 100644
index 616fddc..00000000
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-Qualcomm Resource Power Manager (RPM) over SMD
-
-This driver is used to interface with the Resource Power Manager (RPM) found in
-various Qualcomm platforms. The RPM allows each component in the system to vote
-for state of the system resources, such as clocks, regulators and bus
-frequencies.
-
-The SMD information for the RPM edge should be filled out.  See qcom,smd.txt for
-the required edge properties.  All SMD related properties will reside within the
-RPM node itself.
-
-= SUBDEVICES
-
-The RPM exposes resources to its subnodes.  The rpm_requests node must be
-present and this subnode may contain children that designate regulator
-resources.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,rpm-apq8084"
-		    "qcom,rpm-msm8916"
-		    "qcom,rpm-msm8974"
-		    "qcom,rpm-msm8976"
-		    "qcom,rpm-msm8998"
-		    "qcom,rpm-sdm660"
-		    "qcom,rpm-qcs404"
-
-- qcom,smd-channels:
-	Usage: required
-	Value type: <string>
-	Definition: must be "rpm_requests"
-
-Refer to Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
-for information on the regulator subnodes that can exist under the rpm_requests.
-
-Example:
-
-	soc {
-		apcs: syscon@f9011000 {
-			compatible = "syscon";
-			reg = <0xf9011000 0x1000>;
-		};
-	};
-
-	smd {
-		compatible = "qcom,smd";
-
-		rpm {
-			interrupts = <0 168 1>;
-			qcom,ipc = <&apcs 8 0>;
-			qcom,smd-edge = <15>;
-
-			rpm_requests {
-				compatible = "qcom,rpm-msm8974";
-				qcom,smd-channels = "rpm_requests";
-
-				...
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
new file mode 100644
index 00000000..5b33def
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,smd-rpm.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Resource Power Manager (RPM) over SMD
+
+description: |
+  This driver is used to interface with the Resource Power Manager (RPM) found
+  in various Qualcomm platforms. The RPM allows each component in the system
+  to vote for state of the system resources, such as clocks, regulators and bus
+  frequencies.
+
+  The SMD information for the RPM edge should be filled out.  See qcom,smd.txt
+  for the required edge properties.  All SMD related properties will reside
+  within the RPM node itself.
+
+  The RPM exposes resources to its subnodes.  The rpm_requests node must be
+  present and this subnode may contain children that designate regulator
+  resources.
+
+  Refer to Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
+  for information on the regulator subnodes that can exist under the
+  rpm_requests.
+
+maintainers:
+  - Kathiravan T <kathirav@codeaurora.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,rpm-apq8084
+      - qcom,rpm-msm8916
+      - qcom,rpm-msm8974
+      - qcom,rpm-msm8976
+      - qcom,rpm-msm8996
+      - qcom,rpm-msm8998
+      - qcom,rpm-sdm660
+      - qcom,rpm-qcs404
+
+  qcom,smd-channels:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: Channel name used for the RPM communication
+    items:
+      - const: rpm_requests
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,rpm-apq8084
+          - qcom,rpm-msm8916
+          - qcom,rpm-msm8974
+then:
+  required:
+    - qcom,smd-channels
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        apcs: syscon@f9011000 {
+              compatible = "syscon";
+              reg = <0xf9011000 0x1000>;
+        };
+    };
+    smd {
+        compatible = "qcom,smd";
+
+        rpm {
+            interrupts = <0 168 1>;
+            qcom,ipc = <&apcs 8 0>;
+            qcom,smd-edge = <15>;
+
+                rpm_requests {
+                        compatible = "qcom,rpm-msm8974";
+                        qcom,smd-channels = "rpm_requests";
+
+                        /* Regulator nodes to follow */
+                };
+            };
+     };
+...
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

