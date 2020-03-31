Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4E0C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98378208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4K56/bd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbgCaWTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:19:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50618 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731470AbgCaWTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:19:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id t128so4419522wma.0;
        Tue, 31 Mar 2020 15:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ie6jFqOSrTu+xf/V4MNbj7GzVLme0az5kv4/5mQNB0k=;
        b=I4K56/bdYJDQL4O8Br8bCQ0qsOB4qVBgwm94bxScn5X3XTnso5GJOb82s10Mx8TqAo
         Ykzrh/F2jW0/Z2J4RkR/8bEfZn+mXUkBy6qqmvcP23rywRlrzemujjDCI28exLt1AGYr
         L6ijpnqk4mTh+/QGF40tirFjQtnIrTotOSTK7IGXHClE3aN/7Z3em5p/FQ2rHMTwAwlG
         phc69DUXoIwwyxfoNZLQ5pLNlqqTAUmeQqxXbluJxSHyWObWp+9v4ZpYZ5rsWjGEG5rB
         OoNw1FcFj+mAm4ITsgwHkb01Hb/zZQO3/i1skVv9+ZAMfSvXJwauGZhwNkpC403ulyvI
         g2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ie6jFqOSrTu+xf/V4MNbj7GzVLme0az5kv4/5mQNB0k=;
        b=uJQ21/NdDGrDum8aEg/A5lNXuPxKMb64rOVNjObgwbve0VP3lG0F1vYR16+9wFnjCb
         0lk3cI4scNuOBT46Zr7J08cLnRvFb+R1J7tNQMIcD3lLaIceeXhLJuwJ2yJL9YlD1hwY
         bUStcten4VN5C8riVnXliL/hNlIOxBhkel9KBwiF03hWoYzzPNbWwDrj4XnHNwro2aWQ
         fyeAhs3uHk6Dhk4A3LDbu3NeOteTMTFhq1bAb3d8LAedsKGQMirqvAl0NyaBsjvo1JNw
         1wGmUjCV8BVDcOfzc3MKbL6YMW4R1MId6uclO+55al9diMKY8PkLJFoFZ+bVydaSsLEC
         K2Ow==
X-Gm-Message-State: AGi0Pubjo6WlTCHSUHsIyA0CWwTvDUKL2kgMkcPW9+2CxjzlXRKkY+6+
        aDj3uJRS2JAvFPfMiq4xh63mNFw0
X-Google-Smtp-Source: APiQypLyd0DN5RUQnXvW4cTlNLkxLqtOJOZVqvx5D+gjo8yiER2eIVzcECK1GVcfTHTNek0u6ahVtw==
X-Received: by 2002:a1c:9ac2:: with SMTP id c185mr1027032wme.45.1585693174588;
        Tue, 31 Mar 2020 15:19:34 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id u131sm2271wmg.41.2020.03.31.15.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:19:31 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] arm64: tegra: Enable native timers on Jetson TX2
Date:   Wed,  1 Apr 2020 00:19:12 +0200
Message-Id: <20200331221914.2966407-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331221914.2966407-1-thierry.reding@gmail.com>
References: <20200331221914.2966407-1-thierry.reding@gmail.com>
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

