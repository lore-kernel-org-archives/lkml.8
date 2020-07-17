Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C994C433F7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABDE207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgDHQZAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgGQQ4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgGQQ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:56:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D9C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so15952583wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cyqL66bhaPo6pUJYftE+BouP+W8ifTKxcOtS6pP8tIA=;
        b=bgDHQZAm1Y7zGqco6LHcPFImygLo/eaYHhgO4zR4uqMXJXBH/9/wUXvkgURQEgEcPf
         vRFq3fHY/XmeaUh/vIQRfq1bADE7GHYiWQH+exNS6KTPZddIkQaaSOTeEE1bi7W2D1mY
         VxSPWjFBYAHsExqDJeVWJD9VpQGNiY/CcKTKKEjWbytzE9T9GORFrOXAmRDKAUscog6q
         vSo5MTT6YhP/nJK4HnudqudhwFB9qB4kRLz1I2/7IrgKaw858ntypQ4Hps0xQ8t6V+Ef
         ySaRfcZdo60TpEiSnm9Cf26IdXLDFZ1NvK3lpAsBAF9Jmw26IZJc/czIvlbIyh/c7XP1
         xz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cyqL66bhaPo6pUJYftE+BouP+W8ifTKxcOtS6pP8tIA=;
        b=Fi9QYgUWYRQy90flb9DB8Ae8wga1nNhFnZOM3rkgYrNuQcbZKbH6hFP+Mno/eYsBo2
         zbfUASMMcd2RPsR8QAl9c7psACC71EXPo210q+CSgUYuZ3mS+O5m3u/wDCeX6d1+HG9B
         HIS7YaMtc21z6Ut7iJwIiKvDoV9hwW7J7mxJdJtOQz2YQkBR4cmIoJYeRwkP26JP3J3j
         KYl8jk4wlQmmzQB6gXBDtUAaGIIM0qwqdiPvqvbLwwUcpbf1GxcKXxcDpti9mLGL8grh
         DNbKrpi/nDAX2o+dKUJi6/2pRo3y0r8RjwrmfhmAIfu8bdN5U6ly+LAC51NBRMLgRCy6
         d78Q==
X-Gm-Message-State: AOAM530IiVPu2zrMK1BMKm8COoEaVjNutFMuEVFZLmJJRRyTU6cgv0pC
        NeU3WCSOvJ2lnln+cnjVNgNJ+A==
X-Google-Smtp-Source: ABdhPJzkOkfui+os8Qw2Xmd5y3cEYFZKIpsg38EFiEnyePI47o5q7jh1WVLfiLgGxOTQOSGbdLUnzQ==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr9952906wma.24.1595004973487;
        Fri, 17 Jul 2020 09:56:13 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 13/30] iio: adc: at91_adc: Fix 'bad line' warning
Date:   Fri, 17 Jul 2020 17:55:21 +0100
Message-Id: <20200717165538.3275050-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All lines should start with ' *'.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/at91_adc.c:160: warning: bad line:                         (Interruptions registers mostly)

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/at91_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 0368b6dc6d60a..c5ea75cd88fa8 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -157,7 +157,7 @@
  * struct at91_adc_reg_desc - Various informations relative to registers
  * @channel_base:	Base offset for the channel data registers
  * @drdy_mask:		Mask of the DRDY field in the relevant registers
-			(Interruptions registers mostly)
+ *			(Interruptions registers mostly)
  * @status_register:	Offset of the Interrupt Status Register
  * @trigger_register:	Offset of the Trigger setup register
  * @mr_prescal_mask:	Mask of the PRESCAL field in the adc MR register
-- 
2.25.1

