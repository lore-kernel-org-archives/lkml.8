Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E33C34026
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8488620801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gs3t2/Ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgBQTyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:54:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40232 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgBQTyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:54:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so525726wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 11:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BYR9M1clfYHE1v0ARZeaLz8iyf2HR4xKCefQlA8DsFQ=;
        b=gs3t2/TyF6gF+0zoSvNHpJqpWvhb+OJTbYK+Rimp36zPn+Um3KJI7jU6an+eaF7C1g
         6bsumWdRMHjnuu8oDRtMjAmZNmF/iEZdH8FIQIDkZW0GoN1Ni5mJC/WdxAzKosceidc9
         3KClzAWGMg9kM5UDMuCWqhF7Qya3RyFEi9tCZUhzudbH0PYxgQ3+LYPEgQWWA0OT+UrJ
         m1VtSJwQTkRE3jKrGldEeOzw/QHMImAEvgHNLITBFtM2+0TDCPKaWMdEZYXRfI/sL2nI
         lN+tYgD7vqesBkEHp6/BgDbCgcnE/c3uLWTbIAheHZ0gGv4fYRQ6leWLrsVe6x72HxBB
         RkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BYR9M1clfYHE1v0ARZeaLz8iyf2HR4xKCefQlA8DsFQ=;
        b=dn7JnSiVctf6pPKS9hAkfOHkwrC4OQyOcjvS/1RQa6ntJIlIhTDo3J9Fm4G/FgbJAg
         lyPGWSrwgoxnEh/dPLJWcaG8cYCNkh2ypqEGXWDJPMKNFGoFOVG5qojoDi50vArkEZS1
         gvxZ00JSLLmGJHKOYIVi5Yo2Hsb2CZNE8cuz1RR0ckxfW10rnVBi2pKaaoxXa77ECCkH
         XDFIIWplLnl5qUaZF+MzLRa/0ytarx972KpB6VBgvAMEz9+R4a9cY/oaDyM0uNTqb9HL
         VC3tiEFvbUxhOZp+C422TjC+sJurPyn6mOiLsJRtsHvAY/Gv+BbdOzQ8oPUdFJzVqUXX
         dT6g==
X-Gm-Message-State: APjAAAUe5ndzSpODS+S/5qqIaZExA7QyAC7FnA+KweE4h5M+zC9abeMC
        9JMA9LTeFsUFrMpEK5pVRa74aVWohLY=
X-Google-Smtp-Source: APXvYqzCRYEvCvyjC143+OuW9Wo/mGyHqbMmxdGTb0RSKx1nDwE2TWGL9MQamtoIoyVcxmyNjrfDjg==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr598696wme.94.1581969282023;
        Mon, 17 Feb 2020 11:54:42 -0800 (PST)
Received: from debian-brgl.local (8.165.185.81.rev.sfr.net. [81.185.165.8])
        by smtp.gmail.com with ESMTPSA id v5sm2679469wrv.86.2020.02.17.11.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 11:54:41 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/6] nvmem: fix memory leak in error path
Date:   Mon, 17 Feb 2020 20:54:31 +0100
Message-Id: <20200217195435.9309-3-brgl@bgdev.pl>
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

We need to remove the ida mapping when returning from nvmem_register()
with an error.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ef326f243f36..b0be03d5f240 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -353,7 +353,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(nvmem->wp_gpio))
-		return ERR_CAST(nvmem->wp_gpio);
+		goto err_ida_remove;
 
 
 	kref_init(&nvmem->refcnt);
@@ -430,6 +430,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	device_del(&nvmem->dev);
 err_put_device:
 	put_device(&nvmem->dev);
+err_ida_remove:
+	ida_simple_remove(&nvmem_ida, nvmem->id);
 
 	return ERR_PTR(rval);
 }
-- 
2.25.0

