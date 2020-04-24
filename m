Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CC1C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B84F520704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfBwZ6Y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgDXSQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727031AbgDXSQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:16:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2639EC09B048;
        Fri, 24 Apr 2020 11:16:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k13so12052731wrw.7;
        Fri, 24 Apr 2020 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieWnO8DComqla3yHOcWNlGDT1t9CTFtocezocte3FwY=;
        b=JfBwZ6Y8cWCcahCa59GldWU93zzWnt8l14DjiUJIwHvNELNGgIXOEWkcg8GJtAg0KE
         3ggAZEdzrMcnAbE03Kj/AZdCVqfnUbo4lCQESa9FJGpIOW94m2oLd2yIyrm6k1hZIzcG
         k7lDOi/JcF8r4Eu4imA6Z6nciBGRXP8bqF0bcm2UNkMMMZqOTQY3XMu0Lc9t1+p1HTO4
         4WPNvvdUo4hE4CCqAJowHZtTuTtwV8KzL/03aYqGHozoUaqoO+NBRtcRvIYdb6ebgqig
         pJGUhv/oammk8nJpFd8f5zBcKqyXjKp/pK3dyrlFDxIt/b8JbvHi2Am66usvwyTBuOBe
         fD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieWnO8DComqla3yHOcWNlGDT1t9CTFtocezocte3FwY=;
        b=J7QxNJ4VdYGXF6mxyqjc0iLmWkv6LZFHGUqGJPgbuzUrYQ7vKkYTkiHv31OYw21udF
         ZQGbrVbjKfVBHHXbeUp4TG7Aaq5FJdDlNZKnD/TOGMQzh5xGA2md/wOVw8IaN6lcGPjA
         AUQe2B+ERhQ7VxPGaDiZq+gsUZxlGJFFJYRKoLYmqLMK1bwAQxIkuzqBZQf+ZFxcXkGh
         nd6LlXea0r859Hjzkq3dnzIlohgpMTKypNCFxa2SIPnc2zAoM2lZQ3i5FMcxRKiNWK8u
         RKHYP2lx4woNyz17pV6wo0ceMMv7PTJZyb3hzmH9aOOH78Gv+BtcXehxsX8EqfVm7XZM
         +g+w==
X-Gm-Message-State: AGi0PuYdkjVMkW6kIupIEr/hjae1nvsk4dSzmfMlp1S0RfA7t9m9Rqta
        yFR+XHB9pY734ZEcQsM/wew=
X-Google-Smtp-Source: APiQypIKSmT1g/OvWZvryuhk2ZfBiuMTXa6LcUv3vESta4ZnJL2cNrAoW7cKm4HTnxlFjfLG4W8Qsw==
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr12531518wrw.307.1587752203918;
        Fri, 24 Apr 2020 11:16:43 -0700 (PDT)
Received: from localhost.localdomain ([2a04:2413:8140:d480:18da:1e39:90cf:b88b])
        by smtp.gmail.com with ESMTPSA id c190sm3913426wme.4.2020.04.24.11.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 11:16:43 -0700 (PDT)
From:   Adrian Pop <pop.adrian61@gmail.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Adrian Pop <pop.adrian61@gmail.com>
Subject: [PATCH 1/2] arm: dt-bindings: mfd: stm32f-rcc: Add missing DSI clock
Date:   Fri, 24 Apr 2020 21:16:42 +0300
Message-Id: <20200424181642.32084-1-pop.adrian61@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing clock.

Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
---
 include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/mfd/stm32f7-rcc.h b/include/dt-bindings/mfd/stm32f7-rcc.h
index a90f3613c584..ba5cb7456ee4 100644
--- a/include/dt-bindings/mfd/stm32f7-rcc.h
+++ b/include/dt-bindings/mfd/stm32f7-rcc.h
@@ -107,6 +107,7 @@
 #define STM32F7_RCC_APB2_SAI1		22
 #define STM32F7_RCC_APB2_SAI2		23
 #define STM32F7_RCC_APB2_LTDC		26
+#define STM32F7_RCC_APB2_DSI		27
 
 #define STM32F7_APB2_RESET(bit)	(STM32F7_RCC_APB2_##bit + (0x24 * 8))
 #define STM32F7_APB2_CLOCK(bit)	(STM32F7_RCC_APB2_##bit + 0xA0)
-- 
2.26.2

