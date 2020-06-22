Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1461BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23CA208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAYvSU8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbgFVIAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgFVH7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:59:48 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38ABC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:59:48 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id s21so14807861oic.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTeC9Xi4qmQZeAOaphNZwsLRTSZ0LBevI66eeZFDnkA=;
        b=XAYvSU8HN8yBlbKuHfbJtuSsGToPrd+zDmCC2oKtJ0VVy2zd3Jn71KkbOytQU1ODmg
         ruspmVeLT8+Tyrahotyq7Atc4l436bDFnn2PqWXvxoU46ac9CTaYifRTXlxUB+z1D8C/
         FLqwY696rMer/Pcdm04wr6bqxhYux28lS2p78XtJvZel+FS/4NsO25VjbzQXF33E0BaK
         UvIMLYMXo1e6tNJMPqYB0PvzLQ/squz+fPeIueqQbhavDL7OFF+GgCiCjJvnVxWKF4Jz
         ZPXNANkc+arm9j47j9LSicyc5ZBlReoPVFN7A8kRKywcs8DBn5PSpuZch68+/o/+unNZ
         pN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTeC9Xi4qmQZeAOaphNZwsLRTSZ0LBevI66eeZFDnkA=;
        b=MwydPIZ3+a3zxE8aQ2LCUeiZL/Rl3XFOeA8VNDy83VA5Lv9ix6M0axt9VNi/vLLf2y
         5nqcJhcQUweTRXIluo4fASsHEJ+kY26pHmhL79HlX3Z2xNPj/8YGGduU346vXomPPU2v
         DeF14+THVgpb2MVanL/e33+dLu2MUpa/PE8fwubwpZbaqCQS7BQYZe1tkFEvgscA4UBn
         ZzK0FLcATH4wf808ywmRSPyBDwyh4WW1FXeCwinXxSIRIg9h57oJ2fxFh9v0g1Dvewgd
         3gEBlJdl6EP1DRhIlTm9N4rBc8nJnPedSP/ZkIX4t2ca1vvrNVrYKXdnsC9Cmp8QFzuI
         mXdQ==
X-Gm-Message-State: AOAM530+XF0MUjyLBnii5Aad3eTIOw7n2MKiAGmqsPtcJ2fh/3aaGiyF
        uZ3xc9wp8ejlrWTbC9bjFaQFzw==
X-Google-Smtp-Source: ABdhPJw8A7djz0qzGWjwrGnP2koCSgUdpHbwC8JC4UWp1TlKHu6Nj9ro9JvJV9lwB2MWoeXWGqyMRA==
X-Received: by 2002:aca:5c43:: with SMTP id q64mr11118702oib.130.1592812788187;
        Mon, 22 Jun 2020 00:59:48 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f7sm3135396otl.60.2020.06.22.00.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 00:59:47 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: hwlock: qcom: Allow device on mmio bus
Date:   Mon, 22 Jun 2020 00:59:54 -0700
Message-Id: <20200622075956.171058-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622075956.171058-1-bjorn.andersson@linaro.org>
References: <20200622075956.171058-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In modern Qualcomm platforms the mutex region of the TCSR is forked off
into its own block, all with a offset of 0 and stride of 4096, and in
some of these platforms no other registers in this region is accessed
from Linux.

Update the binding to allow the hardware block to be described directly
on the mmio bus, in addition to allowing the existing syscon based
definition for backwards compatibility.

Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 .../bindings/hwlock/qcom-hwspinlock.yaml         | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
index 71e63b52edd5..88f975837588 100644
--- a/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
+++ b/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
@@ -19,6 +19,9 @@ properties:
       - qcom,sfpb-mutex
       - qcom,tcsr-mutex
 
+  reg:
+    maxItems: 1
+
   '#hwlock-cells':
     const: 1
 
@@ -31,7 +34,12 @@ properties:
 required:
   - compatible
   - '#hwlock-cells'
-  - syscon
+
+oneOf:
+  - required:
+    - reg
+  - required:
+    - syscon
 
 additionalProperties: false
 
@@ -46,6 +54,12 @@ examples:
                 compatible = "qcom,tcsr-mutex";
                 syscon = <&tcsr_mutex_block 0 0x80>;
 
+                #hwlock-cells = <1>;
+        };
+  - |
+        tcsr_mutex: hwlock@1f40000 {
+                compatible = "qcom,tcsr-mutex";
+                reg = <0x01f40000 0x40000>;
                 #hwlock-cells = <1>;
         };
 ...
-- 
2.26.2

