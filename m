Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282A7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 06:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F398E20781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 06:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rba+27wR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHLGcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 02:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgHLGbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 02:31:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E737FC061788;
        Tue, 11 Aug 2020 23:31:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id y3so938735wrl.4;
        Tue, 11 Aug 2020 23:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jdrjiMl6HlVMNdowOw0FJddK+UgJa1twYmTXGeWOXM=;
        b=Rba+27wR4qqAcTaBSsVwMvV6OVR0dP3X9zUvKOikHBM9KQ+FX9sbOuPSw+CflW/ImJ
         +ht8db8WI1eraeoNslDBGzTpvFZmUOvqKtnxgixGGjoBGm5fUS711j59yrYT5OIPHhOu
         nRWwrcETPEWH+YViUTA4Vw/4lyhrLIH53ThvrF4P5crJP5Ylwottbblk0bi87DgLHr3z
         b6sBTw0wpfzMXhBsJoiGH2/CcdyS/oxfVFp7LBSCazyeJdj8ygNKlvGGdsKXZ/mbEPDj
         3j2QOQjNOa20ikGnibnjGwlCcQtqgkly+g1+6RdEWDswMXku/Z3ETuXLxiFJvtEc+Cuf
         f7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jdrjiMl6HlVMNdowOw0FJddK+UgJa1twYmTXGeWOXM=;
        b=XJxO6yw2kIV1RQy3VBJRhMY40HPCRV5cRoeREvYQi+7SKXP5LFteVR47s0FAemRnsg
         VyPNNGzZqaK43Pkh9Qip3+kdrjq5pMcp6Zuj3Pq2tKbIDRzFK8L3TKWPmPJO+0g2MzkS
         mWbGMJHyKObdJmDhMmFjnLfyM7r560wT0Vo7Dg2IcVOpKq8vKPb37kKHKTmjaiF7uYvb
         zA5rdxVTx0NjkWMR/9sfGq3mlki73gO/WEwa6IEwxozI7PTchIsynPl0fpSk5Byhiqge
         hR4vtaffcUN2ng+egY66YgMNM+6OSOrYJRfCewCIDf3dlhV1LTHyhvTPrWRCab5TEV5n
         E3Hw==
X-Gm-Message-State: AOAM530HZNzRwZ2ZfzJ6+D/VfgsMSuncgfAznpIoWmjWk/0B4+dd3XT5
        MjfRNPk8yALtBP3W+zTyIYE=
X-Google-Smtp-Source: ABdhPJxb4aAjBWn4paWRamXmKb+t57wH0XJwjuL10FtEA2AzRrvFn/QgK4yANgeSo0+nT61+muTZnA==
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr34411553wra.150.1597213903565;
        Tue, 11 Aug 2020 23:31:43 -0700 (PDT)
Received: from skynet.lan (88.red-83-49-60.dynamicip.rima-tde.net. [83.49.60.88])
        by smtp.gmail.com with ESMTPSA id m16sm2149945wrr.71.2020.08.11.23.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 23:31:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     f.fainelli@gmail.com, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 10/14] mips: bmips: bcm6328: include and use dt-bindings
Date:   Wed, 12 Aug 2020 08:31:25 +0200
Message-Id: <20200812063129.361862-11-noltari@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812063129.361862-1-noltari@gmail.com>
References: <20200812063129.361862-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there are proper device tree bindings we can start using them.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm6328.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm6328.dtsi b/arch/mips/boot/dts/brcm/bcm6328.dtsi
index af860d06def6..1f84f6b05f88 100644
--- a/arch/mips/boot/dts/brcm/bcm6328.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6328.dtsi
@@ -1,4 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include "dt-bindings/clock/bcm6328-clock.h"
+#include "dt-bindings/interrupt-controller/bcm6328-interrupt-controller.h"
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -73,7 +77,7 @@ uart0: serial@10000100 {
 			compatible = "brcm,bcm6345-uart";
 			reg = <0x10000100 0x18>;
 			interrupt-parent = <&periph_intc>;
-			interrupts = <28>;
+			interrupts = <BCM6328_IRQ_UART0>;
 			clocks = <&periph_clk>;
 			clock-names = "refclk";
 			status = "disabled";
@@ -83,7 +87,7 @@ uart1: serial@10000120 {
 			compatible = "brcm,bcm6345-uart";
 			reg = <0x10000120 0x18>;
 			interrupt-parent = <&periph_intc>;
-			interrupts = <39>;
+			interrupts = <BCM6328_IRQ_UART1>;
 			clocks = <&periph_clk>;
 			clock-names = "refclk";
 			status = "disabled";
@@ -115,7 +119,7 @@ ehci: usb@10002500 {
 			reg = <0x10002500 0x100>;
 			big-endian;
 			interrupt-parent = <&periph_intc>;
-			interrupts = <42>;
+			interrupts = <BCM6328_IRQ_EHCI>;
 			status = "disabled";
 		};
 
@@ -125,7 +129,7 @@ ohci: usb@10002600 {
 			big-endian;
 			no-big-frame-no;
 			interrupt-parent = <&periph_intc>;
-			interrupts = <41>;
+			interrupts = <BCM6328_IRQ_OHCI>;
 			status = "disabled";
 		};
 	};
-- 
2.28.0

