Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A95DC3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555692465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XcDpl37I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgBSJWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:22:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46256 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgBSJW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:22:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so27260189wrl.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 01:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g0YN6Dlne6z0vjZ0AH0dVdxzG7WmpNUk7na6P2hSR2w=;
        b=XcDpl37IaZTVGtMzIhMPsae7KfOm2tGEuA06XO9f7RtlBm+xGAkPWX4C+VswT5xPVY
         K5m54PneLMGJmaAEgRjC/pgbqTaCcxCkoxJXuRJAAx22sBw9KkG3BKFQl9RuV3tsYRr5
         6RMNIZjNGEG8OEEdo1GAzVxS7t/Z+cd73eGztjShyrPpREx2AAi3cMgYoEHQCasAGsoG
         5Ttja22i9R6PV/tb6Hw8/gHvrNXNQ4j1FWxAD3/Gs6CpxeOCUmhQ39slplmQ/xSBQEf7
         F1v0IQrBQ7lrPdgbNI1srG0mWr8Agcp4Zyzm5GUyTe/6PcKT4hZCVCQ64HGO/TpJT2xG
         FOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g0YN6Dlne6z0vjZ0AH0dVdxzG7WmpNUk7na6P2hSR2w=;
        b=e3xqJW4eXc+7sGNqLNYUjEWxiR4eBBnB4A+FQwqmTKmPAf27rpCqE6bdDOIgL+KxdP
         YUJ3UorJFOt0M7c816eoYytxOmyZZq2mdQldmH0Q2AgGszZvHr72GoNSobe7qo6k8B82
         9G+YN9c273RLVGOziwQtYqE/UTPSKjFG6vNhIGt5nJpztDL/WC2trclVY45diGh48cpi
         tq0vnjB04XLBRxPJEe4bR9963pF8wLazknXh2qTnG6Ncyj/QNH73LwBvQmX/jfBxtub5
         z7/SFAYYCB16GUqdgPyNZvKZxE0mdXBGFgrG4thklWf8GlRxLBdYRWg1NhXS19aB8q2B
         hBsw==
X-Gm-Message-State: APjAAAWXe6l7lffjFTCax1b1jxCinEjSuqu3nVvGhnqXeLbr6+bk9MC2
        FNOJVS4k2YX2MHyCezmkSarFTg==
X-Google-Smtp-Source: APXvYqyGU7t/zxEI5K0ATkkBR81u9/X9uwrAb6dbyH/1hfmcdNGOu2ab0YCI1XpX8B+sHXVxBbl5Rg==
X-Received: by 2002:a05:6000:10c:: with SMTP id o12mr35333852wrx.106.1582104146936;
        Wed, 19 Feb 2020 01:22:26 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id s65sm2172296wmf.48.2020.02.19.01.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 01:22:26 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 5/7] nvmem: remove a stray newline in nvmem_register()
Date:   Wed, 19 Feb 2020 10:22:16 +0100
Message-Id: <20200219092218.18143-6-brgl@bgdev.pl>
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

Two newlines are unnecessary - remove one.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index c718ed7859e8..bbdf2fe076b9 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -359,7 +359,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		return ERR_PTR(rval);
 	}
 
-
 	kref_init(&nvmem->refcnt);
 	INIT_LIST_HEAD(&nvmem->cells);
 
-- 
2.25.0

