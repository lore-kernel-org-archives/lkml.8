Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2841CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0366820578
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF3xQPmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHCOae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCOae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:30:34 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC69C06174A;
        Mon,  3 Aug 2020 07:30:33 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so30198518ljd.0;
        Mon, 03 Aug 2020 07:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KnzW7p0iByCA8ZSYOfr1tOM7Ju6uvbTxOgMkLeLg4TE=;
        b=cF3xQPmVRXDdHqrAwvdenMip3tPx3TWp1GiCpdq358ne/UzxoJ1GU9SsT4CpqhfzkM
         OY5d3jqt+WHdY+8jpwU876oqGqXNXBunHreeLZyFxMMrdyjluUKa+Rpcwof3chPAXQon
         GMfkP24z2ED+HMEZbXsI9negmZPWkpIr5gan2jCDWIlN/2Fjw7zS5UrtmwZhqQY0veVE
         b200/dSc2fBSAP593Pq/WZikcyHm90R1EZ3DRRcaRfmsEo+4Ueyee7jz4BlAtVgghfAB
         ARv4jn0MEoonv5cH7r5nzJNUH1Pkx2wxuwYZo5/j/mtYxe33SZHJ05ZJlfQ6o9EruoAZ
         /gHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KnzW7p0iByCA8ZSYOfr1tOM7Ju6uvbTxOgMkLeLg4TE=;
        b=TwAA7Jh929abulUg4iZBsdAsuzY3qa9fVBoxw9sR/DeLBAgN233croSJ+s5NkogdrZ
         uEksd1d0V/fMJe9arS+f55ceeAmcjyZV1qjthD8JnwIx22bQpoNaqagYNnRCH2tERnK3
         lucuciY00HYaxqqju9n9CZ2RsgXCafU6pbfcv41CMCs37tFihH4K7IHxp40QIwNhnLI2
         z7hHk0u0+91taNE8CujIVIj8CHt3K+KJZjgr/76Kkbge+VPC+vGvUPxroZ0XSCCiXhiL
         4niA1DdUIAfgxQUjH7q5HEVrF1rpz7yGlvAqGevztTT3JVBwlZXGiwul0BUmjuUuU39j
         wLRA==
X-Gm-Message-State: AOAM531kOzJye8e2WXl0x+eDg5sFzk170PcHyRC6d0wATKBmSPq/j4ZO
        R7WKrndnrvD07wvmgYTYF7w=
X-Google-Smtp-Source: ABdhPJyKXl1WIje3fN3UuI7wRpj8/m8XTHYYWoYCRBSyLMBIvRtHkFzXGlLXhFq48fEHe5WxIOUEDg==
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr8574575ljm.464.1596465032301;
        Mon, 03 Aug 2020 07:30:32 -0700 (PDT)
Received: from localhost.localdomain ([89.22.145.64])
        by smtp.gmail.com with ESMTPSA id c4sm2725523ljk.70.2020.08.03.07.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 07:30:31 -0700 (PDT)
From:   Alexander Kochetkov <al.kochet@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexander Kochetkov <akochetkov@lintech.ru>,
        Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH] arm64: dts: allwinner: replace numerical constant with CCU_CLKX
Date:   Mon,  3 Aug 2020 17:30:22 +0300
Message-Id: <20200803143022.25909-1-al.kochet@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Kochetkov <akochetkov@lintech.ru>

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index c26cc1fcaffd..dfeeb7350808 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -51,7 +51,7 @@
 			reg = <0>;
 			enable-method = "psci";
 			next-level-cache = <&L2>;
-			clocks = <&ccu 21>;
+			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
 		};
@@ -62,7 +62,7 @@
 			reg = <1>;
 			enable-method = "psci";
 			next-level-cache = <&L2>;
-			clocks = <&ccu 21>;
+			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
 		};
@@ -73,7 +73,7 @@
 			reg = <2>;
 			enable-method = "psci";
 			next-level-cache = <&L2>;
-			clocks = <&ccu 21>;
+			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
 		};
@@ -84,7 +84,7 @@
 			reg = <3>;
 			enable-method = "psci";
 			next-level-cache = <&L2>;
-			clocks = <&ccu 21>;
+			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
 		};
-- 
2.17.1

