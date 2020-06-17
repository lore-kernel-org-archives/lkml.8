Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F83C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA1521789
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Gjk1bNRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgFQSCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:02:55 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:11729 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727101AbgFQSCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:02:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592416972; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=AeAXk33hC2QGvVdME9/+b4Gj7uF3RQv9KrEUH2pVRD8=; b=Gjk1bNRRQQ8dRRk9MbQEZ/VB45pEWbcAtYHdL2fVYF0RSFTY1+AywiH6xTd9XJ1jEP0c30ru
 YwbVeB7Qz9LDQN5Mvtzi1ZIOBsaU8OC1orY6P3QckW/jFuoAc+6z6By5khmaR+7OfNQiBww0
 8imxJijRmhycYD+2PRG8hiLqmGg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-east-1.postgun.com with SMTP id
 5eea5ab1356bcc26ab0a1471 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Jun 2020 18:02:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 42C09C433B1; Wed, 17 Jun 2020 18:02:24 +0000 (UTC)
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B62E2C433C8;
        Wed, 17 Jun 2020 18:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B62E2C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     heikki.krogerus@linux.intel.com, mark.rutland@arm.com,
        broonie@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, agross@kernel.org,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, rdunlap@infradead.org,
        bryan.odonoghue@linaro.org, lijun.kernel@gmail.com,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v3 5/6] dt-bindings: regulator: Add dt-binding for QCOM PMIC VBUS output regulator
Date:   Wed, 17 Jun 2020 11:02:08 -0700
Message-Id: <20200617180209.5636-6-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617180209.5636-1-wcheng@codeaurora.org>
References: <20200617180209.5636-1-wcheng@codeaurora.org>
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
index 000000000000..2fa76111cfb9
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
+        qcom,dcdc@1100 {
+            compatible = "qcom,pm8150b-vbus-reg";
+            reg = <0x1100>;
+        };
+     };
+...
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

