Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA933C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 16:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24692065D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 16:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hr0dQiEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgHIQpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgHIQpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 12:45:07 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC3C061756;
        Sun,  9 Aug 2020 09:45:06 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o23so7079930ejr.1;
        Sun, 09 Aug 2020 09:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H88mI1Spa78eFKDo3i2s+xvsEIQcDrNyhC7EnGO216s=;
        b=Hr0dQiEvmVUgZL4L7p3nMX+qobFHt8gj89ULFPGVZBMlbTvDqQoekVTvPkT3Xjt3qC
         i90nWPF1lXAgQYQj6tyG9Z1+w+lSSr4RX1ONQnwwjzA+ekkUV52soxdGtV/WMfAYm+pi
         9XLV19lkFE9afUEKo1v2USo33E0HmcqzUUi4kC1Z7aR5zhHif2LgW0b+Ta5wdsXDeIfm
         4hOs+OHHQCWcMwdMBSkgJz3EdhZQBkIU5XbeQWd2b8rP9bzjjHEHi3thg7AmUMM/n/Ta
         dkTv62qRz8Kg7g0YT7hYsC+FXC7MVA6Sq2e6ZnZGIGombeLROPt+fREX5qu0Al6pUsxB
         InbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H88mI1Spa78eFKDo3i2s+xvsEIQcDrNyhC7EnGO216s=;
        b=iJdRV6Wcnb6UXQ/1k8yIL0V1zhPHUtvlvVfwaTNZbcotVDSH1ALHFvl2avP9tUYKqi
         D6E53Q1LI5bHeofAavTN/kKqqY8cQbW51V1EC6T5XpH+lhTWWvLoor7ogYBF49lVEFgX
         UamO6eg5Wu/QqReU446V6/Idoj57qkwyQqdMfTDC+z1Yf8wNiVUXrc0QBOdmeEL+EQmM
         ouezLr6m6GANMF1cOGIwYcj+9LVJnUalz61VFslZuXK6KqDJG/px5rF1ITJVJPIotOaH
         K7aytwH18DTlKbSYH9+XW1pSIqiYZ+staCPgYG3MGUGKcR8SE5RVgQ5Wfv7UkhpRIjv+
         WQaA==
X-Gm-Message-State: AOAM531GRWVUvbPabSt3pbLJdinYaTM86ybXIuAAdFBFuA5VKH9WNLW9
        BAMacY0Yh7Y7J1HDjsBgEYw=
X-Google-Smtp-Source: ABdhPJx1xkw0A5gHdxlA02kBB2qFvGFR9pJGK1Jm97xiVxTUdwHuTfRjdK72XmyZs0hdwh/EY50NFg==
X-Received: by 2002:a17:906:924b:: with SMTP id c11mr18877533ejx.75.1596991504160;
        Sun, 09 Aug 2020 09:45:04 -0700 (PDT)
Received: from blackhead.home ([2a01:112f:a1c:7900:7316:ce1e:7b0b:6bd7])
        by smtp.gmail.com with ESMTPSA id b24sm10423215edn.33.2020.08.09.09.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:45:03 -0700 (PDT)
From:   Marcin Sloniewski <marcin.sloniewski@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, mani@kernel.org,
        marcin.sloniewski@gmail.com, a.fatoum@pengutronix.de,
        sam@ravnborg.org, linus.walleij@linaro.org, arnd@arndb.de,
        broonie@kernel.org, lkundrak@v3.sk, daniel@0x0f.com,
        kuninori.morimoto.gx@renesas.com, allen.chen@ite.com.tw,
        robh@kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/3] dt-bindings: arm: stm32: document Odyssey compatible
Date:   Sun,  9 Aug 2020 18:44:49 +0200
Message-Id: <20200809164450.289731-2-marcin.sloniewski@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200809164450.289731-1-marcin.sloniewski@gmail.com>
References: <20200809164450.289731-1-marcin.sloniewski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device tree bindings of Seeed SoM and carrier board.

Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 790e6dd48e34..3b318fe15194 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -50,4 +50,10 @@ properties:
           - const: st,stm32mp157c-ev1
           - const: st,stm32mp157c-ed1
           - const: st,stm32mp157
+      - description: Odyssey STM32MP1 SoM based Boards
+        items:
+              - enum:
+                  - seeed,stm32mp157c-odyssey
+              - const: seeed,stm32mp157c-odyssey-som
+              - const: st,stm32mp157
 ...
-- 
2.27.0

