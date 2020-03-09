Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9778AC10F28
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2022083E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgCIJyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:54:08 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:36868 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbgCIJyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:54:07 -0400
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Mar 2020 15:24:02 +0530
Received: from c-sanm-linux.qualcomm.com ([10.206.25.31])
  by ironmsg01-blr.qualcomm.com with ESMTP; 09 Mar 2020 15:23:42 +0530
Received: by c-sanm-linux.qualcomm.com (Postfix, from userid 2343233)
        id D5B2F230B; Mon,  9 Mar 2020 15:23:41 +0530 (IST)
From:   Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: [PATCH v5 2/9] dt-bindings: phy: qcom,qusb2: Add compatibles for QUSB2 V2 phy and SC7180
Date:   Mon,  9 Mar 2020 15:23:02 +0530
Message-Id: <1583747589-17267-3-git-send-email-sanm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583747589-17267-1-git-send-email-sanm@codeaurora.org>
References: <1583747589-17267-1-git-send-email-sanm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for generic QUSB2 V2 phy which can be used for
sdm845 and sc7180.

Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
index 2342cd0..60124a3 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
@@ -15,10 +15,16 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,msm8996-qusb2-phy
-      - qcom,msm8998-qusb2-phy
-      - qcom,sdm845-qusb2-phy
+    oneOf:
+      - items:
+        - enum:
+          - qcom,msm8996-qusb2-phy
+          - qcom,msm8998-qusb2-phy
+      - items:
+        - enum:
+          - qcom,sc7180-qusb2-phy
+          - qcom,sdm845-qusb2-phy
+        - const: qcom,qusb2-v2-phy
   reg:
     maxItems: 1
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

