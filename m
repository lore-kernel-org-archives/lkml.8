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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B216C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC03B206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjC78e/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgDTMxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728962AbgDTMqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:46:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D1CC061A10;
        Mon, 20 Apr 2020 05:46:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u127so10123555wmg.1;
        Mon, 20 Apr 2020 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nA+q8I/QCJJpzTmNvaZndgqzrDAqaSzjE9lI/zFuMMo=;
        b=CjC78e/d0nNG3P9rU9NgSaru5pIcJeMOJwU4amWhCDJNDBXbj0XWsmcX9gFu7Rbd88
         vBN6RNm+NseO4uWtUyjmfcjjY8BKDOgaoiIYyKl6W1cpaXfqWSyoGeCADxbmHH/vIYgn
         yHkKqmEBAmyvuCNNkcCVN9lM41hxgRZzUnLwMGkYEpXYPE87p2q3hihWpP7f715l7Lue
         Kg8tWNKIHGdtctQpNoYxjcsOUYwohL+0zxVG/sQ4oo120s5uAsatFen5y4qzk7PDaPbb
         OlxsEAmyQahR8JWKyHriZ3o5h8OFHCddjmbJXYJzPGUVjfLUVbBM1Nh5DiyGuVzgdun4
         lOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nA+q8I/QCJJpzTmNvaZndgqzrDAqaSzjE9lI/zFuMMo=;
        b=Zgop2WrBehrf/KMlnR5c6bcMKy5WTXYIwHHilmtr3WTdbhPllgW/J4utplNWFjg5MB
         uxzQy5F2wTu6pYjpQ4Ub3aFog5vktUPlqMJ1nikJe5tVKgz9KP45aHNpeQGl34hrftmZ
         pqcRWVsqPWdddPuIQnUCuKe1Op3o5MD2j/ZkRpmGJF2ccCeMuYs6dSX/wD1G58JUO7/5
         5EPqrFcCW52CrqcZOZM/1I80/Nz4sKb8WOfH4LlT4QXALKpICS8bZiHR9QDbsDlLvu1v
         DwAA12kmojRvTx5Il49aONuexmN1j+swI6Jfsq5zR/1eORMyYhXKLbbpSOAXrycXG7jG
         c5rg==
X-Gm-Message-State: AGi0Pub9D2KMkKe2QD+HW/iREqazPrrkjFdApLB59ONq6WCYjj8G4Gkw
        pCB0TgbJRixP9udDF9PJnDQ=
X-Google-Smtp-Source: APiQypIgQsCnr37Mgb5vYB+mkt008H20mL6sysYceaJuzmDb/O2sDhxdOBqNjyLI5PfMQZbilMOsbw==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr17410408wmd.67.1587386798710;
        Mon, 20 Apr 2020 05:46:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id h17sm1217802wmm.6.2020.04.20.05.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 05:46:37 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 1/2] arm64: dts: allwinner: h6: Add clock to CPU cores
Date:   Mon, 20 Apr 2020 14:46:33 +0200
Message-Id: <20200420124634.32726-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420124634.32726-1-peron.clem@gmail.com>
References: <20200420124634.32726-1-peron.clem@gmail.com>
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

