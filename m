Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B875C28E83
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D145520748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0Xb/BrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgIDGhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgIDGgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:36:52 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63DCC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 23:36:52 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so708017plr.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F7xztAForvza/aTPFJ5kdjkRWK2BzcaAuhBjilFt/LQ=;
        b=d0Xb/BrT5IHhHFFwSAw1jW9xo3JHLF5xv5wxD9qI7K4JIEpQTQOdq7nIVBsa2IDvJ/
         zGQfjq2XpsTFTJ5/fpg8eQirm8PFYpxgM2oyPIFjD2UnHMYaXiCAjyru/PO5IpLWuoam
         n2pEdDdGwLiBqej+f81jG2/V0+8SpE7hTvpnH7hjcp9eB4gUJPHoRU4iuc76TIKv6I4N
         Hh9W0n82ZY8i4j3O4e2zn1nFWZ4tBpBsQ0wd9/Zf/oC3ZBmLhNjd08PM7Q+ynVrGmHjK
         8D/j/l4x10+RVFbeIIJ61cl6+EkRm6FSwNuDmvOG5sehsSkxRF74q1K0apRHHmUDdQnF
         br2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F7xztAForvza/aTPFJ5kdjkRWK2BzcaAuhBjilFt/LQ=;
        b=TTb8WG+SHkiVemEia1iCQC/oyKwMjZByIYet1itH+gLRoHW7HdQgmgkIKkPfwe/giO
         BiXWkM+4GIhFFvXf4ym1/igdSUaDrwveU+tvOrROmrQsG8hYL3Tb/i0XWcQwjfFxqoIP
         PXnChX8GdSqUSvN4FMmjVsipgdRhQg3ybCFL92Jh82gi85FtVPns2gVP2QoqhGYiwORN
         4SKM7iojo7dMr+q5QPqZjLGbagxwux6IjETF24u+SsWRMLw/7KJ2e/uSAQwIgsSY0fY2
         TjHRPCcD37v9Tm/af/vtu6YNPGpQI/ttu3y98FSuu7iw24lW4rlpst64Q5SGA8rGeez5
         a08g==
X-Gm-Message-State: AOAM531+JXWNMP2LA+GhGbkpE7EyHO2ZzE08EMaqKXlPxmtItDj2HfoA
        Jc+ukbHYsGUKPFAcIooNDyJg
X-Google-Smtp-Source: ABdhPJyJN73V6vGB5qHtldumPRENalFRzf+XdcfVxUOp/Kh8KU5nK4P0zg8KU/xmp8ITAornxmLEjg==
X-Received: by 2002:a17:90a:644b:: with SMTP id y11mr6988183pjm.13.1599201412193;
        Thu, 03 Sep 2020 23:36:52 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 143sm5315040pfc.66.2020.09.03.23.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 23:36:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/6] dt-bindings: arm: qcom: Document SM8250 SoC and boards
Date:   Fri,  4 Sep 2020 12:06:32 +0530
Message-Id: <20200904063637.28632-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904063637.28632-1-manivannan.sadhasivam@linaro.org>
References: <20200904063637.28632-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SM8250 SoC binding and also the boards using it.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 6031aee0f5a8..1adc8a33a3e4 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -40,6 +40,7 @@ description: |
         sdm630
         sdm660
         sdm845
+        sm8250
 
   The 'board' element must be one of the following strings:
 
@@ -165,4 +166,10 @@ properties:
               - qcom,ipq6018-cp01-c1
           - const: qcom,ipq6018
 
+      - items:
+          - enum:
+              - qcom,qrb5165-rb5
+              - qcom,sm8250-mtp
+          - const: qcom,sm8250
+
 ...
-- 
2.17.1

