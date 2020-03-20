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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A99C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFE42076E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg61IfGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgCTNf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:35:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40410 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbgCTNfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:35:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so596049wmf.5;
        Fri, 20 Mar 2020 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fhOtbK0ZVL1ABebYKJYf0UxxzluO0JY5MJfCTLBiR34=;
        b=eg61IfGRG4RM8ATBwaJ4ZflHXV9nWhy7dN7OcN/Yia3AMeGSxeqQE8Ur1H1QiQSptW
         NzD7kEzRRXWhsycMK5RUD9ok0rOe7fTyZFhemfq1mYc4+00cpHoLEGkZ05f5zBchT1lm
         bRE+lS9yG87M4n6QpGK/aVcIfldB0NXrLEYyuNS1xW4Ie8v70Yh4v8BQwcTMZi8pKFla
         bDddRe0XGUNzhI9bFTpXPzpYnnqV5Hak0lM383qta3X10KbU8wCsPX5nQ5U54nVIKM5y
         pNUXz5Ex3pS4d5eWwxuZqyJX+E3JAwlFnzd8yidtsGVuvsmMwF1m8DDtCMa/qaNMgO7M
         Dwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fhOtbK0ZVL1ABebYKJYf0UxxzluO0JY5MJfCTLBiR34=;
        b=Jg3rnTZ2gQ3tc+nvd1Ss+8o7Nply/b1fJG9RKzYJQ3Ufn0Nia28xx7/bG2bybfC4QI
         rLPuLjxQo1D5/IUuJu8d7yabRl6zyf8UFbbmkjDPcTjQcXVbj1cbwVUrlEAanwgFEeFa
         uKZ72cCfpJDDLLoXFETcOeex76IHxS9RhXmFWG2jS+rTcA9hIgBH/8Zu8odLPZlHYeMB
         4SitFA2MW7yIsVga+7JZYN1RIYAAQx9NpOj+zfEM8Xx/rS2FiUshu6eL5BI0MIVTOoKr
         kAHzL+1pxoJ/UwEwS34pO76sHB4tr8XScM21SxuClH52iWGC2SescQ7nXFUTLMZ1uPN4
         h1JA==
X-Gm-Message-State: ANhLgQ1nJIc0BLBi1OSKJl4Cih37OPWt8cMH+Oz1J30vGzq/bZi2JBo8
        fXr5Af5Zxul8ENEFY0yYdqQ=
X-Google-Smtp-Source: ADFU+vuLxcyO2KD5jaTVUfpSqHOfct7nsy9xBH35W2ZSyqKfS427VdekhuvEWxvY0ML9TdMPqddS6A==
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr10159562wmd.1.1584711316042;
        Fri, 20 Mar 2020 06:35:16 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id v21sm3105535wmj.8.2020.03.20.06.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:35:14 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] arm64: tegra: Enable native timers on Jetson AGX Xavier
Date:   Fri, 20 Mar 2020 14:34:52 +0100
Message-Id: <20200320133452.3705040-8-thierry.reding@gmail.com>
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

Enable the native timers on Jetson AGX Xavier to allow using the
watchdog functionality to recover from system hangs, for example.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 623f7d7d216b..d68588f2709e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -52,6 +52,10 @@ memory-controller@2c00000 {
 			status = "okay";
 		};
 
+		timer@3010000 {
+			status = "okay";
+		};
+
 		serial@3110000 {
 			status = "okay";
 		};
-- 
2.24.1

