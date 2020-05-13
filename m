Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9BEC2D101
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85C02492C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fb2COTTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgEMF5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 01:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729081AbgEMF5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 01:57:30 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E33FC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 22:57:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f23so6633814pgj.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 22:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6DiGQprIc29jGTRSS3LZaN5JVFAfBWIOn/MrmstepU=;
        b=Fb2COTTw/N3aD5LFq740uqcf3QSh77Yy6iPOdAeFB4E4qUXDDK+SYDileYM1YFcqLl
         zMxq/AxeRh7l3p/pWa6CQ+3Vw2ae7TZQNvWoLomxvCdh8C/7xzFaACTHK74Qwg05dJXV
         UUTezkhlz5DdGS7TFBpBnhR12FUen2C6GHxT14TDeCTgm/9Pjhi4fjodWTcQZVzT38/m
         s/K8AgbVLfKlQT4z9BL0UQnp+MbGS7QIhXE8UYuj1illNa+kt+QBTQ6jZ9nNCpAa5BRW
         KHJUQWh/0n/aJT6bsh+Dzs071uS+POhBPxnNOiyWTl7vCwB4ED0XtV5hPrOp+7u8WouW
         ZIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6DiGQprIc29jGTRSS3LZaN5JVFAfBWIOn/MrmstepU=;
        b=VyLstPApBBrBTFqkVYw32Cpe8dkXHex0//Cze8PTRjWBOekaTQTPK7xNHVfmNduU9O
         QJ9mZPNSOkJ3xRwEOP5Ffm0HwT9fLAxECYdAK+8Hfk09azFKQpJ1i+bWHvsh2jTY2foa
         XFgKKoeIcjzx12DC7hH1EUxL04IuyRnEYXM8jlArwJZ6Cf4zhGlXXlU+ZGgM9bv8T+Ns
         bCmQFR0FIpXXK6wUNYlsXwTaCtOBB4XyuTkn1GPt6LtPTvP5QUR2zBTiwj+ONiECKWHQ
         NlqlVB2Zu4jtjUQ7F2pn8Aw+UFlZguiefD9yR9SddQbYIHOdTGo8k/+2C1UwXTdZ9xmv
         KjtA==
X-Gm-Message-State: AGi0PuaLA3zbLPoeJD5vPhtWC9Pp0EUmCNlE74p6Lray1f4sUa01vBDa
        BKhNiRNlyOHsUAtugx45ppKWQguZbtw=
X-Google-Smtp-Source: APiQypI84evXisIIfEqnC8EO9qzc3IB9Ueo00kGZo3+v1H5V2zsyU8JHw0t4FsBkkGqyEde+HF8bsg==
X-Received: by 2002:a05:6a00:c8:: with SMTP id e8mr24250228pfj.206.1589349449862;
        Tue, 12 May 2020 22:57:29 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w192sm14131161pff.126.2020.05.12.22.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 22:57:29 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v5 1/5] dt-bindings: remoteproc: Add Qualcomm PIL info binding
Date:   Tue, 12 May 2020 22:56:37 -0700
Message-Id: <20200513055641.1413100-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513055641.1413100-1-bjorn.andersson@linaro.org>
References: <20200513055641.1413100-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree binding for the Qualcomm peripheral image loader
relocation information region found in the IMEM.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- Fixed reg in example to make it compile

 .../bindings/remoteproc/qcom,pil-info.yaml    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
new file mode 100644
index 000000000000..87c52316ddbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,pil-info.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm peripheral image loader relocation info binding
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  The Qualcomm peripheral image loader relocation memory region, in IMEM, is
+  used for communicating remoteproc relocation information to post mortem
+  debugging tools.
+
+properties:
+  compatible:
+    const: qcom,pil-reloc-info
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    imem@146bf000 {
+      compatible = "syscon", "simple-mfd";
+      reg = <0x146bf000 0x1000>;
+
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      ranges = <0 0x146bf000 0x1000>;
+
+      pil-reloc@94c {
+        compatible = "qcom,pil-reloc-info";
+        reg = <0x94c 0xc8>;
+      };
+    };
+...
-- 
2.26.2

