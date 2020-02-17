Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCE1C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4B320801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="C5yJlQ0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgBQTyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:54:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42397 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbgBQTyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:54:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so21184965wrd.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 11:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vEpSrHnokxwmZhdlJaP1Fdj4KHCY0aOhXmKsmIiSb2c=;
        b=C5yJlQ0zN1DNoCE7vAWDdzDh2oF7j6+dHO2XT/eCYXi5m1+IVxogqmWGWqAIkmMr6c
         xLaTQXqKC38T1ujrVcOPc0yJ4T/o/jeILhkKJF+Yo4RVk06ZRRlBjZuZBofXxN7NWhNY
         qpvtrLYWbrJXIN0eIwevBaYdSJClurdxLzTVDg0Hyj30k+GG9YkpiA9oGsHEJL4jeQ64
         x9T0DGwG7EahJlYYqbUbeTkglnXadRnup3TzBOI5MOgliIQDip85hI9rT2Y2h62PrxoQ
         bdI3q7CEUGk9wGzK2GcYWqGuBvSmrWWO05nhc3BghDKd0Jn0z9PYh3hXVfQyVHKDsUOZ
         DGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vEpSrHnokxwmZhdlJaP1Fdj4KHCY0aOhXmKsmIiSb2c=;
        b=DGrEfzVOlYYpc6QV5rpgdFRmdPotzhDZmgm/rUvuDePdayYNT+qTqiLYz5pKxEDTCg
         Bscvcz2EjxbYpepiGzk9KPOT9XNe5r95Lnx/dl9buFOxry9VHETtNhLoD70yk/4gEgtm
         TQDNle/7LTsm92uk9Ou2R2Z6x0Fameo32jSXMTwcpsqSK5lrX+GQvavMgxajc4j2Citn
         iy2kC94OYKu5Pu/6bA+FYxTtBvu+Au2A158ucn0Pew1fuP5JiSp/TL/K7ss7H1tFg+hU
         hrcsg1b8lISkXhdf+KhrlcXV9Op9Ye/7OHnpj4pXiaFis08wlf7fPfxsYct3lOUI0mlb
         e6mQ==
X-Gm-Message-State: APjAAAUWXkoEn8V2edPvjbh5UthiDfge/on2aQ82oHgW5awHb4rUuYTM
        Hy+Tk6e+tU86Ozoc8r/dORTMIRGUbis=
X-Google-Smtp-Source: APXvYqy8+uEI+AwlMQIFLWh4NY+e2ujZPYaJBH3XEz62f0FrxkWwIiIuYgEVBfnvWw1JglwM/pIyJw==
X-Received: by 2002:a5d:610c:: with SMTP id v12mr22642217wrt.88.1581969283249;
        Mon, 17 Feb 2020 11:54:43 -0800 (PST)
Received: from debian-brgl.local (8.165.185.81.rev.sfr.net. [81.185.165.8])
        by smtp.gmail.com with ESMTPSA id v5sm2679469wrv.86.2020.02.17.11.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 11:54:42 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/6] nvmem: remove a stray newline in nvmem_register()
Date:   Mon, 17 Feb 2020 20:54:32 +0100
Message-Id: <20200217195435.9309-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217195435.9309-1-brgl@bgdev.pl>
References: <20200217195435.9309-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Two newlines are unnecessary - remove one.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b0be03d5f240..12e2991cdeef 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -355,7 +355,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (IS_ERR(nvmem->wp_gpio))
 		goto err_ida_remove;
 
-
 	kref_init(&nvmem->refcnt);
 	INIT_LIST_HEAD(&nvmem->cells);
 
-- 
2.25.0

