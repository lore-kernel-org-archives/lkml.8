Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81792C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5537220772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="k0iCN5ih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGBURO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgGBURE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:17:04 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8BCC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 13:17:03 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g2so16998142lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 13:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9CjV5IRbtLXef4ZCaeYQurLNNMYOTEz6UYo91B3a5us=;
        b=k0iCN5ihLSHYr/tu3lX8IHxHRFnBO0uko2hOdV4yefDcfwPQNH0zao1tLfjU7VdtDp
         yzwD13qE4V91Qdu1YysJEf4ruLqoH+zF7N2yhUcqHPuGZtHvijipXrXSor25eaBQRXxf
         4WRPpyYpOACNSVtDpQgLWzOhjBj/WJMkNzUyE8OeeG/PENbRDXcJ1tK9Gl6aMe6EjGcg
         O8BYLzwF9uBTPabqhpVVkeTZ2V7RnNpCI1ZGvgAN9J/9sxPulR8jZlF+woDcaWTtjcmv
         5sITNIpuzVE3tV1Mv3K6AyD6plDTzYeP342sKCeOSA18wsHZ0Xcaup89hlzLtP3zFw/y
         BT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9CjV5IRbtLXef4ZCaeYQurLNNMYOTEz6UYo91B3a5us=;
        b=AZ8AZW2ioEIVILjCx6F5FQB+KBj0w6dOat7YP9cilu4r5/fppXw43NyaxMgOQTAYQe
         yG5xpFxfcVGdKuyofcY8xARKkrKJAqkVJOj+HbwkqTnrvSCOEJ3m8hjwSEe6+G+Aclu0
         680vHLiCxg2EZrbhOJdMIGApy+XVjeCe4cgN+O/d3OtrRvl31TtEN9YJ2BLcEo4N2vAr
         fex33As4/JbPaECASiTLL6w/yWx9nVqLe/ntOehvtaEpGyM4+5rxjHOlFEaEYf8ZxHnj
         035o0e/dUL1UgBmVsSg39Dyaz57Uwjaphm8ds9m/9KrVwLbSC/NRx2lK/teOzDVFupl9
         LsGw==
X-Gm-Message-State: AOAM531y/WNaetQhNzN99dpPw2QiUIlG8MkFU+ZuXQ9G6/34bwC7aksr
        OV9/TXoxDtflPsJnbNAN0lpnaw==
X-Google-Smtp-Source: ABdhPJxTvF+/sQ/1u1yKMPhEvQ5mwhQosMRjvbLgIX8F/hyPFunxwmUI84tWTJ/RmeamcAMTQWMgCQ==
X-Received: by 2002:a05:6512:20f:: with SMTP id a15mr19339346lfo.118.1593721022420;
        Thu, 02 Jul 2020 13:17:02 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
        by smtp.gmail.com with ESMTPSA id y2sm3320372lji.8.2020.07.02.13.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:17:01 -0700 (PDT)
From:   Tomasz Nowicki <tn@semihalf.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com, Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH v3 3/4] dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806 SMMU-500
Date:   Thu,  2 Jul 2020 22:16:32 +0200
Message-Id: <20200702201633.22693-4-tn@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702201633.22693-1-tn@semihalf.com>
References: <20200702201633.22693-1-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add specific compatible string for Marvell usage due to errata of
accessing 64bits registers of ARM SMMU, in AP806.

AP806 SoC uses the generic ARM-MMU500, and there's no specific
implementation of Marvell, this compatible is used for errata only.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index d7ceb4c34423..7beca9c00b12 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -38,6 +38,11 @@ properties:
               - qcom,sc7180-smmu-500
               - qcom,sdm845-smmu-500
           - const: arm,mmu-500
+      - description: Marvell SoCs implementing "arm,mmu-500"
+        items:
+          - enum:
+              - marvell,ap806-smmu-500
+          - const: arm,mmu-500
       - items:
           - const: arm,mmu-500
           - const: arm,smmu-v2
-- 
2.17.1

