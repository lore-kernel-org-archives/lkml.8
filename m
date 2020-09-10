Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B7EC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B967321941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Edlxp9JS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgIJJ6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730764AbgIJJzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:55:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38229C06179F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 02:55:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s2so2779184pjr.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 02:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IaGTFnDJBMBefRV/KyfCTUkPl/xUCziFjmJJ4w4CjXw=;
        b=Edlxp9JSKyIwQ3d/65GRMff66HrC1LW3hK1xF7+fYi4S6Ae7V+W1mIakpvOTcZon4U
         uKl4ve/gMbyjqYC5YhLJXnXlJlPCtCu7YZDE0yKdmiBUnG/ZlxdUXJkg596ZDVjZwwhe
         bh1seKT7/YWFj3gVY1RAzKdf1BvZPtlp5fuylziTmuSW7fJ0uqXqO0Hl9rYrYZhzt6vK
         lAnwIFGqCsHGlHUHQSWZ++lQAX0n7wKlwA5octgAgeiMFwjkAnfwvmLXDjpsLbFj6YQb
         BHICuApDFIBstBzxunt/ssewC+a8+qyGh0mam78c+TCYgHB+iRq57dCkJAQL2qOzYCLR
         FlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaGTFnDJBMBefRV/KyfCTUkPl/xUCziFjmJJ4w4CjXw=;
        b=sFVaMSkRRoKKP2VV0u7FeNW5koM94oS/T1xw/PKs4w9mWUwdq3mS0oUbSMUhuIO66L
         v+kyzamKy7yVvDCV6M17PlXnsrEGwuwRUAOQiMJUYKuz5QxTNAMRloNvCiDKF2HV49rD
         zxEja9nyOgKoHZpz+zKh6jZHHPqfO4+vyqqQkq1QWDZVQZfsZxLOElrTsqyDBnbpWlR/
         r6HZegwN2ZXx2ST/ufyHEKMbUh2ekUfeZbTiKkF8ioxT61cChtbJ4iprDq1EF+amivwj
         n4+CaDZ5fXOzCT/1sCYVEJo/rwKUm67/39Pv0hsYWwZRQmDws14s5T5Xsc7C0QuAnhOV
         dnDQ==
X-Gm-Message-State: AOAM5327t/sVgRr/LoPvXFvSCWI5Y7/kIk+MONL6roGIJLi5fvkxvyGR
        4HGLoelq8HJuHVZFgTwY7I//rg==
X-Google-Smtp-Source: ABdhPJygFUaL7C711MVvp4VE0w8Sln3tVyFCklbJMeZp+qTd1iK1V5+XL+JPHZwQC6VD2MqmYq4ewQ==
X-Received: by 2002:a17:90b:3105:: with SMTP id gc5mr4616714pjb.225.1599731746660;
        Thu, 10 Sep 2020 02:55:46 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id s3sm5385018pfe.116.2020.09.10.02.55.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 02:55:46 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] dt-bindings: mailbox: add doorbell support to ARM MHU
Date:   Thu, 10 Sep 2020 15:25:19 +0530
Message-Id: <5d448f579a41345130ae25d01bb94a6e293a6460.1599731645.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <7f50b23d157a97242c79bd8f2ab649a9272b9b59.1599731645.git.viresh.kumar@linaro.org>
References: <7f50b23d157a97242c79bd8f2ab649a9272b9b59.1599731645.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

The ARM MHU's reference manual states following:

"The MHU drives the signal using a 32-bit register, with all 32 bits
logically ORed together. The MHU provides a set of registers to enable
software to set, clear, and check the status of each of the bits of this
register independently.  The use of 32 bits for each interrupt line
enables software to provide more information about the source of the
interrupt. For example, each bit of the register can be associated with
a type of event that can contribute to raising the interrupt."

This patch thus extends the MHU controller's DT binding to add support
for doorbell mode.

Though the same MHU hardware controller is used in the two modes, A new
compatible string is added here to represent the combination of the MHU
hardware and the firmware sitting on the other side (which expects each
bit to represent a different signal now).

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3: Update the json schema and fix number of interrupt lines.

 .../devicetree/bindings/mailbox/arm,mhu.yaml  | 60 +++++++++++++++++--
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
index 4e840cedb2e4..88980ba005a4 100644
--- a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
@@ -18,20 +18,40 @@ description: |
   remote clears it after having read the data.  The last channel is specified to
   be a 'Secure' resource, hence can't be used by Linux running NS.
 
+  The MHU hardware also allows operations in doorbell mode. The MHU drives the
+  interrupt signal using a 32-bit register, with all 32-bits logically ORed
+  together. It provides a set of registers to enable software to set, clear and
+  check the status of each of the bits of this register independently. The use
+  of 32 bits per interrupt line enables software to provide more information
+  about the source of the interrupt. For example, each bit of the register can
+  be associated with a type of event that can contribute to raising the
+  interrupt. Each of the 32-bits can be used as "doorbell" to alert the remote
+  processor.
+
 # We need a select here so we don't match all nodes with 'arm,primecell'
 select:
   properties:
     compatible:
       contains:
-        const: arm,mhu
+        enum:
+          - arm,mhu
+          - arm,mhu-doorbell
   required:
     - compatible
 
 properties:
   compatible:
-    items:
-      - const: arm,mhu
-      - const: arm,primecell
+    oneOf:
+      - description: Data transfer mode
+        items:
+          - const: arm,mhu
+          - const: arm,primecell
+
+      - description: Doorbell mode
+        items:
+          - const: arm,mhu-doorbell
+          - const: arm,primecell
+
 
   reg:
     maxItems: 1
@@ -50,8 +70,11 @@ description: |
       - const: apb_pclk
 
   '#mbox-cells':
-    description: Index of the channel.
-    const: 1
+    description: |
+      Set to 1 in data transfer mode and represents index of the channel.
+      Set to 2 in doorbell mode and represents index of the channel and doorbell
+      number.
+    enum: [ 1, 2 ]
 
 required:
   - compatible
@@ -62,6 +85,7 @@ description: |
 additionalProperties: false
 
 examples:
+  # Data transfer mode.
   - |
     soc {
         #address-cells = <2>;
@@ -84,3 +108,27 @@ additionalProperties: false
             mboxes = <&mhuA 1>; /* HP-NonSecure */
         };
     };
+
+  # Doorbell mode.
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mhuB: mailbox@2b2f0000 {
+            #mbox-cells = <2>;
+            compatible = "arm,mhu-doorbell", "arm,primecell";
+            reg = <0 0x2b2f0000 0 0x1000>;
+            interrupts = <0 36 4>, /* LP-NonSecure */
+                         <0 35 4>, /* HP-NonSecure */
+                         <0 37 4>; /* Secure */
+            clocks = <&clock 0 2 1>;
+            clock-names = "apb_pclk";
+        };
+
+        mhu_client_scpi: scpi@2f000000 {
+            compatible = "arm,scpi";
+            reg = <0 0x2f000000 0 0x200>;
+            mboxes = <&mhuB 1 4>; /* HP-NonSecure, 5th doorbell */
+        };
+    };
-- 
2.25.0.rc1.19.g042ed3e048af

