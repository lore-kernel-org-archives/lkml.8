Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F80C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2AAF20737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598466010;
	bh=S63b8jH3yXPTdFcjM0wgK1kGIdL/qW7ae7J48kYeDyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mS6+o8EKgNZWK0xfCONNKpPlQb6MVnkt5Jt5YgRlNk9uEjP0azoZlZ/T+ylECHHqk
	 WqMeIterOD1w6YgEbB3GdlKyT+/CkCUGWR32TKjsI3/CcKUDjwPnd2T34iyv5QVUEn
	 2KzhstdGMd6IHZy7pmJaAp06akMDkI0PC6tXUqDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgHZSRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgHZSRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:17:21 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 892E020786;
        Wed, 26 Aug 2020 18:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598465840;
        bh=S63b8jH3yXPTdFcjM0wgK1kGIdL/qW7ae7J48kYeDyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TIjMx1lppHHDR7v9UebK4nY3MBUuPIMmGHoBMm5ceEhguzm3KolsI1hBRP2xWwTb0
         LVn0YIhj2IZBnVUq7CwOJxQ+oNMy+pnArbP2XDTVKWKxNsriOktu8k/AC544MgHmef
         vEMcloJdXskKDGsWwlVwbdRm1v11SWVxrUihLk7g=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 02/24] Input: gpio_keys - Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 20:16:44 +0200
Message-Id: <20200826181706.11098-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826181706.11098-1-krzk@kernel.org>
References: <20200826181706.11098-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/input/keyboard/gpio_keys.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index f2d4e4daa818..6f670cbe8a8b 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -505,10 +505,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 				 */
 				bdata->gpiod = NULL;
 			} else {
-				if (error != -EPROBE_DEFER)
-					dev_err(dev, "failed to get gpio: %d\n",
-						error);
-				return error;
+				return dev_err_probe(dev, error, "failed to get gpio\n");
 			}
 		}
 	} else if (gpio_is_valid(button->gpio)) {
-- 
2.17.1

