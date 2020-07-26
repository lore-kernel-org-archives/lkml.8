Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE91C433E8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9376E204EA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="HJvnhiH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGZEkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 00:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGZEkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 00:40:09 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF777C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:40:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k18so106641pfp.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GcYahk119/P6sJeLyBM6skc+StG+Q5VazOhFiNV7EeY=;
        b=HJvnhiH8sqqk/TaRfJ3AAzRXE1dVXQ6bNix3sbK/Zg3QgYOjzjxheLPqiQMsHAfZAa
         KciDaNNL2So4bj2LTI3gA/rTs1aBUnxGhrj5OAFJ2QWK6QeAqAlPhJyuNp97tW+EX3kc
         P9Lqr6s7f9yj8feU28Z3p+I6LFKA6XQiM+WnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GcYahk119/P6sJeLyBM6skc+StG+Q5VazOhFiNV7EeY=;
        b=W83pb9HdAEsC2p6HSqsBvoGGDWV2yNzB7EkgOU8k1Xedp5Fc4plgf5AN1YpyLAR9Y6
         vZCtHPJuILaTEzIszdIGyST6lmxHboEN4tki/GZqz3SDXN86ofe9U2T2+Nx/cGcXDXJG
         RBAPFVBncQmDB4ft9Fvi567Z6FSRoulFJfgkUYu51xoZLn8kydcYTgUl/qG9sHoIJeHt
         GFvLi4Q5UjKfLA42RoOBcMjTDNcXVmX5KCBSXRsD+uTIfaxv/te+oFsluIJuMzK8Z5dE
         yLtA+IhTYNROBoXr45s7meIZAxqeQ4tcomu/kKOkjcYw0CgVGOOMKzSCuXatnWzx0phN
         cqEg==
X-Gm-Message-State: AOAM531GgZLRmxhvZ2rfoOmqnnGdfpRq5+79vRZWYetx3Pzh2tc0Vo/V
        a7FAcj4CsuVR7b7jnSVvEn/QUA==
X-Google-Smtp-Source: ABdhPJy6U1NdGWdP5tLM3lf6I+rTO1BkL50dyZykEF6wULxbH1YRFp23fLmt1mqHr6Pf5k7pVHyfVA==
X-Received: by 2002:a63:2b91:: with SMTP id r139mr8722888pgr.61.1595738408450;
        Sat, 25 Jul 2020 21:40:08 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id t1sm10507372pje.55.2020.07.25.21.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 21:40:07 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 5/7] ARM:mstar: Add PMU
Date:   Sun, 26 Jul 2020 13:39:46 +0900
Message-Id: <20200726043948.1357573-6-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726043948.1357573-1-daniel@0x0f.com>
References: <20200726043948.1357573-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the ARM PMU to the base MStar v7 dtsi.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 6bc55fdbee04..a73b1d162dfd 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -40,6 +40,12 @@ arch_timer {
 		clock-frequency = <6000000>;
 	};
 
+	pmu: pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.27.0

