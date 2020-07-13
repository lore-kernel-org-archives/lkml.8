Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9D0C433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1868F20738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1WN0X53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgGMOu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730130AbgGMOtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB36C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so13447509wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=we+FYdI1lkoYeqfH+hTSe6pNVLsfmTg5CRQP3bOvglU=;
        b=U1WN0X53vbT4MvhLNRle/Pi49aoyXp8l/FZ9qbfpELXVGRvwteyYQ59YIS581Rx0Xp
         q5UQZNPMwm4gbhy2sGnmyUhu+w/WSyDy8SZwq5gc7YFHp11qt2IevOUpEE0bd15DH/8G
         F0tLllXkjBOGT94L/jRw4tRXmh6xUXZ42RV3KnfYe23GHPr8WB7Izy+DlVxJwv3uNcH3
         spPTiORGerSbhn1gcD3+8ZhgKGlr3WTLewuQPjCmNoxXAWdMLet04UicbcIPSh9F7Dh8
         3s3nrgW8efZiHQaPyILOHhsm0gTtGvlZ75SUX8Oby7yTHrd4vKHUhLfTND2frhv/Mv0y
         EjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=we+FYdI1lkoYeqfH+hTSe6pNVLsfmTg5CRQP3bOvglU=;
        b=T6n7ieFeJSGHmu827vSLEx7dsi3oegDAXcj7p8996RQ6YwTU6sVUNVcEb1j/eT5lrm
         XxlL+zxGCACa8PiYCPlj6PL/oYEpwO85FkpLokj7PeCqZdlLmBUrs6bxmnUeDg6wqNl4
         QSRoX42l3n7MRf8i7O9JbM+LXTTBEpEaXjCITYN7uTMztwrffVAMIvy++FHV4DIVVOwB
         1PAhnVI+9mRC/GogYk6LfzULF19spD/nISdOooQEv+Chr9tBE36UmIwljpdL2t+KgXmk
         3W13xTO/qxVqfHj3bg4y8YHeV7EUomc/ulz+iYV2qg0jjwHk6dHyngV6pIoVyL0/k/UJ
         CvMA==
X-Gm-Message-State: AOAM530SicOekFkiiM4R1CgXvH7ZWJNOtrPzcBA2AD1t3GaPdI9VffOE
        Frs/H/Mk7unbpbmPlVStfzbUqg==
X-Google-Smtp-Source: ABdhPJxoVsuUxdjQrc3CM3WbousZGi/1/+jQn4P+0A7iaqIru6LA4EJm04rEqpNRn1DujBpLMkOpjw==
X-Received: by 2002:a1c:c242:: with SMTP id s63mr311154wmf.146.1594651781752;
        Mon, 13 Jul 2020 07:49:41 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 08/25] pinctrl: samsung: pinctrl-s3c64xx: Fix formatting issues
Date:   Mon, 13 Jul 2020 15:49:13 +0100
Message-Id: <20200713144930.1034632-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc struct titles must be followed by whitespace else the
checker gets confused.

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/samsung/pinctrl-s3c64xx.c:212: warning: cannot understand function prototype: 'struct s3c64xx_eint0_domain_data '

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
index f97f8179f2b1b..b8166e3fe4cef 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
@@ -193,7 +193,7 @@ static const struct samsung_pin_bank_type bank_type_2bit_alive = {
 	}
 
 /**
- * struct s3c64xx_eint0_data: EINT0 common data
+ * struct s3c64xx_eint0_data - EINT0 common data
  * @drvdata: pin controller driver data
  * @domains: IRQ domains of particular EINT0 interrupts
  * @pins: pin offsets inside of banks of particular EINT0 interrupts
@@ -205,7 +205,7 @@ struct s3c64xx_eint0_data {
 };
 
 /**
- * struct s3c64xx_eint0_domain_data: EINT0 per-domain data
+ * struct s3c64xx_eint0_domain_data - EINT0 per-domain data
  * @bank: pin bank related to the domain
  * @eints: EINT0 interrupts related to the domain
  */
@@ -215,7 +215,7 @@ struct s3c64xx_eint0_domain_data {
 };
 
 /**
- * struct s3c64xx_eint_gpio_data: GPIO EINT data
+ * struct s3c64xx_eint_gpio_data - GPIO EINT data
  * @drvdata: pin controller driver data
  * @domains: array of domains related to EINT interrupt groups
  */
-- 
2.25.1

