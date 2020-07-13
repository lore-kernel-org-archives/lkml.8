Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAECC43458
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3656820791
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmtW2ht4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgGMOuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbgGMOt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C01C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so16822473wrw.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nkDu4+NF/Jy0nw1npPjBWOEwj+80cykTcSKL8zkEyoE=;
        b=ZmtW2ht4WqM7YXMQqyxHw3ZRWguzPgBqFC2JKAMqnldEWEsJAUcbwc2bmoKXuvKdhB
         ohLnx6dHRciOiJRTxfPCFjCrEU+2qXEPZTQjSGaojFkCaf6eucv0LMOlOH5ybPM6rBxY
         tDPXuEMK7uUVfDp3zwVJ2KxMPq7Hr81fGJ9+9pNX7BcxMW5GNb707zAllgt9brug1YNA
         C5iAFICTeYYWHDJz2rbibn+U9WTtjaFxewwzqY+I7CTq4Iw2/NIsi2sAK7h9pWrxK98S
         7uCOBoC0BEbMzYAIM8CRkDzn8+axiDVRtayVn3F4BqiORSe8IAY5nVQWBQKD31MV3mWw
         wsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkDu4+NF/Jy0nw1npPjBWOEwj+80cykTcSKL8zkEyoE=;
        b=Q+0eMhwQQ0WPU5HQd1kHoL+WpMMedGr69pPmWhaTn0UmGqIJsZ223NGBSGphDwlkhS
         9+jXD+6vZjkklLo1S9ONfGcYP+arFr8r3GApn3DM4PGDyrwQZ/npPeEYWJRWDzs4Helt
         r5mo3D0I/+NAZSEP53rtDkKKhiJT5gzj14SYfFRL3YtrsPrTniFqr8yvfwx67hc44UQV
         erh1cAiF+eR96nqO17q1Tt/84tofyHEDBnDZ5+kS4gD+fYjtiVyaJ2qQg3uckk5g8J5D
         bVWmtc1bT93U3r5ea+qbiRJm15+0MbgFvHXAU+RxQ6Mi08EKeF/N/VXFMF+gdC3ubfnr
         ypag==
X-Gm-Message-State: AOAM533xDh/9YVakhMwyHK6eq8SNRGAZdCGB119wc5XVa/K51eQshLDO
        T5xhgP3a0Ehwgkygbd4v4ja8oQ==
X-Google-Smtp-Source: ABdhPJwWZnEQwNy0uHw6fz+gVKKB5MdRFqRoRee91JUrZWtXKOGQ/CMQO9b8C5u1UFocGLb+2c0OYw==
X-Received: by 2002:adf:ec42:: with SMTP id w2mr80843478wrn.269.1594651798432;
        Mon, 13 Jul 2020 07:49:58 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 23/25] pinctrl: meson: pinctrl-meson-a1: Remove unused const variable 'i2c_slave_groups'
Date:   Mon, 13 Jul 2020 15:49:28 +0100
Message-Id: <20200713144930.1034632-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has never been used.

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/meson/pinctrl-meson-a1.c:749:27: warning: ‘i2c_slave_groups’ defined but not used [-Wunused-const-variable=]
 749 | static const char const i2c_slave_groups[] = {
 | ^~~~~~~~~~~~~~~~

Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Qianggui Song <qianggui.song@amlogic.com>
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/meson/pinctrl-meson-a1.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-a1.c b/drivers/pinctrl/meson/pinctrl-meson-a1.c
index 0bcec03f344aa..8abf750eac7ee 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-a1.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-a1.c
@@ -746,11 +746,6 @@ static const char * const i2c3_groups[] = {
 	"i2c3_sck_x", "i2c3_sda_x", "i2c3_sck_f", "i2c3_sda_f",
 };
 
-static const char * const i2c_slave_groups[] = {
-	"i2c_slave_sda_a", "i2c_slave_sck_a",
-	"i2c_slave_sda_f", "i2c_slave_sck_f",
-};
-
 static const char * const spi_a_groups[] = {
 	"spi_a_mosi_x2", "spi_a_ss0_x3", "spi_a_sclk_x4", "spi_a_miso_x5",
 	"spi_a_mosi_x7", "spi_a_miso_x8", "spi_a_ss0_x9", "spi_a_sclk_x10",
-- 
2.25.1

