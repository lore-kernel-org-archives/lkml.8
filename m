Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0395C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F0420848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdK3RuEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbgCaRCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:02:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39547 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731299AbgCaRCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:02:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id x11so22795246otp.6;
        Tue, 31 Mar 2020 10:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oRINeVDdGBQ2w1iXgS/Wa+Yp6Zm4cCc2abZS5s8f4+U=;
        b=GdK3RuEFe1kCVtxTEB3nUR4BaZAC7jbub22f/XQKpnwZgimjp4A14ZfOREwTk71+YN
         DpaGx+J1kSH9yISno7FLgILIZhxAOgbp696JerhPCT8GSdapWmq/jg4/DafD1xIcqGYO
         oltzrn1DBfkKgFs0XAYMAMpf+N820ALT+cHjCj0OBR2ytKw8fZLxDFIgWuQEbjaNB/42
         p7nCXsr9ztLiY1Pq6yHi9PsDvR/zLUN8eid9d2MLKyBQ9YQitNjNOkebDOO8sUNYrlZV
         x812bpkIVPJXGeGlVArghbc6Qb2lsVF1XSWdW4cC3QxMdaIl85CL18GAeqMg32ffT2Ms
         JYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRINeVDdGBQ2w1iXgS/Wa+Yp6Zm4cCc2abZS5s8f4+U=;
        b=I0XHbtHKRCKmxfeLC6M77Yz6QrMnqg2Pt0gviRDnT936o2MLazCqmaGVA3g9xR1Eu2
         mmSCkDXCnSX18onPyGWaTAmGl5zkzqu9/+SAe1GvfubESVV3ONP+T3p6zz8MUvmjKRdC
         xoBf7gs9KZCcpdzTRO4lFlzq6gv6y8ocWhfKC3LmWoNHRpJhOWGZY4EUodnU9/BNOOF+
         TxawJDwDeMrvh4IbShshA+9Hrgr795f1FYD5/2x20jKmP6INDmexnVVNtjvitNPGDCbP
         U5OPa5pE6Zc23qnCqSqxU7izPC5oZCjd6/2611+wMP9YRnawfP30PUUpOvxRaahjiuIX
         AZDA==
X-Gm-Message-State: ANhLgQ1LsMGuUc1wQ/uEW+vYPLa5mDwDZV6xFohqC89c0EU7ph2c6TU3
        mnQKIdBtU4V3xE3JUuJEZtw=
X-Google-Smtp-Source: ADFU+vvnjRPiOsFlZO3fi/+iOec9ItAWXtVwtErkpzk2PsVvTCz1N/VLm8I8EfB4EMH/R5/ax7ko4Q==
X-Received: by 2002:a05:6830:1495:: with SMTP id s21mr14453598otq.35.1585674152152;
        Tue, 31 Mar 2020 10:02:32 -0700 (PDT)
Received: from desertvoice.lan ([2601:3c7:8303:2a10::21c])
        by smtp.gmail.com with ESMTPSA id h7sm2952605otk.3.2020.03.31.10.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:02:31 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v2 4/5] ARM: suniv: add USB-related device nodes
Date:   Tue, 31 Mar 2020 12:02:18 -0500
Message-Id: <20200331170219.267732-5-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331170219.267732-1-thirtythreeforty@gmail.com>
References: <20200331170219.267732-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

The suniv SoC has a USB OTG controller and a USB PHY like other
Allwinner SoCs.

Add their device tree node.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index 6100d3b75f61..ec9f248ba889 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -4,6 +4,9 @@
  * Copyright 2018 Mesih Kilinc <mesihkilinc@gmail.com>
  */
 
+#include <dt-bindings/clock/suniv-ccu-f1c100s.h>
+#include <dt-bindings/reset/suniv-ccu-f1c100s.h>
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -140,5 +143,31 @@ uart2: serial@1c25800 {
 			resets = <&ccu 26>;
 			status = "disabled";
 		};
+
+		usb_otg: usb@1c13000 {
+			compatible = "allwinner,suniv-f1c100s-musb";
+			reg = <0x01c13000 0x0400>;
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
+			interrupts = <26>;
+			interrupt-names = "mc";
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			extcon = <&usbphy 0>;
+			allwinner,sram = <&otg_sram 1>;
+			status = "disabled";
+		};
+
+		usbphy: phy@1c13400 {
+			compatible = "allwinner,suniv-f1c100s-usb-phy";
+			reg = <0x01c13400 0x10>;
+			reg-names = "phy_ctrl";
+			clocks = <&ccu CLK_USB_PHY0>;
+			clock-names = "usb0_phy";
+			resets = <&ccu RST_USB_PHY0>;
+			reset-names = "usb0_reset";
+			#phy-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.26.0

