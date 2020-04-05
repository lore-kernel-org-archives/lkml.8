Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFDDC2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C0120709
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDU9MpLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDEKtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 06:49:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52205 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgDEKtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 06:49:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id z7so11632211wmk.1;
        Sun, 05 Apr 2020 03:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=953t16PaqsK6LcXl7SedQvIrbO2yGs6c/tDrXm7TIhc=;
        b=gDU9MpLlJXCxtnrJImoSbWNKul0yvFgILeoD6x0Az1GLzewahCBNoaASoP2PwKMwu0
         If9A7h8AvWGp43dPJXZzkKEWy+TXf18/nhD7/OEk//SJ2ussttndqB67MpOX80y7qPUn
         XDGeAkJXlialvYn4mgovXTGTwk8h/cvavMSNFpPg/Aj27whu6BgHq6IBDtcprRnzyUzp
         dI1LvNsoFTdLJjqO/j4OYwqsXAkiHGiXaaYvT9LHva1GvzuNTZ6/rHO3AfdFjz2pStlS
         Rc46XrpmD1T7jUWt7gQd0ferGemsUtHc4Gna7eOK4HpiGdwGRzH2RqlvIhpuSwWQHmSl
         XnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=953t16PaqsK6LcXl7SedQvIrbO2yGs6c/tDrXm7TIhc=;
        b=OYJqFIhSu3stR2uhzjZe7nbe7UHRX53H/Zdoz++OHekF0iMeKzxxHkEf6CXiOg0y0m
         TRc+qj/H2L4wx3KWK5KyuvV5RBwEz+vUfhiZeVFzM88Ds6KT0mh6eS6SR5KLM0J0UYPj
         MA/y8DkoMHOtAQEtFvWPbcjnw4T6hicFsOzd9TCOu963vapZ0e4St+DMlotSObtWKnsI
         lW2vthZ0qbfsFl2Kr35nkaiK8QO2IQnWq/vYj0XKRrU81XFte+LA9YjpYV1TGA5W8LFC
         YKW8SB18y3ZB1R4OMKldJ81r6xC8Gn3oaQaMpCqr1TgDuz+7npauw5Duy5/TbnUktZYd
         Z/tg==
X-Gm-Message-State: AGi0PuYNIbo+hHIMnjSy1P2IumB6C271Bl8KqplV6qTkttnOEcncEjYc
        9C6FViKYr5YC1M0hCrw4s1g=
X-Google-Smtp-Source: APiQypIb6hYEiZU/p/Pp6GyHUm6hJVSiw5xrphdOw1InxhwhbkqgTWtX3m4rJUfQxyavTQCkImQr2g==
X-Received: by 2002:a1c:6044:: with SMTP id u65mr9806744wmb.11.1586083757409;
        Sun, 05 Apr 2020 03:49:17 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id u13sm21606411wru.88.2020.04.05.03.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 03:49:16 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 1/7] arm64: dts: allwinner: h6: Add clock to CPU cores
Date:   Sun,  5 Apr 2020 12:49:07 +0200
Message-Id: <20200405104913.22806-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200405104913.22806-1-peron.clem@gmail.com>
References: <20200405104913.22806-1-peron.clem@gmail.com>
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
index 3329283e38ab..aef4ae760d5e 100644
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

