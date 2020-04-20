Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80055C55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5751B2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3v7c90P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgDTV5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgDTV5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:57:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF54C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:57:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z6so4451502plk.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R4+EbnUpWVTDbrBufnwy+Hvvb+k6edJjvvRt1FVHk0c=;
        b=Z3v7c90P0TKJBPhDH5LmSWpfdwv+AJV0m3lmcFBmurUJLZyIg4YN2waqagTtSfyQei
         FdYSA2cHL85bVumKXSqa1ySMIEHcOkKgAQ03+LvySYJQSVH63dvsKoRlFDbUjGkvb94T
         LuFzsGiziHdoE9d5GVNwJoEiyoLDMxVoGHTxVrNY1t6Jx4Ub2B0Ra1013+JZ7hMfBsI4
         qOIcERrgMuTldTVeTT/RU78wL/+GCREkENJkn7IDL852x0LDa0oNkLTHyTVLdCudZ7Fb
         1ERT6rk/ChA5sM4OQIuYso/ke3RplSXodXhS16sgNb/NGTc7Vahu1+BDJ8FDLSqk6Af6
         lH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R4+EbnUpWVTDbrBufnwy+Hvvb+k6edJjvvRt1FVHk0c=;
        b=eXGqgm7xln5P08JoSg/xm2AneirsvUbsfGGgvPw1VHnHQrFtkTEJ0GS0SPiAX3HqQx
         NkJ3/hM+QbGmdeir9fwfaH2Mv6cF4nXf6/788H2ubRHl3XtzzyZmFQcTMP4J4Dre15Rb
         OT49sPeHtCiict+1I7lTp+wvVTzd28mjL78IBjY5D97QKdySaLPT5qOK7sOB+ZKxugHK
         ieGEqFYs7d3MmVeg5jH8CXyydw28MeBObZ2VXBKPaOdAp0f2bzwHuWCRowlA/oO7tf6U
         g8sy5L0TK4hjgDoUjqqUji3ox7M0Svex7Ex4mSRtBrnwu9WKyQe4er/uIpGHFJQwkhFL
         89WA==
X-Gm-Message-State: AGi0Puaz/Ixl45cWyOQgJ31Zz1JsvBE7u+C8XkzsXB45pK0tong2iHRi
        i2dVKlVLAw3U0icBB9SemRwdR7XXyHs=
X-Google-Smtp-Source: APiQypJ9sXQtm/WXyZjNaKBp6mUw3NoNwG9zgqVLc8aFsJgWGDzvGnKwVH6djyUVhYPZ28FgJsSKRw==
X-Received: by 2002:a17:90a:ea07:: with SMTP id w7mr1771579pjy.172.1587419824119;
        Mon, 20 Apr 2020 14:57:04 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f30sm365863pje.29.2020.04.20.14.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:57:03 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: display: simple: Add IVO M133NWF4 R0
Date:   Mon, 20 Apr 2020 14:57:27 -0700
Message-Id: <20200420215728.1927434-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the vendor prefix for InfoVision Optoelectronics and add their
M133NWF4 R0 13.3" FHD (1920x1080) TFT LCD panel to the compatible list
of panel-simple.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Added this patch

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 Documentation/devicetree/bindings/vendor-prefixes.yaml          | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index daf86ba18f47..31dc88f5b2a9 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -129,6 +129,8 @@ properties:
       - hannstar,hsd100pxn1
         # Hitachi Ltd. Corporation 9" WVGA (800x480) TFT LCD panel
       - hit,tx23d38vm0caa
+        # InfoVision Optoelectronics M133NWF4 R0 13.3" FHD (1920x1080) TFT LCD panel
+      - ivo,m133nwf4-r0
         # Innolux AT043TN24 4.3" WQVGA TFT LCD panel
       - innolux,at043tn24
         # Innolux AT070TN92 7.0" WQVGA TFT LCD panel
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d3891386d671..31012f91fb9a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -463,6 +463,8 @@ patternProperties:
     description: Infineon Technologies
   "^inforce,.*":
     description: Inforce Computing
+  "^ivo,.*":
+    description: InfoVision Optoelectronics Kunshan Co. Ltd.
   "^ingenic,.*":
     description: Ingenic Semiconductor
   "^innolux,.*":
-- 
2.26.0

