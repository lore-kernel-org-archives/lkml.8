Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1CEC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB682253D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONz7v0fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCIUoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:44:05 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46574 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgCIUoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:44:03 -0400
Received: by mail-yw1-f68.google.com with SMTP id x5so10671165ywb.13;
        Mon, 09 Mar 2020 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBcxGM+xg8655uWg7t9Ib3kXfSw3gEEMPIVTQzo5+Rs=;
        b=ONz7v0fqYeRn0zcALLN/4P4bMyGbz2MgW8lGOr49LjkuZn3h8ux5u7QEdc6oTCrBD3
         ElO28rEudO61WDEkso8azH2g5cl6RhOAaP4NWCagn3oFmT64R5liaBhvJVDnwEyvNr9a
         wkiwxEzinL4H9UyL+5iMKBnocsgMb+kzyvG7bNz8yqr+hnZOGJIZntpf/ojjp0d5UYxu
         Egp54pcC8qM4vtcS+PXF+6GTZxhDhgNqRf4sGzyrPUj6csTlcCjb/RvewzgzcHphbIJK
         s/KvWaFqWWlTrTml2e9M6yynxfnUpHC0M0VlvPBBKG0rAN+Y9H+srxi/U0MrTqW+wyiB
         DxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBcxGM+xg8655uWg7t9Ib3kXfSw3gEEMPIVTQzo5+Rs=;
        b=fF+PNW7icdRF04G1kuEuDMvjuzbJqoEdxRwHklWtf1IZXzLyead2Fua1R8eiGDEXqL
         38khAT3gXHVY7Yh4OcwnfkOfR5Vbx4O7iY98z//9ieTX/kmm7yu0vtJoMGxNGjwUN56G
         hbk9divYE5z5Yk9FcMXPZdwcW3HUkOq3aTj4TRJ94zz68Aa8wAmAh7YLtUtDVwBv5s9B
         IIUCiXRAIz3Yt2yWGZJfuedS/7iLN+EDtUhqWufY8qEG8T7qxEmNPv6mMq+4UY4bqvQX
         tkQizBfSu5oe7jSelFCsaFwbYvVuMVPXr2c+9Eqa6ui0kruPju1q0IfkbD2cAKssC4Q1
         8J7Q==
X-Gm-Message-State: ANhLgQ2pAIjMhve0iE4g6mb5ekZXf8vRxmQtCRp543u1E4X4UQrlmhgj
        uHXUFeYZEnVAnvH0IIaEqOcO54+Yuv2wVQ==
X-Google-Smtp-Source: ADFU+vsaIO/P07C7w1s7BaKD1YxR9Se0rUoQ5L/YtqXvN0v/OzPcI7nJd47/9gc9F+t/jMYjRbEApw==
X-Received: by 2002:a81:2f45:: with SMTP id v66mr8784924ywv.76.1583786640048;
        Mon, 09 Mar 2020 13:44:00 -0700 (PDT)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id s63sm17998768ywd.82.2020.03.09.13.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:43:59 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [RESEND PATCH 5/5] ARM: suniv: f1c100s: enable USB on Lichee Pi Nano
Date:   Mon,  9 Mar 2020 15:43:26 -0500
Message-Id: <20200309204326.27403-6-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200309204326.27403-1-thirtythreeforty@gmail.com>
References: <20200309204326.27403-1-thirtythreeforty@gmail.com>
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

