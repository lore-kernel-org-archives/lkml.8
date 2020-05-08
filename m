Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B093DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D27E24958
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m6+WB7dk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgEHNrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728389AbgEHNrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:47:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02A3C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 06:47:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so1929542wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ie6+UuDf+byXPXqX2PqIi5x7CCl0W8NA5IcDm5qQXXA=;
        b=m6+WB7dkD5OY5SUi5lv4lAQ0mBcKHk146e1QwqFyiJLMV7m2seti2PPWrL7Mtg7jPO
         fXjmH/Vnwq/PvdNM4rnRQR2Tdqjfrj3LFUvE//ja5RmUll82j+lwt5OjJNUex+3tSuvB
         vdD4nx5w3ghYDD5wcoyKT9xS1a8iGCzZbYjXujuK8CbZnH5rGkqLhUfHhQC2/gQThxjY
         noNtQ/LLD6fvKiZkWu0yqgqC2AfhxNQmPFSnGMZNEjjDAEFNrPpG9xyYEcjTe4HXV4OU
         iv5bKD2VV9yDVTDx2E3g6Hze2Njrn0R7oUPj520tNshk0RmsY+buEld6wKdQOZL7oXfA
         vJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ie6+UuDf+byXPXqX2PqIi5x7CCl0W8NA5IcDm5qQXXA=;
        b=dcz5gsAk9qNPJbNCnNIIeXpYRthX2POUzs/kb4WVYfMhiPTQPbZWBmLXLQg5BlpgVN
         UdRM3mnvbCzLQRC/CbfndQE6Suuwqxt+9mKUe1DHot5X8nBBf01JBWQz0hEZtZHnxFoq
         uxv2cg8jYzuw+i/jJsQhu8EGjvZcA9TU9haqMbxEeXL5/p4YQg35P7CUt4kIhzFyGh90
         /RXIqwFMmEtLTQkvx9ytBxsjkImpbg1RhCFU9re59/xHPVHo748virAXNlUsmPzJCrp3
         69REFeVTBlla7FA9pUxv/9d6N27JhbYVkdg/3XupQq2AD4W7XYLB7d8F2vILfm2L7YP3
         toPQ==
X-Gm-Message-State: AGi0Pua9L1syEKnDqBtvhXKqlXpANqL/b3psQ2+uYrX3s8JzzrWV6J5f
        IIHqZTxdG+ZW0V9uK7VdwsOmkoLeJQCti2zR
X-Google-Smtp-Source: APiQypIPzHLCqcPpkTXMRiOcVbMkzFJd/j8pltNsJ1oUqIBWiQl4ZEevMtSVlfhwuPrcT/Rvkqk3Xg==
X-Received: by 2002:a5d:6b86:: with SMTP id n6mr3018508wrx.113.1588945620266;
        Fri, 08 May 2020 06:47:00 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058702ff00bc4b798f4f30d41e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:bc4b:798f:4f30:d41e])
        by smtp.gmail.com with ESMTPSA id p7sm3189464wrf.31.2020.05.08.06.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 06:46:59 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, fabrice.gasnier@st.com,
        alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org,
        Etienne Carriere <etienne.carriere@st.com>
Subject: [PATCH] dt-bindings: nvmem: stm32: new property for data access
Date:   Fri,  8 May 2020 15:45:27 +0200
Message-Id: <20200508134527.26555-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Etienne Carriere <etienne.carriere@st.com>

Introduce boolean property st,non-secure-otp for OTP data located
in a factory programmed area that only secure firmware can access
by default and that shall be reachable from the non-secure world.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
---
 .../bindings/nvmem/st,stm32-romem.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
index d84deb4774a4..c11c99f085d7 100644
--- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
@@ -24,6 +24,18 @@ properties:
       - st,stm32f4-otp
       - st,stm32mp15-bsec
 
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+
+    properties:
+      st,non-secure-otp:
+        description: |
+          This property explicits a factory programmed area that both secure
+          and non-secure worlds can access. It is needed when, by default, the
+          related area can only be reached by the secure world.
+        type: boolean
+
 required:
   - "#address-cells"
   - "#size-cells"
@@ -41,6 +53,11 @@ examples:
       calib@22c {
         reg = <0x22c 0x2>;
       };
+
+      mac_addr@e4 {
+        reg = <0xe4 0x8>;
+        st,non-secure-otp;
+      };
     };
 
 ...
-- 
2.17.1

