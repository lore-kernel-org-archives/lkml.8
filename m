Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB501C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBCD20791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsyVyGGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgHMSRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 14:17:19 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCABC061757;
        Thu, 13 Aug 2020 11:17:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id jp10so7220582ejb.0;
        Thu, 13 Aug 2020 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eHl87Tk9sNCP3OVqberPWxWI3WHAWf0EaAib5QaPo5Y=;
        b=EsyVyGGa6ULP6GtzdOZBejj4tSea3XXh3+39K0aPLizW8EUzwetXOW0zugIPEBSY8R
         Q+JclRuxd9CBSKJ/lt2P3SVzhdLyEKP5ntcIftzfhQtU2RCG7wn8r8PY6mAMmZr+kwUj
         EHfx5QKuqYeHxCzqN8vxSGOVMFBV7QLvdjZvO/9BQpPFq85YWFNcssUeNAgHHK/qhY6y
         vgeu9J9F32aXNszrBxQB9UyCyqlPyOHRegYdI7zNwbQlQBEZ5NjiToHAmYrgb9x5PVbQ
         xJ2CzJ1bYZQQl7yM9gQqaFmtM7oJzOnCl5qL1e6spdXyhkfCwrM/hUkOjn2uKNjsgvkr
         lJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eHl87Tk9sNCP3OVqberPWxWI3WHAWf0EaAib5QaPo5Y=;
        b=oYxtihHJNlkwXZjokANBrBHqErZ9Jl7XzljctoDq70v17w4lyEk+O5iikqY/xKAlcj
         +2iu9JHM29URu6SPmK5HjwkfHZaFNTEaQut0ubJdUTRJiSaaOd0pEMa7ncILBml8JW2R
         ZERVCnLqx8/MBX0hR32RYnAyjtrF1b6DjpDy/P6AufozIMgkFlmmwo965wNPLce6flp9
         LYqTQ3UR2KUwK+OCw56ADyqDhdfCxoeJN+IMUO3mJf2PTfTqi329XEFoess1iXkO4Miv
         PwPMM7u21EAovsdG2L2fAXMX2IPCnEay5OYa+HY4EaLFmKY+Ji7q0XnLRGEgN7pKlRhr
         20mA==
X-Gm-Message-State: AOAM531JwqOF2XAZ2e7rRUjV/LrUxESBImwkZsLWNGv45wO5ppBSoMsd
        SO0+6Gy/U1S8MLGewktkjZE=
X-Google-Smtp-Source: ABdhPJzYEM+kZDPWxa4+yFv0i/r3XjVFOzaNT+lmp/cSEMTvsbpUCv35HJzUQYAzXmZw+t8Jdw14KQ==
X-Received: by 2002:a17:906:938f:: with SMTP id l15mr4597829ejx.539.1597342638224;
        Thu, 13 Aug 2020 11:17:18 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w18sm4887647ejf.37.2020.08.13.11.17.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 11:17:17 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: fix cpu-supply for rk3328-evb
Date:   Thu, 13 Aug 2020 20:17:11 +0200
Message-Id: <20200813181711.15906-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property cpu-supply should be added to each cpu separately,
so fix that for rk3328-evb.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index 1969dab84..a48767931 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -70,6 +70,18 @@
 	cpu-supply = <&vdd_arm>;
 };
 
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_arm>;
+};
+
 &emmc {
 	bus-width = <8>;
 	cap-mmc-highspeed;
-- 
2.11.0

