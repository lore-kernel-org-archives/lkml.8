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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D76FC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 763BB21582
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRS3YV17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgEGLPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgEGLPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:15:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7103AC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 04:15:18 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d184so2863212pfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 04:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LPVqop7eYhlKO1AOSFfnjZfL6zhGOb1jJx61piurnL8=;
        b=tRS3YV17LbENu+VpnAc6CsLvuTRwOuDXc5iJ+rNe7z1ZO6/Sggfny1+zIo8dgIBpZl
         kg+jH7StyEUzti01YgpBJvS50xXVsSZk3qBOmgrdfdK/6mJRSYp9xCTa9h8RTdgk+zNR
         MOGHWMYooC5XgYl2CVraN6sJlD4oyzkNOJ9qfqDgN0PBukAP0vj1efJfVDp/2rElpjnz
         aPHvuRIN45z334PdXh+xEyNJR9cLcN0kv8bjI7cdDr+f9JnUN6DCrIgnToM8gTA9sXTt
         duS1BlGzDgKWYzGKSaOp1DKNfzojLz4Dnecot1rd0U6jMcjqBnEEmoQLRuAtBF4kGyVD
         YFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LPVqop7eYhlKO1AOSFfnjZfL6zhGOb1jJx61piurnL8=;
        b=W6gOGDuo88EtcADVnrPBOfLM7GBQgSDzK6Y2t4HIpbc9p73l+F7VmxLDFXI7N7gy+b
         QdYUncZ/EZR9p99LM624DqjbqGc+68Jnk17RFGR1QoqM5aYrM4vsbgb0tNiv9UIlhYZP
         hUOeSf++afTgIAZpWWGhictsax3yQZ/JIvQgi8Y/dmS42SZqPuAF0q3qlTgBxWBmp9hw
         eolnaMC3o0V3PWGjnh7DfJYTH9Jf+j79YB0L3tZwDT0O5aeE552nZquO6Xgtt1HQSa54
         Rfg/yJRw64SQbfIkPMjDJKBWLQ+owCarSXzDlgxmk5BDwiRLzvVwysW5uMhbZm/NU8vZ
         SAmw==
X-Gm-Message-State: AGi0PuZuFf3pRmH3WwzRF85x7ckB3hXtVuxeCiB5Kqjcbry2Js7XIYN5
        XOu+KZQtF5gk7CG0hcCxhd4=
X-Google-Smtp-Source: APiQypIPageHHo5o6CT94w6iXvoqpKWIPl0+2Om0RAPGaNvLr57cPx3lh7dN6T0Lq0Wney2FP8ukbg==
X-Received: by 2002:a62:7555:: with SMTP id q82mr13021927pfc.136.1588850117599;
        Thu, 07 May 2020 04:15:17 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id t74sm4729687pfc.64.2020.05.07.04.15.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 04:15:17 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH V2 2/4] ARM: dts: stm32: Add pin map for I2C3 controller on stm32f4
Date:   Thu,  7 May 2020 19:15:12 +0800
Message-Id: <1588850112-24297-1-git-send-email-dillon.minfei@gmail.com>
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

