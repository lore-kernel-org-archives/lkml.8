Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8F9C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239B4206F7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv0iaaZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDEKtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 06:49:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51038 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgDEKtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 06:49:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id x25so606099wmc.0;
        Sun, 05 Apr 2020 03:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IaJsFC4mWmdWbyKkdQgRslfWupkpd121xwwCWiCDFic=;
        b=Nv0iaaZun8PkGFqjzFCOX/XXu0sTlYO7LusRed2bei95p+rs4hZ7XH2/iv2jGKx862
         oN9+2KsfkmGeiQfJDqT58NKoObV1zqDiDqgJygMerNwfmNjCl85s+ItAryXJsZDJOhVU
         ylJ94U7G6a2oOSmrTYv3D6bN7o5DNh8+8++aG+PXhZ26+PVQzmimqgwKJLEx2OZm1B5T
         2++Zq9V0Ui1hIHtTjFEck8Jn69LwAMDYikkRyvEJqip9WjViVZ/MFzqeMG3xsu9nqywq
         104rznEUw6/mMPPP9kgjczn2DnWMfQDKfHjGzmwcoL/fR2O/Zay7Xdskguof+j5YnPr2
         6xEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaJsFC4mWmdWbyKkdQgRslfWupkpd121xwwCWiCDFic=;
        b=dSDOlPhLSVYce8gzq2HkoSoG/BSvhRu08X+LbtnCYxiZk712F397C/nWmHJlOnzxC+
         bDvUxIdk77VDVbylY6dcNLJX3JtZJ1qf2mEaBFhuZUQllo43jZaUqtk+TFsiTiBULzhJ
         CzIzOxI5buxtaccQldMu4KbX/aD8c5CtIVbLlqXgzks8vDXyt8h2Md6+2eDpXimsu7JR
         n+Vh+n6RkbL7C8Sls6H0LBYgS3xjVcRsRsgkJpWJp7iU0yTK31GNgUd21aaVrPFbGJVA
         djAZTSRO6ZbqoklpB2U0t+Sl6/Y8PzDfQGCr0n/6qODDyClp5ke6XfFvWzXNyCduq9OX
         aFCA==
X-Gm-Message-State: AGi0PubQ/1XsxZ233l9kKirLOcw12d5QhGmMpgjdUbvMDU0Fba7VcMlJ
        zzP4X8F6mptIjAaiBZL9nNE=
X-Google-Smtp-Source: APiQypIS4eeDCAO10hAejWjIAXROTbLF+7oPU0gehy8YueTE+QgfA2pzVNpE3cbH4EFv4ULU0UCRmQ==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr17359670wmj.87.1586083763912;
        Sun, 05 Apr 2020 03:49:23 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id u13sm21606411wru.88.2020.04.05.03.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 03:49:23 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 7/7] arm64: dts: allwinner: h6: Enable CPU and GPU opp tables for Beelink GS1
Date:   Sun,  5 Apr 2020 12:49:13 +0200
Message-Id: <20200405104913.22806-8-peron.clem@gmail.com>
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

Enable CPU and GPU opp tables for Beelink GS1.

This needs also to change the CPU regulator min/max voltage to fit
the OPP table.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index df6d872c34e2..8e65d56a7c85 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -4,6 +4,8 @@
 /dts-v1/;
 
 #include "sun50i-h6.dtsi"
+#include "sun50i-h6-cpu-opp.dtsi"
+#include "sun50i-h6-gpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -70,6 +72,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &de {
 	status = "okay";
 };
@@ -226,8 +232,8 @@
 
 			reg_dcdca: dcdca {
 				regulator-always-on;
-				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-min-microvolt = <820000>;
+				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpu";
 			};
 
-- 
2.20.1

