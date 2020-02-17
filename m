Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BFAC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CDB206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="w5VjHmzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgBQNx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:53:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52982 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgBQNx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:53:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so17235079wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 05:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=PI0LvpGjO/OZvCQU1PxswC2EPMei884/nsAkhdkaeP8=;
        b=w5VjHmzvIVp/HsTMrnc9z5s2CtLUjUztbi2kHK96i4oWzwnIcHTP+GtIBtBQuzpl9Z
         cHu9MWaFp5qHlb8kvQ4/DWJEH5/ae4IjXLtSOQ4d3aWf6XlAHs7VZCA/X1WGMKrxRIke
         C/2tHs+TtOyiPtB6ebp9jT2B4ob1Qzc16UUd75HXx5cW5XhDZ5F/y+0lieIgjHAYu6tT
         bGoFdaetxAV2vCp7/kz3sVG+/nurOi1uhP2inSsg76f5uw7QT0Aoy+iDHkbOGMi6dpgS
         7dmtKchlMlSX2v0/4oS5hqVVSNLwOYUsHlLB0R8Pp6lVxQpiEVTTl9UNhE0eyZbWVYRE
         dbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PI0LvpGjO/OZvCQU1PxswC2EPMei884/nsAkhdkaeP8=;
        b=dkqiNjrOsFx6HJQAIZnl3sGyKC6tySeMuET4pC49pGWNScfo4jzJelDhMAxRuQVyWG
         WbqnuyqOG6gd+ivH17SJ96yLAY9zTyqlEXlYk0WAuGgwSZY/Myka5yU7Ak8J6RcPbTT2
         3kGY0C1XmyzxXaUToMhc4QqxuyAGQZ7Cm3myV3+nZioNlwcWd9IQz79rZccTaFJmm1Rj
         vvgQuTqT1H7cslDv581pQ1TpYkcQxHzg+MA6M6kZRf/ibuHBptqQHqFNfk4wwM3gbixX
         XV6QRW7NJtSgC1F6NUyuUuqa/zPZZBUeG2omKb2iXLxqKc+Da9YyWUgCLaVwA8gQ32p4
         wLTA==
X-Gm-Message-State: APjAAAWlrOZRXSlxGqjKmCSiqEz1qBGpb+Z8wdhJIQJJ50RhRfgYVwld
        wAdtyGSJ1B49bdRExiTvZKabbA==
X-Google-Smtp-Source: APXvYqyFEEWXOUljD2Qt5ltg3BSPgA/LaJUjjNfVWfAHFDf2JNWYuLuHTbsUCcGPvL1qQzYV+3TzoA==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr22664934wmi.89.1581947605445;
        Mon, 17 Feb 2020 05:53:25 -0800 (PST)
Received: from khouloud-ThinkPad-T470p.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o4sm1131010wrx.25.2020.02.17.05.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:53:25 -0800 (PST)
From:   Khouloud Touil <ktouil@baylibre.com>
To:     srinivas.kandagatla@linaro.org, bgolaszewski@baylibre.com
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, baylibre-upstreaming@groups.io,
        Khouloud Touil <ktouil@baylibre.com>
Subject: [PATCH] nvmem: release the write-protect pin
Date:   Mon, 17 Feb 2020 14:52:45 +0100
Message-Id: <20200217135245.29195-1-ktouil@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the auto-release of the write-protect pin that when the
registration fails, it's auto-released.

Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
Reported-by: geert@linux-m68k.org
Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ef326f243f36..5f1988498d75 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -72,6 +72,7 @@ static void nvmem_release(struct device *dev)
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
 
 	ida_simple_remove(&nvmem_ida, nvmem->id);
+	gpiod_put(nvmem->wp_gpio);
 	kfree(nvmem);
 }
 
-- 
2.17.1

