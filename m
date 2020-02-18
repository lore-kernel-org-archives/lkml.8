Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F86C34033
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B612070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GCaozWAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgBRJnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:43:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33615 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgBRJnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:43:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id u6so23116221wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tGKCYnBEpjpoG5QSejrUPURgc2UVgvoiMB1koCeCZI=;
        b=GCaozWAzhz2rzE3xCPycDcZfcJEqLfqMgQo3eIz7yz4vHoD1VyK54/EwdkV5KLeIEs
         kbsuHvMVu4ZPMyBOJfO+Gc3z2MPajyZGfG7z0g4X5mpq+bevno2+vcVtdt1sAU46rzQG
         vxmGaHfYDiWmrah4zwJxta/GwJpkfZsn19u+lPFY0VlbXwTxu3IWmQkEwYAnhkVmorel
         pIyMeeAIHglpnFeJKWHwDXbWA3tuC07pSrYe8S9AzG23GnAzbqIOV2xnptCCJCKACjqu
         3RLJUvOs+Xqy3WpIfGaPRCUe+njTB2kYKCavPhHCML0TSt2PnFcFSjuUG5csSmQ0z6iy
         MkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tGKCYnBEpjpoG5QSejrUPURgc2UVgvoiMB1koCeCZI=;
        b=hpjnN1QO75uwCTIkXL4/5eDcdA0nnJWbLm1omyekZZlPHs7vES09Kp7HhkO23g70Lm
         iqylADHbYC0F3zdRG+0PeRRn8Cp+nW+nqoq+/GkrUZwy7innmq3R0bOSSvHBS7V7kc8e
         1gmnKXLgTcA5+nTDC5I6W6nKHC9ANGPsJDQeKai48+TKEGHT42Z4/w58+l+PoARokJTs
         p0YYpgEm6jpxi2mf7o/82paINBA2/Gi3TaK7Xz1OqTidtIw/xVMCbMeKeVxc3h35t63Y
         Navp/kAZWxl/XrPVDkYOXlHSEFGtc1LZdnum4A4fa6u7KfoixVZ7wNNeh6LIH5JWF1RU
         k5rg==
X-Gm-Message-State: APjAAAU+1lTndKLJPnH75yjnijkaiJTa2D8KvvuaAQb4C57ex56vd88l
        Ee6Zlglg+k4Yy8FWvibM1N2gYNH0tSs=
X-Google-Smtp-Source: APXvYqyaik2K3jmCriYAi/Btuue1NpMxh6Kl4mMKAIzp4/pL1q8QhpdD78hGoBibP9oQDkjFFVN9Pw==
X-Received: by 2002:a5d:4746:: with SMTP id o6mr1437713wrs.70.1582018984313;
        Tue, 18 Feb 2020 01:43:04 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-188-94.w2-15.abo.wanadoo.fr. [2.15.37.94])
        by smtp.gmail.com with ESMTPSA id s23sm5351095wra.15.2020.02.18.01.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 01:43:03 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 7/7] nvmem: add a newline for readability
Date:   Tue, 18 Feb 2020 10:42:34 +0100
Message-Id: <20200218094234.23896-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218094234.23896-1-brgl@bgdev.pl>
References: <20200218094234.23896-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Visibly separate the GPIO request from the previous operation in the
code with a newline.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 5e7d46eccaf6..ec955db4673c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -346,6 +346,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	rval  = ida_simple_get(&nvmem_ida, 0, 0, GFP_KERNEL);
 	if (rval < 0)
 		goto err_free_nvmem;
+
 	if (config->wp_gpio)
 		nvmem->wp_gpio = gpiod_ref(config->wp_gpio);
 	else
-- 
2.25.0

