Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF8FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A2D206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6mGE5E3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbgF3Nd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388139AbgF3Ndw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:33:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CE8C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so18846295wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zyIUTlmpGUcnH+LiKgtC/ATIX5960EbAPmpzyReDmls=;
        b=Q6mGE5E3X/8/+zlhENHURAJbLrEQhKKP61fNSre5+zd/awBDhaniAZCqLJv3T/K+xB
         LLaHcTkwe5z7mGfkbouNMs2GcI+AqRHhuq6Gz1QCCRJe0Y+hn/YHQuGUZWAqb7RUpdaE
         70+NaU99UEzrWJmcUxMJBjS1r9r8XFy8753y04wH/FBtreZ39DbEg4yxDeqSHADl49s1
         crYCHpqzEp8rRerMgtEmyT9czhG4JiM8cwA7eHXPiSnTgDUgjm80qrR51MCfCoBh7bds
         M2AxS/fr2tEVYfL0+cYxhEvrKD3lrdVVxo3BgjB+eZHFrUSXOVioVHn0oc/fAVoRStuq
         SWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zyIUTlmpGUcnH+LiKgtC/ATIX5960EbAPmpzyReDmls=;
        b=YkmoKsZyD/Nr9vhoFzbY4doDSZlPeOqf7XfOsbbLJrCosMFZwvh3LEvjNx8S6Es2WJ
         JWQFQbVYPeBE8bs6E2MUk8uo4ALi5gH6P+b3BnAzRZJE/mSoP0R3Zi+IzRshAtwYn1ff
         s+EB4EV2IBYclxzmVBMO0Ayf5zg4HxuEu10GjjxekrF4Z4wB4fBEZ7Dj5XpeF3qrbAvK
         Hm31/OwZoLiHuMGyhA2HuTTSTOwlK9mVp6C/Uta5/krVaBv+xBgdMvke5jmRW1WPPIru
         N7mI68tqP6h5AnuTGMDTNxEKyLMpeTvALFUnv5kJ3YKKwSTJaJSLtRmXf9cFFovstTbT
         JnkQ==
X-Gm-Message-State: AOAM5315lgTRHQ3uU1JjxSyCjjhLfXIqT1WWUBcnjJip9HhvpIZnL5E2
        dQUPohca5rsOmolVOgCzx1m39A==
X-Google-Smtp-Source: ABdhPJw7St3BA3NSrWMeVnDiPKDDzNpn3UpLraNAHGKv+8L6f1Y/qEVIk8Dy7tAqPKp72fwVAxdgCg==
X-Received: by 2002:a05:600c:2058:: with SMTP id p24mr21449910wmg.74.1593524029704;
        Tue, 30 Jun 2020 06:33:49 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id z16sm3682464wrr.35.2020.06.30.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:33:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 01/10] gpio: gpiolib-of: Provide documentation for of_gpio_spi_cs_get_count()
Date:   Tue, 30 Jun 2020 14:33:36 +0100
Message-Id: <20200630133345.2232932-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630133345.2232932-1-lee.jones@linaro.org>
References: <20200630133345.2232932-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Descriptions for of_gpio_spi_cs_get_count()'s 2 arguments are
missing.  Document both 'dev' and 'con_id'.

Fixes the following W=1 kernel build warnings:

 drivers/gpio/gpiolib-of.c:36: warning: Function parameter or member 'dev' not described in 'of_gpio_spi_cs_get_count'
 drivers/gpio/gpiolib-of.c:36: warning: Function parameter or member 'con_id' not described in 'of_gpio_spi_cs_get_count'

Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 219eb00542334..236985714ea92 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -25,6 +25,9 @@
 
 /**
  * of_gpio_spi_cs_get_count() - special GPIO counting for SPI
+ * @dev:    Consuming device
+ * @con_id: Function within the GPIO consumer
+ *
  * Some elder GPIO controllers need special quirks. Currently we handle
  * the Freescale GPIO controller with bindings that doesn't use the
  * established "cs-gpios" for chip selects but instead rely on
-- 
2.25.1

