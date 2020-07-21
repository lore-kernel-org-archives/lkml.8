Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874D8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DA020729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eek7cfh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgGUSxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgGUSxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 14:53:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF96C061794;
        Tue, 21 Jul 2020 11:53:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f12so22644541eja.9;
        Tue, 21 Jul 2020 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnSVvBPLgxOr7Okxa4+yFdbMwIKkVndKbRuepRfY/Zs=;
        b=eek7cfh8H0FIKKTKyBOBHTZXYqIWxEk2P6Dapr54GUi+cu4HMdvEVwngy6fLz1aDzg
         U0nFCc4ud2FYMXTUQrRiT3tbHejhwGgihOl42ahAgrjrWuM+I6d+6HakuuuzNG5ftqYA
         xuCEbud/W7cgGEpDBQ5xy/W+JlSt3RtlznZhLpdcwEYoAyVWbDcCOYYwBrNxKEgeoOMC
         6FDXsMt+noVatUZPGb7f1gVvQIHr5TUNngAYmHT2s7tnARRznT1CYQ4c0RqU9o93V5wz
         509Oa0X8gkl6SAoeDJ4Kup24jKoQqX8R2+/nUcXa20nn62TkcC4RLCZ7amX1hKN/LYhJ
         nd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnSVvBPLgxOr7Okxa4+yFdbMwIKkVndKbRuepRfY/Zs=;
        b=coRf4wJI8Rh1ItClLp4utGOuQwLkeGBPwogMY7slXBQM4npE8un8nLwZq5cLxzbaWH
         MEbZSfYuKgVkHKj1U7/2nO8J5UmO+EMDmVZuhHVuldaSXxMWMoARNVzsrZeAQbUHNqZS
         EKcIGFCovFEcIS9ocZV/wo242/Kq6ylOj2FLsuBIHTFcfjSuJXksFycqfXp74MQz1FG7
         fljWcsifggYKf2g8Y6ztfoa99AQUTIbP7PY8x10BTlJaSNF8qwQ/xsCKjVZnQEbfOW98
         ht6HkxomTE6aAJWlSG55hXp/QgYLRPo2e+z6dXixLf6voCv0loftBv8RyJ60YMIcC++P
         SfEw==
X-Gm-Message-State: AOAM532kl+jW3RRLtZw+hCbaq5p4uORU7bdTdgtuWML1y+V0NXiw+pkl
        QXzAlhz9YewbGQQCm6CpCG0=
X-Google-Smtp-Source: ABdhPJziAjyw97m/l3cd7CXgr1VWPs/5ficOCx+UJ5aQJNaPKvKkhN4gy0cXRhfSU6uY54k9dE/I3Q==
X-Received: by 2002:a17:906:7c8:: with SMTP id m8mr26420200ejc.527.1595357618581;
        Tue, 21 Jul 2020 11:53:38 -0700 (PDT)
Received: from blackhead.home ([2a01:112f:a1c:7900:7316:ce1e:7b0b:6bd7])
        by smtp.gmail.com with ESMTPSA id f10sm17585506edr.69.2020.07.21.11.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:53:38 -0700 (PDT)
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
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add Seeed Studio
Date:   Tue, 21 Jul 2020 20:53:12 +0200
Message-Id: <20200721185317.208722-1-marcin.sloniewski@gmail.com>
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
index 9aeab66be85f..7dd03b3e9d3c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -902,6 +902,8 @@ patternProperties:
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

