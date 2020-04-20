Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234C5C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A5320735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1pZLH7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgDTNAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728852AbgDTNA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:00:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D78C061A0C;
        Mon, 20 Apr 2020 06:00:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so12012403wrs.9;
        Mon, 20 Apr 2020 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nA+q8I/QCJJpzTmNvaZndgqzrDAqaSzjE9lI/zFuMMo=;
        b=J1pZLH7jiM9RNOk7oB7BKZmvRNCbTg6BvjNDXBpp8O9eS47usYikJH7/+sU9jRSkQu
         HqrKLZzlKB5GQZ9tqg3bZBaRk3u/CRxL6DXN6fL3FZWX9w2kD2W0JUMtPqWzHNoZjk08
         0DRwUJz5HIi0yi0GZdcKJmNec6PmJFBC6RacArimIPtYgG35HiaWyEWHO82I9QHWObZo
         uSNXgeAUTfAr4OoqToEZC3Pf2DPl60BnHA3iAI/4dapAVvhWz+3IjHJAIX8Yz8Nx3zeR
         WsS2rV2e/LQb59Y9P9ZU9MpzxrqirNnpMaSpckFiddg/Ni+0dC5aILDWfIAAXeRnqn3D
         Cvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nA+q8I/QCJJpzTmNvaZndgqzrDAqaSzjE9lI/zFuMMo=;
        b=l9ObYvuzgHoRSXuV5Hj2ZRIw6HFMkTKrPiQM8NDvKrMZ328iyAsI31HLNNSmqDUlDk
         RflZ5GCoftE18Fd61pOjeXupzHuQjX6xjSxprZ895j5dIyYYxMOidYCtQJ87CTLmEvVa
         BVEWdsjHKoq3hcLMrZDlVqQ4JFcOtM2XMZOu6TE2ai2o1hoDB4B29LFcfTFPEjOO84Zu
         zfKgLGdTy9p/RWNUxoZiE8uGaVfyPYjU/6467vfHw+fCSDPMcSnaT80mG+K7CwQdPkg8
         z/iB3i18hpRPDhPc7bwyKrZyO+u9CIns/wD5WU2UD2c7mu0KBCAChh0l/hKTGRt1ldDm
         ZvrA==
X-Gm-Message-State: AGi0PuaO/iranV7c/59E67GHN03UqBAE68K60wgJ/ZUPtqvQyQxLjA7P
        PUNA+0Gt0VrhsaBhJajqIhQ=
X-Google-Smtp-Source: APiQypKWtajRaAihejjMnSgeuLK9Lb250Fvr22I0sXmuCCWb67XU6IJ3wY/PMSswrb5+edDhyjx5hw==
X-Received: by 2002:a5d:6847:: with SMTP id o7mr18776336wrw.83.1587387625601;
        Mon, 20 Apr 2020 06:00:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id e11sm1081680wrn.87.2020.04.20.06.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:00:24 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 1/9] arm64: dts: allwinner: h6: Add clock to CPU cores
Date:   Mon, 20 Apr 2020 15:00:13 +0200
Message-Id: <20200420130021.3841-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420130021.3841-1-peron.clem@gmail.com>
References: <20200420130021.3841-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

The ARM CPU cores are fed by the CPU clock from the CCU. Add a
reference to the clock for each CPU core, along with the clock
transition latency.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index a5ee68388bd3..370e77b86fe1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -25,6 +25,8 @@
 			device_type = "cpu";
 			reg = <0>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu1: cpu@1 {
@@ -32,6 +34,8 @@
 			device_type = "cpu";
 			reg = <1>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu2: cpu@2 {
@@ -39,6 +43,8 @@
 			device_type = "cpu";
 			reg = <2>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu3: cpu@3 {
@@ -46,6 +52,8 @@
 			device_type = "cpu";
 			reg = <3>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 	};
 
-- 
2.20.1

