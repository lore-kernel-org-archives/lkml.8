Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF4C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E20206B1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ngnn9tY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgCKVrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:47:09 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37654 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbgCKVrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:47:08 -0400
Received: by mail-yw1-f68.google.com with SMTP id i1so3582447ywf.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 14:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYTqu7o88DhiQCN4tNkQrXf0r9/tf9NCCJPXItwuqG0=;
        b=Ngnn9tY0dNnZN3nx9YvjEIWeBi8S2tWsNnj6rddIzFEA7Pdc0YM+0/mn7AgMx2HzaM
         vH+fK37OmyXoLOzYM0c0QBYbMydrSYfkjzL7zyLKZKbSWxciXJXu4X69DEYa1xoBA1kI
         zXZ/ltNeG0iSFUUR1yOiawNUwcfxT+JtZRH38OsizyvJcFnaaoWsMDDoUfblTFlTkXxZ
         djGsqYjvvGUOwWZ0+elKdmtWF+YWQCCl/7I/lVEsPie5q0nWXmMmqVBhaHCwsp59k/wf
         ccFmBsQo4tO9gLMOLsi+Y8+DIWEy/uX/7WJC1k8Am6IvmNmV8Z55+1SPIZLjdeul1o20
         3EQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYTqu7o88DhiQCN4tNkQrXf0r9/tf9NCCJPXItwuqG0=;
        b=Th023UZ7rhkKMknI5No1AP/lAO5HHslqgBmwbH/Bxs0TkmDf2xKb/wPndnUpY5oNX0
         iDWzPBhM4KoqBbpjKwfMTSJM3FCqUwUttwZonZh4nqhxnI2v62YsuqHcGeFG+k94eojH
         aMh4+xYtb0nbJgLt8z9eJ7YWeFBIW2IwepUuYAUC7eaTASsXQuJNdsrEiTZFlDQoL5y3
         RHumdf4P3CvxFvCTHUQCDzOSUbHwIFWyLW0+aR0uzCiQWIHcXt1/M+bjqtcq3DWo0JlK
         OZTlaX0AA81SRPuPXe3hj4guBUCgj41pTDTA05eE5Q8uSHs8kNsMN0+gU9GLBw91YzcR
         Cj5Q==
X-Gm-Message-State: ANhLgQ3obMAP9ZHWAcL0OKswkp0rbrEqj7sOlx+Eew3/fAebZM9yLzkn
        UP5603w/6JBNpNAeqbw0wkC4sniPcRE=
X-Google-Smtp-Source: ADFU+vvzcODWsXeejF0XDQuX8AJzozF15nlzc98C1kAuaKrLgndz7qyCgTRl1U+b0E9iTGo8BTSQKw==
X-Received: by 2002:a25:2688:: with SMTP id m130mr5423645ybm.408.1583963225161;
        Wed, 11 Mar 2020 14:47:05 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id h139sm21100965ywa.35.2020.03.11.14.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 14:47:04 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: qcom: fix IPA binding
Date:   Wed, 11 Mar 2020 16:47:00 -0500
Message-Id: <20200311214700.700-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definitions for the "qcom,smem-states" and "qcom,smem-state-names"
properties need to list their "$ref" under an "allOf" keyword.

In addition, fix two problems in the example at the end:
  - Use #include for header files that define needed symbolic values
  - Terminate the line that includes the "ipa-shared" register space
    name with a comma rather than a semicolon

Finally, update some white space in the example for better alignment.

Signed-off-by: Alex Elder <elder@linaro.org>
---

The IPA driver (including "qcom,ipa.yaml") landed in the net-next
tree last week, so this patch is built upon that.  This probably
means this patch should be taken through net-next as well, but
I'll leave that to the maintainers to work out.

					-Alex

 .../devicetree/bindings/net/qcom,ipa.yaml     | 32 +++++++++++--------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 91d08f2c7791..140f15245654 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -87,14 +87,16 @@ properties:
       - const: config
 
   qcom,smem-states:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle-array
     description: State bits used in by the AP to signal the modem.
     items:
     - description: Whether the "ipa-clock-enabled" state bit is valid
     - description: Whether the IPA clock is enabled (if valid)
 
   qcom,smem-state-names:
-    $ref: /schemas/types.yaml#/definitions/string-array
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/string-array
     description: The names of the state bits used for SMP2P output
     items:
       - const: ipa-clock-enabled-valid
@@ -139,6 +141,10 @@ oneOf:
 
 examples:
   - |
+        #include <dt-bindings/interrupt-controller/irq.h>
+        #include <dt-bindings/clock/qcom,rpmh.h>
+        #include <dt-bindings/interconnect/qcom,sdm845.h>
+
         smp2p-mpss {
                 compatible = "qcom,smp2p";
                 ipa_smp2p_out: ipa-ap-to-modem {
@@ -162,17 +168,17 @@ examples:
                         <0 0x1e47000 0 0x2000>,
                         <0 0x1e04000 0 0x2c000>;
                 reg-names = "ipa-reg",
-                                "ipa-shared";
-                                "gsi";
+                            "ipa-shared",
+                            "gsi";
 
                 interrupts-extended = <&intc 0 311 IRQ_TYPE_EDGE_RISING>,
-                                        <&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
-                                        <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
-                                        <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
+                                      <&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
+                                      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                                      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
                 interrupt-names = "ipa",
-                                        "gsi",
-                                        "ipa-clock-query",
-                                        "ipa-setup-ready";
+                                  "gsi",
+                                  "ipa-clock-query",
+                                  "ipa-setup-ready";
 
                 clocks = <&rpmhcc RPMH_IPA_CLK>;
                 clock-names = "core";
@@ -182,11 +188,11 @@ examples:
                         <&rsc_hlos MASTER_IPA &rsc_hlos SLAVE_IMEM>,
                         <&rsc_hlos MASTER_APPSS_PROC &rsc_hlos SLAVE_IPA_CFG>;
                 interconnect-names = "memory",
-                                        "imem",
-                                        "config";
+                                     "imem",
+                                     "config";
 
                 qcom,smem-states = <&ipa_smp2p_out 0>,
-                                        <&ipa_smp2p_out 1>;
+                                   <&ipa_smp2p_out 1>;
                 qcom,smem-state-names = "ipa-clock-enabled-valid",
                                         "ipa-clock-enabled";
         };
-- 
2.20.1

