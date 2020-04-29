Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58104C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3316B2074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SFyoKw5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgD2AYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726348AbgD2AYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:24:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C4CC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:24:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so33994pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1sHtxZdT0wI1goo5Pdu5mOhzBJD4geRWltIkc91pB48=;
        b=SFyoKw5brVEtpGCyhtXkkCmAoKTge7h/OfRJ/dgPsd+wFkvgV9zBoAa5hmhgDH2m4c
         ml6QcgWYpZOPgzOi6QWV4bwPsiDP0E2AuQ6qsOHh18jxuzoEzIdmN6keeTpvrkvYJd41
         JY8hLdf9wvVPtAAn6Ki2W+j3BOuicznR97Mr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1sHtxZdT0wI1goo5Pdu5mOhzBJD4geRWltIkc91pB48=;
        b=eB4YPXVoW96fAc+pft+d3Ny5HTU7X8rLxnvW3G5OERM47rwFxSK+kIv25nbn4sp1q4
         955zWH6OyrBmGKO7I2sxhAIxPkWraK3waKBnAghW/nPYWvsRP/9uRf+g+OTv7oFpf6R7
         3YyT7/4LURjlWbQjftAHRCgRgaW0YDPiDUhFPMTLDUSN4R0QEj+1ZR8a4sNAQnN35KNj
         yqNbFchxLA1ZJqh3rv1+yqZd/PgKf5KBK/4WPM9OLpTpsFcJI177RzNGxmVcaSC94HUM
         jwE7gI/wN4kuhNBpsWNds48WWVHoVcFGiYqddAAifygsGTlV7BzIZZiPIEk9aIwal01b
         UgQQ==
X-Gm-Message-State: AGi0PuYPxHEMPvzsQ3ZfNyTULuwj/iPizB/jKEr7QzT6VEMxnwJ6e1yv
        K8zF2/PNwy/7TopXluQR2Ryh3Bf0vkzQ4g==
X-Google-Smtp-Source: APiQypKY7h/Fyc2zt79ZV85Mae8EDg1UcACG9PeCPGLt4r7q/EMMLU2+bZVZ+z07SHdA2ygPjFm8/g==
X-Received: by 2002:a17:90a:fa8d:: with SMTP id cu13mr28009pjb.27.1588119843473;
        Tue, 28 Apr 2020 17:24:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g6sm3102818pjx.48.2020.04.28.17.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 17:24:03 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     linus.walleij@linaro.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] gpio: Make "offset" and "unsigned int", not just "unsigned"
Date:   Tue, 28 Apr 2020 17:23:28 -0700
Message-Id: <20200428172322.2.Iacb3c8152c3cf9015a91308678155a578b0cc050@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200428172322.1.I396f351e364f3c09df7c7606e79abefb8682c092@changeid>
References: <20200428172322.1.I396f351e364f3c09df7c7606e79abefb8682c092@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I copied the function prototypes from the GPIO header file into
my own driver, checkpatch yelled at me saying that I shouldn't use use
"unsigned" but instead should say "unsigned int".  Let's make the
header file use "unsigned int" so others who copy like I did won't get
yelled at.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/gpio/driver.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 7b5f5681b7e4..8c41ae41b6bb 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -349,30 +349,30 @@ struct gpio_chip {
 	struct module		*owner;
 
 	int			(*request)(struct gpio_chip *gc,
-						unsigned offset);
+						unsigned int offset);
 	void			(*free)(struct gpio_chip *gc,
-						unsigned offset);
+						unsigned int offset);
 	int			(*get_direction)(struct gpio_chip *gc,
-						unsigned offset);
+						unsigned int offset);
 	int			(*direction_input)(struct gpio_chip *gc,
-						unsigned offset);
+						unsigned int offset);
 	int			(*direction_output)(struct gpio_chip *gc,
-						unsigned offset, int value);
+						unsigned int offset, int value);
 	int			(*get)(struct gpio_chip *gc,
-						unsigned offset);
+						unsigned int offset);
 	int			(*get_multiple)(struct gpio_chip *gc,
 						unsigned long *mask,
 						unsigned long *bits);
 	void			(*set)(struct gpio_chip *gc,
-						unsigned offset, int value);
+						unsigned int offset, int value);
 	void			(*set_multiple)(struct gpio_chip *gc,
 						unsigned long *mask,
 						unsigned long *bits);
 	int			(*set_config)(struct gpio_chip *gc,
-					      unsigned offset,
+					      unsigned int offset,
 					      unsigned long config);
 	int			(*to_irq)(struct gpio_chip *gc,
-						unsigned offset);
+						unsigned int offset);
 
 	void			(*dbg_show)(struct seq_file *s,
 						struct gpio_chip *gc);
@@ -459,7 +459,7 @@ struct gpio_chip {
 };
 
 extern const char *gpiochip_is_requested(struct gpio_chip *gc,
-			unsigned offset);
+			unsigned int offset);
 
 /* add/remove chips */
 extern int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
@@ -657,9 +657,9 @@ static inline int gpiochip_irqchip_add_nested(struct gpio_chip *gc,
 }
 #endif /* CONFIG_LOCKDEP */
 
-int gpiochip_generic_request(struct gpio_chip *gc, unsigned offset);
-void gpiochip_generic_free(struct gpio_chip *gc, unsigned offset);
-int gpiochip_generic_config(struct gpio_chip *gc, unsigned offset,
+int gpiochip_generic_request(struct gpio_chip *gc, unsigned int offset);
+void gpiochip_generic_free(struct gpio_chip *gc, unsigned int offset);
+int gpiochip_generic_config(struct gpio_chip *gc, unsigned int offset,
 			    unsigned long config);
 
 /**
-- 
2.26.2.303.gf8c07b1a785-goog

