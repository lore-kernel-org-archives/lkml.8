Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42CEC433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDEF20792
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="a/z/OvqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgG1KDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbgG1KDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:03:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D5FC0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:37 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c6so4647680pje.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lxbXhZvTnyvcOPmVLVmmOZeoQ/h8EuzKcRQrHu6Ys/8=;
        b=a/z/OvqTBcQPu3nsrUseLki7Ob/OUuPfRJ7QCujlcXADHXmo1EkR2oTjhqWS6ApHq3
         L57qbpwjxe/+Q6iHajslHk4NA7XfqOZ1wg6+Vrmw4+dCd28eAkAJ3ZzKysg/UPBRtey4
         cGRaaT0STOn2umBO5k9rujrghxj5yQTrtrLPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lxbXhZvTnyvcOPmVLVmmOZeoQ/h8EuzKcRQrHu6Ys/8=;
        b=hhhu1LrkXSRKpcipCvlCZFxrSgXhOEbHO5TfxPm/cpq5Gg9GDkl8yN3+Td9Hy4u6wb
         NsBqNoO7z4vi/q/A+NLcNK1VJxQsAsGXVtuLztuS0WREHR2JdvVzNjd0r7GHXXcBeI1j
         XuswOlnQ0IiVhYwPnihoAA0FFN3730HS+i1aTMRhx06rBncdAD8WM7z1zf7tv7oxJNXe
         XUFGUuqG930ijiYmUNpFARTo86E+VisDNQ56Rn0VYG2E6rJgcl29DQ7Ri4C67HoyaV29
         vEwK93CTR2o1sTSaRouWC6sA4VNydPdFLHLjdcKVlAlCOiUTxkZ4I17by7zA2JbVxT/G
         DQfQ==
X-Gm-Message-State: AOAM530/qhA9MdjyjBd7T86v5y1G2TjnVPI0pD738rYShrLKj37glltp
        gc3f30LRdwr81lIELsNoNHINbg==
X-Google-Smtp-Source: ABdhPJzgrVdwKcVK8UnYyivtHVMUZH50zK4g0UmUp6oEGbQd3CQ+f2flbMX0GtsnGr+g1mFPLcTnIQ==
X-Received: by 2002:a17:902:768b:: with SMTP id m11mr9252580pll.97.1595930617124;
        Tue, 28 Jul 2020 03:03:37 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id u66sm17779018pfb.191.2020.07.28.03.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:03:36 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 2/9] dt-bindings: arm: mstar: Move existing MStar binding descriptions
Date:   Tue, 28 Jul 2020 19:03:14 +0900
Message-Id: <20200728100321.1691745-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728100321.1691745-1-daniel@0x0f.com>
References: <20200728100321.1691745-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now there is an mstar directory move the existing MStar specific
descriptions into that directory.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 .../devicetree/bindings/{misc => arm/mstar}/mstar,l3bridge.yaml | 2 +-
 Documentation/devicetree/bindings/arm/{ => mstar}/mstar.yaml    | 2 +-
 MAINTAINERS                                                     | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/{misc => arm/mstar}/mstar,l3bridge.yaml (93%)
 rename Documentation/devicetree/bindings/arm/{ => mstar}/mstar.yaml (93%)

diff --git a/Documentation/devicetree/bindings/misc/mstar,l3bridge.yaml b/Documentation/devicetree/bindings/arm/mstar/mstar,l3bridge.yaml
similarity index 93%
rename from Documentation/devicetree/bindings/misc/mstar,l3bridge.yaml
rename to Documentation/devicetree/bindings/arm/mstar/mstar,l3bridge.yaml
index cb7fd1cdfb1a..6816bd68f9cf 100644
--- a/Documentation/devicetree/bindings/misc/mstar,l3bridge.yaml
+++ b/Documentation/devicetree/bindings/arm/mstar/mstar,l3bridge.yaml
@@ -2,7 +2,7 @@
 # Copyright 2020 thingy.jp.
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/misc/mstar,l3bridge.yaml#"
+$id: "http://devicetree.org/schemas/arm/mstar/mstar,l3bridge.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
 title: MStar/SigmaStar Armv7 SoC l3bridge
diff --git a/Documentation/devicetree/bindings/arm/mstar.yaml b/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
similarity index 93%
rename from Documentation/devicetree/bindings/arm/mstar.yaml
rename to Documentation/devicetree/bindings/arm/mstar/mstar.yaml
index bdce34b3336e..c2f980b00b06 100644
--- a/Documentation/devicetree/bindings/arm/mstar.yaml
+++ b/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/mstar.yaml#
+$id: http://devicetree.org/schemas/arm/mstar/mstar.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MStar platforms device tree bindings
diff --git a/MAINTAINERS b/MAINTAINERS
index 432fcc867ed6..9b35edac7ef7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2139,7 +2139,6 @@ M:	Daniel Palmer <daniel@thingy.jp>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://linux-chenxing.org/
-F:	Documentation/devicetree/bindings/arm/mstar.yaml
 F:	Documentation/devicetree/bindings/arm/mstar/*
 F:	arch/arm/boot/dts/infinity*.dtsi
 F:	arch/arm/boot/dts/mercury*.dtsi
-- 
2.27.0

