Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95908C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7223B2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nKm/NU/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgEDR7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730712AbgEDR7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:59:09 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFBDC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:59:09 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q7so480207qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmchGPRatpHGz7FXodcq0SJqPYC5mC9nnx68TlaFw4w=;
        b=nKm/NU/E8zknhGFBOyhBDH4qXUn8D776cT5h6JHftF4GhhDK6x9ry2rz/3390vKj+L
         tN2liW5eIzpYXyOpEagl2/5lPJmBZ/VQImzT4IVSWB4A1XwFTg5LAMBg+Y79lMTvnRbz
         fqUzQGcouFhzr7nhC+k8ZJKatIpZACKQ5KsgukU8IdQ4ybdM5qw3Q2p8bw7XJfI58Ne8
         d+GGbZTZ274frK+wfzNePMwxV38lK3jsUAI762x47ra+I05WuZNE7YyUGRj4Ej2dR8IG
         Zvj23kfA5xhRNdBa/Sm5jyZbT83OnNaTEKCCSmD7asI0QyaFyDOXBFhqBZG9KzBxltEi
         hTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmchGPRatpHGz7FXodcq0SJqPYC5mC9nnx68TlaFw4w=;
        b=mEl3zA6cxMmjmgCvkyy2oofouYfccsdyFjjAs3c7R7m4MvPGnDUk2T9PEH3Vy3XF5a
         HpSPYHuMVDj+w9xSg30Anq0mKPlnWuJLLCUn5Ioisd/nuib8HR8nk9rvGTpy96tcRuFr
         hgqYyHurHiLYD/Mo6KCTc3+21XTIkww0rHqK1Pqgv0JJwe+jtng1COC4crhQcyEpiWJw
         iRxoJG9jqmbYmFD/1y33u10zsItFN47kFAF/f3YNGgI5kla8yfd4WIZZtc1lvrBccxRZ
         KquRG6rCtnhEdu5rWcVsHcqDu+gMP3+PYJADujYLC5i7ApDK/MnKJX/RunFyrbUc4MSU
         uPSg==
X-Gm-Message-State: AGi0PuaLtgbel9AbCQkmUDDCJfNIcxW5ZJMsw1ymgkWkPXXuS/3OtvId
        NhIIYnHqeIfLzZqzjacVTRCMbA==
X-Google-Smtp-Source: APiQypKHzejQhJPuhrRIg5ZslvlTZGo4JtzrXdUU6lsW+xZU4Q0pY9zUQ7/oIZ0C/MMhJDrMkTTBcg==
X-Received: by 2002:a05:620a:15c1:: with SMTP id o1mr387681qkm.187.1588615148533;
        Mon, 04 May 2020 10:59:08 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id h19sm11271088qtk.78.2020.05.04.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:59:08 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, davem@davemloft.net
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        agross@kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/4] dt-bindings: net: add IPA iommus property
Date:   Mon,  4 May 2020 12:58:56 -0500
Message-Id: <20200504175859.22606-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504175859.22606-1-elder@linaro.org>
References: <20200504175859.22606-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPA accesses "IMEM" and main system memory through an SMMU, so
its DT node requires an iommus property to define range of stream IDs
it uses.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 140f15245654..7b749fc04c32 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -20,7 +20,10 @@ description:
   The GSI is an integral part of the IPA, but it is logically isolated
   and has a distinct interrupt and a separately-defined address space.
 
-  See also soc/qcom/qcom,smp2p.txt and interconnect/interconnect.txt.
+  See also soc/qcom/qcom,smp2p.txt and interconnect/interconnect.txt.  See
+  iommu/iommu.txt and iommu/arm,smmu.yaml for more information about SMMU
+  bindings.
+
 
   - |
     --------             ---------
@@ -54,6 +57,9 @@ properties:
       - const: ipa-shared
       - const: gsi
 
+  iommus:
+    maxItems: 1
+
   clocks:
     maxItems: 1
 
@@ -126,6 +132,7 @@ properties:
 
 required:
   - compatible
+  - iommus
   - reg
   - clocks
   - interrupts
@@ -164,6 +171,7 @@ examples:
                 modem-init;
                 modem-remoteproc = <&mss_pil>;
 
+                iommus = <&apps_smmu 0x720 0x3>;
                 reg = <0 0x1e40000 0 0x7000>,
                         <0 0x1e47000 0 0x2000>,
                         <0 0x1e04000 0 0x2c000>;
-- 
2.20.1

