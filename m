Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CC5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FED22168B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KP8Hu6H+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgFTQKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgFTQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:10:22 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEA3C0613EE
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:10:22 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id mb16so13565268ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5sGkeTgB7hG+3/+kop32buJfTUcIo0SVNUTekYvYHs=;
        b=KP8Hu6H+TKWt9icYwwel5BGCy7wG8KTCsCGoSAK+W9eUq7i/GXSA2q6DwPfwMedTUz
         11CcEr8qJFI1fGzQThuGQIBJgK4ZNsr2CQdeuSTpKZaQeeUQ0VSojBLOwvt+VTa8lN2h
         DTZdd72qL5C6hPcJo2AwwrZ7RnJRspjTDyJ7qGeiLh0P/1RlL+xNOSAQUVQQsCJUwl7D
         l44N4MyJWSzgMDJuJH+n3u4G654WojXsT1V52yZJzYzoyIbIRHtaAhuYMZLVCYn/CTwq
         2O2Cz+77lYvpywWEuQfF8IHn9jZGc4sIgY8J7IaCLRNmhzfInUQTCcwIfRqa91qucGWp
         kTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5sGkeTgB7hG+3/+kop32buJfTUcIo0SVNUTekYvYHs=;
        b=jl3gZaB/D1RC8QttKwUR7SJ8gMwCTNaf6bOGBU3H45EaXwfhioaGz9nV9E9FUjQRiq
         u1I4CQRHmruzuVtLHehuuFu1zNtehAk0Ni5E30AJbm0NG3NSKGKqq6G0u8R1ksE85pGI
         o08PwNi5SiRcD7+H5eQtZuxoPZKxssupoFF+9e7d+rJ3jnEog0pkiJsuMQJmAnupj3mc
         4ULZkrtiY/J9KWrKAritH3Q56d0M5saC8gNh6aP2hPFg6VINtI6ZKicVpH0wVlSLyajd
         uXxyEh5uiPlbr02uNXbLgruOF2Xn4zexdCk7rjv8MwIeK/QFGeyUER03BgjQchCtoNjU
         OCSQ==
X-Gm-Message-State: AOAM532GwaGMZDux+wDhlfzsHFBiphDNdQzDbZjOJX4DhyZLjOz3XVP9
        wYe8ZxuzEX0Hwc1gDc8gY3s=
X-Google-Smtp-Source: ABdhPJx4CvOmAO/aNMwlgPaw9yw/l476jL1k+DulhYLM1sPPaPtnarcJAAVfirTfPa+5CcP3cHzYpA==
X-Received: by 2002:a17:906:f2d9:: with SMTP id gz25mr9045554ejb.467.1592669420963;
        Sat, 20 Jun 2020 09:10:20 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371df700428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371d:f700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id a62sm8033207edf.38.2020.06.20.09.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 09:10:20 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] ARM: dts: meson8m2: add resets for the power domain controller
Date:   Sat, 20 Jun 2020 18:10:09 +0200
Message-Id: <20200620161010.23171-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620161010.23171-1-martin.blumenstingl@googlemail.com>
References: <20200620161010.23171-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Meson8m2 SoCs has introduced additional reset lines for the VPU
compared to Meson8. Also it uses a slightly different VPU clock
frequency compared to Meson8 since it can now achieve 364MHz thanks to
the addition of the GP_PLL.
Add the reset lines, VPU clock configuration and update the compatible
string so the implementation differences can be managed.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8m2.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/meson8m2.dtsi b/arch/arm/boot/dts/meson8m2.dtsi
index 2397ba06d608..c7ddbb210366 100644
--- a/arch/arm/boot/dts/meson8m2.dtsi
+++ b/arch/arm/boot/dts/meson8m2.dtsi
@@ -61,6 +61,25 @@ mux {
 	};
 };
 
+&pwrc {
+	compatible = "amlogic,meson8m2-pwrc";
+	resets = <&reset RESET_DBLK>,
+		 <&reset RESET_PIC_DC>,
+		 <&reset RESET_HDMI_APB>,
+		 <&reset RESET_HDMI_SYSTEM_RESET>,
+		 <&reset RESET_VENCI>,
+		 <&reset RESET_VENCP>,
+		 <&reset RESET_VDAC_4>,
+		 <&reset RESET_VENCL>,
+		 <&reset RESET_VIU>,
+		 <&reset RESET_VENC>,
+		 <&reset RESET_RDMA>;
+	reset-names = "dblk", "pic_dc", "hdmi_apb", "hdmi_system", "venci",
+		      "vencp", "vdac", "vencl", "viu", "venc", "rdma";
+	assigned-clocks = <&clkc CLKID_VPU>;
+	assigned-clock-rates = <364000000>;
+};
+
 &saradc {
 	compatible = "amlogic,meson8m2-saradc", "amlogic,meson-saradc";
 };
-- 
2.27.0

