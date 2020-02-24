Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78029C11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C0B20714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt8bTv0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgBXOu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:50:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37560 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgBXOu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:50:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so5479574pfn.4;
        Mon, 24 Feb 2020 06:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LjdCnI1FDhpyq/TpzAqb/yMhriBw2389lOX4pglgwrQ=;
        b=Gt8bTv0adK23rBe6BXKj4Fqv6D5zlw2L9BIMxeXEiBCFzuRAiW+4nAcnJn80MwYkMJ
         ppWWo/X4X/uvS7JK+92wZups/N9PiygjXlIg1eIzofmxzwT83qVMY8dCmB2xR8BXsgYU
         ueX1gT8JoGtk5DczgbbpA8s9en6k+/4AjviHZ1aqLdoy7B9RNH2tmRT5PzlpQdcNmITc
         eSEH3nkopKh3uS0PGT/8bgNfc2RE4gOVSnav2hirm2Zm/SosOuS/6phi5m8RYemIIX3K
         IupNJxAZwsIQv1pCvAlAQQ96mthazlo7ouuzTTSgoFL4B0GAhSaLn+3yol49JJBCFRg4
         YbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LjdCnI1FDhpyq/TpzAqb/yMhriBw2389lOX4pglgwrQ=;
        b=FMaU877hyStqfRAsJwWozcJXnieCWhfHZMBjfRS3MKlKMiZF+m5FFuhK4/tgN2GQsn
         1BX/FDRGNLSXq4w9QKH/nFPWvgK4OIvTDYcOxgKG3uV0RizDFGKGzHXFNc3lY7tMrXnS
         yfhQcdYshSGp3slKcHy1AKGWFx23pjIS+iut7mRQJVNh+Hk1+w+EeMy8ZD5o+RrSoPf8
         zMi1zDuF6Uis/5JCG4DGzZMor4QK40cnuFL2u36Z/fTHZmROpqRjK8tt/eLxepuYqqe1
         V5Fi7tSDoiakCcWn4vi5mL39g5LXhlHHq/4SsBZ+hIWCiZPmUwtnsk2uLkKZpppjzAWB
         t05w==
X-Gm-Message-State: APjAAAWcrwl1VDDsLLXZGMF52cYqIt/+WQoP72mT5iofciDgJIAGW5wj
        gY5kukRwd4gybIF8zcp6Kv1tAoQs/peAxA==
X-Google-Smtp-Source: APXvYqyp5Ic3fOMWGtPCA7Y3BIZcBbRNyIkcwtJ3CRUa4YUOCKjAu2OYwk6Ij5ygOMqKATCWGrTeEQ==
X-Received: by 2002:a63:3754:: with SMTP id g20mr50969368pgn.384.1582555826839;
        Mon, 24 Feb 2020 06:50:26 -0800 (PST)
Received: from firefly.lan (220-235-100-192.dyn.iinet.net.au. [220.235.100.192])
        by smtp.gmail.com with ESMTPSA id y10sm13354189pfq.110.2020.02.24.06.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 06:50:26 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH] gpiolib: fix unwatch ioctl()
Date:   Mon, 24 Feb 2020 14:49:53 +0000
Message-Id: <20200224144953.1845-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the field having a bit cleared by the unwatch ioctl().

Fixes: 51c1064e82e7 ("gpiolib: add new ioctl() for monitoring changes in line info")
Signed-off-by: Kent Gibson <warthog618@gmail.com>

---

I had written some tests for v1 of the new ioctl patch series, and just
updated them to run against the v6, which is now in gpio/for-next.

I found the Unwatch ioctl suffered a regression - it simply didn't work
anymore, though it wasn't returning any error.

This patch fixes that regression.

 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 73a1e0831eeb..2411562a9bac 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1276,7 +1276,7 @@ static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (IS_ERR(desc))
 			return PTR_ERR(desc);
 
-		clear_bit(desc_to_gpio(desc), &desc->flags);
+		clear_bit(desc_to_gpio(desc), priv->watched_lines);
 		return 0;
 	}
 	return -EINVAL;
-- 
2.25.0

