Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B26C35243
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8B12071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+AWfGtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbgAXWnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:43:24 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:45080 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbgAXWnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 17:43:20 -0500
Received: by mail-pf1-f173.google.com with SMTP id 2so1780150pfg.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 14:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fR36UAT87Z0TKgzJqLSUdRVGW5KC0xvFs4pz6EoaSEs=;
        b=W+AWfGtYERngYx58+JdIqakd2DAkpetfVaeID9hwBCBbON7jnjF1idcPZDN1OLhN3w
         622xZcGgQxsvPHvZRkgWq4dOLsTOXwAZNJpdMf7SjRPUPWSR5XzyvfIPtF37IF8PcLyF
         eG2poAj44PWrspC186mA54CivpdLZzf8SEW8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fR36UAT87Z0TKgzJqLSUdRVGW5KC0xvFs4pz6EoaSEs=;
        b=PDzLyBhBSvF6nXYZJhd2IocoiTbs2uczmR4btuftcN8cPm3JOlw8QtGO4eJfaN620d
         W6zySuuC7d/obmRgXwNyzHPLaJTR2KQyKwy5PmHVaHtRTuRcLIAzPllAAd7FowTU75m4
         8/5JrQbbJWEmqaw3iw5fP8pe4pdhO1Hd31K8hYK+hmmLUztbwoNDUsl0fHFAn8iKYNKP
         NC63eBldTmirFR7W3FlWJKdfRNWJipoxe/ewsr51Z4IiCXQ1Zed1A0CKSYTx92fALdW3
         8bOVQ7pUbKoJGbFK7aLcbzLYw9eZjAQD/6hedcnpA0myXD8R4b01L9Yk5tc4SWwBbLFS
         4FvQ==
X-Gm-Message-State: APjAAAV/mpJLsc8RYD4Gp8CSkvAjU+4dZdL5SjfUzl2/cqNVgcIUwtbh
        D1b3ddXNLkWh2a7dKzDLll3Ymw==
X-Google-Smtp-Source: APXvYqzQWhWF4MQsZ7Z+9Immx0ruH/IjtEERzHTTTIJYCcURTdVPjfvN5BCLXulZMP1xLv21An1JIQ==
X-Received: by 2002:a63:1a19:: with SMTP id a25mr6709867pga.447.1579905800195;
        Fri, 24 Jan 2020 14:43:20 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id o2sm7690948pjo.26.2020.01.24.14.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 14:43:19 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        mka@chromium.org, kalyan_t@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        hoegsberg@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] dt-bindings: clock: Fix qcom,gpucc bindings for sdm845/sc7180/msm8998
Date:   Fri, 24 Jan 2020 14:42:19 -0800
Message-Id: <20200124144154.v2.4.I513cd73b16665065ae6c22cf594d8b543745e28c@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200124224225.22547-1-dianders@chromium.org>
References: <20200124224225.22547-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom,dispcc bindings had a few problems with them:

1. When things were converted to yaml the name of the "gpll0 main"
   clock got changed from "gpll0" to "gpll0_main".  Change it back.

2. The bindings are written so that new boards don't have to specify
   all the clocks.  That doesn't really make sense.  Make it so that
   on new boards all 3 clocks are required.

This also updates the example to be sc7180 and use symbolic names for
clock indicies.

NOTE: It seems that we can only make things _more_ restrictive in the
per-SoC overrides for minItems/maxItems.  ...so by default we start
out with a loose min=2, max=3 (implicit).  Then we restrict msm8998 to
exactly 2 and everything else to exactly 3.

Fixes: 5c6f3a36b913 ("dt-bindings: clock: Add YAML schemas for the QCOM GPUCC clock bindings")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Patch ("dt-bindings: clock: Fix qcom,gpucc...") new for v2.

 .../devicetree/bindings/clock/qcom,gpucc.yaml | 42 ++++++++++++++-----
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index 622845aa643f..64cf3c450325 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -21,19 +21,17 @@ properties:
       - qcom,sdm845-gpucc
 
   clocks:
-    minItems: 1
-    maxItems: 3
+    minItems: 2
     items:
       - description: Board XO source
-      - description: GPLL0 main branch source from GCC(gcc_gpu_gpll0_clk_src)
-      - description: GPLL0 div branch source from GCC(gcc_gpu_gpll0_div_clk_src)
+      - description: GPLL0 main branch source (gcc_gpu_gpll0_clk_src)
+      - description: GPLL0 div branch source (gcc_gpu_gpll0_div_clk_src)
 
   clock-names:
-    minItems: 1
-    maxItems: 3
+    minItems: 2
     items:
       - const: xo
-      - const: gpll0_main
+      - const: gpll0
       - const: gpll0_div
 
   '#clock-cells':
@@ -57,16 +55,38 @@ required:
   - '#reset-cells'
   - '#power-domain-cells'
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: qcom,msm8998-gpucc
+then:
+  properties:
+    clocks:
+      maxItems: 2
+    clock-names:
+      maxItems: 2
+else:
+  properties:
+    clocks:
+      minItems: 3
+    clock-names:
+      minItems: 3
+
 examples:
   # Example of GPUCC with clock node properties for SDM845:
   - |
+    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
     clock-controller@5090000 {
       compatible = "qcom,sdm845-gpucc";
-      reg = <0x5090000 0x9000>;
-      clocks = <&rpmhcc 0>, <&gcc 31>, <&gcc 32>;
-      clock-names = "xo", "gpll0_main", "gpll0_div";
+      reg = <0 0x05090000 0 0x9000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+         <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+         <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+      clock-names = "xo", "gpll0", "gpll0_div";
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-     };
+    };
 ...
-- 
2.25.0.341.g760bfbb309-goog

