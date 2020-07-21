Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA90C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E6022065F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQ5/kloZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgGUPVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbgGUPVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:21:13 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C13C061794;
        Tue, 21 Jul 2020 08:21:13 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so15579003edy.1;
        Tue, 21 Jul 2020 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9aNpNKaa3hKIU8fbCISqJpdam9Hz159Xkk+hYct4wA=;
        b=fQ5/kloZEXGKN8xHu+TWTKF25LJoYXcWQ7Mc/nVPI2IvVhkhf25DKVx1SXkuCpai55
         SYPYZlZVrchP4Xz62mZDo/i8y7FXf8BcXBPG6LPV/PsXRH+gz6kxQloXTKiF3HCRmQwF
         nLs14Hvz4Ko637i9AcBO+muu/cvtE2146OvgMeTGv2KCpRtO90asdFV7+LrIVyBmqAZ9
         6zBE/aHapseRbRI+QW50dAqiTgKeyYf7QDEDd5TSLzSXZf8+aJ/cE/MeZ0XbeawX63wZ
         wQ38EapQlb0M/TfdxvQnTL1Gy8/RTBYJ+ye8g5dGpPNaeVmNVQjNHWCo0wvh9joDPeKl
         kQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9aNpNKaa3hKIU8fbCISqJpdam9Hz159Xkk+hYct4wA=;
        b=UY3xtYykBm3HD+JCtFwR245y4+4f/MwN6rXduaLF99X6tRtoorDujEB5I/6hIViFdi
         4m9hEWxPix+NFAFN7YlCat7aZ+14rvrELiTD0/LpVl3oeeBQJm83OLgvxLa+KmaNCdZL
         6f/Vqud99MMqcLP+HoI+KHOCLnBh9QxmOfHPWN7b6mkRhaM54IVHi39Vo2sf0PepAXAl
         dbKBghCD9GLl0KM60J8T31ApTlW/Ni+031HGy+Wssh/Mb9LB8kLF0O1lfv2D0/fKMuq5
         EkSdeg+vKo9JRkZTs1lyfsuRSIlzkPblEFUlUiZVcaPBp6u8jJ+n2r6p2Dv2y4hVaynm
         XnKg==
X-Gm-Message-State: AOAM531a+cl04CkH3HosJ8mV1moWDgaYSirE25IoTQxIzSyzTbCDbG92
        mv1B3gMjNXEyizKVFKWKb9A=
X-Google-Smtp-Source: ABdhPJyxNu5lPrX8rGROYm8KYk23OlCWfkj84wbmE76k1loIEP8t5DPH8bt3ik9lCDGZMpx0kGzsRQ==
X-Received: by 2002:a50:e617:: with SMTP id y23mr26380738edm.47.1595344871972;
        Tue, 21 Jul 2020 08:21:11 -0700 (PDT)
Received: from blackhead.home ([2a01:112f:a1c:7900:7316:ce1e:7b0b:6bd7])
        by smtp.gmail.com with ESMTPSA id se16sm16802826ejb.93.2020.07.21.08.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 08:21:11 -0700 (PDT)
From:   Marcin Sloniewski <marcin.sloniewski@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, mani@kernel.org, a.fatoum@pengutronix.de,
        marcin.sloniewski@gmail.com, sam@ravnborg.org,
        linus.walleij@linaro.org, heiko.stuebner@theobroma-systems.com,
        stephan@gerhold.net, lkundrak@v3.sk, broonie@kernel.org,
        allen.chen@ite.com.tw, robh@kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: stm32: document Odyssey compatible
Date:   Tue, 21 Jul 2020 17:20:14 +0200
Message-Id: <20200721152015.11608-2-marcin.sloniewski@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721152015.11608-1-marcin.sloniewski@gmail.com>
References: <20200721152015.11608-1-marcin.sloniewski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device tree bindings of Seeed SoM and carrier board.

Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 790e6dd48e34..22b9aaa75eee 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -39,6 +39,8 @@ properties:
           - enum:
               - arrow,stm32mp157a-avenger96 # Avenger96
               - lxa,stm32mp157c-mc1
+              - seeed,stm32mp157c-odyssey
+              - seeed,stm32mp157c-odyssey-som
               - shiratech,stm32mp157a-iot-box # IoT Box
               - shiratech,stm32mp157a-stinger96 # Stinger96
               - st,stm32mp157c-ed1
-- 
2.27.0

