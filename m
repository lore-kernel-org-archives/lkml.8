Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B205CC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB932053B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="JKPAyqM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGZEj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 00:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgGZEj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 00:39:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6163C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:39:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id il6so1697516pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TOWjKhpTAUxQGzRJ9viFhazH/fxYC7lH/fcb5nYvYF8=;
        b=JKPAyqM7DYs8ZxV2wxCYxmRX9YIbRDi8htfCF4Iosv2ft0c+yX6CcF7e8oGlxBFZQd
         tbEMr76Ja2sFM5x3o77uGnz75XZRJiOwUdwOEadXmo5WE99JA8Ajkj3WLDXOPCHiR3oz
         KZ6YYQZ2O6yNgOvDuse6P9nGN9NGm6FfAmDrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TOWjKhpTAUxQGzRJ9viFhazH/fxYC7lH/fcb5nYvYF8=;
        b=WscZdeFS0GFdgZhDuA7A9EZDQCnUCUzxSpV5ykpPV2G9kLLxgqjWMdeKjZdCuLGwwB
         HJxkzzRY21mXhQpGFGov6aRM0JsrBwMwZLG5IslhuVsU2XR4Tu+IhJ6pdzZytPFjSsTt
         zcQQkRSHSUVwFbI/oOUZRRr2fqs+1llgHseM36Fw6vsJHBnqXcFIoDzx95fmCJvBITrC
         effkk/KS4vVedrgIRAIepHwGaWUXxcqss3gj74Xgz55ZchFB8di5p0jRwO0O9PoyFjGf
         QOeixkQTuGPCwXG12yFFkh1T/G562Q+oFt62cn2m7i4ZX7Zzfiks/aE0hKZgkCgJhepu
         dBmw==
X-Gm-Message-State: AOAM5310cP857GYw+mkeOyLFgsQH/0IaPG9YpxC25cbqlAxYhHckhYiJ
        tTX5I97yeaSnTLemZZqB/jxEy6zt7Zs=
X-Google-Smtp-Source: ABdhPJxh4sRsd07sZyUTJSxYKMWazSwAyP3irmtzA7+FVUKFIaegODvr1sdEwiFJSqJADyhWgO0+AA==
X-Received: by 2002:a17:90b:11c7:: with SMTP id gv7mr12685172pjb.175.1595738398347;
        Sat, 25 Jul 2020 21:39:58 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id t1sm10507372pje.55.2020.07.25.21.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 21:39:57 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/7] ARM:mstar: Add IMI SRAM region
Date:   Sun, 26 Jul 2020 13:39:42 +0900
Message-Id: <20200726043948.1357573-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726043948.1357573-1-daniel@0x0f.com>
References: <20200726043948.1357573-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All MStar v7 SoCs have an internal SRAM region that is between 64KB
(infinity2m) and 128KB(infinity3, mercury5).

The region is always at the same base address and is used for the
second stage loader (MStar IPL or u-boot SPL) and will be used for
the DDR self-refresh entry code within the kernel eventually.

This patch adds a 128KB region to the SoC and the minimum 64KB SRAM
region to the base dtsi. Families with more SRAM will override the
size in their family level dtsi.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 3b99bb435bb5..6bc55fdbee04 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -45,7 +45,8 @@ soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x16001000 0x16001000 0x00007000>,
-			 <0x1f000000 0x1f000000 0x00400000>;
+			 <0x1f000000 0x1f000000 0x00400000>,
+			 <0xa0000000 0xa0000000 0x20000>;
 
 		gic: interrupt-controller@16001000 {
 			compatible = "arm,cortex-a7-gic";
@@ -78,6 +79,11 @@ pm_uart: uart@221000 {
 				clock-frequency = <172000000>;
 				status = "disabled";
 			};
+                };
+
+		imi: sram@a0000000 {
+			compatible = "mmio-sram";
+			reg = <0xa0000000 0x10000>;
 		};
 	};
 };
-- 
2.27.0

