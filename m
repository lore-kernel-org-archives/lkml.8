Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8F9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EF220760
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrrLRE8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgGBRZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgGBRZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:25:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55829C08C5C1;
        Thu,  2 Jul 2020 10:25:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dp18so30693227ejc.8;
        Thu, 02 Jul 2020 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnTRoWjTfYr2A0Uu+ecfb7UTjmUGA+TKhWtn9pkCD0I=;
        b=MrrLRE8T6J2vS9TQARvXwu8USGzuPxgmYm6BHRL88aSYWsp3/l4n6dmpJvUr0iagtS
         eFsSyzjvWmZt7fgTlOsHnBEWVciouvhP8n4iPEo9N6bPJ5ajUdKIz7gTXUfHeqTrG1iT
         QmiJ1bSxWZHNQxL5T2kf4oWF+kWadTdaAkTQmBCKUpdSCS7IBVMNoBe5XTOgjQisemaS
         IE+o+wVwfVuf5/+BljBz1U7dGInj9bsIDlhHgSB3QJroDQNGjUOByJ/OBvw2a0ubKTZn
         8c7+LXrloX9CIcVuRx2Ozx/yqVS8WWtva1A1SpxCl3B586MkWlsXTPOqi4UsMZ+yjLEC
         CL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnTRoWjTfYr2A0Uu+ecfb7UTjmUGA+TKhWtn9pkCD0I=;
        b=nkcSW4O5XJsRcQV08qu3U1pVqmAXdITtipWeok+V4uU+18hxeyH7k3/vUchTsqpBMf
         Ur1e6LanA2Tvo+EpzOhx3aH9Qiq70XKq5beon0gRYXLSRIsccktn/67ejdl8UhP7nX6a
         Onq+nstbMs6ST3OegnUxln2oG7mSCv5O5C/asZuHCadt8jRssZ+yqKEy2JqtJhFrbX0y
         oWQ1EApHlqiRWZpVaCCsFhiAfnm0JGMqprfr6KsDoQaVo38kOu4+obzgOm/Dc2pHUCn7
         4wf0ocg8Sf9ub04o3QLUw+a6XjiwitAl9ZzrHpEq07KB0avZjgN8OEeiM9LjjhDzsmdm
         3brw==
X-Gm-Message-State: AOAM532A+nHYOyI96JRr+3DtoNMjb4yvP9uhbpz2Lk/p1vrB8BjMZbuJ
        TSv/lTVvN4HgBQyiadFGMVhb1BNhLLQ=
X-Google-Smtp-Source: ABdhPJwiP2P0UIlaSVwrUUaua3N8zGJ8j3nQZeobo/IS6TbPfAs6R7ZnqLBuwhXOUApwiNHibGuQ+w==
X-Received: by 2002:a17:907:20c4:: with SMTP id qq4mr27836954ejb.85.1593710745093;
        Thu, 02 Jul 2020 10:25:45 -0700 (PDT)
Received: from localhost.localdomain ([2a04:2413:8140:6d80:2142:c138:da0:5086])
        by smtp.gmail.com with ESMTPSA id p4sm7427033eji.123.2020.07.02.10.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 10:25:44 -0700 (PDT)
From:   Adrian Pop <pop.adrian61@gmail.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adrian Pop <pop.adrian61@gmail.com>
Subject: [PATCH v2 1/2] ARM: dt-bindings: stm32: Add missing DSI clock.
Date:   Thu,  2 Jul 2020 20:27:13 +0300
Message-Id: <20200702172714.158786-1-pop.adrian61@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.27.0

