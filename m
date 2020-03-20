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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE39C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A6320781
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDDOZzd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgCTNfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:35:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34110 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbgCTNfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:35:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id 26so3049726wmk.1;
        Fri, 20 Mar 2020 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WS2drkVzUywPkUAraDwxibChKAzL4Ioj5dgxbparViM=;
        b=XDDOZzd5oKgpObDjVSEymgFC00jnB6CJGgwYRpLe2YS56tTaQuoAwzkFzt2ONA3MAh
         oScRa2rjuEALTd3sH8oQ0p0FYExZ0MS/yjTjQgoR7sfcRbWo/luQwsR9vu8O1cI9rgq7
         xdD8+oNHLyo3ziH20YvKtD4/wPNTF91ywgEutQ/og6+syfumauw0xTDTmjf7j7I2A3Fa
         /sJ8pVDYUJSbLqp2nGfmeVYSJs8f5uU9n3Sjojy1EqznPwhjMgVTXVg5rGDgcBk+NUq5
         rMZihxPy7DYyM7HdGztCmqSbYuhZd7o1yGX/BcHyoyDGWzNx8AQXUBv5uQR8rnkHSLtd
         yVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WS2drkVzUywPkUAraDwxibChKAzL4Ioj5dgxbparViM=;
        b=G9uadDJhB5o3KA1gpH+v14UDjHQSZ1UU4cgd5V2qs/5w7UD/YddT/og5Ya1IwpTDN9
         dttdyVDsPZi8ufjY4GpWy3sqLpIZ9Aj1mwnrwcvqvhJOoQVa18REtrlVX+/mb8UD6ozm
         hADYQjsev8VJFJnUMKu3FhmtNNw990aO6EDIEJ0ZOt2rvlOfqkoqhKhIAdn6udbe5ia+
         G3/iGaHLDRqVwXb2xdXuS694ZXyuGjRhKKVJqLnL1wUZuIfxyHkP+Ox3GxkAIDhhnLLu
         DOLMbUlYjLl3qVl7v7pTmT/e/9kHHoJCpLvg6sIVvAOR7L2BER6ebA5+kPhxGA+VUdQi
         1cpw==
X-Gm-Message-State: ANhLgQ1WqKtUGqpIuSQgwLL9lbnD6YJTNN5k62Ylr37p7dyqzZQiFERg
        pqUqcVeOm1iyWxcOPou3ZXU=
X-Google-Smtp-Source: ADFU+vu4Jujmu4QzXEDeYZvm3w3yoKNfvuqOg7RHd7k31B8z5CPlT0KxTW1WbrEw48Wc6JUGdoAGGA==
X-Received: by 2002:a7b:c94b:: with SMTP id i11mr1744214wml.113.1584711313846;
        Fri, 20 Mar 2020 06:35:13 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id f15sm8409789wru.83.2020.03.20.06.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:35:13 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] arm64: tegra: Add native timer support on Tegra194
Date:   Fri, 20 Mar 2020 14:34:51 +0100
Message-Id: <20200320133452.3705040-7-thierry.reding@gmail.com>
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

The native timers IP block found on NVIDIA Tegra SoCs implements a
watchdog timer that can be used to recover from system hangs. Add the
device tree node on Tegra194.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 019f66f03a97..a0a5b44ff9bb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -213,6 +213,23 @@ emc: external-memory-controller@2c60000 {
 			};
 		};
 
+		timer@3010000 {
+			compatible = "nvidia,tegra194-timer",
+				     "nvidia,tegra186-timer";
+			reg = <0x03010000 0x000e0000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		uarta: serial@3100000 {
 			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
 			reg = <0x03100000 0x40>;
-- 
2.24.1

