Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004A4C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C893020842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DyVOmojv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgBKJT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:19:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37204 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgBKJTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:19:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so11314449wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 01:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EtQ76os3WQVh0lw6qN9j82AIAuvSyf0QqFvaxFLUUBU=;
        b=DyVOmojvRFjUnnrjwaMeuiQ2YjiblV2VtavuQVFfBCWbNZYhxJi4e9GsozvPg/qhaE
         VNpQ0Gq5Lf1jvaGoJl6btT6JwUrkJD7aH5LSEZRfcg9tOhegu9FGg2agiVKH2vLVI/ow
         baYpT3ytVqOreWeFWw7laF92UyzKY9JS+WujaPjXd0Fr/pKldPbUBbCZ3KEpMg0CTURo
         r3LrApXf293+3jwT7tIWb3MOoTj2EdXwjGzQk97g96nDz4TodOrID3UnsFZ/09h+6Kkl
         dl4T/k3/UmJJTAfyH3WP5vc0E2FxJWUK/eCDAVRT/gv/HtiyyJv2YmUeHkHPbyk9EUtx
         NKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EtQ76os3WQVh0lw6qN9j82AIAuvSyf0QqFvaxFLUUBU=;
        b=sVXf+ENJAmw/+Hpo7Sm40tp0trNAhNTCzfE5lPUPyMv2j3neKPBwcTL3IqrL54OoUa
         KSYMhQObU6+n/mia9O1M5J7Ir+1Ebvb260L8mCeTYQE26fWJlzZJJPn9ZN93lJ4chWha
         vBviFe2T5mcNi7Z+xHySAvRkIJNCHqKIyS5JjB8fDvRJEcc65PclK85HFlwKbCG1hTwR
         1J6IHGQ4EXKoHrcszu20spvAUFxqEafnCLlAr0bI617HEL34jFCuqHM5poUt2QMzmxS+
         YUCz4gplvOUvIQ/tBq0UcFaEY4XQ806Gory/gULiT8M2iJZ2Bd7VsY1e+XzvbjqOMHDu
         MC3w==
X-Gm-Message-State: APjAAAWEsIqcp8+ehZKQ/B5vcnzG7D+x/hyU6QQSm3IsJIaX0FvyrV/K
        D691JZg1PUmi888/9TyOQlu4xQ==
X-Google-Smtp-Source: APXvYqzKebWA8ZpvWSMpxM6xOkfIIW2ZrNGnVdQQRIq21HnxvXCKT4gzhudC0T63hzJh8ZHje4y2sg==
X-Received: by 2002:a5d:6087:: with SMTP id w7mr7374811wrt.36.1581412789413;
        Tue, 11 Feb 2020 01:19:49 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id y131sm2958622wmc.13.2020.02.11.01.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 01:19:49 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v6 4/7] gpiolib: emit a debug message when adding events to a full kfifo
Date:   Tue, 11 Feb 2020 10:19:34 +0100
Message-Id: <20200211091937.29558-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211091937.29558-1-brgl@bgdev.pl>
References: <20200211091937.29558-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently if the line-event kfifo is full, we just silently drop any new
events. Add a ratelimited debug message so that we at least have some
trace in the kernel log of event overflow.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 43d98309e725..36afe0b2b150 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -978,6 +978,8 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
 					    1, &le->wait.lock);
 	if (ret)
 		wake_up_poll(&le->wait, EPOLLIN);
+	else
+		pr_debug_ratelimited("event FIFO is full - event dropped\n");
 
 	return IRQ_HANDLED;
 }
-- 
2.25.0

