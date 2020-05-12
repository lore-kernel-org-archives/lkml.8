Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2213C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F19520731
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sqqdAXK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbgELVwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728313AbgELVv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:51:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4215BC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:51:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id m12so19121996wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ML06J9nAXnrGfb8Sw/sNjsFqqfba47oOWTFdhQokhaE=;
        b=sqqdAXK6AKL3cbZ99XKBs8vbhtAITOFn3FP5urm5A9+m+E3vBxCyHzDePpPHKg5vjj
         LKHfYxs290ihRp1p84MmSSxnUVV+ubgjKVy09HRPONVXw0pyP2WdpBV9fuMZJQ6eh4Nb
         LNH67EVYxVFhj36nWZNsIAr4MZUM4VCo45Ypo+0r/hjTilR1SzePTzQQ+oG9lLx+Bxyj
         7A8pjPfgVM/UuTmXTFVyqFug0Fsz7pvFsKcr766wVUk2+i3mCLqXYuCxyFH8CKCdJ+Xg
         CVDq61GKy/MdOLe54IBiKfX/yfXceGudA3Bmz2MbI7+HQk7Dz1MSCMhukgmoc1n6zJ/e
         A/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ML06J9nAXnrGfb8Sw/sNjsFqqfba47oOWTFdhQokhaE=;
        b=Y++yaIswIK8qX57WLshUwMc8IJ/zqvARQVT3XOtw/L6e/LeQPqClNQvoK5ZmZSI4ic
         WqhMJhuy4TDGFPDqKWnFPHpKKyPUc01qlpQBFv/N8K9sdlU2oBuw+2jDZjKWIUBMxP6h
         +EUH2hUabP+8HPUZOJOiKHprI4UA9GkD6sYnwqXtvX5yCmOtoT4hFKhb2fwjoQ5FEJRK
         w4WxjDg+aMnqr/V8cfAb0ajHbfzzE90jEvRMcC7vNv4B7vZdcgEOFcmBBqR7UiybJ8lI
         iY8xhMV5Y0mdai6hFkSsKHtXsDCISvnrHfmJR4lgcu/E/RL6BNQ0cP0IUPxYrXOLgPaB
         l3Qw==
X-Gm-Message-State: AGi0PuZiProtNMlXHR0IDoPxm3Q0sLM32yxaDxKvPcTCFCv6kyeyxep3
        ilolahSXfWFsla00b1SjCKU=
X-Google-Smtp-Source: APiQypKHylusgy6f8u/ZP6adCO9GAkIUbJCRnspiKCYLMh1Hp4j9DPjXr8tdjOS9U6uh8sjsjGYg1A==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr37244079wmh.141.1589320316956;
        Tue, 12 May 2020 14:51:56 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id d9sm9154234wmd.10.2020.05.12.14.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 14:51:56 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] ARM: dts: meson: Add the Ethernet "timing-adjustment" clock
Date:   Tue, 12 May 2020 23:51:47 +0200
Message-Id: <20200512215148.540322-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512215148.540322-1-martin.blumenstingl@googlemail.com>
References: <20200512215148.540322-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "timing-adjusment" clock now that we now that this is connected
to the PRG_ETHERNET registers. It is used internally to generate the
RGMII RX delay no the MAC side (if needed).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi  | 5 +++--
 arch/arm/boot/dts/meson8m2.dtsi | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index e34b039b9357..ba36168b9c1b 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -425,8 +425,9 @@ &ethmac {
 
 	clocks = <&clkc CLKID_ETH>,
 		 <&clkc CLKID_MPLL2>,
-		 <&clkc CLKID_MPLL2>;
-	clock-names = "stmmaceth", "clkin0", "clkin1";
+		 <&clkc CLKID_MPLL2>,
+		 <&clkc CLKID_FCLK_DIV2>;
+	clock-names = "stmmaceth", "clkin0", "clkin1", "timing-adjustment";
 	rx-fifo-depth = <4096>;
 	tx-fifo-depth = <2048>;
 
diff --git a/arch/arm/boot/dts/meson8m2.dtsi b/arch/arm/boot/dts/meson8m2.dtsi
index 5bde7f502007..96b37d5e9afd 100644
--- a/arch/arm/boot/dts/meson8m2.dtsi
+++ b/arch/arm/boot/dts/meson8m2.dtsi
@@ -30,8 +30,9 @@ &ethmac {
 		0xc1108140 0x8>;
 	clocks = <&clkc CLKID_ETH>,
 		 <&clkc CLKID_MPLL2>,
-		 <&clkc CLKID_MPLL2>;
-	clock-names = "stmmaceth", "clkin0", "clkin1";
+		 <&clkc CLKID_MPLL2>,
+		 <&clkc CLKID_FCLK_DIV2>;
+	clock-names = "stmmaceth", "clkin0", "clkin1", "timing-adjustment";
 	resets = <&reset RESET_ETHERNET>;
 	reset-names = "stmmaceth";
 };
-- 
2.26.2

