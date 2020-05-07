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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44433C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1282075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bqxfo24A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGHq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgEGHqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:46:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFB7C061A10
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 00:46:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d184so2617281pfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cweRr9cAyY6zAkbWBKWMpZ4+w4vWexg4Pp5+tOHzveM=;
        b=Bqxfo24AfFYXWhsN8GHnujLuoVkBpk+oLN5n/pKhY1B/kTAZsV4QlTI/+64OgJd7me
         /3GbM2TCKbKKs5H0kBqmM/lnyfr9O1RVWszihBOglb3thtIhJhcsvO0cuaevmIsigXdc
         AvG+O3NOWCh8NEyKHb9rrPLijMLpT2UVpR3OtJax9CXsSrfustfDX6lSjq7KY+lxg8aH
         cRYpX6Ay58EqICKpIAqzfQGh+rA6W3MSlwo/Gl8PisC8qnqo5nBQPZ6Vs295kRAD8EEu
         ru29YLo93QVo76QU8igeajEgubBaI0bCFrxP9vYIm1WQw+gIC21E0CRyu41/mtzKfcMM
         c0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cweRr9cAyY6zAkbWBKWMpZ4+w4vWexg4Pp5+tOHzveM=;
        b=QgHKpEQzLLAJOP7AJYKNN0KcYDidKuhSKVtdp+qRevx13FIzLOn0ElReAp85hQBl+J
         mGaU0+AOf5vtSnBtegWrlGLnFb0bWbYvUBmaTsivbaVEJooIklOvWpe4HF8rjylzi2jJ
         hyTvopMYhurXhd2kyEouuSlJBLBvLnYc7p3nyVzpEA2E+aniYewkAF6cUnUYyjGHgNo2
         Og8K7gMDHVOQgCcjt1WIHK0Da6MsrnvbkHlOjYyJfLj/ataTIteAb8Axo828ir3oqvkG
         j+rwsgFzBn18jIppR7R+XTIsnqG4i5GjP8arnmjMxH+VN+7U956dH+JI2DhzriO3RbUy
         lncQ==
X-Gm-Message-State: AGi0PuY7SmqbtvwS6cp4VebSFjEuTL3HtWIMXDJ7jkB5S7ToSPrm4r/Q
        gqLG4YxNdD2AaPmL5JBLOHY=
X-Google-Smtp-Source: APiQypI8VrY230e+hhO68sFDKpYBvjJ1jP2UrGvK+1FaFovSdhtxYdf0l+gaPRquhoaquZMZUdgkeQ==
X-Received: by 2002:aa7:9429:: with SMTP id y9mr13001101pfo.8.1588837613949;
        Thu, 07 May 2020 00:46:53 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id r26sm4127943pfq.75.2020.05.07.00.46.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 00:46:53 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 1/4] ARM: dts: stm32: add I2C3 support on STM32F429 SoC
Date:   Thu,  7 May 2020 15:46:43 +0800
Message-Id: <1588837603-14206-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588837603-14206-1-git-send-email-dillon.minfei@gmail.com>
References: <1588837603-14206-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch adds I2C3 instances of the STM32F429 SoC

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index d777069..257b843 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -402,6 +402,18 @@
 			status = "disabled";
 		};
 
+		i2c3: i2c@40005c00 {
+			compatible = "st,stm32f4-i2c";
+			reg = <0x40005c00 0x400>;
+			interrupts = <72>,
+				     <73>;
+			resets = <&rcc STM32F4_APB1_RESET(I2C3)>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(I2C3)>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		dac: dac@40007400 {
 			compatible = "st,stm32f4-dac-core";
 			reg = <0x40007400 0x400>;
-- 
2.7.4

