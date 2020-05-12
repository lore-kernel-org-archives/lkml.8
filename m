Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF60C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66FF218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjYwOS6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgELHEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 03:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgELHED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 03:04:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24988C061A0C;
        Tue, 12 May 2020 00:04:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s11so2249295pgv.13;
        Tue, 12 May 2020 00:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KnWhTxSokldqb010DnL4ORytzuGapXn7Hq520J7Za+c=;
        b=IjYwOS6yRJWzajwfxnyfRcGRgJufp90e2oizEGjmBih5am4Peqs//yI9PBpIboOzU2
         CZO7EDNpWbHzsF18edURJPTllwO9BZ79aBFYNtwcsZc6DFIZn8+alqC2s201mzhMJIkp
         3TcZmcgqnP3O5Sm7JeURdw7TyVUFJLRHTd4KqVs/bfP71TM6mTago+ifRJxbMabCZ5RU
         J7Rr93CevBl/XszLMpKAZXHFq488StrTbq+2a4M6QafQj1cDTCotx7X+cLzxoodu9eff
         fQnABVAI8DBaYWFsxbNkWlX8fqB/s7u68B+d7DEwdHDMFVEM8vQPZzyRaKh7wm1EUakk
         jn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KnWhTxSokldqb010DnL4ORytzuGapXn7Hq520J7Za+c=;
        b=je8aCzL+CCBQSNIexOGenqBB1uBvaEbWwkno08nXKn5SuvEAxHttZb2km3cya9BTYQ
         ZrTdY6V7MpogkM3FKj9u5mrm5YiW2ljBovA7AG+mt0kK39G/vyvSWuS3R8DMcwOzoBPR
         bPAxf4PaukQxAckyhWnGZUibRaNyzrQ50ECuFtCaTRxdQf1vO9hmYqhpbqGoUob8y2Y2
         WDv/v1fRjyaIVo9VOP80a70fxN2QTbJ2IGrDPPHnGkK7dRS7UomMQTT5zdxBYksBkbxV
         H5CV4qWUoGwfbBbAHz3DRTVoctsdWxFLWIC1ePiUL2kJvrO4/IcpCUVoTpeHVcMmdgiu
         SdvA==
X-Gm-Message-State: AGi0PuaCUXgRJGF9wmOpJ5t4w8l6b1gTpzWIpfYG+Mg6ZnzjvQZMXt2C
        V7HPM4DixVRcOIm7xaxN+6Y=
X-Google-Smtp-Source: APiQypJgzsQrvrMxxxS1gIKRvHu2KK37xvZy80d20Mc2DmCk4cb+KwcWxqzPiseDTD0DXbnIzfEGlQ==
X-Received: by 2002:a63:9801:: with SMTP id q1mr19050050pgd.447.1589267041774;
        Tue, 12 May 2020 00:04:01 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id 62sm11016369pfu.181.2020.05.12.00.03.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 00:04:01 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon.minfei@gmail.com
Subject: [PATCH v3 3/5] ARM: dts: stm32: enable ltdc binding with ili9341 on stm32429-disco board
Date:   Tue, 12 May 2020 15:03:35 +0800
Message-Id: <1589267017-17294-4-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
References: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Enable the ltdc & ili9341 on stm32429-disco board.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

Changes:

V3:
    change dts binding compatible to "st,sf-tc240t-9370-t"

V2:
    none

v1:
    none

arch/arm/boot/dts/stm32f429-disco.dts | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 30c0f67..4475e40 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -49,6 +49,8 @@
 #include "stm32f429.dtsi"
 #include "stm32f429-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "STMicroelectronics STM32F429i-DISCO board";
@@ -127,3 +129,40 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&ltdc {
+	status = "okay";
+	pinctrl-0 = <&ltdc_pins_f429_disco>;
+	pinctrl-names = "default";
+
+	port {
+		ltdc_out_rgb: endpoint {
+			remote-endpoint = <&panel_in_rgb>;
+		};
+	};
+};
+
+&spi5 {
+	status = "okay";
+	pinctrl-0 = <&spi5_pins>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpioc 2 GPIO_ACTIVE_LOW>;
+	dmas = <&dma2 3 2 0x400 0x0>,
+	       <&dma2 4 2 0x400 0x0>;
+	dma-names = "rx", "tx";
+	display: display@0{
+		/* Connect panel-ilitek-9341 to stm32 via ltdc*/
+		compatible = "st,sf-tc240t-9370-t";
+		reg = <0>;
+		spi-3wire;
+		spi-max-frequency = <10000000>;
+		dc-gpios = <&gpiod 13 0>;
+		port {
+			panel_in_rgb: endpoint {
+			remote-endpoint = <&ltdc_out_rgb>;
+			};
+		};
+	};
+};
-- 
2.7.4

