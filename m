Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8081FC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610362076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xHJHTx9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbgG2AsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730877AbgG2AsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:48:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC43C0619D5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:48:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s15so1767611pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EfvldELvo7FLErlsWiPVmAKuN5/SSFt2LmTOBkch4kw=;
        b=xHJHTx9HefSaFKWD99K/a9Hxxsg14EZ0R7MjRerhC5HktfBA386qIt0TiPmveUYa8e
         Xh6QKnGdUkZODk+PZYNKQJ3Wy+8aaXe3dY7LIN9E/E/n74Aj4EKuRZlZqX8vZN6ddulD
         CjJsEJ65XjyBJK0HKWWo47QTOhKXHazH7/9M2ImseYflwXqDmFMuuzwFX7gy7mXHiADh
         +sMzlTGEtTqMsgz+/NwVxVEFfl8BVnhTmX8XbR2/CyfDRLLFWQiPo7F6aLNZF08vIYQF
         /KboZeV5uNNgsWP5UmnxJJaNvzeAwjjShKfH2lLlqzfFWsoQbF6xpIYUumE4rhxPQFDQ
         61gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EfvldELvo7FLErlsWiPVmAKuN5/SSFt2LmTOBkch4kw=;
        b=LtugXxzqfp3zSTWoWnvjq/exqjlgXyTOiaB7Bl7peh+eq++K5I0jwf1ZaolRJtycL5
         Oci07tS+aKi0a++ziiXb0lyXdtAQjlmyDGknVHCLpxGSCoj9HqGbLUu5LUXiG6SnXeSL
         zPPerbhmElZ9vKS+nx6uYdRFoP8/hJ46/ofrg6QQhQ/lMnCL8s036K5Vg2Fy631pxEcA
         GUjAHNXGEO3u0KZa5mZES3xJsJbOzYyKjjIILnEgS9KhonJvq3aOX4bQLN3mWHdlPQLF
         8DQMzMttKGH/urZ8M3jr1RDd9ylJpMeI1JaE+zGynAo+B+Vwsei2AfOAgmV/r5YvMV9i
         ct2A==
X-Gm-Message-State: AOAM530Uw1aGpQ9wBdU2/UItWFhNsf/So8JAyKpiWSbq0fMd4aeFm1Ng
        K1r8X5MFTOKberSvcDE5C5gskw==
X-Google-Smtp-Source: ABdhPJytjlRHqA72yY0KPiWKOWc6Pn9lDKQnBeGMXjcmSmSP/8NoYvt4Jb6mHcI1wDmaqYEGo6JvaA==
X-Received: by 2002:aa7:9422:: with SMTP id y2mr27652112pfo.211.1595983691313;
        Tue, 28 Jul 2020 17:48:11 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q12sm239414pfg.135.2020.07.28.17.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 17:48:10 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: hwlock: qcom: Remove invalid binding
Date:   Tue, 28 Jul 2020 17:47:57 -0700
Message-Id: <20200729004757.1901107-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm hwlock is described in DeviceTree either directly on the
mmio bus or split between a syscon and a mutex node, but as noted in
[1] the latter is not valid DT, so remove any traces of this from the
binding.

[1] https://lore.kernel.org/r/CAL_JsqLa9GBtbgN6aL7AQ=A6V-YRtPgYqh6XgM2kpx532+r4Gg@mail.gmail.com/

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../bindings/hwlock/qcom-hwspinlock.yaml      | 25 +------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
index 88f975837588..1c7149f7d171 100644
--- a/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
+++ b/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
@@ -25,37 +25,14 @@ properties:
   '#hwlock-cells':
     const: 1
 
-  syscon:
-    $ref: "/schemas/types.yaml#/definitions/phandle-array"
-    description:
-      Should be a triple of phandle referencing the TCSR mutex syscon, offset
-      of first mutex within the syscon and stride between each mutex.
-
 required:
   - compatible
+  - reg
   - '#hwlock-cells'
 
-oneOf:
-  - required:
-    - reg
-  - required:
-    - syscon
-
 additionalProperties: false
 
 examples:
-  - |
-        tcsr_mutex_block: syscon@fd484000 {
-                compatible = "syscon";
-                reg = <0xfd484000 0x2000>;
-        };
-
-        hwlock {
-                compatible = "qcom,tcsr-mutex";
-                syscon = <&tcsr_mutex_block 0 0x80>;
-
-                #hwlock-cells = <1>;
-        };
   - |
         tcsr_mutex: hwlock@1f40000 {
                 compatible = "qcom,tcsr-mutex";
-- 
2.26.2

