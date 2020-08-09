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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DE5C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 16:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D504D206C0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 16:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ckxwpo7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgHIQpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIQpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 12:45:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7300AC061756;
        Sun,  9 Aug 2020 09:45:02 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id m22so7057680eje.10;
        Sun, 09 Aug 2020 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V/7ORdIOTb173XCMu8rmzTqIYUKz1Qdd9CmYuO/q9kk=;
        b=Ckxwpo7Wwje1tHWyYkFuCPjkk8lq361qN0fZq/Ot7NowxoRWYoR1g/tnfDhAXT926+
         UJ3GFEp+yYfpWObFra7T19FkICr1y8sJzU90cTKPAzTGcjSjyecirRc0errKn7Y9RWLU
         ko/zmsSo+BfGWHCNGJ/t5OiqDo/tSbSQVC08iSWu3/bgkFhiTdePj5Da3kGmCDcN+DWt
         YhTLxhWnAxVWFjZO4nH5SActl/dxNgDwNrfWKhMP+XbsbWpvj4PO4Mv5XFFic3oCs8XP
         Y+FullCakX/j2BvSpvvC2zlRXAfZRvQPqou3fnvYi+g77K98V9klPYfJCFmbANo2/RnQ
         aTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V/7ORdIOTb173XCMu8rmzTqIYUKz1Qdd9CmYuO/q9kk=;
        b=V5D85zztaVJUbAiX8Mir8KFatRtwWuAfpa0dFHEdOGPgl0niknbyR3Fnhhv6rzjWRc
         XdSNhY5EwM2Rj6pdTmdI4p3gcXTrj37tZSlKq26rmkY84nNLCVhTlV4977HQFU/7Q4u1
         5uUf7FEcYD4gTauAQ7uK+BP9oPAaPnOSIhTf5MjriKfSjNtqCfNgWOBaEoV2pjXKzGoJ
         Fc8KKNMqnUkeGURODFoDuE1z8ayzLgRH+fJCuObKJbZatIjB79/DfUO1AK+Q7MFCCzJB
         CGPyzX8P4gpyyVQFI/m2Yw2BW4Eycpay4fniZgW6XWXifUu7dpGQYZ9XFpUSa2MFBquQ
         2wSw==
X-Gm-Message-State: AOAM530OPMoUvDMjTCBU5Q5m7KhjyiYZx6+r6lW98Kj93wbKkTv6vvUP
        Ew8NJX+FRKXDTJyTlODt8Bs=
X-Google-Smtp-Source: ABdhPJxOfdaSkhY2zLWjUeQrTFtLLw4cyiNiCGj7cslQ38Ma5YOQwE6W1HZjpC+W2K79NY+GnMaQTg==
X-Received: by 2002:a17:906:359b:: with SMTP id o27mr19174818ejb.103.1596991501120;
        Sun, 09 Aug 2020 09:45:01 -0700 (PDT)
Received: from blackhead.home ([2a01:112f:a1c:7900:7316:ce1e:7b0b:6bd7])
        by smtp.gmail.com with ESMTPSA id b24sm10423215edn.33.2020.08.09.09.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:45:00 -0700 (PDT)
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
Subject: [PATCH v7 1/3] dt-bindings: vendor-prefixes: add Seeed Studio
Date:   Sun,  9 Aug 2020 18:44:48 +0200
Message-Id: <20200809164450.289731-1-marcin.sloniewski@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "seeed" vendor prefix for Seeed Technology Co., Ltd
Website: https://www.seeedstudio.com/

Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f3d847832fdc..cfde16a7084c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -910,6 +910,8 @@ patternProperties:
     description: Schindler
   "^seagate,.*":
     description: Seagate Technology PLC
+  "^seeed,.*":
+    description: Seeed Technology Co., Ltd
   "^seirobotics,.*":
     description: Shenzhen SEI Robotics Co., Ltd
   "^semtech,.*":
-- 
2.27.0

