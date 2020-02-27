Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE86C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169D3246B2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZxfOfa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgB0SPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:15:03 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43260 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbgB0SPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:15:01 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so37380oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBcxGM+xg8655uWg7t9Ib3kXfSw3gEEMPIVTQzo5+Rs=;
        b=FZxfOfa8j3Z9LaKOlTYM37oQt9g55oDEG9tJeX1T3cIG/BQ+Zai1Z+a4KOa5hRH4Dr
         HdaSyi9uuGcxwWqGtVwRUx2XDHRaa1u5l6rBMaNXKLnkRw4Oie+5vABlAoa3VZuB76+6
         PulKv7ZGYEE39prNYxv0GCS0Shl/cJ2364pkodVx7TgIIPyYjfPXPYlI8yUuq4kUnjWg
         xAbJ59IexhQrKqe3VbDXxpoKZdHkcmdQ3sO/vgFPCLbnPM070PbaFhLC6Smcfdan+kJD
         BHIF2BSDWFOuUsWzq2cSxWaIv5769Ywx/H8IWmrxc8BXJCcPPf1/usyhj8hEFw1WC8UR
         dFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBcxGM+xg8655uWg7t9Ib3kXfSw3gEEMPIVTQzo5+Rs=;
        b=cmsoupK6UapZIBOHxNJqTjVA/PH3r/M4Lz+vPbYaBi1D3bxvQHsE6J7RzC8yE32KFj
         4b2p/gc1g47MzgHPUYBbxQDIlTyzUkMZzgTAoIH3Ok8FYOEFe0F/0eXD0G8xug+C8rYA
         rw9U2+yW4o8XRBuQGcbbaSOWN+4UNAVjId2V4F0MZxaI0W4L3XEcJSqP0f9rbVz/51Su
         HMicIviUuzlYVrZPm92FvbCVkdsKlziByoM8BYrtBEt9Us6oeiDotSv+oRGFL/Y/UPB+
         Ba0UfuVGA9ZJazqMq6GXG/Qru+JQVhQErjOWXmnryr9QHnKDln5NMVst5y9ODkKrhqJG
         Cj/Q==
X-Gm-Message-State: APjAAAUq0HqpirTHFZWudKquEc5PgLWHvwg0ndL5xOz88bz5+60WkbTz
        Hy0L0J2iNO5p2bsyEhi9vdt5bx+cOMoycg==
X-Google-Smtp-Source: APXvYqyduQK4JBSqSoXg9hATT4oVsXan1YS6W2a4NowiE2fyS+8Af5itf6y4TrPeAMivxVA+3WNBGQ==
X-Received: by 2002:a05:6830:1e2d:: with SMTP id t13mr176250otr.128.1582827300893;
        Thu, 27 Feb 2020 10:15:00 -0800 (PST)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id t203sm2205534oig.39.2020.02.27.10.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:15:00 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH 5/5] ARM: suniv: f1c100s: enable USB on Lichee Pi Nano
Date:   Thu, 27 Feb 2020 12:14:52 -0600
Message-Id: <20200227181452.31558-6-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227181452.31558-1-thirtythreeforty@gmail.com>
References: <20200227181452.31558-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Lichee Pi Nano has a Micro-USB connector, with its D+, D- pins connected
to the USB pins of the SoC and ID pin connected to PE2 GPIO.

Enable the USB functionality.

This patch depends on the previous change to the F1C100s device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 .../arm/boot/dts/suniv-f1c100s-licheepi-nano.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
index a1154e6c7cb5..c42186e22d45 100644
--- a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
+++ b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
@@ -6,6 +6,8 @@
 /dts-v1/;
 #include "suniv-f1c100s.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Lichee Pi Nano";
 	compatible = "licheepi,licheepi-nano", "allwinner,suniv-f1c100s";
@@ -19,8 +21,22 @@ chosen {
 	};
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pe_pins>;
 	status = "okay";
 };
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpio = <&pio 4 2 GPIO_ACTIVE_HIGH>; /* PE2 */
+	status = "okay";
+};
-- 
2.25.0

