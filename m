Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B44C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BD792075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR5Zu3h0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgEGHrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgEGHrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:47:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4158C061A10
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 00:47:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w65so2599700pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 00:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LPVqop7eYhlKO1AOSFfnjZfL6zhGOb1jJx61piurnL8=;
        b=AR5Zu3h0zYcp2CjYSCzPv5BOBji1VqKwGPKlVLR0QF5Uo3TGwx7XJKWyLDyI+su6CY
         WEcR6iVRdAJGvmCgEY6pKJ0Cm2D5yWjW4ZfyIILIu5rBLKHNaeCZ+DRzxu3SRQzF/Yvc
         L8umyfpq2yFYf7Lm2HACE/KCjlW+4Ecg24dueY4O74JKLhJU/x+51Q8JVyg/QOiDbgcd
         I5ChzDJ4tg1lm6D6yTvW9vLUJSLCLYy3rh5ZaMhCcr35nRL/HfOsYF9+8hG8JotvzWoF
         kiK/LwSbnYfA5bY+jk8irL/cDe82nl9Y8WxllKjEzJcJHgeu0sYQCrIuO0aFyWYpdHAI
         R5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LPVqop7eYhlKO1AOSFfnjZfL6zhGOb1jJx61piurnL8=;
        b=Dl6sXiH901FLkzR5/ja4wfag4uPlN8G7sC+j9IDbC2ua7DrWVGZSK7Mo1Wyk5g9+Eo
         Z8jtdDWjUFSuC+YwbctgrWOA5vz7/f3LU8e95qw1zg4wGUf6x2NZ15WVzkUN6dLElEym
         YO9XSFUyCrUBcJXoqe9bTPy6mpeKEpN+STLYyAvczARR3DTBE4OeYjhg1Vo1og5LhWhR
         p7x7uONGJUipx5PUjyrKmpIONWpIqr49wUvkHTs71Q4sf9dojBvSPTVQm6ft4akWH62y
         XQvlqOnFjTF4lqcK7U3D1T7H1OdVve0IpIg3WABj9tAsmqfrr8HiBIbVg5jAa+MFB+d/
         kI3w==
X-Gm-Message-State: AGi0PuYUrIjq/OxIwdgEsWbY6bec5ul1dSII4FMsFQ+s9tvsWwORju7A
        RlqdLuGhlirRz2IujZz9/MSvHuB4NjQ=
X-Google-Smtp-Source: APiQypJSPQuY+csp6bCCGwKD3ZC1sC7/TB05ndt59XXU0LqPCVDPgfV81xHWnSNnl5MlKhMSWxCOMQ==
X-Received: by 2002:a63:6cf:: with SMTP id 198mr3353646pgg.59.1588837639579;
        Thu, 07 May 2020 00:47:19 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id x12sm4011292pfo.62.2020.05.07.00.47.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 00:47:19 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 2/4] ARM: dts: stm32: Add pin map for I2C3 controller on stm32f4
Date:   Thu,  7 May 2020 15:47:15 +0800
Message-Id: <1588837635-14267-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch adds the pin configuration for I2C3 controller on
stm32f4.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index 392fa14..051f336 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -316,6 +316,18 @@
 				};
 			};
 
+			i2c3_pins: i2c3-0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 9, AF4)>,
+						/* I2C3_SDA */
+						 <STM32_PINMUX('A', 8, AF4)>;
+						/* I2C3_SCL */
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <3>;
+				};
+			};
+
 			dcmi_pins: dcmi-0 {
 				pins {
 					pinmux = <STM32_PINMUX('A', 4, AF13)>, /* DCMI_HSYNC */
-- 
2.7.4

