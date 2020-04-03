Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA6CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4CB2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9pFk0M6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgDCUWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:22:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35178 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgDCUW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:22:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id i19so9133741wmb.0;
        Fri, 03 Apr 2020 13:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ie6jFqOSrTu+xf/V4MNbj7GzVLme0az5kv4/5mQNB0k=;
        b=E9pFk0M60FMxmXq0jC2JbvyM3NnJkoT4O/tYp8hJMLeeVtcX9ZZ+URGVGxtv93oZjs
         CQUBPv40PISGgkI7Jz7m3Wg3kbpVoTJxz0ZQ0FOF2EGx9oHhtSysK2zjSbkrt7ICXxUf
         z9TmIjkXgk/y3zBddDyydf03QLfoP6opcxl0wuiG9PD71h0uMDK40t32nwvHsAeKZtwQ
         940eefC9IocgZwAp1Hge6bSpWY/K8xcFszS4mTZuSqcZr0sz7bwQzpBvCeKGqWHbkXcI
         P5ryXtYcJPJBFLDCMu4my9NXikOfCLWj6dSn/kLF/cwnZQQET6lzxPgFwDYovK8pkUzi
         ZMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ie6jFqOSrTu+xf/V4MNbj7GzVLme0az5kv4/5mQNB0k=;
        b=YwkayA8cYhQaPYKm14f/NW281rSOvDSzARTWakDluAk0qAXMLvC1xj0d91FZGoNlIh
         hkFzelFHrUdn7IUhD0Yf7nUthb78VmBdbC7m2nlU7LBrb0m6cH4GpijHHf5MxRzLOWn/
         8pZZHnPODyhEvCUYjcSVTny5rRmpOFKRP0ICuhX3c9Teg63arj+BEFRmdQt/sC3dc3wT
         /zVJBG1uijDYfrX2W1TZfR43Yo7/pa/Pp+f/xjD4O7oUqlCR+uoa5HuOnniDy+3nUmEz
         NzMWbpEnYWG8PotCIgfycN1+VloK0NVoSkcOO8g81sjfvX6PkN5pE9wcplgg4Iu1ldCl
         tBmw==
X-Gm-Message-State: AGi0PuZ40MGmLcLDIKSMJDm3pTru6URsHn0LLV9RmepqNpsO72jX5/Le
        VWyD8Y3da8bwk8nlfomsR34=
X-Google-Smtp-Source: APiQypJK3zLGT47/3do2eHeIDloqjzmPGIsDYIKPT4ovLYkP7JxPwlI/CajThmFE5FBlH4geNSo3UQ==
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr9796857wmf.166.1585945345935;
        Fri, 03 Apr 2020 13:22:25 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id j11sm12724139wmi.33.2020.04.03.13.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:22:25 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] arm64: tegra: Enable native timers on Jetson TX2
Date:   Fri,  3 Apr 2020 22:22:07 +0200
Message-Id: <20200403202209.299823-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403202209.299823-1-thierry.reding@gmail.com>
References: <20200403202209.299823-1-thierry.reding@gmail.com>
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

