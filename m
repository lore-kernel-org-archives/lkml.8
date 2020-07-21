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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC77C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89AA20729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEAQo5sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgGUSxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 14:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgGUSxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 14:53:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A88C061794;
        Tue, 21 Jul 2020 11:53:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w6so22679958ejq.6;
        Tue, 21 Jul 2020 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9aNpNKaa3hKIU8fbCISqJpdam9Hz159Xkk+hYct4wA=;
        b=DEAQo5shwBlvBDRE4dq0fqNYhqsjuBfmp4YDc8urvZqI7UMHffWCHF973BrWjh6I2c
         bBf3A0VyCMOcf0jc43LARef9Y+1omwycwLNv412cwFJKSccPWfxBSnlzwsuvMZCjF8Ui
         grcWepGGTFfaJ8OroAzf1RbFtkz03FBMp1QBQbwVNB5Gev6vdT+E/jZO9uekvf9CjKFM
         Zj3tkumqKiB6cidZvhh3gSNZhSaR8P0IS5zUL+8KWUeiM3+jqHi9HiroiCQJ75Ts8jRa
         3I26u9vQRsqVX+KJJ4dSTbhUZI/RovjTvOxhWsF7PHQUBzzWA2PYngOSQSe6FoeC8FWy
         gO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9aNpNKaa3hKIU8fbCISqJpdam9Hz159Xkk+hYct4wA=;
        b=BVivaU2ZRlCxF9uy1oTNVcwz9cgf6VkJesv/hm4bZJiu2mztukjB760PM0YP7cA5jP
         tUWmow+rCWF7XOXYA8coDeBb29kDve+Q5BEWlWywlq4wMk36Auv0Hc+HO8S8ar1zWqr7
         yKENoIa5Bb1a3d0l7n+0usdUhYdaTM1afBphstpjkUMadJtbS9fuWofkzr8eVLbrjRaR
         FwfrGy992UQzsdKZTsICPkulJvfvxABRjfe+8vrd4KOfVrPEQfZVlqiHNAG7IBKZXr0Z
         dyiHuOgpp+0n+bIjcc8XWxyauZ8mYoHtaOAOuAAuMLxaFBGDwmOgvJEIdZPMQXjuNfKh
         DDew==
X-Gm-Message-State: AOAM532hbljKhfFdMjuzHKWVAkZZTQewbSGFqhtF1Z6X21GUYbvpxM2Z
        tsdTxIVQ+A+GKXQU0sTo7DBKOtbRnng=
X-Google-Smtp-Source: ABdhPJx2PEmZzBGyKk4N7s3Eq4qDceCGTBVNcZ+IU16CpoHMs71/47vgt34rCkU5sCNoiMFM0uFsvQ==
X-Received: by 2002:a17:906:4a87:: with SMTP id x7mr25245724eju.44.1595357624699;
        Tue, 21 Jul 2020 11:53:44 -0700 (PDT)
Received: from blackhead.home ([2a01:112f:a1c:7900:7316:ce1e:7b0b:6bd7])
        by smtp.gmail.com with ESMTPSA id f10sm17585506edr.69.2020.07.21.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:53:44 -0700 (PDT)
From:   Marcin Sloniewski <marcin.sloniewski@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: arm: stm32: document Odyssey compatible
Date:   Tue, 21 Jul 2020 20:53:13 +0200
Message-Id: <20200721185317.208722-2-marcin.sloniewski@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721185317.208722-1-marcin.sloniewski@gmail.com>
References: <20200721185317.208722-1-marcin.sloniewski@gmail.com>
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

