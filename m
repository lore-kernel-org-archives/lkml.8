Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E438C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C6A20882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z1sBxW4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbgIJJ6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730609AbgIJJzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:55:40 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567AEC06179B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 02:55:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so2772878pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 02:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JlPu/fma8Wv6beiC8BOJ1wqv04CLGFnXPqAwT28bt3I=;
        b=z1sBxW4YmZIfGKvGOaW+5n71uktXLJCGKxaf7EZOkF/QMUsaop7A7jbUPm1eT8eZ9Q
         SbHkISTOMhMREIR9ItHocN9Rtur8xd+Z5fiqCODgObYKEPsCQnEOYqOTDduWw/+4Oqof
         jIN9ThdeaKOu1o1jBtTIVK6zzBTJJlsHs/uwt4Jn2mFbzTgdqcW4s5RqAJZK+qaL0NYP
         YVaWi9cvts4IkHJ7FX5LZ8/HaR7zw59DrhKwrSaRSLCHniHafoFe1VUIU8V4kIoOyNug
         jQzy7Ce4c+Q1F1wu1R4G4P/RMRd88bDqUmqLWMoYee9P4c2ykJTF1QbgE5ssKYVtziUI
         OHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JlPu/fma8Wv6beiC8BOJ1wqv04CLGFnXPqAwT28bt3I=;
        b=lTAL5rGs5sNwmcSZpTCOauf3P/2YlMWvTuLU+/ODsCpfnyNBREnd6HfXw7GOWkffsi
         OjidxyW0zHnOBgVOjs3MVTnwTojEArPxOem06EeTXzjve0bDwY8SmT7gJsKiznQ/9jKC
         SHffccLgP1fQbO6wWuTzKqmJzLjwFys3poNnygzAnWsRhzJLcq1jSMI9eCxAdA3v+NNi
         wDUKyIz6n761qW6OxFxMyv1fmGcoYCUqqXsmUh0UXT8dj/9kSdhoi9rsoNE/z/r4Xzfb
         m5wBe+dGK6aJ/ZFA6AYpu7wCM2+XHi8yj8zfUfINZn3eyiJqSMRgH5Tb17aR3A8FxsAd
         otcw==
X-Gm-Message-State: AOAM530OJM38+wKK7xapg0j86EYl6x8VapSsUSjo0gNi23jsz7+7nAtw
        Xf6GRtsyj1CkjQsaJ5cOpmbVUw==
X-Google-Smtp-Source: ABdhPJykJJq0byCnVztMHWbo3H2EohdgAPfnnowua9twE/mwibkxraGHSfY3PwXZt2r9xxINcyZXbw==
X-Received: by 2002:a17:902:bb84:: with SMTP id m4mr4626014pls.90.1599731738712;
        Thu, 10 Sep 2020 02:55:38 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id l123sm4443187pgl.24.2020.09.10.02.55.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 02:55:38 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/2] dt-bindings: mailbox : arm,mhu: Convert to Json-schema
Date:   Thu, 10 Sep 2020 15:25:18 +0530
Message-Id: <7f50b23d157a97242c79bd8f2ab649a9272b9b59.1599731645.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DT binding over to Json-schema.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3: New patch.

 .../devicetree/bindings/mailbox/arm,mhu.yaml  | 86 +++++++++++++++++++
 .../devicetree/bindings/mailbox/arm-mhu.txt   | 43 ----------
 2 files changed, 86 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt

diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
new file mode 100644
index 000000000000..4e840cedb2e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/arm,mhu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM MHU Mailbox Controller
+
+maintainers:
+  - Jassi Brar <jaswinder.singh@linaro.org>
+
+description: |
+  The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has 3
+  independent channels/links to communicate with remote processor(s).  MHU links
+  are hardwired on a platform. A link raises interrupt for any received data.
+  However, there is no specified way of knowing if the sent data has been read
+  by the remote. This driver assumes the sender polls STAT register and the
+  remote clears it after having read the data.  The last channel is specified to
+  be a 'Secure' resource, hence can't be used by Linux running NS.
+
+# We need a select here so we don't match all nodes with 'arm,primecell'
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,mhu
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: arm,mhu
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      Interrupt information corresponding to each of the 3 links of MHU,
+      low-priority non-secure, high-priority non-secure, and secure.
+    maxItems: 3
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb_pclk
+
+  '#mbox-cells':
+    description: Index of the channel.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#mbox-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mhuA: mailbox@2b1f0000 {
+            #mbox-cells = <1>;
+            compatible = "arm,mhu", "arm,primecell";
+            reg = <0 0x2b1f0000 0 0x1000>;
+            interrupts = <0 36 4>, /* LP-NonSecure */
+                         <0 35 4>, /* HP-NonSecure */
+                         <0 37 4>; /* Secure */
+            clocks = <&clock 0 2 1>;
+            clock-names = "apb_pclk";
+        };
+
+        mhu_client_scb: scb@2e000000 {
+            compatible = "fujitsu,mb86s70-scb-1.0";
+            reg = <0 0x2e000000 0 0x4000>;
+            mboxes = <&mhuA 1>; /* HP-NonSecure */
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
deleted file mode 100644
index 4971f03f0b33..000000000000
--- a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-ARM MHU Mailbox Driver
-======================
-
-The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
-3 independent channels/links to communicate with remote processor(s).
- MHU links are hardwired on a platform. A link raises interrupt for any
-received data. However, there is no specified way of knowing if the sent
-data has been read by the remote. This driver assumes the sender polls
-STAT register and the remote clears it after having read the data.
-The last channel is specified to be a 'Secure' resource, hence can't be
-used by Linux running NS.
-
-Mailbox Device Node:
-====================
-
-Required properties:
---------------------
-- compatible:		Shall be "arm,mhu" & "arm,primecell"
-- reg:			Contains the mailbox register address range (base
-			address and length)
-- #mbox-cells		Shall be 1 - the index of the channel needed.
-- interrupts:		Contains the interrupt information corresponding to
-			each of the 3 links of MHU.
-
-Example:
---------
-
-	mhu: mailbox@2b1f0000 {
-		#mbox-cells = <1>;
-		compatible = "arm,mhu", "arm,primecell";
-		reg = <0 0x2b1f0000 0x1000>;
-		interrupts = <0 36 4>, /* LP-NonSecure */
-			     <0 35 4>, /* HP-NonSecure */
-			     <0 37 4>; /* Secure */
-		clocks = <&clock 0 2 1>;
-		clock-names = "apb_pclk";
-	};
-
-	mhu_client: scb@2e000000 {
-		compatible = "fujitsu,mb86s70-scb-1.0";
-		reg = <0 0x2e000000 0x4000>;
-		mboxes = <&mhu 1>; /* HP-NonSecure */
-	};
-- 
2.25.0.rc1.19.g042ed3e048af

