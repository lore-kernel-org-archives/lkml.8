Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E2AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F68E206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rooF5Y/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgGaObK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgGaObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:31:09 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573D4C061574;
        Fri, 31 Jul 2020 07:31:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id jp10so5066002ejb.0;
        Fri, 31 Jul 2020 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnSVvBPLgxOr7Okxa4+yFdbMwIKkVndKbRuepRfY/Zs=;
        b=rooF5Y/LejVp6e+lkheBsBcOKwrWhHZzYXHf1m9XAOFNv87fHiPOh8t6nVxb4zVyuN
         QDpyFEFyiTwlk8xKArO+TX4KUIY++pi8GQ2aMGQeJFu49tn7aim8G/kueOGS8tfEIrpQ
         m8Eb/crBpL+aHjgty9b9jP36O8almuZhO0THmWfwhZOGRGmaQuoebyiVPkJPoZnWfb12
         IcMNREwMZeqv+FGO3XG63F7LBQcdiGEnQayFjSUl4e7jJzqbqQliGxVniSm03H8C3sTg
         +qszh99IXLCLTlEOsKO0vTmCHnKjuYFc0sYdgnG4a917/G1WL5EJUUsElxaTKZz5mVRc
         1i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnSVvBPLgxOr7Okxa4+yFdbMwIKkVndKbRuepRfY/Zs=;
        b=VBv/0f5mnx7z0A2vvyd5tb7ZlO462rHq4C1Qiy9COlQMF+QOIydLw3KPrib47wO0B1
         Wb7FwDVFmmSSkwU5M0eR3tz8kKYWRdwsEKoNEYIAhY2+rylzoAyDgrDhxPe425ZFa9y0
         oU6A3BV99XxHkG3Pe57Xsv9KHOZmSVp4Xv+Jx1Und6mz35DwSnDW72foai4soLW9BtV+
         3fD4wJL4E1zOYnry1JrmaVJQPRMT8Z7xGhfc6vn9O0fH2pw42ZHfylmhEPwvxLmM6R3P
         7Rn21q6VN09hIYNJGfFAKt0ED0nw37eZk2e65P+kfz76009E4e8QVkxxQB1aY4XIAJ4p
         GU9A==
X-Gm-Message-State: AOAM530n7v+wrLhXrp2hWYV0dhZ6hFHAgTXMSGdMQXhUVbd3c6ihPju5
        luUpW3iAY5lJhQMJyjt0EDVHMPgIbWE=
X-Google-Smtp-Source: ABdhPJybf/XZgZB/Q/5YD/PtnotUkX1ldsL6Uu0I4qModtm+zX/Ggq7KmPlZXxlfNH2FA8a1tV0ngA==
X-Received: by 2002:a17:906:269a:: with SMTP id t26mr4331783ejc.286.1596205867955;
        Fri, 31 Jul 2020 07:31:07 -0700 (PDT)
Received: from blackhead.home ([2a01:112f:a1c:7900:7316:ce1e:7b0b:6bd7])
        by smtp.gmail.com with ESMTPSA id t19sm9749213edw.63.2020.07.31.07.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 07:31:06 -0700 (PDT)
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
Subject: [PATCH v6 1/3] dt-bindings: vendor-prefixes: add Seeed Studio
Date:   Fri, 31 Jul 2020 16:30:51 +0200
Message-Id: <20200731143053.44866-1-marcin.sloniewski@gmail.com>
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

