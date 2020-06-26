Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4DBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BA520836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="V2ovmlNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgFZSzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:55:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43265 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgFZSzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:55:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593197743; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jAnXM5CLYetIoTCfX0FEVFBAqUqxfjLXBqpTDvDUR7s=; b=V2ovmlNM8ztVZxOz3kfsrU2G6xNj+uCLu7Z1xwyxsSqBl9ubldQL7utcnU3pojRn82PzWrTP
 tO34z/PYFaEVDvOgEmSy49dWHLq4BUOsL5bQGyHTYdUObIunt0mnrGM0Hdu/MY0r8FMI1sJf
 /KFAkQnnpA6RKci75YcQ85tnYsQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ef6449e0206ad41d16a6dad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 18:55:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 050D2C433CB; Fri, 26 Jun 2020 18:55:25 +0000 (UTC)
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EC46C433CA;
        Fri, 26 Jun 2020 18:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EC46C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     heikki.krogerus@linux.intel.com, agross@kernel.org,
        mark.rutland@arm.com, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org, rdunlap@infradead.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v4 5/6] dt-bindings: regulator: Add dt-binding for QCOM PMIC VBUS output regulator
Date:   Fri, 26 Jun 2020 11:55:15 -0700
Message-Id: <20200626185516.18018-6-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626185516.18018-1-wcheng@codeaurora.org>
References: <20200626185516.18018-1-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This describes how to enable the Qualcomm PMIC VBUS booster used for
providing power to connected USB peripherals when the USB role is host
mode.  The driver itself will register the vbus_usb regulator, so that
external drivers can utilize the enable/disable regulator APIs.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
---
 .../regulator/qcom,usb-vbus-regulator.yaml    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
new file mode 100644
index 000000000000..12ed98c28aaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,usb-vbus-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: The Qualcomm PMIC VBUS output regulator driver
+
+maintainers:
+  - Wesley Cheng <wcheng@codeaurora.org>
+
+description: |
+  This regulator driver controls the VBUS output by the Qualcomm PMIC.  This
+  regulator will be enabled in situations where the device is required to
+  provide power to the connected peripheral.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pm8150b-vbus-reg
+
+  reg:
+    maxItems: 1
+    description: VBUS output base address
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+     pm8150b {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pm8150b_vbus: dcdc@1100 {
+            compatible = "qcom,pm8150b-vbus-reg";
+            reg = <0x1100>;
+        };
+     };
+...
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

