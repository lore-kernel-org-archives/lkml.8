Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24368C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0610420768
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uHWduRT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389428AbgF2VEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbgF2TMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0722C08ECA6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:50:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so14277726wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/lPkRY5zqjvg98KXV/ewwSSeHltl7MZJ65glZzN0dPQ=;
        b=uHWduRT5zZJw4Hwc9B74igIqFOEHnjuRsYYMcRLM99cZ1YohKhbSuZsTzU3QNZn5n8
         DggURCBqcVH2hKXL67YV8IzP115GSey41KFa0vv0U7Lp2uGwQL6E2xn37o7EOKGWqi+F
         mXmL71fmVcc9rLdTYLsD4EsduHmkOk/VXC3X9JXq/6Dv9MB06hYXNJlkUYlWqLmPgM5V
         A23bUylZ1YJ1dXxD6n9hAb81iW4LN5RWRu5oHTSRQKRX7kPnWGRv5t8Ldpq6LkyHTwLS
         xlWA/+mUQisbhbRJxFYbKpF6wGEKu6IItURDPtgSNDAN1YEwzdnkinovzA2KvpRKJVUq
         ZmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/lPkRY5zqjvg98KXV/ewwSSeHltl7MZJ65glZzN0dPQ=;
        b=Lozlx15JIW80A78FSjIgNvPaPdFSn+lNDjXDzQIP4i0Ct+jugXksOJx4IFF/ZO1GYx
         sHjwDNrZAdCeB3GSKwF3aSCu0R6WMXYBSwCwyV242mjQfFqDGuOJOCAtV1V34ebAfvfu
         9Et1ZX5sEivUlAPlXK68Fm9POgHEktgCztsqlMqwLy8TLmqdHrZP8x0QEwio0hLPl9p6
         zxOvYG8FYqimlVPQn8b7Ap88exDaAiApuq95x67cALTbCQBr+cLlFZu3ZSPbuPx+TR69
         2bB8XFx2i7YOshlZrES016fx58MS46kyOw599zlHkZ7hxdlw5uV3wNr64OtW5Q74b9RI
         oBMQ==
X-Gm-Message-State: AOAM533Zx38ggFbBfevR7CPvpEDIImpiKK/OoTlPPylZpf8Jtvvljo6Q
        kFE6sRdbnGgjzjd+pQlbxIEC8g==
X-Google-Smtp-Source: ABdhPJxEvLFDqGizVKVA+kCWvUNxwkMOgwoH94wkn9w50auKmytYRDvwZYMieLGnlarkAN4tua/fxw==
X-Received: by 2002:a7b:cf10:: with SMTP id l16mr15384822wmg.93.1593413416631;
        Sun, 28 Jun 2020 23:50:16 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id z25sm26400850wmk.28.2020.06.28.23.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:50:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/6] devres: move the size check from alloc_dr() into a separate function
Date:   Mon, 29 Jun 2020 08:50:04 +0200
Message-Id: <20200629065008.27620-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200629065008.27620-1-brgl@bgdev.pl>
References: <20200629065008.27620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We will perform the same size check in devm_krealloc(). Move the relevant
code into a separate helper.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/devres.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index c34327219c34..1df1fb10b2d9 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -89,15 +89,23 @@ static struct devres_group * node_to_group(struct devres_node *node)
 	return NULL;
 }
 
+static bool check_dr_size(size_t size, size_t *tot_size)
+{
+	/* We must catch any near-SIZE_MAX cases that could overflow. */
+	if (unlikely(check_add_overflow(sizeof(struct devres),
+					size, tot_size)))
+		return false;
+
+	return true;
+}
+
 static __always_inline struct devres * alloc_dr(dr_release_t release,
 						size_t size, gfp_t gfp, int nid)
 {
 	size_t tot_size;
 	struct devres *dr;
 
-	/* We must catch any near-SIZE_MAX cases that could overflow. */
-	if (unlikely(check_add_overflow(sizeof(struct devres), size,
-					&tot_size)))
+	if (!check_dr_size(size, &tot_size))
 		return NULL;
 
 	dr = kmalloc_node_track_caller(tot_size, gfp, nid);
-- 
2.26.1

