Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49E1C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E01D20725
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB43zfc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEHBqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 21:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgEHBqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 21:46:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18047C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 18:46:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k19so6121pll.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 18:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LPVqop7eYhlKO1AOSFfnjZfL6zhGOb1jJx61piurnL8=;
        b=CB43zfc2JYiMsXGaSfTcH60amDf/MlsHLRAtdfJB6P3Q9cjb8wAwYz3Wxj+tzXlJgu
         Y9EJg471fUeOK+LCx7qu1DkbWDuqG4s8TMbTtJC/bMJrVB0PgIBLj4JWa7Khlgb5kE5M
         KZuRsnDmcE2eD1/3+8fXOnaK4Rnywz8jRQ0L6iUptOcl7WwPHUsodGf5kFOFGs1jT6Py
         qZEmC2hBoCYrGNj0XZ7738p3mkFAi4xA1epozT3LauHL8sFWCBZ0+TsYgk2nFZB1gAhd
         znKq3vheicxRnTbwT6rUHTrg3+9g2n2ab+vvL8dX2oPLXCzi4PspUcHp5SjkoUeeSUWe
         VIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LPVqop7eYhlKO1AOSFfnjZfL6zhGOb1jJx61piurnL8=;
        b=Q79aeXd1lQAq0rzryBef0EjXu6m6hcjFUgsii81KxQkcXvMZ74h8Re27q1B43YID/T
         2JLp8UxNqKwsSw8RYwhSre7dSHCVZtSB1B4KoJ11FMF/vHt73lTDEqNw5/lnqQ69pTW9
         NLuhmU0yyXRlp+LITQgIqtQxQuQjFutR03H/7ZMrgJ1A1wpvKwR0E32iM/90IR1GwI/6
         s5/6rOF5HF8s69JDNE3PfLwqoRS+DIOmanUIRXJZ0nO2hy7uIcAT3WvgKHjB2WCixbY+
         vCak3pkwF2ULE/BC2e/Qq0xnBEsya8vLqBQgKGTF9Cd5kh9H1Ss9wzI7jQ/4SBA1vaTA
         7whg==
X-Gm-Message-State: AGi0PubmcLNm4C7Lj5dJ+aUi0VPv196/bPWzkhOMjUYDvlm81dH4TbsS
        RD7bYffPqgiKO5sm1aATz+Q=
X-Google-Smtp-Source: APiQypKYtnjt5BuwWJAO7lMyWZ0afQw2+8ef6ewM9hR/2/Pg0xHZin/kH71U7koFCWmmamMtdbYD6w==
X-Received: by 2002:a17:90a:e596:: with SMTP id g22mr3235874pjz.201.1588902398711;
        Thu, 07 May 2020 18:46:38 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id f74sm9270816pje.3.2020.05.07.18.46.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 18:46:38 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v3 2/4] ARM: dts: stm32: Add pin map for I2C3 controller on stm32f4
Date:   Fri,  8 May 2020 09:46:26 +0800
Message-Id: <1588902388-4596-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588902388-4596-1-git-send-email-dillon.minfei@gmail.com>
References: <1588902388-4596-1-git-send-email-dillon.minfei@gmail.com>
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

