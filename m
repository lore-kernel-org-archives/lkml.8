Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380B0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17210208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK6F+t/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgGaObN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgGaObM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:31:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B5FC061574;
        Fri, 31 Jul 2020 07:31:12 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id jp10so5066168ejb.0;
        Fri, 31 Jul 2020 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SoBgP3OEfZo1S+W2OL+antn28vvn8c/8vKe/rfz3jjQ=;
        b=SK6F+t/JxJcgV2SCsOGQZE+MfXDB7UoxryEUzRShs9Ek7cGT90QdiCHOwbK/7/yzoY
         i4QAWLp9WOmPzuPx7a9TD5yqyqGzYuSZqstAuIN6xVCZzko2yUCXh6fk5PgCk/VAZa43
         XZotn1ECSLVYb7Pzav44xNNPa3Bh58Q5oRWI7Fp2qIPEuUgqQDH1wHpEkW6gY5B9bAzp
         FBkPbWql3XUWg5fcnyGs9GbJ655X/79WY2wKH2Rhw/JikAsRTYWFltd5Ox0oHDkISBDr
         70XG6Fw1ogKGrDInyv2WHlDbM3AcHcBaZnL84sH5f3yRlN9ykHfmDAN1e753NSCeUpCZ
         4JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SoBgP3OEfZo1S+W2OL+antn28vvn8c/8vKe/rfz3jjQ=;
        b=ZOvQextLEadlv6FnDHx+n8RBCjtkGpansWFNoWcSsTEwjzxkQclP4AX+Jw03/e/+Lp
         xJ18xHbR1x0a4JMWpsoiYwE0/PErj8QJFQVaIrtOSfdZHtugK5wwqw2HgS2Fy4QO6uSj
         NTg7d5eJm8AZWwQreAoP4YPYsfoaIy2LVYm3CxgBlrlpOvmGjDCoSoFlN6Dvvk2X2Q8E
         zdQDqzIl9ZZ67YtxS0isRAhIFSfSGtMpA1nN2fpPlFgyDtoTpMZPa3st2y98S5z2pYYC
         QOsl33EsUySGmxQqf3RQncQE+Huug3sK2BM4GP6G22k0Ryb3qxx2NmLx6FhEXjyRGcQc
         G8pA==
X-Gm-Message-State: AOAM531LCZqpGxzLW0jQhsxZ7du7j/K4KzZZIBFefOaub40oEyIJ4kcX
        yrIaYY8Cv6T6VgucuF534BM=
X-Google-Smtp-Source: ABdhPJwbdjNlbrDerhlhZ8Q37dyLhQem1aQxCxoJK+A2ZFDSqrRmTzWNJ42F39j17QjMiuTv5xX8yg==
X-Received: by 2002:a17:906:1911:: with SMTP id a17mr4066941eje.431.1596205870759;
        Fri, 31 Jul 2020 07:31:10 -0700 (PDT)
Received: from blackhead.home ([2a01:112f:a1c:7900:7316:ce1e:7b0b:6bd7])
        by smtp.gmail.com with ESMTPSA id t19sm9749213edw.63.2020.07.31.07.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 07:31:10 -0700 (PDT)
From:   Marcin Sloniewski <marcin.sloniewski@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, mani@kernel.org, a.fatoum@pengutronix.de,
        marcin.sloniewski@gmail.com, sam@ravnborg.org,
        linus.walleij@linaro.org, stephan@gerhold.net,
        heiko.stuebner@theobroma-systems.com, lkundrak@v3.sk,
        broonie@kernel.org, allen.chen@ite.com.tw, robh@kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] dt-bindings: arm: stm32: document Odyssey compatible
Date:   Fri, 31 Jul 2020 16:30:52 +0200
Message-Id: <20200731143053.44866-2-marcin.sloniewski@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731143053.44866-1-marcin.sloniewski@gmail.com>
References: <20200731143053.44866-1-marcin.sloniewski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device tree bindings of Seeed SoM and carrier board.

Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
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

