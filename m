Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81BFC3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16B82064C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kN4ndebW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgBSJWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:22:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33094 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgBSJWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:22:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id u6so27367856wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 01:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=odwKwtP2lE8W97hrRy8NvVzj5zWj2rVZZDM+vhqGNzE=;
        b=kN4ndebWVxSAl3I2DeNQFdgtH5aq0q9L9+oarqqkG+xsMTE62bhik4iJ5XqnBoF5q/
         /3bTEIpaKsDjo5fe3hIBVllyXv2UYDc+nPURBs9sRjQZnN0IdlUUrmFd1BJfugsPaXrq
         mtBPLync0/t3eexaWGxSkfGEnQ92QuvCo3HvszjoF3EV4G5WQezQ//rTaE9SW5AQHwIO
         zxT6/snlUIoVoAQDU1bx3D8WpRpRfNkO47tIPosDKUPfCxmnBkvkZcJnXxsIoqP8SsTb
         1sMBgyv4tnBUqj7PzzrodZSdkviZj1l/c17AWmjk1XumhemE5nv3uDZmcQ6jy7gfzabS
         CI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=odwKwtP2lE8W97hrRy8NvVzj5zWj2rVZZDM+vhqGNzE=;
        b=aEUqDPAZnelJCO7uKY7NtYpvGG5Yk7ezPQKEH9TwE2FPY1zrh9IA4TFkxjOoVB0JfY
         SBFk1spLMr5a2u5snmqmXtWhqu+fIk7uQ0foq3AQqW52wYCKl+aBIFth9fFlSJs47xQ4
         RW5bARsBYt/vUISf/VEMAoySqVSwFPUUjDnaGK9UXP0QA2r0BAgDJNU7vgxGR3Fv3e+o
         hZsAHMoLxU3Xxo/LKWLDwIbVSCN/NDf0nhlUqxxMywzSM1xe5QFw73jBLhJPecqljr+/
         vAVeGCkfjfMiN/vx6NVcYP5Tv7KX3L1V5u0925oQkYHRRcfwtIkDvm6NAJXxKMq25Kw6
         rmlQ==
X-Gm-Message-State: APjAAAW5BB11A3CgA9aAGwvgE8TntwH1nmz5egxQzG2CGW7fH6FIjyNr
        pmY4BdFzspb3VhWgMVs+nTdJHw==
X-Google-Smtp-Source: APXvYqzMAsBMU+3D/XofaGr4QgydoNbC5+5IkqGNjXo2HITsljiwnnn5pJgC9o9DjsVBK+fpvaklTw==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr33982122wru.82.1582104149172;
        Wed, 19 Feb 2020 01:22:29 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id s65sm2172296wmf.48.2020.02.19.01.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 01:22:28 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 7/7] nvmem: add a comment about resource management
Date:   Wed, 19 Feb 2020 10:22:18 +0100
Message-Id: <20200219092218.18143-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219092218.18143-1-brgl@bgdev.pl>
References: <20200219092218.18143-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The fact that part of the resources associated with the nvmem resources
is freed by the release() callback in device_type caused me some
confusion. Add a comment explaining that to nvmem_register().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 40fe5913c264..6e28f3fddf53 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -397,6 +397,11 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
 
+	/*
+	 * After calling device_add() we can stop freeing previously
+	 * allocated resources - they'll be freed from nvmem_release()
+	 * when the device's reference count drops to 0.
+	 */
 	rval = device_add(&nvmem->dev);
 	if (rval)
 		goto err_put_device;
-- 
2.25.0

