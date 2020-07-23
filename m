Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F261AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CABD02065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkMxynTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGWTiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWTiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:38:03 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14335C0619DC;
        Thu, 23 Jul 2020 12:38:03 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n26so7660632ejx.0;
        Thu, 23 Jul 2020 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9aNpNKaa3hKIU8fbCISqJpdam9Hz159Xkk+hYct4wA=;
        b=QkMxynTHFSOlrYHV37e2/babhMJB67VamqWrafseHoTuw3Ae/Q8QekQWsGF2kOS60b
         +jvJWhvl777kQyPceA92HNij6qOMQ9a564mJ79S+1az5XMvyA1F7SARy+Ojjs8nkNj/o
         AFIfG+r4Uta3/cbY7J+1VrXCyTMCfVz93KeMYk+8U/VcQPQzbq1fxQQtJeF9RISJoNC3
         I+Liw3A8PYYoxwJEMGJ8VRxUSwRnQ8H4KOmbrIrQ1EP8wbFzx3O8/ceSMyDPtpKNcROl
         kdXQclxlz/Xa1JkPNSGvW+Yn/xqf8Zf6SYCDCr1mc4wN1YI6A1vb8Yv08k9xybnpLRvV
         A2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9aNpNKaa3hKIU8fbCISqJpdam9Hz159Xkk+hYct4wA=;
        b=qI2xP1UwdlLZPg1gVP6u+gIy+jIXHlG3Ay3Vs0Vg8e7JqUFYXzwnV9K6frGTKMMYTc
         P7odR2dHiCHkTeyC+ViMBV07+66yfpKmPM2r+O3LbVlSsYkH6anjw8f/cmoMqW1lZYRU
         v4eQ/TRJULhNc0grQzjDHnh4KxIaEt9EYoKTKY/1vYfDE9jzotrMHlFQSX6j0jt/u+4A
         AeG3zDvVXPCJOvEa0eEEmA3IeuiOfDgb4XWMGX3NC5tZbO/xOnMZ/qs6hteEDCfPmEoh
         1IsBsXE8064viJ7CyBwwQ3UEsOLB8kbYuNzDNH5Xr6brJ8/+wDgPcPUo7gPDzfbwOOos
         sPKg==
X-Gm-Message-State: AOAM533/+MqudQKu11nyVKN50176oQnmLX5ID9dlmtKbzpW7wRC4Jobm
        OthtPJBYMcOoItcuoX3qnf4=
X-Google-Smtp-Source: ABdhPJy2sXNkWdJWkhZX5v9NVxeNJIf8aQTzdZtj5AK0CtAVs57Kz2V0BehmkljdmSZk5zYeAmpoZQ==
X-Received: by 2002:a17:906:70cf:: with SMTP id g15mr5518734ejk.531.1595533081769;
        Thu, 23 Jul 2020 12:38:01 -0700 (PDT)
Received: from blackhead.home ([2a01:112f:a1c:7900:7316:ce1e:7b0b:6bd7])
        by smtp.gmail.com with ESMTPSA id o20sm2655719ejr.64.2020.07.23.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 12:38:01 -0700 (PDT)
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
Subject: [PATCH v4 2/3] dt-bindings: arm: stm32: document Odyssey compatible
Date:   Thu, 23 Jul 2020 21:37:36 +0200
Message-Id: <20200723193737.190291-2-marcin.sloniewski@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723193737.190291-1-marcin.sloniewski@gmail.com>
References: <20200723193737.190291-1-marcin.sloniewski@gmail.com>
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

