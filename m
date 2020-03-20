Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4B0C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627802076E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYiSWXG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgCTNff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:35:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52830 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgCTNfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:35:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so6533689wmo.2;
        Fri, 20 Mar 2020 06:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ie6jFqOSrTu+xf/V4MNbj7GzVLme0az5kv4/5mQNB0k=;
        b=bYiSWXG8HNjZu608MUAN1KPB+00ESgXXtFJe3GhMQamj1oqGRLdIag3YlPDV84IXVx
         Pk2IKG85pzwF+e2b1gPFFZP1XlJMDBM1eOJozEl3FYERUxf42zq8cNoXdifXXmFSZUIm
         s3QvzOLmDGB7sdRpYfXUOXxBnk/TKAmHkuQLNxDD0jZO0vBcu5w4IWQmJZr9hJ3ZqgOh
         XVJ7CVyUYtY4PtZSDFVsRTp3sLEV68KxruuIpNGs6o2eA14en3bYLw0YRCr/0F/s4NOL
         PmLGJsdYO2Q1CKNTDho+GzRMnNeXIOmXyqakuaFBnV1DfMxJsME7EDYWKbfBBQTKD85a
         Se6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ie6jFqOSrTu+xf/V4MNbj7GzVLme0az5kv4/5mQNB0k=;
        b=gHujxYpJsKYNvJNcZ05UyHp3wG6N9oysZV3mG+8qotCYzT04k+MbwOlakTtrRKJbgY
         iebcQj6h+FkQHmraAdcHeSqwZdP55ImOO6jpPUTMy9h+lspIzorseHQCAF99Hm+zonrB
         ETDVlp5OD5o6cxmK5I4CoAygQDgMAX9l7rdYvtHVcXCiyK0zhDMVvcTwTGelZf7/UP2d
         T1qUd19t3yyuuoxXJLo1yK32QNlG+acG6X4X4tSphbr2I9yChVGcG8agnHJVzghSaJcI
         fcpd1aCu7rIxtAonHtAh7pqeHQzY6qbZ2zKAa6AfPuRBG4YhCN3fUN+dAaBZZrFep+6k
         bkEw==
X-Gm-Message-State: ANhLgQ3Wl/0FQmCkirqYAPCO2kTi9kYxVtyb9sBgWtwsJZ9m3mHu7y4D
        wlYm80jRYEUK6Dy+XRK8xlY=
X-Google-Smtp-Source: ADFU+vsxJ/OjFy5JkjSacUfjpV9FUE3JNkijj7IBK0oDz5QHO52DdVAXkWTcM1oGmUpgb0A5Bptssw==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr10231998wmc.15.1584711312059;
        Fri, 20 Mar 2020 06:35:12 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id j39sm8892844wre.11.2020.03.20.06.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:35:11 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] arm64: tegra: Enable native timers on Jetson TX2
Date:   Fri, 20 Mar 2020 14:34:50 +0100
Message-Id: <20200320133452.3705040-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320133452.3705040-1-thierry.reding@gmail.com>
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Enable the native timers on Jetson TX2 to allow using the watchdog
functionality to recover from system hangs, for example.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
index da96de04d003..9aa17744c4a0 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -58,6 +58,10 @@ memory-controller@2c00000 {
 		status = "okay";
 	};
 
+	timer@3010000 {
+		status = "okay";
+	};
+
 	serial@3100000 {
 		status = "okay";
 	};
-- 
2.24.1

